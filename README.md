Installs dogecoind on Ubuntu 12.04.3 x64

Selflessly following this guide:http://www.dogeco.in/wiki/index.php/Compiling_Dogecoind_on_Ubuntu/Debian

After you're done installing, su to the dogecoin user (or ssh) and run 

bin/dogecoind && bin/bin/minerd -a scrypt -o [url]:[port] -O [worker]:[password] -t [threads]

Substitute the desired values of course

!!!!
Make sure to put in your SSH key in the YOURPUBLICRSA
Or comment that line and uncomment the 'passwd dogecoin' line
!!!!

Run with sudo since it's got apt-y stuff in it.

DOGEnations appreciated @ DKg1vamoVEgvsSMFzWjHiPGXSVWX4FFFh6
