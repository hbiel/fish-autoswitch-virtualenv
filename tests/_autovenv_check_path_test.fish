set temp (mktemp -d)
cd $temp

@test "_autovenv_check_path: no environment found" (_autovenv_check_path ".") -z

mkdir -p venv/sub1/sub2
touch venv/.venv
@test "_autovenv_check_path: .venv found" (_autovenv_check_path "./venv/sub1/sub2") = "./venv/.venv"

mkdir -p poetry/sub1/sub2
touch poetry/poetry.lock
@test "_autovenv_check_path: poetry.lock found" (_autovenv_check_path "./poetry/sub1/sub2") = "./poetry/poetry.lock"

mkdir -p pipenv/sub1/sub2
touch pipenv/Pipfile
@test "_autovenv_check_path: Pipfile found" (_autovenv_check_path "./pipenv/sub1/sub2") = "./pipenv/Pipfile"

rm -rf $temp
