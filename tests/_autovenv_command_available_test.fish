@test "_autovenv_command_available: command is available" (_autovenv_command_available fish) $status -eq 0

@test "_autovenv_command_available: command is not available" (_autovenv_command_available not_a_valid_command > /dev/null) $status -eq 1
