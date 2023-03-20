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
mkdir Hyperledger
cd Hyperledger
curl -sSLO https://raw.githubusercontent.com/hyperledger/fabric/main/scripts/install-fabric.sh && chmod +x install-fabric.sh
```

* Download the v2.2.1 binaries, run this command
```
./install-fabric.sh --fabric-version 2.2.1 binary
```

* Configure bin path in bashrc file
```
nano ~/.bashrc
export PATH=$PATH:/home/user/Hyperledger/bin
```

* Clone github Repository
```
git clone https://github.com/galisaishankar08/MeatLedger.git
```

* Edit crypto-config.yaml, configtx.yaml, create-channel.sh file as your requirements

* create a channel-artifacts folder
```
mkdir channel-artifacts
```

* Run generate.sh and it will result crypto-config folder with organizations folders.
```
chmod +x generate.sh
./generate.sh
```

* Edit base.yaml, docker-compose.yaml, create_join_Channel.sh.sh the files as your requirements

* Now run the network and Docker should be on
```
docker-compose up -d
```

* To down network run this command
```
docker-compose down
```
* Frome here onwards network should up 

* Run create_join_Channel.sh and it will result a channel file in channel-artifacts <br>
It will createChannel, joinChannel and updateAnchorPeers
```
chmod +x create_join_Channel.sh
./create_join_Channel.sh
```

* Check organisation is in the channel
```
docker exec -it peer0.Herdsman.ml.com sh
peer channel list
```
