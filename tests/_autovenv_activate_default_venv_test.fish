set -x AUTOSWITCH_DEFAULTENV "testenv"
mock _autovenv_get_venv_type \* "printf pipenv" # shouldn't be called here; we set it up to check if 'virtualenv' is used on activation
mock _autovenv_get_venv_dir "testenv" "printf testdir"
mock _autovenv_maybeworkon \* "echo \$argv"
@test "_autovenv_activate_default_venv: activate default env" (_autovenv_activate_default_venv | string collect) = "testdir virtualenv"
set -e AUTOSWITCH_DEFAULTENV

set -x VIRTUAL_ENV "testenv"
mock _autovenv_get_venv_name \* "printf testenv"
mock deactivate \* "echo deactivate"
@test "_autovenv_activate_default_venv: deactivate current env" (_autovenv_activate_default_venv | string collect) = (printf "Deactivating pipenv \e[35mtestenv\e(B\e[m
deactivate" | string collect)
