#!/bin/bash

function downloadAndExtract () {
  echo "Downloading: $1 to $2"

  while IFS="|" read -r rtype url comment rdate rwho
  do
    echo "Processing: $url"

    if [ "$rtype" = "LINE" ]; then
      # not great way of reordering the date but anyway
      IFS="/" read -r rday rmonth ryear <<< "$rdate"

      rdate="$ryear-$rmonth-$rday"

      # dump anything after ?
      local stripped="${url%\?*}"
      
      # dump anything before last slash (/); then
      local strippedBare="${stripped##*\/}"
      
      # preappend folder name and date
      local loconame="$target_folder/$rdate-$strippedBare"

	  if [ -f "$loconame" ]; then 
		  echo "Skipping: $loconame"	  
	  else 
	      wget -O "$loconame" "$url"
	
	      #embed the comment, do not modify file and preserve original date and time
	      exiftool -overwrite_original "$loconame" -comment="$comment" -P
	      
	      echo "Downloaded: $loconame"
	  fi 
    elif [ "$rtype" = "LAST" ]; then
      urlToDownload="$url"
      return 0
    else
      exit 1
    fi
  done < <(wget -O - "$1" --load-cookies ./cookies.txt | grep -v '</form' | tidy -asxml -f /dev/null | sed 's/&nbsp/ /g' | xsltproc extractBits.xsl -)
  urlToDownload=""
}

# target_folder="/home/dalen/Downloads/SaoirsePics/pics/"
target_folder="$2"
urlToDownload="$1"
while [ "$urlToDownload" != "" ]; do
  # downloadAndExtract modifies urlToDownload
  downloadAndExtract "$urlToDownload"
done
