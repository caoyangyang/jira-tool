#!/bin/sh
get(){
 boardType=$(head -n 1 account.profile | tail -1)
 #need ready different config by board type
 url=`head -n 2 account.profile | tail -1`
 accountName=`head -n 3 account.profile | tail -1`
 accountPassword=`head -n 4 account.profile | tail -1`

 apiToken=`getAuthString $accountName $accountPassword`

 response=`curl -s --request "GET" \
               --url "https://$url/rest/api/2/$1" \
               --header "Authorization: $apiToken"`
 echo $response
}

post(){
 boardType=$(head -n 1 account.profile | tail -1)
 #need ready different config by board type
 url=`head -n 2 account.profile | tail -1`
 accountName=`head -n 3 account.profile | tail -1`
 accountPassword=`head -n 4 account.profile | tail -1`

 apiToken=`getAuthString $accountName $accountPassword`
 response=`curl -s -w "%{http_code}"  --request "POST" \
               --url "https://$url/rest/api/2/$1" \
               --header "Authorization: $apiToken" \
               --header 'Content-Type: application/json' \
               --data "$2"`
  echo $response
}

getAuthString(){
  encodeStr=`echo "$1:$2\c" | base64 `
  echo "Basic $encodeStr"
}