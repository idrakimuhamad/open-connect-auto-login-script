HOST='xxx.xxxxx.com'
PASSCODE='xxxxxx'
PASSWORD='xxxxxxxxxxxxx'
STAFF_ID='xxxxxx'
TOKEN=$(stoken tokencode -p $PASSCODE)
PIN=$PASSCODE$TOKEN

printf "$STAFF_ID\n$PIN\n$PASSWORD\ny" | /opt/cisco/anyconnect/bin/vpn -s connect $HOST
