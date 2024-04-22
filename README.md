# MT Exercise 3: Pytorch RNN Language Models

This repo shows how to train neural language models using [Pytorch example code](https://github.com/pytorch/examples/tree/master/word_language_model). Thanks to Emma van den Bold, the original author of these scripts. 

# Requirements

- This only works on a Unix-like system, with bash.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

# Steps

Clone this repository in the desired place:

    git clone https://github.com/moritz-steiner/mt-exercise-03
    cd mt-exercise-03

Create a new virtualenv that uses Python 3. Please make sure to run this command outside of any virtual Python environment:

    ./scripts/make_virtualenv.sh

**Important**: Then activate the env by executing the `source` command that is output by the shell script above.

Download and install required software:

    ./scripts/install_packages.sh

Download and preprocess data:

    ./scripts/download_data.sh

Train a model:

    ./scripts/train.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved.

Generate (sample) some text from a trained model with:

    ./scripts/generate.sh

# Changes
scripts/download_data.sh: I changed the link to download another book from project Gutenberg, and preprocess and split into train, valid, test sets. 

scripts/train.sh: I only changed the hyperparameters epochs and dropout. I changed epochs to 20 because I saw that after epoch 15 the validation loss and perplexity was not improving.

/tools/pytorch-examples/word language model/main.py
1. Added a new flag (--save_perplexities) for printing the perplexities at each epoch to a log file. This creates a new folder called logs in mt-exercise-03, and creates a new log file perplexities_{dropout}.log in logs folder. For example if dropout is 0.0: logs/perplexities_0.0.log is created.
2. Run ./scripts/train.sh each time changing the dropout in the train.sh.
   
scripts/tables_plots.py: I created a new python script that takes as input the logs folder. It parses the folder, and generates the table and plot for the assignment Part 2. 

Running:

    python {path_to_repo_folder}/mt-exercise-03/scripts/tables_plots.py  {path_to_repo_folder}/mt-exercise-03/logs




