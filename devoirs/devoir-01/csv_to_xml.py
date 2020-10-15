#BOUZARD Arthur M2TAL
import csv
import re
import lxml
from lxml import etree

outfile = "toilettes-paris.xml"
infile = "sanisettesparis.csv"
dtd = "wc.dtd"


if __name__ == '__main__' :
	with open(infile, 'r', newline="", errors="ignore") as file :
		reader = csv.DictReader(file, delimiter=";", quotechar='"')
		root = etree.Element("toilettes")
		for row in reader :
			if row['ADRESSE'] == "" :
				continue
			toilette = etree.SubElement(root, "toilette", statut=row['STATUT'], type=row['TYPE'])
			second_child1 = etree.SubElement(toilette, "adresse")
			second_child2 = etree.SubElement(toilette, "horaire")
			second_child2.text = row['HORAIRE']
			second_child3 = etree.SubElement(toilette, "services")
			second_child4 = etree.SubElement(toilette, "equipement")
			second_child4.text = row['URL_FICHE_EQUIPEMENT']
			third_child1 = etree.SubElement(second_child1, "libelle")
			third_child1.text = row['ADRESSE']
			third_child2 = etree.SubElement(second_child1, "arrondissement")
			third_child2.text = row['ARRONDISSEMENT']
			third_child_fs1 = etree.SubElement(second_child3, "acces-pmr")
			third_child_fs1.text = row['ACCES_PMR']
			third_child_fs2 = etree.SubElement(second_child3, "relais-bebe")
			third_child_fs2.text = row['RELAIS_BEBE']
			
	XML = etree.tostring(root, xml_declaration=True, encoding="utf-8", pretty_print=True, method="xml",  standalone=False, doctype=f"""<!DOCTYPE toilettes SYSTEM "{dtd}">""")
	with open(outfile, 'wb') as out :
		out.write(XML)
