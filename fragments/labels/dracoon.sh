dracoon)
    name="Dracoon"
    type="pkg"
    packageID="com.dracoon.be347f75-2ea9-418f-8894-3c2228483e01"

    base_dl_site="https://server.support.dracoon.com/hc/en-us/categories/360002797199"

    # Extract URL specific to "For macOS 10.12 or later:"
    fileshare_url=$(curl -s $base_dl_site | awk '/For macOS 10.12 or later:/,/<\/a>/ {if ($0 ~ /href="https:\/\/download.dracoon.com\/public\/download-shares\/[a-zA-Z0-9]*"/) print}' | grep -o 'https://download.dracoon.com/public/download-shares/[a-zA-Z0-9]*')
    fileshare_id=$(basename "$fileshare_url" | cut -d'/' -f 1)

    # Data to be sent in the POST request (with the password included)
    postData='{"password":""}'

    # Make the POST request using curl and capture the response
    response=$(curl -s -X POST -H "Content-Type: application/json" -d "$postData" "https://download.dracoon.com/api/v4/public/shares/downloads/$fileshare_id")

    # Extract the downloadUrl value from the JSON response using jq
    downloadURL=$(echo "$response" | jq -r '.downloadUrl')
    appNewVersion=$(curl -s "$base_dl_site" | sed -n 's/.*<span style="font-weight:600">Version \([^<]*\)<\/span>.*/\1/p')
    expectedTeamID="G69SCX94XU"
    blockingProcesses=("DRACOON Finder Integration")
    ;;
