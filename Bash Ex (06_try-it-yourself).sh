#! /bin/bash
#Return Code Values
RCSuccess=0
RCHome=1
RCTerm=2
RCService=4
#--------------------------------------
#Home Directory
echo $HOME
if [[ $? -ne 0 ]] ; then
RCSuccess=$(($RCSuccess + $RCHome))
echo $RCSuccess
fi
#------------------------------------
#Terminal Type
echo $TERM
if [[ $? -ne 0 ]] ; then
RCSuccess=$(($RCSuccess + $RCTerm))
echo $RCSuccess
fi
#-------------------------------------
#Services level 3
services=$(ls /etc/rc3.d/S*)

for service in $services; do
  service_name=$(echo $service | awk -F '/' '{print $NF}')
  service_status=$(systemctl is-active $service_name)
  if [[ $service_status == "active" ]]; then
    echo "$service_name is running."
  else
    echo "$service_name is not running."
    RCSuccess=$(($RCSuccess + $RCService))
  fi
done

#Final Return Code
if [[ $RCSuccess -eq 0 ]] ; then
echo "Script executed without errors, Exit code: $RCSuccess"
else
echo "Script executed with errors, Exit code: $RCSuccess"
fi
