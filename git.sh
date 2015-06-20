LABURL="https://gitlab.com/eda-developers/matrix.git"
HUBURL="https://github.com/jayant-sharma/ft2232h-fifo.git"

if [[ $2 == 'lab' ]]
then
	if   [ $1 == 'init' ]
	then
		git remote add origin $LABURL
		echo "gitlab remote added"
	elif [ $1 == 'seturl' ]
	then
		git remote set-url origin $LABURL
		echo "gitlab remote added"
	elif [ $1 == 'push' ]
	then
		git remote set-url origin $LABURL
		git push -u origin master
		echo "gitlab remote pushed"
	elif [ $1 == 'fpush' ]
	then
		git push -f origin master
		echo "gitlab remote pushed"
	else
	   	echo "No command! Provide valid git operation as first argument."
	fi
elif [[ $2 == 'hub' ]]
then
	if   [ $1 == 'init' ]
	then
		git remote add origin $HUBURL
		echo "github remote added"
	elif [ $1 == 'seturl' ]
	then
		git remote set-url origin $HUBURL
		echo "github remote added"
	elif [ $1 == 'push' ]
	then
		git remote set-url origin $HUBURL
		git push -u origin master
		echo "github remote pushed"
	elif [ $1 == 'fpush' ]
	then
		git push -f origin master
		echo "github remote pushed"
	else
	   	echo "No command! Provide valid git operation as first argument."
	fi
elif [ $1 == 'help' ]
then
   echo "<arg1> <arg2>"
   echo "<arg1> : git operation - init, push, fpush, pull, seturl"
   echo "<arg1> : repository    - lab, hub"
else
   echo "No git repository mentioned! Use --help"
fi


