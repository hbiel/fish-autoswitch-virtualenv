set temp (mktemp -d)
cd $temp

mock _autovenv_get_venv_type \* "printf pipenv"
mock pipenv \* "echo \$argv"
mock _autovenv_activate_pipenv \* "echo 'pipenv activated'"
@test "mkvenv: create & activate pipenv" (mkvenv | string collect) = "install --dev
pipenv activated"

@test "mkvenv: create & activate pipenv (passing params)" (mkvenv --param | string collect) = "install --dev --param
pipenv activated"

mock _autovenv_get_venv_type \* "printf poetry"
mock poetry \* "echo \$argv"
mock _autovenv_activate_poetry \* "echo 'poetry activated'"
@test "mkvenv: create & activate poetry" (mkvenv | string collect) = "install
poetry activated"

@test "mkvenv: create & activate poetry (passing params)" (mkvenv --param | string collect) = "install --param
poetry activated"

set -x AUTOSWITCH_FILE ".test"
mkdir $temp/virtualenv && cd $temp/virtualenv
mock _autovenv_get_venv_type \* "printf unknown"
mock _autovenv_randstr \* "printf 1234"
mock _autovenv_get_venv_dir \* "printf venvdir"
mock virtualenv \* "echo \$argv"
mock chmod \* "echo \$argv"
mock _autovenv_maybeworkon \* "echo 'virtualenv activated'"
mock _autovenv_install_requirements \* "echo 'requirements installed'"
@test "mkvenv: create & activate virtualenv" (mkvenv | string collect) = (printf "Creating virtualenv \e[35mvirtualenv-1234\e(B\e[m
600 .test
virtualenv activated
requirements installed" | string collect)
rm $AUTOSWITCH_FILE

@test "mkvenv: create & activate virtualenv (verify AUTOSWITCH_FILE)" (mkvenv > /dev/null ) -f .test -a (read content < .test && printf $content) = "virtualenv-1234"
rm $AUTOSWITCH_FILE

@test "mkvenv: create & activate virtualenv (verbose)" (mkvenv --verbose | string collect) = (printf "Creating virtualenv \e[35mvirtualenv-1234\e(B\e[m
--verbose venvdir
600 .test
virtualenv activated
requirements installed" | string collect)
rm $AUTOSWITCH_FILE

set -x AUTOSWITCH_DEFAULT_PYTHON "default_python"
@test "mkvenv: create & activate virtualenv (AUTOSWITCH_DEFAULT_PYTHON)" (mkvenv | string collect) = (printf "Creating virtualenv \e[35mvirtualenv-1234\e(B\e[m
Using default python \e[35mdefault_python\e(B\e[m
600 .test
virtualenv activated
requirements installed" | string collect)

@test "mkvenv: create & activate virtualenv (autoswitch file already exists)" (mkvenv | string collect) = ".test file already exists. If this is a mistake use the rmvenv command"

rm -rf $temp
