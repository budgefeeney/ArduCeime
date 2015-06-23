#!/bin/bash

read -d '' chap1Files <<EOF
Chap1/BayesianInference.tex	
Chap1/NonConjVariational.tex
EOF

read -d '' chap2Files <<EOF
Chap2/LangModels.tex
Chap2/Admix-Intro.tex
Chap2/Admix-DPs.tex
Chap2/Admix-OtherLangModels.tex
Chap2/Admix-Eval.tex
Chap2/Admix-Inference.tex
EOF

read -d '' chap3Files <<EOF
Chap3/Admix-Covariates.tex
Chap3/MTL-Intro.tex
Chap3/main.tex
Chap3/MTL-GaussScale.tex
Chap3/FutureJointDecomp.tex
EOF



outfile="upgrade-auto.tex"
rm -f $outfile

echo "\\input{header.tex}" >> $outfile

echo "\\title{Upgrade Report}" >> $outfile
echo "\author{Bryan Feeney}" >> $outfile

echo "\\maketitle" >> $outfile
echo "\\tableofcontents" >> $outfile
echo "\\clearpage" >> $outfile

#echo "\\section{Literature Review}" >> $outfile

for chap1File in $chap1Files;
do
	echo $chap1File
	tail -n +2 $chap1File | sed -e "s/\\input{..\/footer.tex}//g" | sed -e "s/plots\//Chap1\/plots\//g" >> $outfile
done
for chap2File in $chap2Files;
do
	echo $chap2File
	tail -n +2 $chap2File | sed -e "s/\\input{..\/footer.tex}//g" | sed -e "s/plots\//Chap2\/plots\//g" >> $outfile
done
for chap3File in $chap3Files;
do
	echo $chap3File
	tail -n +2 $chap3File | sed -e "s/\\input{..\/footer.tex}//g" | sed -e "s/plots\//Chap3\/plots\//g" >> $outfile
done

echo "\input{footer.tex}" >> $outfile
echo >> $outfile