# oneliners
oneliners and random notes

```
#count words on gzipped files
ls *gz | while read i; do zcat $i | wc -l & done


#bgzip vcf files in a dir
ls *vcf | while read i; do bgzip $i & done

#tabix gzvcf files in a dir
ls *vcf.gz | while read i; do tabix -p vcf $i & done
```
