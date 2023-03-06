export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/crypto-config/ordererOrganizations/ml.com/orderers/orderer.ml.com/msp/tlscacerts/tlsca.ml.com-cert.pem
export PEER0_Herdsman_CA=${PWD}/crypto-config/peerOrganizations/Herdsman.ml.com/peers/peer0.Herdsman.ml.com/tls/ca.crt
export PEER0_Slaughter_CA=${PWD}/crypto-config/peerOrganizations/Slaughter.ml.com/peers/peer0.Slaughter.ml.com/tls/ca.crt
export PEER0_Retailer_CA=${PWD}/crypto-config/peerOrganizations/Retailer.ml.com/peers/peer0.Retailer.ml.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/config/

export CHANNEL_NAME=meatledger

setGlobalsForOrderer(){
    export CORE_PEER_LOCALMSPID="OrdererMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/crypto-config/ordererOrganizations/ml.com/orderers/orderer.ml.com/msp/tlscacerts/tlsca.ml.com-cert.pem
    export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/ordererOrganizations/ml.com/users/Admin@ml.com/msp
    
}

setGlobalsForPeer0Herdsman(){
    export CORE_PEER_LOCALMSPID="HerdsmanMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_Herdsman_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/Herdsman.ml.com/users/Admin@Herdsman.ml.com/msp
    export CORE_PEER_ADDRESS=localhost:7051
}

setGlobalsForPeer1Herdsman(){
    export CORE_PEER_LOCALMSPID="HerdsmanMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_Herdsman_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/Herdsman.ml.com/users/Admin@Herdsman.ml.com/msp
    export CORE_PEER_ADDRESS=localhost:8051
    
}

setGlobalsForPeer0Slaughter(){
    export CORE_PEER_LOCALMSPID="SlaughterMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_Slaughter_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/Slaughter.ml.com/users/Admin@Slaughter.ml.com/msp
    export CORE_PEER_ADDRESS=localhost:9051
    
}

setGlobalsForPeer1Slaughter(){
    export CORE_PEER_LOCALMSPID="SlaughterMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_Slaughter_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/Slaughter.ml.com/users/Admin@Slaughter.ml.com/msp
    export CORE_PEER_ADDRESS=localhost:10051
    
}

setGlobalsForPeer0Retailer(){
    export CORE_PEER_LOCALMSPID="RetailerMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_Retailer_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/Retailer.ml.com/users/Admin@Retailer.ml.com/msp
    export CORE_PEER_ADDRESS=localhost:11051
    
}

setGlobalsForPeer1Retailer(){
    export CORE_PEER_LOCALMSPID="RetailerMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_Retailer_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/Retailer.ml.com/users/Admin@Retailer.ml.com/msp
    export CORE_PEER_ADDRESS=localhost:12051
    
}

createChannel(){
    # rm -rf ./channel-artifacts/*
    setGlobalsForPeer0Herdsman
    
    peer channel create -o localhost:7050 -c $CHANNEL_NAME \
    --ordererTLSHostnameOverride orderer.ml.com \
    -f ./channel-artifacts/${CHANNEL_NAME}.tx --outputBlock ./channel-artifacts/${CHANNEL_NAME}.block \
    --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
}

removeOldCrypto(){
    rm -rf ./api-1.4/crypto/*
    rm -rf ./api-1.4/fabric-client-kv-Herdsman/*
    rm -rf ./api-2.0/Herdsman-wallet/*
    rm -rf ./api-2.0/Slaughter-wallet/*
    rm -rf ./api-2.0/Retailer-wallet/*
}


joinChannel(){
    setGlobalsForPeer0Herdsman
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer1Herdsman
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer0Slaughter
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer1Slaughter
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer0Retailer
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer1Retailer
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    
}

updateAnchorPeers(){
    setGlobalsForPeer0Herdsman
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.ml.com -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}anchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    
    setGlobalsForPeer0Slaughter
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.ml.com -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}anchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

    setGlobalsForPeer0Retailer
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.ml.com -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}anchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    
}

# removeOldCrypto

#create a channel-artifacts folder in this dir before running this file.
# createChannel
# joinChannel
# updateAnchorPeers
