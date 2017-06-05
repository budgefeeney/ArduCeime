#!/bin/bash


if [ -z $1 ]
then
	PREFIX=""
else
	PREFIX="$1-"
fi

HOURS=20
MEM=6G

SRC_HOME=`dirname $0`
WHERE_I_WAS=$PWD
cd $SRC_HOME
SRC_HOME=$PWD
cd $WHERE_I_WAS

WORDS_FILE="$SRC_HOME/W.pkl"
OUT_PATH="$SRC_HOME/out"
STM_EXEC="$SRC_HOME/stm.sh"

NUM_FOLDS=5
NUM_FOLDS_TO_RUN=3
EVAL="perplexity"

BATCH_SIZES="10 100 500 2000"
R_RATES="1 10 100"
F_RATES="0.55 0.75 0.95"

TOPIC_COUNT=10

TRAIN_ITERS=500
QUERY_ITERS=100

ALGOR="lda_svb"

for BATCH_SIZE in $BATCH_SIZES
do
	for R_RATE in $R_RATES
	do
		for F_RATE in $F_RATES
		do

			echo "$STM_EXEC \
			--model $ALGOR \
			--dtype f8 \
			--num-topics $TOPIC_COUNT  \
			--folds $NUM_FOLDS \
			--truncate-folds $NUM_FOLDS_TO_RUN
			--eval $EVAL \
			--iters $TRAIN_ITERS \
			--query-iters $QUERY_ITERS \
            --gradient-batch-size $BATCH_SIZE \
            --gradient-rate-retardation $R_RATE \
            --gradient-forgetting-rate $F_RATE \
			--log-freq 1 \
			--debug True \
            --words $WORDS_FILE" | qsub -N "Job-REUT_4-SVB-K-$TOPIC_COUNT-B-$BATCH_SIZE-R-$R_RATE-F-$F_RATE" -l h_rt=$HOURS:0:0 -l mem_free=$MEM,h_vmem=$MEM,tmem=$MEM -S /bin/bash
		done
	done
done

#echo "$STM_EXEC \
#--model $ALGOR \
#--dtype f8 \
#--num-topics $TOPIC_COUNT  \
#--folds $FOLDS \
#--eval $EVAL \
#--iters $TRAIN_ITERS \
#--query-iters $QUERY_ITERS \
#--log-freq 10 \
#--words $WORDS_FILE" | qsub -N "Job-REUT_2-LDA-K-$TOPIC_COUNT" -l h_rt=$HOURS:0:0 -l mem_free=$MEM,h_vmem=$MEM,tmem=$MEM -S /bin/bash





