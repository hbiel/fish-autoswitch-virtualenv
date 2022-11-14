@test "_autovenv_autoswitch_message: message get's printed" (_autovenv_autoswitch_message "123") = "123"

@test "_autovenv_autoswitch_message: message can be formatted" (_autovenv_autoswitch_message "%s" (set_color magenta)"123"(set_color normal) | string collect) = (printf "\e[35m123\e(B\e[m" | string collect)

set -x AUTOSWITCH_SILENT "true"
@test "_autovenv_autoswitch_message: message can be hidden" (_autovenv_autoswitch_message "123") -z
