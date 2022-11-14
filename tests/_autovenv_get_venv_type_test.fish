set temp (mktemp -d)
cd $temp

@test "_autovenv_get_venv_type: no environment found" (_autovenv_get_venv_type (pwd)) = "unknown"

touch Pipfile
@test "_autovenv_get_venv_type: Pipfile found" (_autovenv_get_venv_type (pwd)) = "pipenv"
rm Pipfile

touch poetry.lock
@test "_autovenv_get_venv_type: poetry.lock found" (_autovenv_get_venv_type (pwd)) = "poetry"
rm poetry.lock

touch requirements.txt
@test "_autovenv_get_venv_type: requirements.txt found" (_autovenv_get_venv_type (pwd)) = "virtualenv"
rm requirements.txt

touch setup.py
@test "_autovenv_get_venv_type: setup.py found" (_autovenv_get_venv_type (pwd)) = "virtualenv"
rm setup.py

rm -rf $temp
