#!/bin/bash

read -d '' chap1Files <<EOF
Chap1/MTL-Intro.tex	
Chap1/MTL-Kro.tex
Chap1/MTL-GaussScale.tex
Chap1/LangModels.tex
Chap1/Admix-Intro.tex
Chap1/Admix-DPs.tex		
Chap1/Admix-Inference.tex	
Chap1/Admix-Covariates.tex	
Chap1/Admix-Eval.tex		
Chap1/Admix-OtherLangModels.tex	
Chap1/NonConjVariational.tex
EOF



outfile="upgrade-auto.tex"
rm -f $outfile

echo "\\input{header.tex}" >> $outfile

echo "\\title{Upgrade Report}" >> $outfile
echo "\author{Bryan Feeney}" >> $outfile

echo "\\maketitle" >> $outfile
echo "\\tableofcontents" >> $outfile
echo "\\clearpage" >> $outfile

echo "\\section{Literature Review}" >> $outfile

for chap1File in $chap1Files;
do
	echo $chap1File
	tail -n +2 $chap1File | sed -e "s/\\input{..\/footer.tex}//g" | sed -e "s/plots\//Chap1\/plots\//g" >> $outfile
done


echo "\input{footer.tex}" >> $outfile
echo >> $outfile