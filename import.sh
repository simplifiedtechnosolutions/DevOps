
echo "apk update"
apk update
echo "install git"
apk add --no-cache bash git openssh
apk --no-cache add curl
echo "start importing......."
                set -eux
                ls -ltr
				pwd
				
                
                # Define a timestamp function
                DESC="Importing from DEV on (`date +%Y-%m-%d::%H-%M-%S`)"
                git clone test-git-repo test-git-repo-exported

                cd test-git-repo-exported
				

                Code=$(curl -sSL -w '%{http_code}' --location -u $apiusername:$apiusernamepwd -d @config/export.xml --request PUT '<destination consumer http url/rest endpoint>' --header 'Accept: application/json' --header 'Content-Type: application/xml' -o response.json)
                if [[ "$Code" =~ ^2 ]]; then
                  # Server returned 2xx respons
                  echo "Operation Successfull $Code"
                  exit 0;
                elif [[ "$Code" = 404 ]]; then
                  # Server returned 404, so compiling from source
                  echo "ERROR: server returned HTTP code $Code"
                  exit 1
                else
                    echo "ERROR: server returned HTTP code $Code"
                    exit 1
                fi
                ls -lha