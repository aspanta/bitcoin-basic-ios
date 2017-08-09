Bitcoin Basic iOS Application
===================


Bitcoin Basic iOS app is a remote controller for the Bitcoin Core Wallet running on your computer or hosted server in a daemon mode.
Available to download at https://itunes.apple.com/us/app/bitcoin-basic/id1235523651.

How to configure the Bitcoin Core Wallet
-------------

Please update the **bitcoin.conf** as follows:

```
listen=1
server=1
daemon=1
rpcport=8332
rpcallowip=0.0.0.0/0
```

And then restart the wallet.

How to connect to the Bitcoin Core Wallet
-------------

 - Install the "Bitcoin Basic" iOS app to your mobile device
 - Run the app
 - Specify all necessary details as requested by the app
