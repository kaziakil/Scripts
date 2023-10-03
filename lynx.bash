
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Lynx~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Lynx rquires the -cfg to look for configuration in someplace other than
# its own master lynx.cfg file. This requires reloading the shell if these
# files move for any reason. (They are symlinks in the config.) The best
# way to get around this configuration issue and still allow lynx to be
# called from other programs is to encapsulate it with a function.

export _lynx=$(which lynx)

lynx () {
	if [[ -z "$_lynx" ]]; then
		telln "Doesn't look like `lynx` is installed."
		return 1
	fi
	[[ -r ~/.lynx.cfg ]] && lynxcfg="-cfg=$HOME/.lynx.cfg";
	[[ -r ~/.lynx.lss ]] && lynxless="-lss=$HOME/.lynx.lss";
	$_lynx $lynxcfg $lynxlss "$*"
}	&& export -f lynx

urlencode () {
	declare str="$*"
	declare encoded=""
	declare i c x
	for (( i=0; i<${#str}; i++ )); do
		c=${str:$i:1}
		case "$c" in
			[-_.~a-zA-Z0-9] ) x="$c" ;;
		* ) printf -v x '%%%%02x' "'$c" ;;
		esac
		encoded+="$x"
	done
	echo "$encoded"
}

duck () {
	declare url=$(urlencode "$*")
	lynx "https://duckduckgo.com/lite?q=$url"
}
alias "?"=duck

google () {
	declare url=$(urlencode "$*")
	lynx "https://google.com/search?q=url"
}
alias "??"=google
 


