#! /usr/bash
#此安装脚本会覆盖/etc/environment，如果之前/etc/environment文件不为空，请备份源文件。
#安装命令：bash install_java.sh install
#卸载命令：bash install_java.sh uninstall

if [ $1 == "install" ];then
	if [ $USER != "root" ];then
	    myPath=/home/$USER
	else
	    echo "Please exit root user."
	    exit
	fi
	echo "**********************检查安装包*************************"
	if [ ! -e "$myPath/Downloads/JRE.tar.gz" ];then
		echo "*********************安装包不存在************************"
	    sudo apt-get update
	    sudo apt-get install curl
	    pageCode="$(curl https://www.java.com/zh_CN/download/linux_manual.jsp)"
	    pageCode=${pageCode%%下载 Java 软件 Linux x64 RPM*}
	    pageCode=${pageCode% onclick=*}
	    url=${pageCode##*href=}
	    url=${url:1:-1}
		wget -O$myPath/Downloads/JRE.tar.gz $url
	    echo "***********************下载完成**************************"
	fi
	cd $myPath/Downloads/
	echo "**********************解压安装包*************************"
	dirName=$(find jre* -type d)
	dirName=${dirName%%/bin*}
	len=${#dirName}
	len=$((len))
	len=$(((len-1)/2))
	dirName=${dirName::$len}
	if [ -z "$dirName" ];then
	    tar xzf ./JRE.tar.gz
	fi
	echo "***********************解压完成*************************"
	#获得解压后的文件夹名称
	dirName=$(find jre* -type d)#寻找路径包含jre的文件夹
	dirName=${dirName%%/bin*}  #删掉第二个路径bin之后的字符串
	len=${#dirName}             #获得剩下字符串长度 两个重复路径中间加一个空格
	len=$((len))                 #字符串转数字
	len=$(((len-1)/2))           #计算单个路径字符串长度
	dirName=${dirName::$len}    #截取前len个字符，就是路径
	#判断JAVA文件夹是否存在
	if [ ! -d "/usr/java" ]; then
		sudo mkdir /usr/java
	fi
	echo "*********************复制解压后的文件*********************"
	sudo cp -a ./$dirName /usr/java
	echo "**********************添加环境变量***********************"
	sudo sh -c 'echo "JAVA_HOME=\"/usr/java/$dirName\"" > /etc/environment'
	sudo sh -c 'echo "CLASSPATH=\"$JAVA_HOME/lib\"" >> /etc/environment'
	sudo sh -c 'echo "PATH＝\"$JAVA_HOME/bin\"" >> /etc/environment'
	echo "********************环境变量添加完成**********************"
	sudo update-alternatives --install /usr/bin/java java /usr/java/$dirName/bin/java 300
	echo "***********************安装完成**************************"
	echo 0 | sudo update-alternatives --config java
	echo "***********************配置完成**************************"
elif [ $1 == "uninstall" ];then
	uninstallDir=$(update-alternatives --display java)
	uninstallDir=${uninstallDir#*为 }
	uninstallDir=${uninstallDir%% 链*}
	echo "***********************开始卸载**************************"
	sudo update-alternatives --remove java $uninstallDir
	sudo rm -r /usr/java
	echo "***********************卸载完成**************************"
fi










