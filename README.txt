Pictures downloader for ChildPaths App
by Dalen Kambur (dalen dot kambur at gmail dot com)

USE AT OWN RISK!

How to use:
1. Login to childpaths web frontend and navigate to child's gallery page (the path will end up in /photos)
2. Copy cookies into cookies.txt file
3. (deprecated-ignore this line) Modify allPics.bash to set target_folder in line 2
4. Invoke allPics.bash passing 
4.1 URL obtained from address bar in step 1 as parameter
4.2 target folder as second parameter
5. Enjoy waiting.

Pre-requisites:
- bash
- sed
- wget
- tidy
- xsltproc
- exiftool

What does the script do:
- uses cookies given to download first page of photos
- does a wee bit of clean through sed, tidy and uses xsltproc to extract all pictures and comments and link to next page
- each picture is renamed to include full date and image as given by the system, and upon download, comments inserted into metadata
- picture is only downloaded if it does not exist
- the next page downloaded