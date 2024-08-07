function poweroff; echo 'Poweroff? (y/N)' && read -l x && [ $x = "y" ] && /sbin/poweroff; end
