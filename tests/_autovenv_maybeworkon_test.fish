set temp (mktemp -d)
cd $temp

@test "_autovenv_maybeworkon: venv not found" (_autovenv_maybeworkon "./nonexistent" "virtualenv" | string collect) = (printf "Unable to find \e[35mnonexistent\e(B\e[m virtualenv
If the issue persists run \e[35mrmvenv\ &&\ mkvenv\e(B\e[m in this directory\n" | string collect)

mkdir ./venv1
mkdir ./venv2

mock _autovenv_get_python_version \* "echo 1.2.3"
mock _autovenv_validated_source \* "return 0"
@test "_autovenv_maybeworkon: activate venv1" (_autovenv_maybeworkon "./venv1" "virtualenv" | string collect) = (printf "Switching virtualenv \e[35mvenv1\e(B\e[m \e[32m[1.2.3]\e(B\e[m" | string collect)

set -x AUTOSWITCH_MESSAGE_FORMAT "message format test %venv_type"
@test "_autovenv_maybeworkon: message format can be overwritten" (_autovenv_maybeworkon "./venv1" "virtualenv") = "message format test virtualenv"
set -e AUTOSWITCH_MESSAGE_FORMAT

set -x VIRTUAL_ENV "venv1"
@test "_autovenv_maybeworkon: venv1 is active, switch to venv2" (_autovenv_maybeworkon "./venv2" "virtualenv" | string collect) = (printf "Switching virtualenv \e[35mvenv2\e(B\e[m \e[32m[1.2.3]\e(B\e[m" | string collect)

set -x VIRTUAL_ENV "testenv2"
mock _autovenv_validated_source \* "return 1"
@test "_autovenv_maybeworkon: venv2 is active, don't activate again" (_autovenv_maybeworkon "./venv" "virtualenv" > /dev/null ) $status -eq 0

rm -rf $temp
