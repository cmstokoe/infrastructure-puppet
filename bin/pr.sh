#!/bin/bash

# Put your token some where and tweak as needed

token=`cat /path/to/your/ghtoken`
branch=`git rev-parse --abbrev-ref HEAD`
desc=`git log -n 1 --oneline | cut -d ' ' -f2-`
json="{\"title\": \"$desc\", \"body\":\"$desc\",\"head\":\"${branch}\",\"base\": \"deployment\"}"
uuid=`uuidgen`
echo $json > /tmp/$uuid.json
echo "Making PR for $branch: $desc..."
if curl -i -XPOST -H "Authorization: token $token" -d @/tmp/$uuid.json https://api.github.com/repos/apache/infrastructure-puppet/pulls | grep -q "201 Created"
    then echo "PR Successfully created!"
    else echo "PR Failed! Wrong token used?"
fi
rm /tmp/$uuid.json
echo "All done!"
