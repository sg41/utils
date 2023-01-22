#!/bin/bash
create_and_push(){
            name=$(basename $(pwd))
            echo $name
            [[ $3 != "" ]] && [[ $2 = "-d" ]] && [[ $3 != "" ]] ||  { echo "No description"; exit 1 ; }
            request='{"name":"'${name}'","description":"'${3}'","private":"true"}'
            echo $request
             #-H "Authorization: Bearer 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"\
             curl \
             -X POST \
             -H "Accept: application/vnd.github+json" \
             -H "Authorization: Bearer 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"\
             -H "X-GitHub-Api-Version: 2022-11-28" \
             https://api.github.com/user/repos -d "${request}" 
             git remote add github git@github.com:sg41/${name}.git
             git push github    
}

case $1 in
    -a)
        for d in sql?
        do
            cd $d
            create_and_push "$@"
            cd ../
        done
        ;;
    -g)
            create_and_push "$@"
            ;;
    *)
        echo "use $0 -g -d \"description\""
        echo "to publish current git repository to github"
        echo "UNCOMMENT create_and_push function"
        echo "maybe change of token will be required"
esac
