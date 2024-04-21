### VIDEO https://youtu.be/OEVR5mNV2ac ###

Add REP: 
    
    echo 'deb http://ftp.debian.org/debian buster-backports main' | sudo tee
    /etc/apt/sources.list.d/buster-backports.list

    sudo apt update
    sudo apt install wireguard
    sudo apt install iptables


#Generate Private and Public keys.
    
    wg genkey | sudo tee /etc/wireguard/privatekey | wg pubkey | sudo tee
    /etc/wireguard/publickey

#Check interface name
     
     ip -o -4 route show to default | awk '{print $5}'

#Create Server Configuration:

     sudo nano /etc/wireguard/wg0.conf

#Paste following to the file.

    [Interface]
    Address = 10.0.0.1/24
    SaveConfig = true
    ListenPort = 51820
    PrivateKey = SERVER_PRIVATE_KEY
    PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j
    MASQUERADE
    PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j
    MASQUERADE

#Save the File


#Start the wg config.

    sudo wg-quick up wg0

#Output should be:

    [#] ip link add wg0 type wireguard
    [#] wg setconf wg0 /dev/fd/63
    [#] ip -4 address add 10.0.0.1/24 dev wg0
    [#] ip link set mtu 1420 up dev wg0
    [#] iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o ens3 -j
    MASQUERADE

#See more details:

    sudo wg show wg0
    interface: wg0
    public key: +Vpyku+gjVJuXGR/OXXt6cmBKPdc06Qnm3hpRhMBtxs=
    private key: (hidden)
    listening port: 51820

#See the ip for the vpn.

    ip a show wg0

4: wg0: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1420 qdisc noqueue state UNKNOWN
group default qlen 1000
link/none
inet 10.0.0.1/24 scope global wg0
valid_lft forever preferred_lft forever

#Enable to start with system

    sudo systemctl enable wg-quick@wg0

#Allow ipv4 forward.

    sudo nano /etc/sysctl.conf
    // net.ipv4.ip_forward=1 > net.ipv4.ip_forward=1 (remove comment "//")
    #Apply the changes.
    sysctl -p
    
#Output should be:

    net.ipv4.ip_forward = 1

#Create client config.

    nano /etc/wireguard/wg1.conf

#Paste the following to the file.
#Change the lines to your keys and ip addr!

    [Interface]
    PrivateKey = CLIENT_PRIVATE_KEY
    Address = 10.0.0.2/24
    DNS = 1.1.1.1, 8.8.8.8
    [Peer]
    PublicKey = SERVER_PUBLIC_KEY
    Endpoint = SERVER_IP_ADDRESS:51820
    AllowedIPs = 0.0.0.0/0

#Save the file and add the client public key with following command.

    sudo wg set wg0 peer CLIENT_PUBLIC_KEY allowed-ips 10.0.0.2
    Watch wg show

#Connect to the vpn from PC/Phone

#TO export the config to a qr-code install the following.

    sudo apt install qrencode

#then use the command (You need to be in the same dir as the conf file /etc/wireguard)

    qrencode -t ansiutf8 < wg1.conf

#Scan the QR code from your phone.
