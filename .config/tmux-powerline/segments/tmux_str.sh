# shellcheck shell=bash
# print tmux

generate_segmentrc() {
	read -r -d '' rccontents <<EORC
# prints tmux
EORC
	echo "$rccontents"
}

run_segment() {
	echo "tmux"
	return 0
}
