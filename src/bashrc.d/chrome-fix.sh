alias chrome-fix='sudo sed -i -e "s/\(google-chrome-stable.*\)\( --incognito\)\(.*\)$/\1\3/" -e "s/\(google-chrome-stable\)/\1 --incognito/" /usr/share/applications/google-chrome.desktop'
