
echo "apk update"
apk update
echo "install git"
apk add --no-cache bash git openssh
apk --no-cache add curl
echo "start exporting......."
			   ls -ltr
                
                git clone test-git-repo test-git-repo-exported
                DESC="exporting from DEV on (`date +%d-%^h-%Y::%H:%M:%S-%3N`)"
                cd test-git-repo-exported
               
                Code=$(curl -u $apiusername:$apiusernamepwd --request \
                      POST "<http post url>" \
                    --header 'Content-Type: application/json' \
                    --header 'Accept: application/xml' \
                    --header 'X-Requested-By: xelsysadm' \
                    --data-raw '{< json data>}' -o config/export.xml)
                if [[ "$Code" =~ ^2 ]]; then
                # Server returned 2xx respons
                echo "Operation Successfull $Code"
                elif [[ "$Code" = 404 ]]; then
                    # Server returned 404, so compiling from source
                    echo "ERROR: server returned HTTP code $Code"
                    exit 1
                else
                    echo "ERROR: server returned HTTP code $Code"
                    exit 1
                fi
                git add .

                git config --global user.name "Service Account"
                git config --global user.email "admin@test.com"

                git commit -m "Commit deployment response file on `date`"
                ls -lha