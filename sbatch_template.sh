#!/bin/bash

# Lines that begin with #SBATCH specify commands to be used by SLURM for scheduling. They are not comments.
#SBATCH --qos=scavenger                 
#SBATCH --partition=scavenger
#SBATCH --ntasks=3

# # SLURM defaults that you might want to change:
# #SBATCH --qos=default                 # The qos parameter doesn't actually have a default - you must specify it. See resources available for each qos below.
# #SBATCH --partition=dpart             # You must add "--partition=scavenger" if you choose "--qos=scavenger"
# #SBATCH --account=vulcan              # You must add "--account=<faculty name>" if you choose "--qos=high"
# #SBATCH --time=0-01:00:00             # Time to reserve for your job. If your job ends before this the resources will be freed. Format=d-hh:mm:ss
# #SBATCH --mem=8gb                     # For point2mesh runs I needed 32gb in the max cases.
# #SBATCH --gres=gpu:0                  # Specify how many GPUs and of why type. Ex: gpu:p6000:1, gpu:gtx1080ti:1, gpu:rtx2080ti:1, gpu:rtxa6000:1
# #SBATCH --ntasks=1                    # Use this to run concurrent commands. If you set "--ntasks=2" you must set "--ntasks=1" down below with srun.
# #SBATCH --job-name=bash               # Takes the first srun command as the job name.
# #SBATCH --output="slurm-%j.out"       # indicates a file to redirect STDOUT to; %j is the jobid. Must be set to a file instead of a directory or else submission will fail.
# #SBATCH --error="slurm-%j.out"        # indicates a file to redirect STDERR to; %j is the jobid. Must be set to a file instead of a directory or else submission will fail.

# Run any commands necessary to setup your environment:
source /etc/profile.d/modules.sh
module load Python3/3.10.4
source $(conda info --base)/etc/profile.d/conda.sh          # Use if conda is already on your path but you still need to run "conda init <shell_name>"       
conda activate point2mesh

# Use srun to run job steps. These can be run concurrently if you specify"--exclusive --ntasks=1". 
# "--exclusive" indicates each step should run on its own CPU and "--ntasks=1" is needed because srun inherits "--ntasks=3" from #SBATCH and using that
# in all the steps makes 9 total tasks when only 3 were allocated for our job. 
srun --exclusive --ntasks=1 bash -c "hostname; sleep 12; python3.10 --version;" &   # using an '&' will background the process allowing them to run concurrently.
srun --exclusive --ntasks=1 bash -c "hostname; sleep 10; python3 --version;" &     
srun --exclusive --ntasks=1 echo $CONDA_DEFAULT_ENV &                  
wait                                                                                # Wait is required to allow any background processes to complete.

# Once the end of the batch script is reached your job allocation will be revoked (resources freed).
# Call this from a submission node with "sbatch sbatch_template.sh"

# $ show_qos
#             Name     MaxWall MaxJobs                        MaxTRES     MaxTRESPU   Priority
# ---------------- ----------- ------- ------------------------------ ------------- ----------
#           normal                                                                           0
#           medium  3-00:00:00       2       cpu=8,gres/gpu=2,mem=64G                        0
#             high  1-12:00:00       2     cpu=16,gres/gpu=4,mem=128G                        0
#          default  7-00:00:00       2       cpu=4,gres/gpu=1,mem=32G                        0
#        scavenger  3-00:00:00             cpu=32,gres/gpu=8,mem=256G                        0
#            janus  3-00:00:00            cpu=32,gres/gpu=10,mem=256G                        0
#           exempt  7-00:00:00       2     cpu=32,gres/gpu=8,mem=256G                        0
#            class    12:00:00       1       cpu=4,gres/gpu=1,mem=32G                        0
#              cpu  2-00:00:00       1                cpu=1024,mem=4T                        0
#        exclusive 30-00:00:00                                                               0
#           sailon  3-00:00:00             cpu=32,gres/gpu=8,mem=256G   gres/gpu=48          0