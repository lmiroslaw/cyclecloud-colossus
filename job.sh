echo Hostfile:
echo `cat $SLURM_JOB_NODELIST`
echo
date
sudo beeond start -n $(readlink -f $SLURM_JOB_NODELIST) -d /mnt/resource/beeond -c /beeond
date
echo Finished beeond
echo `df -h /beeond`
echo
sleep 5

mpirun hostname
 
# Let's stop Beeond now :
date
time sudo beeond stop -n $(readlink -f $SLURM_JOB_NODELIST) -L -d
date
