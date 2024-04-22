import os
import argparse
import matplotlib.pyplot as plt


def parse_logs(log_folder):
    log_files = [f for f in os.listdir(log_folder) if f.startswith('perplexities_')]

    dropout_epochs = {}
    for log_file in log_files:
        dropout_ratio = log_file.split('_')[-1]
        dropout_epochs[dropout_ratio] = {}

        with open(os.path.join(log_folder, log_file), 'r') as f:
            for line in f:
                epoch, score = line.strip().split('\t')
                dropout_epochs[dropout_ratio][int(epoch)] = float(score)

    return dropout_epochs

def print_table(dropout_epochs):
    epochs = set()
    for dropout_ratio, epochs_scores in dropout_epochs.items():
        epochs.update(epochs_scores.keys())

    sorted_epochs = sorted(list(epochs))
    header = ['Epoch'] + list(dropout_epochs.keys())
    print('\t|\t'.join(header))
    print('---' * (sum(len(column) for column in header) + len(header) - 1))
    
    for epoch in sorted_epochs:
        row = [str(epoch)]
        for dropout_ratio in dropout_epochs.keys():
            row.append(str(round(dropout_epochs[dropout_ratio].get(epoch, ''), 2)))
        print('\t|\t'.join(row))

def plot_line_chart(dropout_epochs, output_file="line_plot.png"):
    plt.figure(figsize=(10, 6))

    for dropout_ratio, data in dropout_epochs.items():
        epochs = list(data.keys())
        scores = list(data.values())
        plt.plot(epochs, scores, label=f'Dropout {dropout_ratio}')

    plt.xlabel('Epoch')
    plt.ylabel('Score')
    plt.title('Training and Score')
    plt.legend()
    plt.grid(True)
    plt.savefig(output_file)  # Save the plot to a file
    plt.close()  # Close the figure to release memory

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Read and print log files in a folder.')
    parser.add_argument('log_folder', type=str, help='Path to the folder containing log files')
    args = parser.parse_args()

    dropout_epochs = parse_logs(args.log_folder)
    print_table(dropout_epochs)
    print(dropout_epochs)
    plot_line_chart(dropout_epochs)