# anyconnect-auto-login-script

A script to automate (semi-automate) the login process to Cisco AnyConnect Mobility Client.

## Before started

You are going to need below items before you can proceed:

* the `.stid` file. Usually you get this file from your VPN administrator
* `stoken` must be installed first. install using brew. If you don't have brew, install it first
* validate that you do have VPN client installed
* the VPN hostname
* the script assume that for the first password, its a combination of PIN + secure ID PIN. If yours doesn't use this combination, update it per your use case

## Setup

We need to import the `.stid` with `stoken` before getting started. To install `stoken`, run brew script below

```
brew install stoken
```

Run the script below to import the `.stid`

```sh
stoken import --file=<PATH_TO_STID_FILE>.sdtid
```

It will ask that you set your password to dencrypt the pin, make sure to use the same PIN that you use in the mobility app (assuming you're having two password)

Once it is done, run the below and compare it with your SecureID app making sure its matching.

```sh
stoken tokencode
```

Once this is done, proceed to edit the `vpn.sh` file with your data.

### Update the script

```sh
HOST='HOST_URL.com'
PASSCODE='123456' // secure id pin
PASSWORD='PASSWORD' // your company password
STAFF_ID='11111' // your VPN username
TOKEN=$(stoken tokencode -p $PASSCODE) // this will generate the token for secureID
PIN=$PASSCODE$TOKEN // for my case, the first password is a combination of the PASSCODE + TOKEN

printf "$STAFF_ID\n$PIN\n$PASSWORD\ny" | /opt/cisco/anyconnect/bin/vpn -s connect $HOST
```

The flag `y` in the script is for Prompt Banner. If you do not have that case, remove it.

Save it, and run below to give it permission

```sh
chmod 755 vpn.sh
```

Run it and see if its working. Should see something like below:

```sh
Cisco AnyConnect Secure Mobility Client (version 4.8.00175) .

Copyright (c) 2004 - 2019 Cisco Systems, Inc.  All Rights Reserved.


  >> state: Disconnected
  >> state: Disconnected
  >> notice: Ready to connect.
  >> registered with local VPN subsystem.
  >> contacting host (xxx.xxxx.com) for login information...
  >> notice: Contacting xxx.xxxx.com.

  >> Awaiting user input.

Username: [xxxxxx] xxxxxx
Passcode:
Second Password:
  >> notice: Please respond to banner.

This system is a property of XXXXXX and is a private system. All access is monitored and logged. Unauthorized use is prohibited and illegal access will be prosecuted to the full extent of the law.

Permission assigned: XXXXXXXXXX

  >> state: Connecting
  >> notice: Establishing VPN session...
  >> notice: The AnyConnect Downloader is performing update checks...
  >> notice: Checking for profile updates...
  >> notice: Checking for customization updates...
  >> notice: Performing any required updates...
  >> notice: The AnyConnect Downloader updates have been completed.
  >> state: Connecting
  >> notice: Establishing VPN session...
  >> notice: Establishing VPN - Initiating connection...
  >> notice: Establishing VPN - Examining system...
  >> notice: Establishing VPN - Activating VPN adapter...
  >> notice: Establishing VPN - Configuring system...
  >> notice: Establishing VPN...
  >> state: Connected
```

Test your connection and make sure stuff's working.

The script `disconnectVpn.sh` will disconnect the connection. When run, it will show something like below.

```sh
Cisco AnyConnect Secure Mobility Client (version 4.8.00175) .

Copyright (c) 2004 - 2019 Cisco Systems, Inc.  All Rights Reserved.


  >> state: Connected
  >> state: Connected
  >> registered with local VPN subsystem.
  >> state: Disconnecting
  >> notice: Disconnect in progress, please wait...
  >> state: Connected
  >> notice: Connected to vpn.rhbgroup.com.
  >> state: Disconnecting
  >> notice: Disconnect in progress, please wait...
  >> state: Disconnecting
  >> state: Disconnected
```

Done.

You can go beyond by creating an alias to the script to make it easier to trigger it anytime.
