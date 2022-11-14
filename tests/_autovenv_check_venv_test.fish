set temp (mktemp -d)
cd $temp

mock _autovenv_check_permissions \* "return 0"
mock type poetry "return 0"
mock type pipenv "return 0"

mkdir -p venv
touch venv/.venv
mock _autovenv_check_path \* "printf ./venv/.venv"
mock _autovenv_virtual_env_dir \* "printf ./virtualenvs/testenv"
mock _autovenv_maybeworkon \* "echo venv_active"
@test "_autovenv_check_venv: .venv file activated" (_autovenv_check_venv) = "venv_active"

mkdir -p venv2/.venv/bin
touch venv2/.venv/bin/activate
mock _autovenv_check_path \* "printf ./venv2/.venv"
mock _autovenv_maybeworkon \* "echo venv2_active"
@test "_autovenv_check_venv: .venv dir activated" (_autovenv_check_venv) = "venv2_active" 

mkdir -p poetry
touch poetry/poetry.lock
mock _autovenv_check_path \* "printf ./poetry/poetry.lock"
mock _autovenv_activate_poetry \* "echo poetry_active"
@test "_autovenv_check_venv: poetry activated" (_autovenv_check_venv) = "poetry_active"

mkdir -p pipenv
touch pipenv/Pipfile
mock _autovenv_check_path \* "printf ./pipenv/Pipfile"
mock _autovenv_activate_pipenv \* "echo pipenv_active"
@test "_autovenv_check_venv: pipenv activated" (_autovenv_check_venv) = "pipenv_active"

rm -rf $temp
