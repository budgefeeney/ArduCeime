#!/bin/bash


if [ -z $1 ]
then
	PREFIX=""
else
	PREFIX="$1-"
fi

HOURS=48
MEM=12G

SRC_HOME=`dirname $0`
WHERE_I_WAS=$PWD
cd $SRC_HOME
SRC_HOME=$PWD
cd $WHERE_I_WAS

OUT_PATH="$SRC_HOME/out"
STM_EXEC="$SRC_HOME/stm.sh"

NUM_FOLDS=5
EVAL="perplexity"

TOPIC_COUNTS="5 10 25 50 100 150 200"
VB_ALGORS="lda_cvb lda_cvb0" #"lda_cvb0 lda_vb mom_em"
DATASETS="reuters nips tnews"

TRAIN_ITERS=500
QUERY_ITERS=100

for TOPIC_COUNT in $TOPIC_COUNTS
do
	for ALGOR in $VB_ALGORS
	do
		for DATASET in $DATASETS
		do
			WORDS_FILE="$SRC_HOME/$DATASET.pkl"

			echo "$STM_EXEC \
			--model $ALGOR \
			--dtype f4 \
			--num-topics $TOPIC_COUNT  \
			--folds $NUM_FOLDS \
			--eval $EVAL \
			--iters $TRAIN_ITERS \
			--query-iters $QUERY_ITERS \
			--log-freq 10 \
			--words $WORDS_FILE" | qsub -N "Job-$DATASET-$ALGOR-$TOPIC_COUNT" -l h_rt=$HOURS:0:0 -l mem_free=$MEM,h_vmem=$MEM,tmem=$MEM -S /bin/bash
		done
	done
done

for TOPIC_COUNT in $TOPIC_COUNTS
do
	WORDS_FILE="$SRC_HOME/tnews.pkl"
	ALGOR="lda_vb"
	echo "$STM_EXEC \
			--model $ALGOR \
			--dtype f8 \
			--num-topics $TOPIC_COUNT  \
			--folds $NUM_FOLDS \
			--eval $EVAL \
			--iters $TRAIN_ITERS \
			--query-iters $QUERY_ITERS \
			--log-freq 10 \
			--words $WORDS_FILE" | qsub -N "Job-$DATASET-$ALGOR-$TOPIC_COUNT" -l h_rt=$HOURS:0:0 -l mem_free=$MEM,h_vmem=$MEM,tmem=$MEM -S /bin/bash
done

TRAIN_ITERS=1000
QUERY_ITERS=100
HOURS=20
MEM=6G

GIBBS_ALGORS="lda_gibbs mom_gibbs"

for TOPIC_COUNT in $TOPIC_COUNTS
do
        ALGOR="lda_gibbs"
        for DATASET in $DATASETS
		do
			WORDS_FILE="$SRC_DIR/$DATASET.pkl"
	
			echo "$STM_EXEC \
						--model $ALGOR \
						--dtype i4:f8 \
						--num-topics $TOPIC_COUNT  \
						--folds $NUM_FOLDS \
						--eval $EVAL \
						--iters $TRAIN_ITERS \
						--query-iters $QUERY_ITERS \
						--log-freq 10 \
						--words $WORDS_FILE" | qsub -N "Job-$DATASET-$ALGOR-$TOPIC_COUNT" -l h_rt=$HOURS:0:0  -l mem_free=$MEM,h_vmem=$MEM,tmem=$MEM -S /bin/bash
		done
		
        ALGOR="mom_gibbs"
        for DATASET in $DATASETS
		do
			WORDS_FILE="$SRC_DIR/$DATASET.pkl"
	
			echo "$STM_EXEC \
						--model $ALGOR \
						--dtype f8 \
						--num-topics $TOPIC_COUNT  \
						--folds $NUM_FOLDS \
						--eval $EVAL \
						--iters $TRAIN_ITERS \
						--query-iters $QUERY_ITERS \
						--log-freq 10 \
						--words $WORDS_FILE" | qsub -N "Job-$DATASET-$ALGOR-$TOPIC_COUNT" -l h_rt=$HOURS:0:0  -l mem_free=$MEM,h_vmem=$MEM,tmem=$MEM -S /bin/bash
		done
done

