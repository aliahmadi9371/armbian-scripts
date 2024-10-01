ppp

https://blog.enchose.com/raspberry-pi-runs-ppp-dial-up-quectel-ec25-lte-modem/

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install ppp

Create ppp-creator.sh with below script and put it into the Pi

#!/bin/sh

echo "install ppp"
apt-get install ppp

echo "creating directories"
mkdir -p /etc/ppp/peers

echo "creating script file : /etc/ppp/peers/quectel-chat-connect"
echo "
ABORT \"BUSY\"
ABORT \"NO CARRIER\"
ABORT \"NO DIALTONE\"
ABORT \"ERROR\"
ABORT \"NO ANSWER\"
TIMEOUT 30
\"\" AT
OK ATE1
OK ATI;+CSUB;+CSQ;+CPIN?;+COPS?;+CGREG?;&D2
# Insert the APN provided by your network operator, default apn is $1
OK AT+CGDCONT=1,\"IP\",\"\\T\",,0,0
OK ATD*99#
CONNECT" > /etc/ppp/peers/quectel-chat-connect


echo "creating script file : /etc/ppp/peers/quectel-chat-disconnect"
echo "
ABORT \"ERROR\"
ABORT \"NO DIALTONE\"
SAY \"\nSending break to the modem\n\"
\"\"  +++
\"\"  +++
\"\"  +++
SAY \"\nGoodbay\n\"" > /etc/ppp/peers/quectel-chat-disconnect


echo "creating script file : /etc/ppp/peers/quectel-ppp"
echo "
/dev/$2 115200
user \"\"
password \"\"
# The chat script, customize your APN in this file
connect 'chat -s -v -f /etc/ppp/peers/quectel-chat-connect -T $1'
# The close script
disconnect 'chat -s -v -f /etc/ppp/peers/quectel-chat-disconnect'
# Hide password in debug messages
hide-password
# The phone is not required to authenticate
noauth
# Debug info from pppd
debug
# If you want to use the LTE link as your gateway
defaultroute
# pppd must not propose any IP address to the peer
noipdefault
# No ppp compression
novj
novjccomp
noccp
ipcp-accept-local
ipcp-accept-remote
local
# For sanity, keep a lock on the serial line
lock
modem
dump
nodetach
# Hardware flow control
nocrtscts
remotename 3gppp
ipparam 3gppp
ipcp-max-failure 30
# Ask the peer for up to 2 DNS server addresses
usepeerdns" > /etc/ppp/peers/quectel-ppp

echo "\n\nUse \"sudo pppd call quectel-ppp\" command and go internet"


Type chmod +x ./ppp-creator.sh

Type sudo ./ppp-creator.sh Irancell ttyUSB3 (Note: Irancell is your APN name) --> Irancell
Type sudo pppd call quectel-ppp persist to keep PPP connect up，from ifconfig we will find ppp0 up，in this time we 
Type sudo ip route add 0.0.0.0/0 dev ppp0 to make all packets going via ppp0

If you want to disconnect PPP, just running killall pppd




sudo chattr +i /etc/resolv.conf -> can not remove or edit file 
sudo chattr -i /etc/resolv.conf -> can remove or edit file


AT+CMGF=1
AT+CSCS="GSM"
AT+CNMI=2,1,0,0,0
AT+CSMP=17,167,0,0


AT+CPMS="ME","ME","ME"
AT+CMGL="ALL"