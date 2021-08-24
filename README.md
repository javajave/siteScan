# SiteScan
Scan for hiddin data in the files of the selected website, extract the results (if any) and expand to linked sites

# This script
Ask if you want to be anonymous,verify if nipe is installed, and if not, install is.
Will give you the option to add sites to crawl.
Download the site to a folder on your computer.
If the script gets to the same site again, thanks to a hash list it will only check the new files on the site (if any).
Check through keywords which sites are linked yo your site, and add them to the list.
Search for hidden information using strings, exiftool and binwalk.
If the script finds a hidden file, it will export it to a separate folder and carve it using DD.
Alerts about new information and save it into a log files.

