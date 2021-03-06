ssh -i ~/.ssh/id_rsa skryabinglebedu_2138@lomonosov2.parallel.ru

scp -r ~/Projects/coursework/mpi_collective skryabinglebedu_2138@lomonosov2.parallel.ru:~/_scratch/research/

scp -r ~/Projects/coursework/mpi_collective/big_testing.sh skryabinglebedu_2138@lomonosov2.parallel.ru:~/_scratch/research/mpi_collective



module rm xalt
module load slurm
module load openmpi
cd _scratch/research/mpi_collective/

rm cycle
mpicxx noise_affinity/cycle.cpp -o cycle
sh setup.sh




rm big_testing.sh; cat >> big_testing.sh

mpicxx barrier.cpp -o barrier
chmod +x launch_script_barrier.sh
nohup ./launch_script_barrier.sh 1 14 1 1s 256 100000 10000 &

squeue --user skryabinglebedu_2138



