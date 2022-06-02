#!/bin/bash

SYS=`uname`

if [ "$SYS" = "Darwin" ]; then
	PKG="brew"
else
	PKG="apt"
fi

FIG=`$PKG list | grep figlet`

if [ "$FIG" = "figlet" ]; then
	:
else
	$PKG install figlet
fi

if [ $# -eq 1 ]; then
	FONT="standard"
else
	FONT=$2
fi

LINE=`figlet -w 1000 -f $FONT $1 | wc -l`

echo "void	print_header(void)"
echo "{"
for i in `seq "$LINE"`
do
	TMP=`figlet -w 1000 -f $FONT $1 | awk -v line=$i 'NR==line{print}'`
	echo "	printf(\"${TMP}\\n\");"
done
echo "}"