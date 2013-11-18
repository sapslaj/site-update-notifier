#!/bin/bash
 
SLEEPTIME=30              # Seconds between checks
URL="http://example.com"  # URL to check
EMAIL="email@example.com" # Email to send updates to
SUBJECT="Site Update"     # Subject of email
 
if [ -e /tmp/siteupdate/current_index ] ; then echo "" ; else touch /tmp/siteupdate/current_index ; fi
if [ -e /tmp/siteupdate/latest_index ] ; then echo "" ; else touch /tmp/siteupdate/latest_index ; fi
 
while : 
do
  curl $URL > /tmp/siteupdate/current_index
 
  CHANGES=$(diff /tmp/siteupdate/current_index /tmp/siteupdate/latest_index)
 
  if [ "$CHANGES" != "" ]
  then
    mail -s $SUBJECT $EMAIL < /tmp/siteupdate/current_index # Change this as needed 
    cat /tmp/siteupdate/current_index > /tmp/siteupdate/latest_index
  fi
 
  sleep $SLEEPTIME
done