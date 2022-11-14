@test "_autovenv_get_venv_dir: virtualenv basedir (standard)" (_autovenv_get_venv_dir "pipenv123") = "$HOME/.virtualenvs/pipenv123"

set -x AUTOSWITCH_VIRTUAL_ENV_DIR "/tmp"
@test "_autovenv_get_venv_dir: virtualenv basedir (override)" (_autovenv_get_venv_dir "pipenv123") = "/tmp/pipenv123"
