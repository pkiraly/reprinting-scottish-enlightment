# Reprinting Scottish enlightment

This repository contains supporting code for a paper which aims to shed light to the 19th century reprinting/republishing patterns of the Scottish enlightment works. The analysis is conducted in cooperation with the [Helsinki Computational History Group](https://www.helsinki.fi/en/researchgroups/computational-history)

Data sources
- [The National Bibliography of Scottland](https://data.nls.uk/data/metadata-collections/national-bibliography-of-scotland/) (NBS)
- [English Short Title Catalogue](http://estc.bl.uk/F/?func=file&file_name=login-bl-estc)


1. Download and extract NBS data into `./raw_data`.


2. Extract important data from NBS with QA catalogue:

```
# download QA catalogue library
wget https://repo1.maven.org/maven2/de/gwdg/metadataqa/metadata-qa-marc/0.6.0/metadata-qa-marc-0.6.0-jar-with-dependencies.jar .

JAR=metadata-qa-marc-0.6.0-jar-with-dependencies.jar
java -cp $JAR de.gwdg.metadataqa.marc.cli.Formatter
./formatter --selector "008~7-10;260c;264c;260a;264a;245c;100a;700a" \
            --defaultRecordType BOOKS \
            --separator " ### " \
            --outputDir data-raw \
            --fileName marc-history.csv \
             raw_data/*.mrc
```