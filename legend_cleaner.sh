PREV_LINE=""

if [ -f temp_legend ];then
  rm temp_legend
fi

for f in "."/*; do

  find "$f" ! -name '*~' ! -name '*.sh' ! -name '\.' | sed 's/\.\///g' | 
  while read filename; do	

    output=$(echo clean_$filename)

    if [ -f "$output" ];then
      rm "$output"
    fi

    cat "$filename" | sed '/^\([0-9]\)\{3\}/d' >> temp_legend

    cat temp_legend | 
      while read line
	do 
	  if [[ $line =~ ^[[:space:]]$ ]];then
	    PREV_LINE+="\n"
	    echo -e "$PREV_LINE" >> "$output"
	      PREV_LINE=""
	    else
	      PREV_LINE+=$(echo $line | tr -d '\r' | tr -d '\n')
	      if [[ $line =~ ,[0-9]{3} ]];then
		PREV_LINE+=" : "
	      fi
	    fi

      done	 
    echo "$output"   
  done
  rm temp_legend
done

