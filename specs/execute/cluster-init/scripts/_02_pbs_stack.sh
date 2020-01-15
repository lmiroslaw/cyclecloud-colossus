#!/bin/bash -x

#-- workaround issue with PBS hardcoding the stack size limit to 16384

configure_system()
{
cp /opt/pbs/lib/init.d/limits.pbs_mom /opt/pbs/lib/init.d/org.limits.pbs_mom 
cat << EOF > /opt/pbs/lib/init.d/limits.pbs_mom 
    MEMLOCKLIM=`ulimit -l`
    NOFILESLIM=`ulimit -n`
    STACKLIM=`ulimit -s`
    ulimit -l unlimited
    ulimit -n 65535
    ulimit -s unlimited
EOF
# pbs restart doesn't start the pbs_mom daemon for some reason
#/etc/init.d/pbs stop
#echo "PBS Stopped; sleeping 60"
#sleep 60
#echo "PBS Check:"
#date
#ps -ef | grep pbs
#echo "PBS Starting:"
#/etc/init.d/pbs start
#echo "PBS Check2:"
#date
#ps -ef | grep pbs
}

configure_system
