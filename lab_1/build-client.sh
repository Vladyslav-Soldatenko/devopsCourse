#!/bin/bash

cd "shop-angular-cloudfront" || exit
printf "instralling dependencies\n"
npm i
printf "running build\n"
ENV_CONFIGURATION=""
if [[ $# -gt 0 && $1 == 'production' ]]
then
    ENV_CONFIGURATION="production"
fi

npm run build -- --configuration=$ENV_CONFIGURATION

if [[ -f "./dist/client-app.zip" ]]
then
    printf "removing previous zip\n"
    rm ./dist/client-app.zip
fi 

zip -r dist/client-app.zip ./dist/*