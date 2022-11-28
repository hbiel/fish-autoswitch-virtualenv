@test "enable_autoswitch_virtualenv: AUTOSWITCH_DISABLE is unset" (set -g AUTOSWITCH_DISABLE; enable_autoswitch_virtualenv; set -q AUTOSWITCH_DISABLE) $status -eq 1

@test "disable_autoswitch_virtualenv: AUTOSWITCH_DISABLE is set" (disable_autoswitch_virtualenv; set -q AUTOSWITCH_DISABLE) $status -eq 0
