# oneliners
oneliners and random notes

```
#count words on gzipped files
ls *gz | while read i; do zcat $i | wc -l & done

#bgzip vcf files in a dir
ls *vcf | while read i; do bgzip $i & done

#tabix gzvcf files in a dir
ls *vcf.gz | while read i; do tabix -p vcf $i & done

#simple change of file names
ls *bam  | sed 's/-//g' | paste tmp - | awk '{print "mv "$1" "$2}' | while read i; do $i; done
```
