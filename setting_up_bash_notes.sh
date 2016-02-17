#Notes for setting up useful bash functions
#IMPORTANT: this is not my code - it was taken from Bash Cookbook 
#buy here http://www.amazon.com/bash-Cookbook-Solutions-Examples-Cookbooks/dp/0596526784

# Useful functions
# mkdir newdir then cd into it
# usage: mcd (<mode>) <dir>
function mcd {
local newdir='_mcd_command_failed_'
if [ -d "$1" ]; then
# Dir exists, mention that...
echo $1 exists...
else
if [ -n "$2" ]; then
# We've specified a mode
command mkdir -p -m $1 "$2" && newdir="$2"
else
# Plain old mkdir
command mkdir -p "$1" && newdir="$1"
fi
fi
builtin cd "$newdir"
# No matter what, cd into it
} # end of mcd
# Trivial command line calculator
function calc {
# INTEGER ONLY! --> echo The answer is: $(( $* ))
# Floating point
awk "BEGIN {print \"The answer is: \" $* }";
} # end of calc
# Allow use of 'cd ...' to cd up 2 levels, 'cd ....' up 3, etc. (like 4NT/4DOS)
# Usage: cd ..., etc.
function cd {
local option= length= count= cdpath= i= # Local scope and start clean
# If we have a -L or -P sym link option, save then remove it
if [ "$1" = "-P" -o "$1" = "-L" ]; then
option="$1"
shift
fi
# Are we using the special syntax? Make sure $1 isn't empty, then
# match the first 3 characters of $1 to see if they are '...' then
# make sure there isn't a slash by trying a substitution; if it fails,
# there's no slash. Both of these string routines require Bash 2.0+
if [ -n "$1" -a "${1:0:3}" = '...' -a "$1" = "${1%/*}" ]; then
# We are using special syntax
length=${#1} # Assume that $1 has nothing but dots and count them
count=2
# 'cd ..' still means up one level, so ignore first two
# While we haven't run out of dots, keep cd'ing up 1 level
for ((i=$count;i<=$length;i++)); do
cdpath="${cdpath}../" # Build the cd path
done
# Actually do the cd
builtin cd $option "$cdpath"
elif [ -n "$1" ]; then
# We are NOT using special syntax; just plain old cd by itself
builtin cd $option "$*"
else
# We are NOT using special syntax; plain old cd by itself to home dir
builtin cd $option
fi
} # end of cd
# Do site or host specific things here
case $HOSTNAME in
*.company.com
) # source $SETTINGS/company.com
;;
host1.*
) # host1 stuff
;;
host2.company.com ) # source .bashrc.host2
;;
drake.*
) # echo DRAKE in bashrc.jp!
export TAPE=/dev/tape
;;
esac
Sample inputrc:
# cookbook filename: inputrc
# settings/inputrc: # readline settings
# To re-read (and implement changes to this file) use:
# bind -f $SETTINGS/inputrc
# First, include any systemwide bindings and variable
# assignments from /etc/inputrc
# (fails silently if file doesn't exist)
$include /etc/inputrc
$if Bash
# Ignore case when doing completion
set completion-ignore-case on
# Completed dir names have a slash appended
set mark-directories on
# Completed names which are symlinks to dirs have a slash appended
set mark-symlinked-directories on
# List ls -F for completion
set visible-stats on
# Cycle through ambiguous completions instead of list
"\C-i": menu-complete
# Set bell to audible
set bell-style audible
# List possible completions instead of ringing bell
set show-all-if-ambiguous on
#
#
#
#
From the readline documentation at
http://tiswww.tis.case.edu/php/chet/readline/readline.html#SEC12
Macros that are convenient for shell interaction
edit the path
"\C-xp": "PATH=${PATH}\e\C-e\C-a\ef\C-f"
# prepare to type a quoted word -- insert open and closed double quotes
# and move to just after the open quote
"\C-x\"": "\"\"\C-b"
# insert a backslash (testing backslash escapes in sequences and macros)
"\C-x\\": "\\"
# Quote the current or previous word
"\C-xq": "\eb\"\ef\""
# Add a binding to refresh the line, which is unbound
"\C-xr": redraw-current-line
# Edit variable on current line.
#"\M-\C-v": "\C-a\C-k$\C-y\M-\C-e\C-a\C-y="
"\C-xe": "\C-a\C-k$\C-y\M-\C-e\C-a\C-y="
$endif
