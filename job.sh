SBATCH --job-name=imb
#SBATCH --output=imb_hc.txt
#SBATCH --account=tsp
#SBATCH --nodes=2
#SBATCH --ntasks=2
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=44
#SBATCH --time=60:00
#SBATCH --partition=HC44
module load mpi/impi_2018.4.274

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

mpirun -np 2 -ppn 44 -genv I_MPI_FABRICS=shm:ofa -genv I_MPI_FALLBACK_DEVICE=0 IMB-MPI1 hostname
 
# Let's stop Beeond now :
date
time sudo beeond stop -n $(readlink -f $SLURM_JOB_NODELIST) -L -d
date
