# make root red
if [ `id -u` = 0 ]
then
    PS1="\[\033[31m\]\h:\W \u\$\[\033[0m\] "
fi

