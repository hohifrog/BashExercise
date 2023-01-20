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
ls /etc/rc3.d/S*
if [[ $? -ne 0 ]] ; then
RCSuccess=$(($RCSuccess + $RCService))
echo $RCSuccess
fi
#-------------------------------------
#Final Return Code
if [[ $RCSuccess -eq 0 ]] ; then
echo "Script executed without errors, Exit code: $RCSuccess"
