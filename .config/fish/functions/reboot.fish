function reboot; echo 'Reboot? (y/N)' && read -l x && [ $x = "y" ] && /sbin/reboot; end
