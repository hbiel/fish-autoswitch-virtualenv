mock deactivate \* "echo 'got called!'"
@test "_autovenv_deactivate_virtualenv: deactivate available, gets called" (_autovenv_deactivate_virtualenv) = "got called!"

mock type "-q deactivate" "return 1"
@test "_autovenv_deactivate_virtualenv: deactivate not available, doesn't get called" (_autovenv_deactivate_virtualenv) -z
@test "_autovenv_deactivate_virtualenv: deactivate not available, return code is 0" (_autovenv_deactivate_virtualenv) $status -eq 0
