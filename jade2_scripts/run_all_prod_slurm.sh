#!/bin/bash

# submit each repeat as an array per engine

# export important file locations
export HOMEDIR="/jmain02/home/J2AD004/sxk13/axh37-sxk13"
export MAINDIRECTORY="$HOMEDIR/benchmark_mcl1" # Set file path for protein
export scripts_dir="$HOMEDIR/scripts" # choose location of scripts
export protein_file="$HOMEDIR/benchmark/inputs/tyk2/tyk2_parameterised" # this should be the prm7 and rst7 file name. best as input folder 
export ligands_folder="$HOMEDIR/benchmark/inputs/tyk2/ligands"

# export all execution model files for later scripts
export lig_file="$MAINDIRECTORY/execution_model/ligands.dat"
export net_file="$MAINDIRECTORY/execution_model/network_combined_reverse.dat"
export prot_file="$MAINDIRECTORY/execution_model/protocol.dat"

# sourcing - as needed in the othe sh scripts
source $scripts_dir/extract_execution_model_bash.sh

echo "The folder for all these runs is $MAINDIRECTORY"
echo ${trans_array[@]}
echo ${eng_array[@]}
echo ${win_array[@]}
echo ${repeats_array[@]}

for trans in ${trans_array[@]}; do

var1=$(squeue -u axh37-sxk13 | grep "PD")
var2=$(squeue -u axh37-sxk13 | grep "axh37-sx  R")
var=$((${#var1}*3 + ${#var2} ))
echo "for this $trans, var is $var"

until [ $var -lt 2500 ] ; do
date
echo "jobs still running (var more than 2500), won't submit yet. sleep for 60m..."
sleep 60m
var1=$(squeue -u axh37-sxk13 | grep "PD")*
var2=$(squeue -u axh37-sxk13 | grep "axh37-sx  R")
var=$((${#var1}*3 + ${#var2} ))
echo "var is now $var"
done

echo "can submit job..."
sleep 5
jidprod=$(sbatch --parsable --array=0-$((${#repeats_array[@]}-1)) production.sh $trans)
echo "Production jobid for $trans is $jidprod"
sleep 10

done

echo "submitted all jobs"

## run using:
## nohup ./run_all_prod_slurm.sh > output.out &
