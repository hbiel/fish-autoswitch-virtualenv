set temp (mktemp -d)
cd $temp

mock deactivate \* "echo deactivate"

mock _autovenv_get_venv_type \* "printf pipenv"
mock pipenv \* "echo \$argv"
@test "rmvenv: remove pipenv" (rmvenv | string collect) = "deactivate
--rm"

mock _autovenv_get_venv_type \* "printf poetry"
mock poetry "run which python" "echo python"
mock poetry \* "echo \$argv"
@test "rmvenv: remove poetry" (rmvenv | string collect) = "deactivate
env remove python"

mock _autovenv_get_venv_type \* "printf virtualenv"
echo "testenv" > .venv
mock _autovenv_get_venv_dir \* "printf $temp/testdir"
mock rmvenv_rm \* "echo \$argv"
@test "rmvenv: remove virtualenv" (rmvenv | string collect) = (printf "Removing \e[35mtestenv\e(B\e[m
-rf $temp/testdir
.venv" | string collect)

set -x VIRTUAL_ENV "testenv"
mock _autovenv_activate_default_venv \* "echo Deactivating"
@test "rmvenv: remove virtualenv while still active" (rmvenv | string collect) = (printf "Deactivating
Removing \e[35mtestenv\e(B\e[m
-rf $temp/testdir
.venv" | string collect)

rm -rf $temp
