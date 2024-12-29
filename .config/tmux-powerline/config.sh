# Default configuration file for tmux-powerline.

# General {
	# Show which segment fails and its exit code.
	export TMUX_POWERLINE_DEBUG_MODE_ENABLED="false"
	# Use patched font symbols.
	export TMUX_POWERLINE_PATCHED_FONT_IN_USE="true"

	# The theme to use.
	export TMUX_POWERLINE_THEME="jer"
	# Overlay directory to look for themes. There you can put your own themes outside the repo. Fallback will still be the "themes" directory in the repo.
	export TMUX_POWERLINE_DIR_USER_THEMES="${XDG_CONFIG_HOME:-$HOME/.config}/tmux-powerline/themes"
	# Overlay directory to look for segments. There you can put your own segments outside the repo. Fallback will still be the "segments" directory in the repo.
	export TMUX_POWERLINE_DIR_USER_SEGMENTS="${XDG_CONFIG_HOME:-$HOME/.config}/tmux-powerline/segments"

	# The initial visibility of the status bar. Can be {"on", "off", "2"}. 2 will create two status lines: one for the window list and one with status bar segments.
	export TMUX_POWERLINE_STATUS_VISIBILITY="on"
	# In case of visibility = 2, where to display window status and where left/right status bars.
	# 0: window status top, left/right status bottom; 1: window status bottom, left/right status top
	export TMUX_POWERLINE_WINDOW_STATUS_LINE=0
	# The status bar refresh interval in seconds.
	# Note that events that force-refresh the status bar (such as window renaming) will ignore this.
	export TMUX_POWERLINE_STATUS_INTERVAL="1"
	# The location of the window list. Can be {"absolute-centre, centre, left, right"}.
	# Note that "absolute-centre" is only supported on `tmux -V` >= 3.2.
	export TMUX_POWERLINE_STATUS_JUSTIFICATION="left"

	# The maximum length of the left status bar.
	export TMUX_POWERLINE_STATUS_LEFT_LENGTH="60"
	# The maximum length of the right status bar.
	export TMUX_POWERLINE_STATUS_RIGHT_LENGTH="180"

	# The separator to use between windows on the status bar.
	export TMUX_POWERLINE_WINDOW_STATUS_SEPARATOR=""

	# Uncomment these if you want to enable tmux bindings for muting (hiding) one of the status bars.
	# E.g. this example binding would mute the left status bar when pressing <prefix> followed by Ctrl-[
	#export TMUX_POWERLINE_MUTE_LEFT_KEYBINDING="C-["
	#export TMUX_POWERLINE_MUTE_RIGHT_KEYBINDING="C-]"
# }

# disk_usage.sh {
	# Filesystem to retrieve disk space information. Any from the filesystems available (run "df | awk '{print }'" to check them).
	export TMUX_POWERLINE_SEG_DISK_USAGE_FILESYSTEM="/local/home/jerebill"
# }

# hostname.sh {
	# Use short or long format for the hostname. Can be {"short, long"}.
	export TMUX_POWERLINE_SEG_HOSTNAME_FORMAT="short"
# }

# pwd.sh {
	# Maximum length of output.
	export TMUX_POWERLINE_SEG_PWD_MAX_LEN="80"
# }

# tmux_mem_cpu_load.sh {
	# Arguments passed to tmux-mem-cpu-load.
	# See https://github.com/thewtex/tmux-mem-cpu-load for all available options.
	export TMUX_POWERLINE_SEG_TMUX_MEM_CPU_LOAD_ARGS="-g 0 -a 0 -i 30"
# }

# vcs_branch.sh {
	# Max length of the branch name.
	export TMUX_POWERLINE_SEG_VCS_BRANCH_MAX_LEN=""
	# Symbol when branch length exceeds max length
	export TMUX_POWERLINE_SEG_VCS_BRANCH_TRUNCATE_SYMBOL="…"
	# Default branch symbol
	export TMUX_POWERLINE_SEG_VCS_BRANCH_DEFAULT_SYMBOL=""
	# Branch symbol for git repositories
	export TMUX_POWERLINE_SEG_VCS_BRANCH_GIT_SYMBOL="${TMUX_POWERLINE_SEG_VCS_BRANCH_DEFAULT_SYMBOL}"
	# Branch symbol for hg/mercurial repositories
	export TMUX_POWERLINE_SEG_VCS_BRANCH_HG_SYMBOL="${TMUX_POWERLINE_SEG_VCS_BRANCH_DEFAULT_SYMBOL}"
	# Branch symbol for SVN repositories
	export TMUX_POWERLINE_SEG_VCS_BRANCH_SVN_SYMBOL="${TMUX_POWERLINE_SEG_VCS_BRANCH_DEFAULT_SYMBOL}"
	# Branch symbol colour for git repositories
	export TMUX_POWERLINE_SEG_VCS_BRANCH_GIT_SYMBOL_COLOUR="0"
	# Branch symbol colour for hg/mercurial repositories
	export TMUX_POWERLINE_SEG_VCS_BRANCH_HG_SYMBOL_COLOUR="45"
	# Branch symbol colour for SVN repositories
	export TMUX_POWERLINE_SEG_VCS_BRANCH_SVN_SYMBOL_COLOUR="220"
# }

# vcs_compare.sh {
	# Symbol if local branch is behind.
	export TMUX_POWERLINE_SEG_VCS_COMPARE_AHEAD_SYMBOL="↑ "
	# Symbol colour if local branch is ahead. Defaults to "current segment foreground colour"
	export TMUX_POWERLINE_SEG_VCS_COMPARE_AHEAD_SYMBOL_COLOUR=""
	# Symbol if local branch is ahead.
	export TMUX_POWERLINE_SEG_VCS_COMPARE_BEHIND_SYMBOL="↓ "
	# Symbol colour if local branch is behind. Defaults to "current segment foreground colour"
	export TMUX_POWERLINE_SEG_VCS_COMPARE_BEHIND_SYMBOL_COLOUR=""
# }

# vcs_modified.sh {
	# Symbol for count of modified vcs files.
	export TMUX_POWERLINE_SEG_VCS_MODIFIED_SYMBOL="± "
# }

# vcs_others.sh {
	# Symbol for count of untracked vcs files.
	export TMUX_POWERLINE_SEG_VCS_OTHERS_SYMBOL="󱀶"
# }

# vcs_rootpath.sh {
	# Display mode for vcs_rootpath.
	# Example: (name: folder name only; path: full path, w/o expansion; user_path: full path, w/ tilde expansion)
	export TMUX_POWERLINE_SEG_VCS_ROOTPATH_MODE="name"
# }

# vcs_staged.sh {
	# Symbol for count of staged vcs files.
	export TMUX_POWERLINE_SEG_VCS_STAGED_SYMBOL="⊕ "
# }
