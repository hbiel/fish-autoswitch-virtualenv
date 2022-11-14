set temp (mktemp -d)
cd $temp

printf "printf 'fake 1.2.3'" > ./fake_python
chmod +x ./fake_python
@test "_autovenv_get_python_version: get python version" (_autovenv_get_python_version "./fake_python") = "fake 1.2.3"

@test "_autovenv_get_python_version: python not existing" (_autovenv_get_python_version "no_python") = "unknown"

rm -rf $temp
