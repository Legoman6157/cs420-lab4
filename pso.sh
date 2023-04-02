#Number of particles: 10 to 100, in increments of 10
#Inertia: 0.1 to 1, in increments of 0.1
#Cognition parameter: 0.1 to 4 in increments of 0.1
#Social parameter: 0.1 to 4 in increments of 0.1


declare -a param_seqs
param_seqs[0]=$(seq 10 10 100)
param_seqs[1]=$(seq .1 .1 1)
param_seqs[2]=$(seq .1 .1 4)
param_seqs[3]=$(seq .1 .1 4)

declare -a param_names
param_names[0]=num_particles
param_names[1]=inertia
param_names[2]=cognition
param_names[3]=social

combination=0

#Iterate over all parameters
for i in $(seq 0 1 3)
do
    : > pso-${param_names[$i]}.csv
    echo combination,iteration,particles,inertia,cognition,social,function,epochs,solution_x,solution_y,fitness,converged >> pso-${param_names[$i]}.csv

    #Iterate over all parameter values
    for param_value in ${param_seqs[$i]}
    do
        #Do both Rosenbrock and Booth function
        for function in $(seq 1 1 2)
        do
            #Run each combination 20 times
            for local_iteration in $(seq 0 1 19)
            do
                echo 
                echo Combination: $combination
                echo Function: $function
                echo Local iteration: $local_iteration
                echo File: pso-${param_names[$i]}.csv
                echo Parameter used: --${param_names[$i]} $param_value
                echo Function used: --function $function
                echo File used: --fn pso-${param_names[$i]}.csv
                echo Command used: python3 pso.py --${param_names[$i]} $param_value --function $function --fn pso-${param_names[$i]}.csv

                echo -n $combination,$local_iteration, >> pso-${param_names[$i]}.csv

                python3 pso.py --${param_names[$i]} $param_value --function $function --fn pso-${param_names[$i]}.csv
            done; #local_iteration in $(seq 0 1 19)
            combination=$((combination+1))
        done; #function in $(seq 1 1 2)
    done; #param_value in ${param_seqs[$i]}
    combination=0
done; #i in $(seq 0 1 3)