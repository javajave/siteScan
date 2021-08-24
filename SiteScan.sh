#!/bin/bash

############Varbs###########
StartPath=$ChoosePath/Web-down
LogPath=$ChoosePath/Web-down/Logs
InfoPATH=$ChoosePath/Web-down/Sites
SitePATH=$ChoosePath/Web-down/List-of-sites/site.list
############Varbs###########

function CREATION() { #create the directores for each site 
	

cd $ChoosePath
if [ ! -d Web-down ]; then ##create pro2
	sudo mkdir Web-down
fi
	cd Web-down
if [[ ! -d List-of-sites ]]; then ##create List-of-sites
	mkdir List-of-sites
	cd List-of-sites
	
##create all the files
	sudo bash -c 'echo "https://hezbollah.org/" > site.list'
	sudo chmod 777 site.list 2>/dev/null
	echo "www.alaraby.co.uk" >> site.list
	sudo bash -c 'echo " " >> all-add-http-sites'
	sudo chmod 777 all-add-http-sites 2>/dev/null
	sudo bash -c 'echo " " >> all-add-https-sites'
	sudo chmod 777 all-add-https-sites 2>/dev/null
	###
	cd ../
fi
if [[ ! -d Sites ]]; then ##create Sites
	mkdir Sites
fi
if [[ ! -d HASHES ]]; then ##create Sites
	mkdir HASHES
fi
if [[ ! -d Logs ]]; then ##create Notes
	mkdir Logs	
fi

				###Resets the files
	cd Logs 
	sudo bash -c 'echo ""------------------$(date)------------------"" >> GeneralInfo.log'
	sudo chmod 777 all-add-http-sites 2>/dev/null
	sudo bash -c 'echo ""------------------$(date)------------------"" >> Tools.log'
	sudo chmod 777 all-add-https-sites 2>/dev/null
				###

cd $StartPath

	
}

function StartQuestions() { #All the variables I want the user to select
	
	figlet "welcome to Web_stigno"
	sleep 1

banner()
{
  echo "+------------------------------------------+"
  printf "| %-40s |\n" "`date`"
  echo "|                                          |"
  printf "|`tput bold` %-40s `tput sgr0`|\n" "$@"
  echo "+------------------------------------------+"
}

banner "Lets start"
sleep 1

	echo "But first, I have some questions for you .."
	echo "Which pill will you choose? (Red /lue)"
	sleep 3
	echo "just kidding.. :P" 
	sleep 1
	read -p "Do you want to enter a path to the place the informaition wiil be save (y/n) [Default -- /home/kali] " YesNo
if [ $YesNo = y ];then 
		read -p "What is your path ? " ChoosePath
fi
	
	#read -p "Select the recursive level for the web downloads. 1-Most limited, 5-Most extensive? " RecursiveLevel
	#read -p "Select the rate limit for the web downloads (in KB.. 100, 200, 300, 400, etc? " RateLimit
	
	read -p "Do you want to add different file types to search in the site beyond: [*]jpg, jpeg, png, gif, pdf, exe[*] ?(y/n) " YesNo
if [ $YesNo = y ];then 
		read -p "What is the file types ? " DiffrentFileType
fi
	
	
	
echo "Do you wont to add website for scanning to the list? (y/n)"; read YesNo
	
	if [ $YesNo == y ]; then
	echo "Do you want to write the sites(1), or the file is preloaded on the computer(2)?"; read onetwo #ask if the user want to write to link the path to the sites
		if [ $onetwo == 1 ];then
		echo "Enter the urls"; read SITEURL
		echo "$SITEURL" >> $SitePATH #add the required site to the list
		elif [ $onetwo == 2 ];then
		echo "Enter the path to the file"; read LISTURLPATH
		cat $LISTURLPATH >> $SitePATH #add the required sites path to the list
		else
		echo "The wording is not acceptable, please try again"
		echo "-----------------------------------------------"
		WEB-LIST #if the answer isnt in the required  format 
		fi
		
	elif [ $YesNo == n ]; then
	echo "Continue"
	else
	echo "The wording is not acceptable, please try again"
	echo "-----------------------------------------------"
	WEB-LIST
	fi
	
	
	
read -p "Do you want to add the site the sctipt find to the list of sites? (y/n) " AddSiteAsnwer
CREATION
}

StartQuestions

