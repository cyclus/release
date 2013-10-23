

if [ -z $1 ]
then
   echo "Error: No run-spec specified"
   exit 1
fi


path=`pwd`
echo "
method    = scp
scp_file  = $path/*
recursive = true
">$path/fetch/myCiclus.scp


nmi_submit $1

