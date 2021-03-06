% Beginning Bash
% Tony Williams
% X World 2016

### Setting Up `Terminal`

### Looking Good
- A Good Profile 'Solarized'
- Setting Font and Size
- Setting Window Size

<div class="notes">
A good start is to make Terminal look better. You can colorize the
output with a profile and use a better font and bigger font size. I've
included my favourite Terminal theme 'Solarized', and my favourite
monospaced font, Input. You can customise Input if you go to it's web site.
</div>

### Before We Begin
- Homebrew
- coreutils
- dockutil
- source-highlight

<div class="notes">
Before we start we need to install a couple of packages. We will do that
with `homebrew`.

coreutils is a pack of  general utilities from the Gnu project. We
install these as Linux uses them.

dockutil is a Python script to manipulate the Dock. We will
use it in a script later.

source-highlight is a package from the Gnu project that highlights 
source code. We use it for that purpose.
</div>

### `source` A File
- bash_profile.sh

<div class="notes">
if we run a shell script it runs in a different shell process so any
changes we make to the way bash runs or looks disappear at the end of
the script.

We can get around this with the `source` command. This takes a text
file and behaves exactly if we had typed it into the command line ourselves.
</div>

### `defaults` Read
``` bash
defaults read com.apple.dock | less
```

<div class="notes">
`defaults` is a command that allows us to read, write, and delete Mac OS
X user defaults from the command-line. Here we are reading the
preferences for the dock. Notice the bar and `less`. bash allows us
to "pipe" the output from one command as the input of another.
</div>

### `defaults`
``` bash
defaults write com.apple.dock autohide -bool YES ; killall Dock
defaults write com.apple.dock autohide -bool NO ; killall Dock
defaults write com.apple.dock orientation "right" ; killall Dock
defaults write com.apple.dock orientation "bottom" ; killall Dock
```

<div class="notes">
Now we use 'write' to change the preferences. After we type the first
one we can use line editing to get the next 3 lines. C-a goes to start
of the line, C-e goes to the end. Esc-f goes forward a word and Esc-b
goes a word back. Esc-d deletes the next word.
</div>

### Shell Programming

### Variables
``` bash
WORD="Foobar" ; echo $WORD
```

<div class="notes">
Here we see how to set a variable and how to use one. Notice the
semi-colon? We use a semi-colon to seperate two commands on the same
line.
</div>

### Pretty Prompt
``` bash
PS1="\[\033[34m\]\h:\w \u\$\[\033[0m\] "
```

<div class="notes">
The shell has a number of special variables. PS1 is one, it sets the
look of your prompt.
In `prompt.sh`.
</div>

### Alias fun
- Commonly used options
- Hard to remember options

### Alias Examples
``` bash
LS_OPTIONS="--color=auto -F -G"
# standard ls coloured
alias ls='gls $LS_OPTIONS'
# standard plus dot files
alias la='gls $LS_OPTIONS -A'
# long ls
alias ll='gls $LS_OPTIONS -l'
alias l='gls $LS_OPTIONS -lA'
```

<div class="notes">
Here we have some aliases for a command with long and hard to
remember options. An alias becomes a literal command so you can have
options and arguments after it, but you can't pass an argument to the
middle of it. This requires a function.

In `alias.sh`.
</div>

### First Steps - Just A Little Function
``` bash
# function to send man page to preview
manp()
{
man -t $* | open -f -a /Applications/Preview.app/
}
```

<div class="notes">
Here's a function that allows multiple arguments in the middle. The
`$*` will be replaced by all the arguments on the command line.
</div>

### Bigger Function - Pass Parameters
```bash
myfunc() 
{ 
    echo "Arg 2: $2" 
    echo "Arg 1: $1"
} 
myfunc "This is an arg" "Another arg"
```

<div class="notes">
In `func.sh`
</div>

### Decisions, Decisions
- If, else, then
- Case
- Using '&&' and '||'

### Example Decision
``` bash
# make root red
if [ `id -u` = 0 ]
then
        PS1="\[\033[31m\]\h:\W \u\$\[\033[0m\] "
fi
```

<div class="notes">
An if statement. In this one we decide if we want to change the colour
of the prompt depending if we are `root` or not. Not the `id -u`
between the backticks. When we place a command between backticks the
command is run and the output is used. Here we have the `id` shell
command print our user ID, which is 0 if we are root.
</div>

### Colour `ls`
``` bash
 # colours for the Gnu ls (from coreutils)
if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto -F -G -h'
    eval `gdircolors ~/.dircolors`
fi
```

<div class="notes">
Here's another if statement. Notice that this time we don't have
a return before the `then`, instead we have a semi-colon, `;` to
represent the same thing. On any line we can replace a return with a
semi-colon.
</div>

