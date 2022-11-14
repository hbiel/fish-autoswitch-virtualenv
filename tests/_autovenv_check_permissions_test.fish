set temp (mktemp -d)
cd $temp

touch testfile
@test "_autovenv_check_permissions: user is owner and has permission" (_autovenv_check_permissions "./testfile") $status -eq 0

chmod +777 testfile
@test "_autovenv_check_permissions: user doesn't have permission" (_autovenv_check_permissions "./testfile" > /dev/null ) $status -eq 1

rm -rf $temp
