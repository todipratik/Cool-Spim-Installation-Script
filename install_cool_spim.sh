: '
	Author: Pratik Todi, Anirudh Nain
	September 22, 2015
	Installs cool and spim tools in Ubuntu (32-bit and 64-bit)
'

#!/bin/bash

# Installing the tools
sudo apt-get update 
sudo apt-get install flex
sudo apt-get install bison
sudo apt-get --assume-yes install flex bison build-essential csh openjdk-6-jdk libxaw7-dev libc6-i386
if ! [ -d /usr/class ];
then
	sudo mkdir /usr/class
fi
sudo chown $USER /usr/class
cd /usr/class
if [ -f student-dist.tar.gz ];
then
	rm -f student-dist.tar.gz
fi
wget http://spark-university.s3.amazonaws.com/stanford-compilers/vm/student-dist.tar.gz
if [ -d cs143 ];
then
	rm -rf cs143
fi
tar -xvzf student-dist.tar.gz
if ! grep -q "export PATH=/usr/class/cs143/cool/bin:$PATH" ~/.bashrc;
then
	echo "export PATH=/usr/class/cs143/cool/bin:$PATH" >> ~/.bashrc
fi
if [ -f ~/.bash_aliases ];
then
	. ~/.bash_aliases
fi
str=`uname -m`
if [ $str = "x86_64" ];
then
	sudo apt-get --assume-yes install libc6-i386
fi

echo "Installation complete"


# Compiling the examples in /cs143/examples
cd /usr/class/cs143/examples
files=`ls *.cl`
for file in $files
do
	coolc $file
done

# Executing the assembly code
files=`ls *.s`
for file in $files
do
	echo -e "\n\n"Executing $file"\n"
	spim $file
done