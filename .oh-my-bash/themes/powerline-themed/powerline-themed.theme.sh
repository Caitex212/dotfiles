#! bash oh-my-bash.module

source "$OSH/themes/powerline-themed/powerline-themed.base.sh"
source ~/.cache/wal/colors.sh

PROMPT_CHAR=${POWERLINE_PROMPT_CHAR:=""}
POWERLINE_LEFT_SEPARATOR=${POWERLINE_LEFT_SEPARATOR:=""}

# --- THEME SEGMENTS ---

# User Info: Using Color 1 (Dark Brown/Grey)
# This is dark enough that your light text (#c4c5c1) will remain readable.
USER_INFO_THEME_PROMPT_COLOR=1
USER_INFO_THEME_PROMPT_SECONDARY_COLOR="-"
USER_INFO_THEME_PROMPT_COLOR_SUDO=3

# CWD (Current Directory): Using Color 4 (Deep Forest Green/Grey)
# This is one of your darker accents to avoid the white-on-white clash.
CWD_THEME_PROMPT_COLOR=4

# SCM (Git): Using Color 2 for clean, Color 5 for dirty.
# We avoid Color 7 and Color 15 entirely as backgrounds.
SCM_THEME_PROMPT_CLEAN_COLOR=2
SCM_THEME_PROMPT_DIRTY_COLOR=5
SCM_THEME_PROMPT_STAGED_COLOR=6
SCM_THEME_PROMPT_UNSTAGED_COLOR=1
SCM_THEME_PROMPT_COLOR=${SCM_THEME_PROMPT_CLEAN_COLOR}

# Python/Ruby: Using Color 8 (The "Bright Black" which is actually a dark olive in your set)
PYTHON_VENV_THEME_PROMPT_COLOR=8
RUBY_THEME_PROMPT_COLOR=8

# Status/Clock: Keeping them very dark
LAST_STATUS_THEME_PROMPT_COLOR=1
CLOCK_THEME_PROMPT_COLOR=0 # Uses your absolute black background

# --- OVERRIDE FOR READABILITY ---
# If you still find it hard to read, we use '0' (Black) for segments 
# that are too light, but for your palette, 1, 2, 4, and 5 are the safest "dark" choices.

POWERLINE_PROMPT=${POWERLINE_PROMPT:="user_info cwd scm python_venv"}

function _omb_theme_PROMPT_COMMAND { __powerline_prompt_command "$@"; }
_omb_util_add_prompt_command _omb_theme_PROMPT_COMMAND