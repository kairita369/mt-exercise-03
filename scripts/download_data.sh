#! /bin/bash

scripts=$(dirname "$0")
base=$scripts/..

data=$base/data

mkdir -p $data

tools=$base/tools

# link default training data for easier access

#mkdir -p $data/wikitext-2
#
#for corpus in train valid test; do
#    absolute_path=$(realpath $tools/pytorch-examples/word_language_model/data/wikitext-2/$corpus.txt)
#    ln -snf $absolute_path $data/wikitext-2/$corpus.txt
#done

# download a different interesting data set!

# mkdir -p $data/grimm
mkdir -p $data/crime_and_punishment

#mkdir -p $data/grimm/raw
mkdir -p $data/crime_and_punishment/raw

#wget https://www.gutenberg.org/files/52521/52521-0.txt
#mv 52521-0.txt $data/grimm/raw/tales.txt

wget https://www.gutenberg.org/cache/epub/2554/pg2554.txt
mv pg2554.txt $data/crime_and_punishment/raw/book.txt

# preprocess slightly

#cat $data/grimm/raw/tales.txt | python $base/scripts/preprocess_raw.py > $data/grimm/raw/tales.cleaned.txt
cat $data/crime_and_punishment/raw/book.txt | python $base/scripts/preprocess_raw.py > $data/crime_and_punishment/raw/book.cleaned.txt


# tokenize, fix vocabulary upper bound

#cat $data/grimm/raw/tales.cleaned.txt | python $base/scripts/preprocess.py --vocab-size 5000 --tokenize --lang "en" --sent-tokenize > \
#    $data/grimm/raw/tales.preprocessed.txt
cat $data/crime_and_punishment/raw/book.cleaned.txt | python $base/scripts/preprocess.py --vocab-size 5000 --tokenize --lang "en" --sent-tokenize > \
    $data/crime_and_punishment/raw/book.preprocessed.txt

# split into train, valid and test

#head -n 440 $data/grimm/raw/tales.preprocessed.txt | tail -n 400 > $data/grimm/valid.txt
#head -n 840 $data/grimm/raw/tales.preprocessed.txt | tail -n 400 > $data/grimm/test.txt
#tail -n 3075 $data/grimm/raw/tales.preprocessed.txt | head -n 2955 > $data/grimm/train.txt

head -n 440 $data/crime_and_punishment/raw/book.preprocessed.txt | tail -n 400 > $data/crime_and_punishment/valid.txt
head -n 840 $data/crime_and_punishment/raw/book.preprocessed.txt | tail -n 400 > $data/crime_and_punishment/test.txt
tail -n 3075 $data/crime_and_punishment/raw/book.preprocessed.txt | head -n 2955 > $data/crime_and_punishment/train.txt

