#!/bin/sh
echo *******NEW SIMULATION******
# Set hyperparamaters
#sim_mode=hi
beta=5.0
gamma=100.0
epsilon=0.9
#beta=$(bc <<< "scale=5; 0.1/$epsilon^10")
seed=9
#likelihood_std=98

# Display hyperparameters
echo beta=$(echo "$beta"|bc) gamma=$(echo "$gamma"|bc) epsilon=$(echo "$epsilon"|bc) seed=$seed

# Loop through each round
for i in 0 1 2 3 4
do
    python closed_loop_oed.py --round_idx=$i --gamma=$gamma --epsilon=$epsilon --init_beta=$beta --seed=$seed
    python generate_predictions.py --round_idx=$i --seed=$seed
done

# One more round
python closed_loop_oed.py --round_idx=5 --gamma=$gamma --epsilon=$epsilon --init_beta=$beta --seed=$seed