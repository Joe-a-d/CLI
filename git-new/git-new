#!/bin/bash

#####################################################
# Author: Joao Almeida-Domingues , 2019
# License: https://www.gnu.org/licenses/gpl-3.0.html
#####################################################

    ### parse args
    # 1. Git or Bitbucket
    # 2. Username
    # 3. NEW_REPO_NAME
    # 4. private = true/false
    # 5. push

    server=$1
    user=$2
    repo=$3
    new=$4

    ### github logic branch
    ### authentication via PAT

    if [ "$server" = "git" ]
    then
    curl  -H "Authorization: token $github_token" \
        -d '{ "name": "'"$repo"'" ,
            "auto_init": true ,
            "private": false
          }' \
        https://api.github.com/user/repos

        if [ "$new" = "-n" ]
        then
            git init
            git remote add origin git@github.com:$user/$repo.git
            git add .
            git commit -m 'init from exisitng repo'
            git push -u -f origin master
        else
            git clone https://github.com/$user/$repo.git
        fi

    ### butbucket logic branch
    ### authentication via username:Password

    elif [ "$server" = "bit" ]
    ### safe password prompt hidden stdin
    printf "Password: "
    read -s pass
    then
        # -s silent mode ; -o outputs response to file ; -u authentication ; -H add one element to Header -d data
        curl -s -o response.json -u $user:$pass -X POST -H "Content-Type: application/json" -d '{
            "scm": "git"
        }' https://api.bitbucket.org/2.0/repositories/$user/$repo

        type=$( cat response.json | jq '.type' )
        if [ "$type" == "\"error\"" ]
            then
            error=$( cat response.json | jq '.error.message' )
            echo "FAILED"
            echo "ERROR MESSAGE: "$error" "
            else
                #adds empty readme in order to auto-init remote master

                rm response.json
                touch README.md
                git init
                git remote add origin git@bitbucket.org:$user/$repo.git
                git add .
                git commit -m "init branch"
                git push -u origin master


        fi
    else
        echo "\n invalid server argument" ; sleep 2 ; (exit 1)
    fi
