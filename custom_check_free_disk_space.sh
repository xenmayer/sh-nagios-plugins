#!/bin/bash

# get current used space percent
used_space=`df -h / | grep -v Filesystem | awk '{print $5}' | sed 's/%//g'`

# set default warning and critical space usage
warning_usage=70
critical_usage=90

# get command options
while getopts w:c: option
do
  case "${option}" in 
    w)
      warning_usage=${OPTARG} 
    ;;
    c)
      critical_usage=${OPTARG} 
    ;;
  esac
done

# check OK status
if (($used_space < $warning_usage && $used_space < $critical_usage)) 
then echo "OK disk usage is $used_space%"
    exit 0
fi

# check warning status
if (($used_space > $warning_usage && $used_space < $critical_usage)) 
then
    echo "WARNING disk usage is $used_space%"
    exit 1
fi

# check critical status
if (($used_space > $critical_usage )) 
then
    echo "CRITICAL disk usage is $used_space%"
    exit 2
fi

# unknown exit
exit 3
