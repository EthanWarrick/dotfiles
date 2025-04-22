function lsusb-speed --description='List protocol versions of connected USB devices'
  lsusb -v 2> /dev/null | grep --color=never -G "bcdUSB\|Bus [[:digit:]]"
end
