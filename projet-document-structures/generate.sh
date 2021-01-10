#Bouzard Arthur M2TAL
#!/bin/bash

##############################################
#Part 1 : ( /10pts + Bonus)
##############################################
#1 : UNZIP.

path=./transformation/input;
mkdir $path/unziped 2> generate.log.txt;
for file in $(ls $path)
do	
	if [[ $(echo "$file" | cut -d "." -f2) == "odt" ]]
	then
		unzip -qq $path/$file -d $path/unziped/$(echo "$file" | cut -d "." -f1) 2>> generate.log.txt;
	fi
done;
echo "Unzip Done.";

##############################################
# 2 : Convert extracted content to xml with xslt stylesheet using saxon.
##############################################
xslcontent=APRICOT

for document in $(ls $path/unziped)
do
	sed -i "s/$xslcontent/$document/" ./transformation/xslt/odt-to-tei.xsl;
	java -jar saxon/saxon-he-10.3.jar $path/unziped/$document/meta.xml ./transformation/xslt/odt-to-tei.xsl > ./transformation/output/$document.xml;
	xslcontent=$document;
done;

sed -i "s/$xslcontent/APRICOT/" ./transformation/xslt/odt-to-tei.xsl;
echo "XML files have been generated using '$(ls ./transformation/xslt)'."
#Deleting unziped odt content now useless.
rm -r $path/unziped 2>> generate.log.txt

##############################################
# 3 : Validate XML with TEI rng schema using xmllint.

for file in $(ls ./transformation/output)
do
	xmllint --noout -relaxng ./transformation/schema/tei_minimal.rng ./transformation/output/$file;
done;

echo "If a document does not validate, you have to check if your odt file is well formated.";
##############################################
#End

if [[ $(cat generate.log.txt) == "" ]]
then
	rm generate.log.txt;
fi

exit;