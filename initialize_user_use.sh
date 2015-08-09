#!/bin/bash
#Usage(Must with a dot, dot, dot, or the "source ~/.bashrc" will have no effect) : . ./initialize_user_use.sh userNameXXX
echo $1
user_name=`whoami`
user_home_dir=/home/$user_name

function create_if_not_exist()
{
	if [ -d $1 ]; 
	then
		echo "Directory "$1" already exists"
	else
		mkdir -p $1
	fi
}
function create_python2_virtual_env()
{
	echo "--- Create virtual Python2 environment ---"
	py2_path=$user_home_dir/develop/pythons/vpy2
	if [ -d $py2_path ]; then
		echo "Virtual Python2 path already exists, maybe do not need one"
	else
		py2_exe_path=`which python`
		virtualenv --python=$py2_exe_path $py2_path
		echo "alias vpy2=\"source $py2_path/bin/activate\"" >> ~/.bashrc
	fi
	echo -e "--- Finish creating virtual Python2 environment ---\n"
}
function create_python3_virtual_env()
{
	echo "--- Create virtual Python3 environment ---"
	py3_path=$user_home_dir/develop/pythons/vpy3
	if [ -d $py3_path ]; then
		echo "Virtual Python3 path already exists, maybe do not need one"
	else
		py3_exe_path=`which python3`
		virtualenv --python=$py3_exe_path $py3_path
		echo "alias vpy3=\"source $py3_path/bin/activate\"" >> ~/.bashrc
	fi
	echo -e "--- Finish creating virtual Python3 environment ---\n"
}
function install_python_dev()
{
	create_if_not_exist $user_home_dir/develop/pythons
	create_if_not_exist $user_home_dir/develop/pythons/packages
	create_python2_virtual_env
	create_python3_virtual_env
}

# create directories, and install virtual Python environment, and Alias for quickly change into python virtual env
install_python_dev

# Change ~/.bashrc and ~/.bash_profile

# Change prompt showing ways
sed -i 's#\\w#\\W#' ~/.bashrc
echo "alias rm=\"rm -i\"" >> ~/.bashrc
function install_ruby_dev()
{
  # install rvm
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  \curl -sSL https://get.rvm.io | bash
  source /home/ubuntu/.rvm/scripts/rvm
  echo "source /home/ubuntu/.rvm/scripts/rvm" >> ~/.bashrc

  ruby_dir=$user_home_dir/develop/ruby
	create_if_not_exist $ruby_dir
  cd $ruby_dir
  # Check ruby version >= 2.0.0
  ruby_version=`ruby --version | awk '{print $2}' | awk -F'p' '{print $1}' | awk -F'.' '{print $1}'`
  if [ $ruby_version -gt 1 ]; then
          echo "Ruby version >= 2.0, is OK"
  else
          rvm install 2.2.2
  fi
  gem install bundler
  git clone git@github.com:mostevercxz/mostevercxz.github.io.git gitblog
  cd gitblog
  bundle install
}

install_ruby_dev

source ~/.bashrc
