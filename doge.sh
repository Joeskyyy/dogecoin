# Installs dogecoind on Ubuntu 12.04.3 x64
#
# Selflessly following this guide:http://www.dogeco.in/wiki/index.php/Compiling_Dogecoind_on_Ubuntu/Debian
#
# After you're done installing, su to the dogecoin user (or ssh) and run 
# bin/dogecoind && bin/bin/minerd -a scrypt -o [url]:[port] -O [worker]:[password] -t [threads]
# Substitute the desired values of course
# !!!!
# Make sure to put in your SSH key in the YOURPUBLICRSA
# Or comment that line and uncomment the 'passwd dogecoin' line
# !!!!
#
# DOGEnations appreciated @ DKg1vamoVEgvsSMFzWjHiPGXSVWX4FFFh6

#Get updates
apt-get update && apt-get -y upgrade

#Install essentials
apt-get install -y ntp git build-essential libssl-dev libdb-dev libdb++-dev libboost1.48-all-dev libqrencode-dev ia32-libs zip unzip vim
wget http://miniupnp.free.fr/files/download.php?file=miniupnpc-1.8.tar.gz
tar -zxf download.php\?file\=miniupnpc-1.8.tar.gz
cd miniupnpc-1.8/
make
make install
cd ..
rm -rf miniupnpc-1.8 download.php\?file\=miniupnpc-1.8.tar.gz
echo

#Compile Dogecoind
echo "Compiling dogecoin"
git clone https://github.com/dogecoin/dogecoin
cd dogecoin/src
make -f makefile.unix USE_UPNP=1 USE_QRCODE=1
strip dogecoind
echo

#Set up dogecoin user
echo "Setting up dogecoin user"
useradd dogecoin -d /home/dogecoin -m -G users -s /bin/bash
chmod 0701 /home/dogecoin
# Uncomment if you want to set a password, note, you will be prompted during this
#passwd dogecoin
echo 'dogecoin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
mkdir /home/dogecoin/.ssh
echo 'YOURPUBLICRSA' >> /home/dogecoin/.ssh/authorized_keys
mkdir /home/dogecoin/bin
cp ~/dogecoin/src/dogecoind  /home/dogecoin/bin/dogecoind
chown -R dogecoin:users /home/dogecoin/bin
cd && rm -rf dogecoin

cd /home/dogecoin && bin/dogecoind
sleep 2
mkdir -p /home/dogecoin/.dogecoin
cp -f ~/.dogecoin/* /home/dogecoin/.dogecoin

echo -e 'daemon=1\nrpcuser=dogecoinrpc\nrpcpassword=FHyvZWfNWTG5VGgpSxe6Qd9TkFryi83THjSy5KxH6iZU' > /home/dogecoin/.dogecoin/dogecoin.conf
chmod 0600 /home/dogecoin/.dogecoin/dogecoin.conf

# Get latest blockchain
cd /home/dogecoin/.dogecoin
wget http://doge.rstreefland.com/dogechains/blockchain.zip
unzip -o blockchain.zip
rm -f blockchain.zip
chown -R dogecoin:users /home/dogecoin/

cd .. && bin/dogecoind

#Install minerd
wget http://sourceforge.net/projects/cpuminer/files/pooler-cpuminer-2.3.2-linux-x86.tar.gz/download

tar -zxf download
mv minerd /home/dogecoin/bin
chown dogecoin:users /home/dogecoin/bin/minerd
chmod 0700 /home/dogecoin/bin/minerd
rm -f download
