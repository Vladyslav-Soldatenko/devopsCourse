#!/bin/bash

cd "shop-angular-cloudfront" || exit

printf "running lints\n"
npm run lint

if [[ ! $? -eq 0 ]]
then 
    printf "there are lint problems, please fix\n"
    exit
fi

npm run test

if [[ ! $? -eq 0 ]]
then 
    printf "there are tests problems, please fix\n"
    exit
fi