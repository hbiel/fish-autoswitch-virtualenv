@test "_autovenv_get_venv_name: special case - pipenv" (_autovenv_get_venv_name "./pipenv-123" "pipenv") = "pipenv"

@test "_autovenv_get_venv_name: standard case" (_autovenv_get_venv_name "./project" "virtualenv") = "project"