function WE-ALL-ONE-LOP() { # all the info about download the web

while true
do

for Site in  $(cat $SitePATH) ; do

function TOOLS() { #All tools will be activated only if this is the first crawl of the site, or a new file is discovered

function DELETE() { #If there was a download problem, it will delete the site's folder
	
	cd $InfoPATH/$WebDir 
	sudo rm -rf AllPicters MoreSites hezbollah.org
	for dir in $(ls) ; do cd $dir ;  if [ -z $(ls) ] ; then cd ../ ; sudo rm -rf $dir ; else cd ../ ; fi ; done #remove all empty directorys	
}

function KEYWORD22() { #strings all the content of the hidden files
	
	cd $InfoPATH/$WebDir/strings
		
	echo '''
	password
	pass
	user
	credential
	credentials
	walla
	israel
	kill
	bomb
	attack
	''' > string.list2 #list of keywords

	sudo cat string.list2 | awk '{print $1}' > string.list1
	sudo rm -f string.list2
	
	IFS=$'\n'
	for word in $(cat string.list1)
	do 
	strings $InfoPATH/$WebDir/DD-extracted/* | grep -s -i "$word" 2>/dev/null > $InfoPATH/$WebDir/strings/DD$word.strings
	done
	sudo rm -f string.list1  2>/dev/null
	
		###deleting all the empty files
		cd $InfoPATH/$WebDir
		sudo find . -size 0 > zerosize  #### all files in one directory
		zirofilenumber=$(wc -l zerosize |  awk '{print $1}')
		echo "you had $zirofilenumber empty files"
			for file in $(cat zerosize) #delete al ziro size files
			do
			sudo rm -rf $file
			done 
			sudo rm -rf zerosize
		
			if [[ -z $(sudo find . -size 0) ]]; then #chack all files deleted
			echo "all empty files [*] removed [*]"
			else 
			echo "[*] problem [*] whith removing the empty files"
			fi
			
		sudo rm string.list1
		cd $InfoPATH/$WebDir
		
	for word in $(ls $ChoosePath/Web-down/Sites/hezbollah.org/strings)
	do
	echo "$(date +%T) $word  found " >> $LogPath/GeneralInfo.log
	echo "$(date +%T) $word  found " 
	done
echo "finish strings"

DELETE
}

function BinWalK() { #Checks for hidden images / executables / zip and extract them 


	echo "[*]Start chacking metadata whith Binwalk[*]"
	
	if [ -z $(which binwalk) ]; then # check if exif was installed 
	banner "Downloading binwalk"
	sleep 2 
	apt-get install binwalk -y 
	echo "finish installing"  
	fi
	
cd $InfoPATH/$WebDir/Bin-Exif
	sudo bash -c 'echo "$(date)" > Binwalk-Info' # file for all the output
	sudo chmod 777 Binwalk-Info 2>/dev/null
cd $InfoPATH/$WebDir/AllPicters

	for img  in $(ls $InfoPATH/$WebDir/AllPicters) ; do
		echo "[*][*]--Binwalking $img--[*][*]"
		sudo binwalk $img | egrep 'executable|image|zip' | egrep -v '0x0|0xC' | sudo tee -a .results.txt #Filter only manipulated images
																		#save to file so that there is only one binwalk per image (faster) 
																										 
		if [ -z $(cat .results.txt) ]; then	
		sudo rm $img # remove clear images
		else
		cat .results.txt
		echo " " >> $InfoPATH/$WebDir/Bin-Exif/Binwalk-Info
		echo "[*][*]--Binwalking $img--[*][*]" >> $InfoPATH/$WebDir/Bin-Exif/Binwalk-Info #Moves the information found to the file
		cat .results.txt >> $InfoPATH/$WebDir/Bin-Exif/Binwalk-Info
		
								###DD###
		
		#####The function will take out the hidden file and move it to a separate folder
		Lin=$(cat .results.txt | wc -l) #For each row (hidden file)
	
		echo " " >> $InfoPATH/$WebDir/Bin-Exif/Binwalk-Info
		echo "[*][*]--Extracting hidden info from $img--[*][*]" >> $InfoPATH/$WebDir/Bin-Exif/Binwalk-Info	
		echo " "
		echo "[*][*]--Extracting hidden info from $img--[*][*]" 
				
		for Num in $(seq 1 2); do 
		PR1=$(head -n $Num .results.txt | tail -1 | awk '{print $1}')  #Takes out the "skip" number for dd
		PR3=$(head -n $Num .results.txt | tail -1 | awk '{print $3}')  #Takes out the file type
		
			sudo dd if=$img of=D$Num--$img--$PR3 skip=$PR1 bs=1 #ectract the hidden file! :P
		
				echo "DD -- found $PR3 file hidden, extracted to D$Num--$img--$PR3--" >> $InfoPATH/$WebDir/Bin-Exif/Binwalk-Info
				echo "DD -- found $PR3 file hidden, extracted to D$Num--$img--$PR3--"
			mv D$Num--$img--$PR3 $InfoPATH/$WebDir/DD-extracted
		done
								###DD###

		fi
		sudo rm -f .results.txt #Avoid mistakes that will cause duplication
	done

cd $InfoPATH/$WebDir/Bin-Exif
		
if [ -z $(cat Binwalk-Info | grep "Binwalking" ) ] ; then # This indicates that Exif has not found any special information
echo "$(date) [*]Binwalk found interesting information in $WebDir[*]" >> $LogPath/Tools.log
cat $InfoPATH/$WebDir/Bin-Exif/Binwalk-Info >> $LogPath/Tools.log
fi
	
}

function EXIF-TOOL() { #Retrieves metadata found using the exiftool && keywords
	
	echo "[*]Start chacking metadata whith ExifTool[*]"
	
	if [ -z $(which exiftool) ]; then # check if exif was installed 
	echo "you dont have exiftool... start installing" 
	sleep 2
	apt-get install exif libimage-exiftool-perl -y 
	echo "finish installing" 
	sleep 2 
	fi
	
cd $InfoPATH/$WebDir/Bin-Exif
	sudo bash -c 'echo "GPS" > .ExifKeyWord' # A list of keywords that represent important information
	sudo chmod 777 .ExifKeyWord 2>/dev/null
	echo "Warning" >> .ExifKeyWord
	
	sudo bash -c 'echo "$(date)" > Exif-Info' # file for all the output
	sudo chmod 777 Exif-Info 2>/dev/null
cd $InfoPATH/$WebDir/AllPicters
	
	for img  in $(ls $InfoPATH/$WebDir/AllPicters) ; do
	
		IFS=$'\n'
		for Keyword  in $(cat $InfoPATH/$WebDir/Bin-Exif/.ExifKeyWord | awk '{print $1,$2,$3,$4}') ; do # A list of columns that represent important information
			if [[ ! -z  $(exiftool $img | grep -i $Keyword) ]] ; then ## The information will only be recorded if a result is found
		
				if [[ -z $(cat $InfoPATH/$WebDir/Bin-Exif/Exif-Info | grep "$img") ]] ; then		###In this way, the name of the image will be listed only if it finds vital information about the image, and only once!
				echo "                               " >> $InfoPATH/$WebDir/Bin-Exif/Exif-Info
				echo "[*][*]--Exifing $img--[*][*]" >> $InfoPATH/$WebDir/Bin-Exif/Exif-Info
				echo "[*][*]--Exifing $img--[*][*]"
				fi 
				echo "                               " >> $LogPath/Tools.log
				echo "[*][*]--Exifing $img--[*][*]" >> $LogPath/Tools.log
				exiftool $img | grep -i $Keyword
				exiftool $img | grep -i $Keyword >> $LogPath/Tools.log
				exiftool $img | grep -i $Keyword >> $InfoPATH/$WebDir/Bin-Exif/Exif-Info
					
			fi
		done
	done
	
	
cd $InfoPATH/$WebDir/Bin-Exif
		
if [ $(cat Exif-Info | grep "Exifing" | wc -l) == $(cat Exif-Info | wc -l) ] ; then # This indicates that Exif has not found any special information
sudo rm $InfoPATH/$WebDir/Bin-Exif/Exif-Info
else 
echo "$(date) [*]Exiftool found interesting information in $WebDir[*]" >> $LogPath/Tools.log
cat $InfoPATH/$WebDir/Bin-Exif/Exif-Info >> $LogPath/Tools.log
fi

BinWalK
}

function KEYWORD() { #strings al the content of the web
	
	cd $InfoPATH/$WebDir/strings
		
	echo '''
	password
	pass
	user
	credential
	credentials
	flag
	gmail
	israel
	kill
	bomb
	attack
	''' > string.list2 #list of keywords

	sudo cat string.list2 | awk '{print $1}' > string.list1
	sudo rm -f string.list2
	
	IFS=$'\n'
	for word in $(cat string.list1)
	do 
	strings $InfoPATH/$WebDir/AllPicters/* | grep -s -i "$word" 2>/dev/null > $InfoPATH/$WebDir/strings/$word.strings
	done
	sudo rm -f string.list1  2>/dev/null
	
		###deleting all the empty files
		cd $InfoPATH/$WebDir
		sudo find . -size 0 > zerosize  #### all files in one directory
		zirofilenumber=$(wc -l zerosize |  awk '{print $1}')
		echo "you had $zirofilenumber empty files"
			for file in $(cat zerosize) #delete al ziro size files
			do
			sudo rm -rf $file
			done 
			sudo rm -rf zerosize
		
			if [[ -z $(sudo find . -size 0) ]]; then #chack all files deleted
			echo "all empty files [*] removed [*]"
			else 
			echo "[*] problem [*] whith removing the empty files"
			fi
			
		sudo rm string.list1
		cd $InfoPATH/$WebDir
		
	for word in $(ls $ChoosePath/Web-down/Sites/hezbollah.org/strings)
	do
	echo "$(date +%T) $word  found " >> $LogPath/Tools.log
	echo "$(date +%T) $word  found " 
	done
echo "finish"
		
EXIF-TOOL
}
KEYWORD

}

function HASHES() { #Checks if the second download of the site had download new files that have not yet been explored
	
cd $StartPath/HASHES
	if [ ! -f $StartPath/HASHES/hashes-$WebDir ] ; then  ###If the first installation of the site, the hashes file will be created.
	echo " " > $StartPath/HASHES/hashes-$WebDir
	sudo find $InfoPATH/$WebDir/AllPicters -type f -exec md5sum "{}" + > $StartPath/HASHES/hashes-$WebDir
	echo "$(date +%T) Hash list created" >> $LogPath/GeneralInfo.log
	TOOLS
	else ###If the file already exists, this is not a first installation and should check for new information
	echo "$(date +%T) this is the seconed scan of $WebDir, check for new files.." >> $LogPath/GeneralInfo.log
	echo "check" > $StartPath/HASHES/new-hashes.list-$WebDir
	sudo find $InfoPATH/$WebDir/AllPicters -type f -exec md5sum "{}" + > $StartPath/HASHES/new-hashes.list-$WebDir
	
	echo "check" > $StartPath/HASHES/CheckBoth-$WebDir
	cat $StartPath/HASHES/hashes-$WebDir > $StartPath/HASHES/CheckBoth-$WebDir ###Causes that if the same files are found, it will appear twice
	cat $StartPath/HASHES/new-hashes.list-$WebDir >> $StartPath/HASHES/CheckBoth-$WebDir
	
	sudo cat $StartPath/HASHES/CheckBoth-$WebDir | awk '{print $1}' | sort | uniq -c > $StartPath/HASHES/hashes.test-$WebDir #If the file appears only once, it is probably new
	sudo cat $StartPath/HASHES/hashes.test-$WebDir | awk '$1 <2 {print $2}' > $StartPath/HASHES/new-hashes-$WebDir #Extracts the new hash
		
		sudo rm $StartPath/HASHES/hashes.test-$WebDir $StartPath/HASHES/hashes-$WebDir $StartPath/HASHES/CheckBoth-$WebDir $StartPath/HASHES/hashes-$WebDir 2>/dev/null
		if [ -z $(cat $StartPath/new-hashes-$WebDir) ];then
		sudo rm $StartPath/HASHES/new-hashes-$WebDir
		echo "$(date +%T) didnt found any new information in $Site, continue to the next site.." >> $LogPath/GeneralInfo.log
		
		else				###Removes all files that have already passed scan and leaves only the new ones
		echo "$(date +%T) [*]found new information[*] in $WebDir" >> $LogPath/GeneralInfo.log
		
		cd $InfoPATH/$WebDir/AllPicters
			for file in $(cat $StartPath/HASHES/new-hashes-$WebDir | awk '{print $(NF-0)}')
			do
				sudo mv "$file" $InfoPATH/$WebDir 2>/dev/null #move the new files
			done
		cd $InfoPATH/$WebDir/AllPicters
		sudo rm -rf *
		cd ../
			for file in $(cat $StartPath/HASHES/new-hashes-$WebDir | awk -F '/' '{print $(NF-0)}')
			do
				sudo mv "$file" $InfoPATH/$WebDir/AllPicters 2>/dev/null #returns the new files
			done
							###
		TOOLS
		
		fi
		sudo mv $StartPath/HASHES/new-hashes.list-$WebDir $StartPath/HASHES/hashes-$WebDir
		
	fi	

}

function MORE-SITES() { #Extracts by filtering out more sites that were listed in the site's information and puts them into the download list

	cd $InfoPATH/$WebDir/MoreSites	
					
	sudo bash -c 'echo "http https" > .HttpHttps' 2>/dev/null
	 
	for SiTe in $(cat .HttpHttps)
	do
			
	##My computer has a problem with the directory creation process
	cd MoreSites &>/dev/null
	sudo bash -c 'echo "chack" > $SiTe.site' 2>/dev/null
	sudo chmod 777 $SiTe.site 2>/dev/null
	cd ../
	##sudo bash -c also not work

		cat * 2>/dev/null | grep -o -iR "$SiTe://*....................................." > $InfoPATH/$WebDir/MoreSites/$SiTe.site 2>/dev/null # Isolates only the http sites
	
	##My computer has a problem with the directory creation process
	cd MoreSites &>/dev/null
	sudo bash -c 'echo "chack" > $SiTe.list' 2>/dev/null
	sudo chmod 777 $SiTe.list 2>/dev/null
	##sudo bash -c also not work
	
		
		if [ $SiTe == http ];then
		cat http.site | awk -F'http' '{print $2}' | awk -F'/' '{print $2,$3}' | grep "www" | sort -n | uniq | egrep -i 'Iran|gov.ir|hamas|hezbollah|gov.ps|palestin|shahid|Lebanon|Cairo|Arab|akhbar|aljazeera|Muhammad|Ahmed' > http.list
		elif [ $SiTe == https ];then
		cat https.site | awk -F'https' '{print $2}' | awk -F'/' '{print $2,$3}' | grep "www" | sort -n | uniq | egrep -i 'Iran|gov.ir|hamas|hezbollah|gov.ps|palestin|shahid|Lebanon|Cairo|Arab|akhbar|aljazeera|Muhammad|Ahmed' > https.list
		fi
						###Prevents the information collection from leaking
						###Sites like facebook, ynet, etc..
		sudo rm -f $SiTe.site Keyword.list
		
		if [[ ! -z $(cat $SiTe.list) ]]
		then
		echo "$(date +%T) Found $(cat $SiTe.list | wc -l ) new $SiTe sites in $Site" >> $LogPath/GeneralInfo.log
		echo "$(date +%T) Found $(cat $SiTe.list | wc -l ) new $SiTe sites in $Site"
		cat $SiTe.list #show the new sites
		fi
	
		if [[ $AddSiteAsnwer == y ]] ; then ##add the sites to the list
		cat $SiTe.list >> $SitePATH
		cd $StartPath/List-of-sites
		sudo bash -c 'echo " " > list'
		cat site.list | sort | uniq | awk '{print $1}' > list
		sudo rm site.list
		mv list site.list
		sudo rm -f $StartPath/List-of-sites/all-add-$SiTe-sites #Will only delete the file if the user chooses to use it
		elif [[ $AddSiteAsnwer == n ]] ; then ## if not, its save them in a log file
		cat $SiTe.list >> $StartPath/List-of-sites/all-add-$SiTe-sites.log
		fi	
	done
HASHES
}

function GET-WEB-INFO-OUT() { #Once we have downloaded the site, it exits the file types I will request for a separate folder

cd $InfoPATH/$WebDir
echo "jpg jpeg png gif pdf exe $DiffrentFileType"> .pictertype.list #list of file types

for TYPE in $(cat .pictertype.list) ; do #create a lop for exits the file types
	
	
	sudo find . -type f -name "*.$TYPE" > .path-$TYPE.txt
	
	for x in $(cat .path-$TYPE.txt); do
		sudo mv "$x" $InfoPATH/$WebDir/AllPicters 2>/dev/null
		
	done
	echo "$(date +%T) Found $(cat .path-$TYPE.txt | wc -l ) $TYPE in $Site" >> $LogPath/GeneralInfo.log
	sudo rm -rf .path-$TYPE.txt
done

MORE-SITES
}

function DOW-WEB() { #create the first directores and download the website
 
echo "start downloading $Site" >> $LogPath/GeneralInfo.log


sudo wget -nv -r -l 3 $Site

#sudo wget -nv -r -l $RecursiveLevel --limit-rate="$RateLimit"k $Site ##After testing, this command downloads the most information from the site

echo "-------------------------------------------"
echo "Finish downloading $Site" >> $LogPath/GeneralInfo.log

GET-WEB-INFO-OUT
}

function VARBS() { #Creates the appropriate variables for the site

		cd $InfoPATH

	###create a directory for each site
WebDir=$(echo "$Site" | awk -F'/' '{print $3}')

if [ -z $WebDir ] ; then # if the site name done have "/" it's still work  
WebDir=$(echo "$Site")
fi

if [ ! -d $WebDir ]; then # create a dir for each site
sudo mkdir $WebDir
fi
cd $WebDir

if [ ! -d AllPicters ] ;then ##create AllPicters
sudo mkdir AllPicters
fi

if [[ ! -d MoreSites ]]; then ##create MoreSites
mkdir MoreSites
fi

if [[ ! -d DD-extracted ]]; then ##create DD-extracted
mkdir DD-extracted
fi
	
if [[ ! -d strings ]]; then ##create strings
mkdir strings
fi 
	
if [[ ! -d Bin-Exif ]]; then ##create Bin-Exif
mkdir Bin-Exif
fi 	
	

echo "-------------$Site-------------" >> $LogPath/GeneralInfo.log
echo "-------------$Site-------------" >> $LogPath/Tools.log

DOW-WEB

}
VARBS

done #for the do lop

done #for the while lop
}

function ANONIMOUS() { #all the part relaited to the anonimpus

function YOUR-ANONIMOUS() { #check if I am Anonimous
	
	cd $NipePath
	sudo perl nipe.pl start 
	sudo perl nipe.pl status > NipeStatus
	STATUS=$(cat NipeStatus | grep -o activated)
	echo "$STATUS"
		if [ "activated" == "$STATUS" ] 
		then 
		echo "YOUR computer is [*] Anonimous [*]"  >> $LogPath/GeneralInfo.log
		echo "YOUR computer is [*] Anonimous [*]"
		sleep 1.5
		else	#In the first installation of Nipe / starting Nipe after reboot the server
				#there is a known issue, sometimes you have to run it 2 times and it works..
			echo "There is a problem with the starting Nipe, tring one more time"
			sleep 1.5
			sudo perl nipe.pl stop
			sudo perl nipe.pl start 
			sudo perl nipe.pl status > NipeStatus
			STATUS=$(cat NipeStatus | grep -o activated)
			echo "$STATUS"
			if [ "activated" == "$STATUS" ] 
			then 
			echo "YOUR computer is [*] Anonimous [*]"  >> $LogPath/GeneralInfo.log
			echo "YOUR computer is [*] Anonimous [*]" 
			sleep 1.5
			else	
			echo "YOUR computer is [*] NOT [*] Anonimous, Exit..." >> $LogPath/GeneralInfo.log
			echo "YOUR computer is [*] NOT [*] Anonimous, Exit..."
			exit
			fi	
		fi
	WE-ALL-ONE-LOP	
}

function INSTALL() { #check if the apps you want to use are installed
	
		if [ ! -z $(pwd | grep "nipe") ] 
		then 
		echo "[*] nipe is install in your computer. [*] You can initializing the scan"
		sleep 1.5
		else     ####nipe install commends###
		banner "Download nipe.pl"
		sleep 3
		sleep 1.5
		cd $ChoosePath

		sudo git clone https://github.com/htrgouvea/nipe && cd nipe && sudo cpan install Try::Tiny Config::Simple JSON && sudo ./nipe.pl install
			if [ -f $ChoosePath/nipe/nipe.pl ] #check if nipe download properly
			then
			echo "[*]Nipe installed[*]"
			sleep 2
			else 
			echo "problem whith installing Nipe [*****]"
			exit
			fi
		sudo updatedb
		FindNipe
		fi 
		YOUR-ANONIMOUS
}

function FindNipe() { # path to find nipe
	
		cd $ChoosePath
		locate nipe | grep nipe.pl | head -1 > .nipe.path1
		NipePath=$(cat .nipe.path1 | sed 's/nipe.pl//g' | sed 's/.$//') # peth to nipe in any computer
		sudo rm -f .nipe.path1
		cd $NipePath
		INSTALL
}

function Ask-You-Anonimous() { # ask if you want the remote server to be anonimous
echo "Do you want to be Anonumous(y/n)?"
read YesNo
if [ $YesNo = y ]; then # if yes send to anonimous function
FindNipe
else                    # if no send to recon apps function
echo "OK.... Your choice..."

WEB-LIST

fi
}
Ask-You-Anonimous


}

ANONIMOUS


