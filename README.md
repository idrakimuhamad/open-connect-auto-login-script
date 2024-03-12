# Auto VPN connection with OpenConnect 

A script to automate (semi-automate) the login process through OpenConnect

## Getting started

You are going to need below items before you can proceed:

* Install `openconnect` using brew. If you don't have brew, install it first.
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

Once this is done, proceed to edit the `config.cfg` file with your data.

Run below to give the `vpn.sh` permission

```sh
chmod 755 vpn.sh
```

The script provided way to connect to VPN with our without splitting. To use the splitting feature, you need to install [`vpn-slice`](https://github.com/dlenski/vpn-slice) first.