function lsusb-speed --description='List protocol versions of connected USB devices'
  lsusb -v 2>/dev/null | awk '
    /^Bus/ { name=$0 }
    /bcdUSB/ {
      usb=$0
      sub(/.*bcdUSB[[:space:]]+/,"",usb)
      sub(/^Bus [0-9]+ Device [0-9]+: ID [0-9a-f]+:[0-9a-f]+ /,"",name)
      sub(/[[:space:]]+$/, "", name)
      if (length(name) > 68) name=substr(name,1,65)"…"
      printf "%-68s %s\n", name, usb
    }
  '
end
