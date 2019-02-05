#!/bin/bash
basedir="."
basehttp="http://www.samsung.com"
httprootfilepath="/common/next/css/"
httprootfilename="samsung.css"
httprootfullpath="${httprootfilepath}${httprootfilename}"
files="${basedir}${httprootfullpath}"
all_css_files="./all_css_files.txt"
touch $all_css_files

function download_http_base {
   mkdir -p "${basedir}${httprootfilepath}"
   wget -O "${basedir}${httprootfullpath}" "${basehttp}${httprootfullpath}"
   echo "${basedir}${httprootfullpath}" >> "$all_css_files"      
}

function download_dependencies {
   local filesaux=(${files[*]})
   files=()
for index in ${!filesaux[*]}
do
   filename=${filesaux[$index]}
   echo "css_source = $filename"

   todownload=$(read_paths_to_download "$filename")

   IFS=', ' read -r -a todownload <<< $todownload

   for filepathindex in ${!todownload[*]}
   do
      filepath=${basedir}${todownload[$filepathindex]}

      echo todownload = "$filepath" 

      local is_css="$(echo $filepath | grep .\css)"
      local already_added="$(cat $all_css_files | grep ^${filepath})"
 
      if [[ (! -z $is_css) && (! $already_added) ]]; then
         files+=("${filepath}")
         echo "${filepath}" >> "$all_css_files"

      fi
	
      download_http_file "$filepath"
   done
done
}

function read_paths_to_download {
   local filename_param="$1"
   local result=$(cat "$filename_param" |\
 	grep -oP url\(.*?\)\(\ \|\;\) |\
	sed -e 's/url("//g' |\
	sed -e 's/url(//g' |\
	sed -e 's/url//g' |\
	sed 's/")//g' |\
	sed -e 's/;//g' |\
	sed "s/);//g" |\
	sed "s/')//g" |\
	sed "s/)//g" |\
 	sed "s/'//g")

   echo "$result"
}

function download_http_file {
   local httpfile_param="$1"
   filename=$(echo $filepath | sed -e 's/\(.*\)\///g')
   path=$(echo ${filepath} | sed "s/$filename//g")
   mkdir -p $path
   httpfile=$(echo ${basehttp}${httpfile_param})
   wget -qO $filepath $httpfile
}

download_http_base

while [ $files ]
do
   download_dependencies
done

rm $all_css_files

#delete below this
cat teste.srt | grep -oP '\d*'
cat teste.srt | sed '/^[[:space:]]*$/d' >> new_teste.srt # deleting all empty lines
cat teste.srt | grep -e '\([0-9]\)\{3\}' | sed 's/\([0-9]\)/\1/g' # replacing patter with the same value
cat teste.srt | grep -e '\([0-9]\)\{3\}' | sed 's/\(\S -->\) \(\S\)/\1/g' # replacing space after --> pattern
cat teste.srt | sed 's/\(\S --> \S\S:\S\S:\S\S,\S\S\S\)/efwf/g'
cat teste.srt | sed 's/\(\S --> \S\{12\}\)/ewf/g'
cat teste.srt | grep -e '\(\S\{12\} --> \S\{12\}\)$'
cat teste.srt | sed '/<pattern>$/{N;s/\n/\t/}'
cat teste.srt | sed "/\(.*\)$/{N;s/\n/\t/}" #join lines two by two


 


cat teste.srt | sed '/^\([0-9]\)\{3\}$/d' >> new_teste.srt


