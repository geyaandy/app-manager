#!/bin/bash
apppath=/opt/appmanager
if [ ! -d $apppath ];then
	mkdir -p $apppath
elif [ -f "/etc/init.d/appmanager" ];then
	systemctl stop appmanager
	sleep 2
fi


cp -f $apppath/script/appmg_service.sh /etc/init.d/appmanager
chmod 755 /etc/init.d/appmanager

systemctl enable appmanager
systemctl start appmanager

rm -rf /usr/bin/appc
ln -s /opt/appmanager/script/appc.sh /usr/bin/appc
chmod +x /opt/appmanager/script/appc.sh

# insert source to bash, remove in case of any lib conflict
sourcefile=""
if [ -f /etc/bashrc ]; then
	sourcefile=/etc/bashrc
else
	if [ -f /etc/bash.bashrc ]; then
		sourcefile=/etc/bash.bashrc
	else
		sourcefile=/etc/profile
	fi
fi
