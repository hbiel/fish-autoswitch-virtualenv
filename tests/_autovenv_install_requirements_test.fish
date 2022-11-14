set temp (mktemp -d)
cd $temp

mock pip \* "echo \$argv"

mkdir $temp/default_requirements
cd $temp/default_requirements
touch test_requirements.txt
set -x AUTOSWITCH_DEFAULT_REQUIREMENTS "test_requirements.txt"
@test "_autovenv_install_requirements: install from default requirements" (printf "y" | _autovenv_install_requirements) = "install -r test_requirements.txt"
set -e AUTOSWITCH_DEFAULT_REQUIREMENTS

mkdir $temp/setup.py
cd $temp/setup.py
touch setup.py
@test "_autovenv_install_requirements: install from setup.py" (printf "y" | _autovenv_install_requirements) = "install -e ."

set -x AUTOSWITCH_PIPINSTALL "FULL"
@test "_autovenv_install_requirements: install from setup.py (FULL)" (printf "y" | _autovenv_install_requirements) = "install ."
set -e AUTOSWITCH_PIPINSTALL

mkdir -p $temp/requirements/sub1/sub2
cd $temp/requirements
touch requirements.txt
touch sub1/requirements.txt
touch sub1/sub2/more_requirements.txt
@test "_autovenv_install_requirements: install from **/*requirements.txt" (printf "y\ny\ny" | _autovenv_install_requirements | string collect) = "install -r requirements.txt
install -r sub1/requirements.txt
install -r sub1/sub2/more_requirements.txt"

rm -rf $temp
