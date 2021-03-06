#!/bin/bash

syscoin_of_the_markdown() {
  LC_ALL=C
  mkdir -p docs && cd docs
  version=$(syscoin-cli -version | grep -o "v\d\.\d\.\d")
  rm -rf "${version}"
  mkdir -p "${version}" && cd "${version}"
  
  echo "# ${category}" > "../${category}.md"
  while read i; do 
    c=$(echo "$i" | head -n1 | awk '{print $1;}');
    if [[ $c == "==" ]]; then 
      h=$(echo "$i" | head -n1 | awk '{print $2;}');
      echo "$h"
      if [[ $h != $head ]]; then
        if [ "$head" != "" ]; then
          cd ..
        fi
        head="$h";
        #echo "## [$head](${categorylink}/$head.md)" >> "../${category}.md"
        mkdir -p ${head}
        cd $head
        #echo "# ${head}" > "../${head}.md"
      fi
    else
      if [[ $c != $cmd ]]; then
        cmd="$c";
      fi
    fi
    if [[ $cmd != "" ]]; then
      echo " - $cmd"
      TICKS="\\\`\\\`\\\`"
      RTICKS=""
      ETICKS=""
      CTICKS=""
      EXAMPLES=""
      helpdoc=$(syscoin-cli help $cmd)
      echo "$helpdoc" | grep -q "Available commands:" && CTICKS=$TICKS
      echo "$helpdoc" | grep -q "Arguments:" && RTICKS=$TICKS
      echo "$helpdoc" | grep -q "Arguments:" && ETICKS=$TICKS
      if [ "$ETICKS" = "" ]; then
        echo "$helpdoc" | grep -q "Result\( (.*)\)*:" && ETICKS=$TICKS
      fi
      echo "$helpdoc" | grep -q "Examples:" && EXAMPLES="Y"

      cli=$(echo "$helpdoc" | grep -o "^${cmd}.*\$")

      helpdoc=$(echo "$helpdoc" | sed -e "s#^${cmd}\(.*\)#**\`${cmd}\\1\`**#")
      helpdoc=$(echo "$helpdoc" | sed -e "s/Arguments:/***Arguments:***é$TICKS/" | tr 'é' '\n') 
      helpdoc=$(echo "$helpdoc" | sed -e "s/Result\( (.*)\)*:/${RTICKS}éé***Result\1:***é$TICKS/" | tr 'é' '\n') 
      helpdoc=$(echo "$helpdoc" | sed -e "s/Available commands:/${ETICKS}éé***Available commands:***é$TICKS/" | tr 'é' '\n') 
      helpdoc=$(echo "$helpdoc" | sed -e "s/Examples:/${ETICKS}éé***Examples:***é$TICKS/" | tr 'é' '\n')

      # add command to parent readme
      #echo "* [\`$cmd\`](${head}/${cmd}.md)" >> "../${head}.md"

      # add command to directory readme
      echo "## [\`$cmd\`](${cmd}.md)" >> "${cmd}.md"
      echo "\`\`\`" >> "${cmd}.md"
      echo "$cli" >> "${cmd}.md"
      echo "\`\`\`" >> "${cmd}.md"
      echo "" >> "${cmd}.md"

      # create command markdown file
      echo "## **\`${cmd}\`**" > "${cmd}.md"
      echo "" >> "${cmd}.md"
      echo "$helpdoc" >> "${cmd}.md"
      if [ "$ETICKS" != "" ] || [ "$CTICKS" != "" ] || [ "$RTICKS" != "" ] || [ "$EXAMPLES" != "" ]; then
        echo "\`\`\`" >> "${cmd}.md"
      fi
    fi
  done < <(syscoin-cli help)
  cd ../../..
}

syscoin_of_the_markdown
#echo "$(syscoin_of_the_markdown) " > README.md