### Make A Case
``` bash
#!/bin/bash

echo -n "Word: " ; read WORD

case $WORD in
    ( "Foo" )       echo "Bar" ;;
    ( "Bar" )       echo "Foo" ;;
    ( "FooBar" )    echo "No Way" ;;
    ( * )           echo "FooBar" ;;
esac
```

<div class="notes">
Here is a case statement. If the variable matches the value in the
parentheses it runs the statement on that line. The value `( * )`
matches everything. The `read` statement reads from the command line
until you press return. In `case.sh`.
</div>

### Using && and ||
A **AND** B **OR** C
```bash
[ `id -u` = 0 ] && PS1="\[\033[31m\]\h:\W \u\$\[\033[0m\] " \
|| PS1="\[\033[34m\]\h:\w \u\$\[\033[0m\] "
```

<div class="notes">
Here we use logic operators rather than if and else. This is perfect
if you only want to run single commands. It works because the shell is
"lazy" and won't run the second command in an AND when the first is
false, then because the first set of statements is false it will run
the command after the OR. In `and.sh`.
</div>

### Checking The Result Code
``` bash
if ls mysillyfilename ; then
    echo "File exists."
fi

# checking result code variable
ls mysillyfilename
if [ $? = 0 ] ; then
    echo "File exists."
fi
```

<div class="notes">
We can use the result from any command in an `if` statement. The
special variable `$?` saves the result of the last command.
</div>


### Checking A File
```bash
if [ -e README.md ] ; then
	echo "Readme exists"
fi
```

<div class="notes">
We can also test files, their existence and type. Here we use `-e` to
test that the file exists.
</div>

### File Checks

|    |                      |    |                       |
|:--:|:---------------------|:--:|:----------------------|
| -a | if file exists       | -d | if file is directory  |
| -e | if file exists       | -r | if file is readable   |
| -w | if file is writeable | -x | if file is executable |
| -O | is owned by the user | -G | is owned by the group |

<div class="notes">
Here is a list of some of the more useful file tests. `man test` will
get you a comprehensive list and a list of all the comparison
operators for strings and numbers
</div>

### Round And Round
- For
- While
- Done

### While Loop
``` bash
#!/bin/bash
WORD="Start"
while [ "$WORD" != "" ] ; do
echo -n "Word: " ; read WORD
    case "$WORD" in
        ( "Foo" )       echo "Bar" ;;
        ( "Bar" )       echo "Foo" ;;
        ( "FooBar" )    echo "No Way" ;;
        ( "" ) ;;
        ( * )           echo "FooBar" ;;
    esac
done
```

<div class="notes">
A while loop. So long as the statement is true it will loop forever.
In `while.sh`.
</div>

### For Ever
``` bash
for file in *.sh ; do
    echo $file
done
```

<div class="notes">
A for loop. The echo statement will run for each item in `*.sh`.
In `for.sh`.
</div>

### Even More For
``` bash
for (( i = 1 ; i <= $1 ; i++ )) ; do
    echo "I is $i"
done
```

<div class="notes">
This is the C style `for`. There are the 3 parts. The first is run at
the beginning of the `for`. The second is the test which is done at the
top of the loop (so it is possible for the loop to never run). The
third part is run at the bottom of the loop. In `efor.sh`.
</div>

### Expanding Variables
``` bash
LIST="Foo Bar Baz"
for i in $LIST ; do
	echo $i
done
```

<div class="notes">
We can also loop through items in a variable.
</div>

### Field Separator
``` bash
IFS=":"
LIST="a:b:c d"
for i in $LIST ; do
    echo $i 
done
```

<div class="notes">
What defines an "item" is the Internal Field Seperator or IFS. Here we
change it to a colon. In `expand.sh`.
</div>

### Special Characters In Strings
``` bash
IFS=$'\t'
LIST=$'a\tb\tc d'
for i in $LIST ; do
    echo $i 
done
```

<div class="notes">
You can change the IFS to a special character such as a tab or a
newline. To get either in a string you can surround the string like
this and then `\t` is replaced by tab and `\n` is replaced by a newline.
</div>

### Redirection

### How It's Done
- Fresh output
`ls > files.txt`
- Append to the file
`ls >> files.txt`

<div class="notes">
We can take the output of a command and redirect it to a file. A
single greater than will overwrite an existing file, two will append
to the end of an existing file. Both will create the file if it
doesn't exist.
</div>

### Using tee
- Fresh file
`ls | tee files.txt`
- Append to the file
`ls | tee -a files.txt`

<div class="notes">
`tee` allows us to redirect the output to a file _and_ see it in the terminal.
</div>

