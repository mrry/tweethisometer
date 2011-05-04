#!/bin/bash

if [[ $1 == '--offline' ]]
then

    while `true`
    do
	WCW=`detex thesis.tex | wc -w`
       	echo -n $WCW "     "
	sleep 1
    done


else

    twitter | tail -n 1 | gawk '{print $3;}' > .count || exit
    
    while `true`
    do
	WCW=`detex thesis.tex | wc -w`
	OLD_WCW=`cat .count`
	
	if [ $WCW -gt $(($OLD_WCW + 100)) ]
	then
	    echo $WCW > .count
	    twitter set Written $WCW words!
	    echo
	    echo -n $WCW\* "    "
	    sleep 60
	fi
	
	echo -n $WCW "     "
	sleep 0.5
    done

fi

