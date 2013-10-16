

path=`pwd`
echo "
method    = scp
scp_file  = $path/*
recursive = true
">$path/fetch/myCyclusCI.scp


nmi_submit $1

