#!/usr/bin/env bash

DB2SETUPFILE=v11.1.4fp4a_linuxx64_server_t.tar.gz

echo -e "--- DB2 11.1 on Centos 7 ---"

if [ ! -f /vagrant/$DB2SETUPFILE ]; then
   echo "File does not exist"
   exit 1
fi

echo -e "*** Update OS packages"

yum update -y

yum install -y ksh
yum install -y glibc
yum install -y libstdc++
yum install -y glibc
yum install -y glibc-locale
yum install -y glibc-locale-32bit
yum install -y glibc-locale-64bit
yum install -y libstdc++.so.5
yum install -y compat-libstdc++-33
#yum install -y tree
yum install -y libstdc++.so.6
yum install -y pam-devel.i686
yum install -y pam-devel.x86_64
yum install -y pam.i686
yum install -y pam.x86_64
yum install -y redhat-lsb
yum install -y ntp
yum install -y git
yum install -y libaio.so.1

yum install -y gcc-c++
yum install -y libaio

echo -e "*** Install JDK"
yum install -y java-1.8.0-openjdk

echo -e "*** Disable selinux"
sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config
setenforce 0


echo -e "*** Untar db2"
mkdir -p /opt/softinst
tar xvf /vagrant/$DB2SETUPFILE -C /opt/softinst

echo -e "*** Creating response file"
echo "
LIC_AGREEMENT       = ACCEPT
PROD       = DB2_SERVER_EDITION
FILE       = /opt/ibm/db2/V11.1
INSTALL_TYPE       = TYPICAL
DAS_CONTACT_LIST       = LOCAL
INSTANCE       = inst1
inst1.TYPE       = ese
*  Instance-owning user
inst1.NAME       = db2inst1
inst1.GROUP_NAME       = db2iadm1
inst1.HOME_DIRECTORY       = /db2home/db2inst1
inst1.PASSWORD       = db2inst1pwd
inst1.AUTOSTART       = YES
inst1.SVCENAME       = db2c_db2inst1
inst1.PORT_NUMBER       = 50001
inst1.FCM_PORT_NUMBER       = 60000
inst1.MAX_LOGICAL_NODES       = 6
inst1.CONFIGURE_TEXT_SEARCH       = NO
*  Fenced user
inst1.FENCED_USERNAME       = db2fenc1
inst1.FENCED_GROUP_NAME       = db2fadm1
inst1.FENCED_HOME_DIRECTORY       = /db2home/db2fenc1
inst1.FENCED_PASSWORD       = db2fenc1pwd
*  Installed Languages
LANG       = EN" > /opt/db2-inst1.rsp

echo -e "*** Install database"
/opt/softinst/server_t/db2setup -r /opt/db2-inst1.rsp
