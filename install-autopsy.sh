# install autopsy

brew uninstall --ignore-dependencies sleuthkit
brew cleanup
brew tap bell-sw/liberica
brew install liberica-jdk8-full --cask
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
echo 'export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)' | tee >> ~/.bashrc >> ~/.zshrc
brew install ant afflib libewf libpq

echo "PLEASE ENTER YOUR PASSWORD(sudo):"
sudo mkdir /usr/local/opt/
sudo ln -s $JAVA_HOME /usr/local/opt/openjdk

#Build and Install the Sleuthkit
cd ~/Downloads
curl https://github.com/sleuthkit/sleuthkit/releases/download/sleuthkit-4.11.1/sleuthkit-4.11.1.tar.gz -o sleuthkit-4.11.1.tar.gz
tar xzvf sleuthkit-4.11.1.tar.gz
cd sleuthkit-4.11.1
export CPPFLAGS="-I/usr/local/opt/libpq/include"
./configure
make
sudo make install

ifSleu=`ls /usr/local/share/java | grep sleuthkit`

if [[ "$ifSleu" == "" ]]; then
	echo -e "\n\033[1;31mError! Fail to build and install sleuthkit!\033[0m"
	exit
fi

echo -e "\n\033[1;32m$ifSleu installed.\033[0m"

brew install testdisk
brew install gstreamer gst-plugins-base gst-plugins-good
brew install autopsy