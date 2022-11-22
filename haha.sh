#!/bin/bash

#~ 1. Submit the source code (.sh) and a pdf file with screenshots proving the functions work.
#~ 2. Use comments in your code (.sh) to explain what you did.
#~ 3. If you are using code from the internet, add credit and links.
#~ 4. In the script, write the student's name and code, the class code, and the lecturer's name.
#~ 5. In the pdf, explain each part what your code is about and what was it trying to achieve and the results

#~ student name lee yi yang janson
#~ code s7
#~ the class code cfc2407
#~ lecturer's name james

#~ 1.Install relevant applications on the local computer

#~ https://github.com/htrgouvea/nipe
#~ Nipe is to access TOR on command line and scripting to make us anonymous
function install(nipe)
#~ Download and move into the nipe folder
{ 	git clone https://github.com/htrgouvea/nipe && cd nipe
	
	#~ Install libs and dependencies
	sudo cpan install Try::Tiny Config::Simple JSON
	
#~ Nipe must be run as root
	sudo perl nipe.pl install
	
}

install
#~ pwd is to show which directory we are at
pwd
#~ change directory into nipe in order to start nipe
cd nipe

#~ start and check status of nipe, sudo perl nipe.pl start is to start the nipe tool and sudo perl nipe.pl status is to check the status after starting the service

function anonymous
{ sudo perl nipe.pl start
}
{ sudo perl nipe.pl status  
}
#~ curl ifconfig.io/country_code is to check our ipaddress after starting and activated nipe service
{ curl ifconfig.io/country_code
}
	echo 'you are anonymous'
	
#~ sshpass is a utility designed for running ssh and scp, Using sshpass you can use passwords to ssh or scp command without interactions
#~ connection and scan
sshpass -p 'tc' ssh tc@192.168.244.131 'nmap 151.101.195.5 -oG final1.scan ;  sudo -S <<< tc masscan 151.101.195.5 -p 20-80 > final2.scan ; whois 151.101.195.5 > final3.scan'
#~ by using sshpass we can access ssh or scp without interaction as -p 'tc' is to tell this is the password so that we wont have to type in password when it is required to type in the password normally
#~ once connected through ssh we did a nmap of <ip address> -oG is to save the file in a grepable format and save into file1.scan
#~ masscan needed sudo in order to start so we do a sudo -S(allow us to pipe password from command/file or do a <<< (passwd) to inject the password directly, masscan <ipaddress> -p 20-80( which is the port to scan is 20 to 80) and >( which is to inject/save file) to file2.scan(file name)
#~ Whois is a widely used Internet record listing that identifies who owns a domain and how to get in contact

pwd
#~ print working directory
cd ..
#~ change directory .. is to move back one directory, as we need to move to nipe folder in order to start nipe, and we move back one directory to save the file which we scaned into the current folder

#~ saving file to local computer
sshpass -p 'tc' scp tc@192.168.244.131:~/final1.scan .
sshpass -p 'tc' scp tc@192.168.244.131:~/final2.scan .
sshpass -p 'tc' scp tc@192.168.244.131:~/final3.scan .

#~ sshpass to input the password so we can do it without interaction, and scp(is a means to secure copy between machines) <host>@<ipaddress>
