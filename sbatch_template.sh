#!/bin/bash

# Lines that begin with #SBATCH specify commands to be used by SLURM for scheduling

#SBATCH --job-name=sbatch_template  # sets the job name
#SBATCH --output="slurm-%j.out"     # indicates a file to redirect STDOUT to; %j is the jobid. Must be set to a file instead of a directory or else submission will fail.
#SBATCH --error="slurm-%j.out"      # indicates a file to redirect STDERR to; %j is the jobid. Must be set to a file instead of a directory or else submission will fail.
#SBATCH --qos=scavenger             # set QOS, this will determine what resources can be requested
#SBATCH --partition=scavenger
#SBATCH --gres=gpu:1                # Specify how many GPUs and of why type. Ex: gpu:p6000:1, gpu:gtx1080ti:1, gpu:rtx2080ti:1, gpu:rtxa6000:1
#SBATCH --time=0-03:00:00           # how long you think your job will take to complete; format=d-hh:mm:ss

module load Python3/3.10.4          # run any commands necessary to setup your environment
conda activate point2mesh

srun bash -c "hostname; python3 --version" &    # Use srun to invoke commands within your job; using an '&'
srun bash -c "hostname; python3 --version" &    # will background the process allowing them to run concurrently.
srun echo $CONDA_DEFAULT_ENV &                  # So this script runs
wait                                            # wait for any background processes to complete

# once the end of the batch script is reached your job allocation will be revoked
# Call this from a submission node with "sbatch sbatch_template.sh"