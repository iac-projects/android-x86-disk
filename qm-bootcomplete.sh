mkdir -p /etc/quamotion/

settings put secure install_non_market_apps 1
echo 1 > /etc/quamotion/allow_non_market_apps

settings put global package_verifier_enable 0
echo 1 > /etc/quamotion/disable_package_verifier

settings put global stay_on_while_plugged_in 6
echo 1 > /etc/quamotion/stay_on_while_plugged_in

svc power stayon true
echo 1 > /etc/quamotion/power_stayon