### Both OUT and ERR
If you want to log to the same file:
`command1 >> log_file 2>&1`

If you want different files:
`command1 >> log_file 2>> err_file`
<div class="notes">
There are actually *two* outputs. The "ordinary" one, STDOUT and one
for errors, STDERR. They are numbered 1 and 2 respectively and we can
direct them both if we want.
</div>

### Here documents
```bash
logger -t SYSADMIN <<EOM
I am going to reboot the system
I'm doing it because I want to
EOM
```

<div class="notes">
Open up Console then run these lines. Logger allows you to write to
the system log. Using a here document allows us to write multiple lines.
</div>

### Maths Using `expr`
``` bash
#!/bin/bash

WEEKS=$1
DAYS=`expr $WEEKS '*' '7'`
date -v +${DAYS}d 
```

<div class="notes">
We can do maths in scripts using the `expr` command. In `weeks.sh`.
</div>

### Maths Using Expansion
``` bash
#!/bin/bash

WEEKS=$1
DAYS=$(($WEEKS*7))
date -v +${DAYS}d 
```
Or even
`echo $(( 7 * ( 4 + 2 ) ))`
Though the spaces are not required `echo $((7*(4+2)))`

<div class="notes">
It often looks clearer to use shell arithmetic expansion for maths.
</div>

### Improve The Look
``` bash
WEEKS=$1
DAYS=`expr $WEEKS '*' '7'`
date -v +${DAYS}d | awk '{ print $1 " " $2 " " $3 " " $4 }'
```

<div class="notes">
We can pipe the output of the `date` command to a utility called
`awk`. This is a powerful text processing language but here we just
use a simple command. This one just prints some of the fields. Awk is
often used to trim or reformat the output of another command.
In `weeks2.sh`.
</div>

### LaunchAgents & LaunchDaemons
- LaunchAgents run at user login
  - definition found in ~/Library/LaunchAgents/
- LaunchDaemons run at boot
 - definition found in /System/Library/LaunchDaemons/

<div class="notes">
Here we get into what we can do with a script. Anything can be a
LauchAgent or LaunchDaemons, so we can write a script that gets
installed as part of the system.

Both LaunchAgents and LaunchDaemons can run once, stay running or be
re-run at an interval.

The actual script can live anywhere but the file defining how it is run
lives in one of the two spots.
</div>

### Controlling LaunchAgents
- plist file
- named 'something.command.plist' e.g.
  - com.honestpuck.command.plist

<div class="notes">
The defining file is a plist. It is usully named as a reverse domain name
followed by the command name.

You can write one by hand but it is easier to use a utility such as
Lingon X or LaunchControl.
</div>

### Giving It A Try
- agent_test.sh
- com.honestpuck.test.plist

<div class="notes">
Let's give it a try by creating a LaunchAgent,
com.honestpuck.test.plist, to run `agent_test.sh`
using LaunchControl.
</div>

### A Complex Example
- local.job.plist

<div class="notes">
com.honestpuck.test.plist is a simple example. Let's create a more
complex one that runs every hour.
</div>

### Putting it all together
 - dock_setup.sh

<div class="notes">
Now let's put it all together by looking at a longish shell
script that can get used as a LaunchAgent.
</div>

### Getting A Profile
 - bash_profile.sh
 
<div class="notes">
Another example, let's look at part of my .bash_profile file that we
have been using.
</div>

### Places To Go

- This presentation <http://bit.ly/xw2016-9>
- Apple have a good `bash` tutorial <http://apple.co/1MFChLE>
- Good `bash` tutorial <http://bit.ly/xw2016-2>
- Comprehensive `awk` tutorial <http://bit.ly/xw2016-5>
- Effective AWK Programming <http://bit.ly/xw2016-7>
- All About Redirection <http://bit.ly/xw2016-1>

<div class="notes">
Before we go here are some web sites you might like to visit for more information.
</div>

### More Places To Go

- Apple's page on Launch Daemons and Agents <http://bit.ly/xw2016-8>
- Lingon X <http://bit.ly/xw2016-6>
- LaunchControl <http://bit.ly/xw2016-11>
- Good tutorial on LaunchAgent and Daemon format <http://launchd.info>
- My home directory on git <http://bit.ly/xw2016-10>
- MacAdmins Slack channel <https://macadmins.herokuapp.com>

<div class="notes">
And some more :)
</div>

### A Final List

- Input font <http://input.fontbureau.com>
- Solarized colour theme <http://ethanschoonover.com/solarized>
- bash completion <http://bit.ly/xw2016-12>
- shellcheck, a script checker <http://www.shellcheck.net>


