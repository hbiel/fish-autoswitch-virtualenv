set temp (mktemp -d)
cd $temp

printf "printf 'got called'" > ./fake_env
chmod +x ./fake_env
@test "_autovenv_validated_source: script sourced" (_autovenv_validated_source "./fake_env") = "got called"

@test "_autovenv_validated_source: invalid characters" (_autovenv_validated_source "../fake_env" 2> /dev/null) -z

rm -rf $temp
