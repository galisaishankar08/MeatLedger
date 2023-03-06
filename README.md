# Meat-Ledger
Meat Ledger is an Integrated Provenance, BLOCKCHAIN Security and Payments Platform.

## Prerequisites

* [Docker](https://www.docker.com/products) - v1.13 or higher
* [Docker Compose](https://docs.docker.com/compose/overview/) - v1.8 or higher
* [NPM](https://www.npmjs.com/get-npm) - v5.6.0 or higher
* [nvm](https://github.com/creationix/nvm/blob/master/README.md) - v8.11.3 (use to download and set what node version you are using)
* [Node.js](https://nodejs.org/en/download/) - node v8.11.3 ** don't install in SUDO mode
* [Git client](https://git-scm.com/downloads) - v 2.9.x or higher
* [Python](https://www.python.org/downloads/) - 2.7.x

## Steps
* To get the install script:
```
curl -sSLO https://raw.githubusercontent.com/hyperledger/fabric/main/scripts/install-fabric.sh && chmod +x install-fabric.sh
```

* Download the v2.2.1 binaries, run this command
```
./install-fabric.sh --fabric-version 2.2.1 binary
```

* Create fabric scripts folder and move config to composer folder
```
mkdir fabric-scripts
cd fabric-scripts

mkdir composer
cd composer

mv ../../config ./
```

* Download crypto-config.yaml, configtx.yaml, create-channel.sh and edit that file as requirements

* Run create-channel.sh and it will result crypto-config folder with organizations folders.
```
chmod +x create-channel.sh
./create-channel.sh
```

* Change dir to fabric-scripts floder
```
cd ..
```

* Download base.yaml, docker-compose.yaml, createChannel.sh and edit that file as requirements

* Now run the network and Docker should be on
```
docker-compose up -d
```

* To down network run this command
```
docker-compose down
```

* create a channel-artifacts folder
```
mkdir channel-artifacts
```

* Run createChannel.sh and it will result a channel file in channel-artifacts <br>
It will createChannel, joinChannel and updateAnchorPeers
```
chmod +x createChannel.sh
./createChannel.sh
```

* Check organisation is in the channel
```
docker exec -it peer0.Herdsman.ml.com sh
peer channel list
```
