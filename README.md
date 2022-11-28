# Reprinting Scottish enlightment

This repository contains supporting code for a paper which aims to shed light to the 19th century reprinting/republishing patterns of the Scottish enlightment works. The analysis is conducted in cooperation with the [Helsinki Computational History Group](https://www.helsinki.fi/en/researchgroups/computational-history)

Data sources
- [The National Bibliography of Scottland](https://data.nls.uk/data/metadata-collections/national-bibliography-of-scotland/) (NBS)
- [English Short Title Catalogue](http://estc.bl.uk/F/?func=file&file_name=login-bl-estc)


## Get data

1. Download and extract NBS data into `./raw_data`.


2. Extract important data from NBS with QA catalogue:

```
# download QA catalogue library
wget https://repo1.maven.org/maven2/de/gwdg/metadataqa/metadata-qa-marc/0.6.0/metadata-qa-marc-0.6.0-jar-with-dependencies.jar .
JAR=metadata-qa-marc-0.6.0-jar-with-dependencies.jar

# extract the following fields: 
# 008/7-10: normalized publication date
# 260c: Date of publication, distribution, etc.
# 264c: Date of production, publication, distribution, manufacture, or copyright notice
# 260a: Place of publication, distribution, etc.
# 264a: Place of production, publication, distribution, manufacture
# 245c: Statement of responsibility, etc.
# 100a: Personal name (Main Entry)
# 700a: Personal name (Added Entry)
java -cp $JAR de.gwdg.metadataqa.marc.cli.Formatter \
     --selector "008~7-10;260c;264c;260a;264a;245c;100a;700a" \
     --defaultRecordType BOOKS \
     --separator " ### " \
     --outputDir raw_data \
     --fileName nbs-data.csv \
     --marcxml \
     raw_data/NBS_v2_validated_marcxml.xml
```

It creates raw_data/nbs-data.csv with ' ### ' as column separator. If a data element is repeated, the individual values as separated by ' # '.

3. Get ESTC data from the COMHIS team.

## Run

```
Rscript scripts/comhis.R
```

It generates a number of images in the `img` directory and `dated_authors.csv` file in `data` directory.
