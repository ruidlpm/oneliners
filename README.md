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

#fix chunkcounts out file if IID starts with a number
head -n2  chunkcounts.out |tail -n1 | tr ' ' '\n' | awk '$1~/^[0-9]/' - |  awk '{print sed "/"$1"/X"$1"/"}' | while read i; do echo "sed 's"$i"g'"; done | tr '\n' '|' | sed 's/|$//g'  > replace_ids.sh
```
