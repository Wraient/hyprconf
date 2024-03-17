#!/bin/bash

# First POST request
otp_url="http://wifiunify38.spectra.co/userportal/pages/usermedia/spectra3/stanza-disable-random-mac/otp.jsp"
otp_data="memberId=23TSFBA023"
otp_cookies="JSESSIONID=A7A0859DC5ED1606979E3C1BDB502A78"
otp_response=$(curl -s -X POST -d "$otp_data" -b "$otp_cookies" "$otp_url")

# Second POST request
login_url="http://wifiunify38.spectra.co/userportal/newlogin.do"
login_data="username=STN-23TSFBA023&password=1981&type=2&phone=0&jsonresponse=1"
login_cookies="JSESSIONID=A7A0859DC5ED1606979E3C1BDB502A78"
login_response=$(curl -s -X POST -d "$login_data" -b "$login_cookies" "$login_url")

# Third POST request
magic_url="http://10.201.21.1/login"
magic_data="username=STN-23TSFBA023&password=1981&magic="
magic_response=$(curl -s -X POST -d "$magic_data" "$magic_url")

if [[ $(echo "$otp_response" | grep -c "200 OK") -eq 1 && \
      $(echo "$login_response" | grep -c "200 OK") -eq 1 && \
      $(echo "$magic_response" | grep -c "200 OK") -eq 1 ]]; then
    echo "Login successful"
else
    echo "Login failed"
fi

