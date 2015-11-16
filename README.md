# oneliners
oneliners and random notes

```
#count words on gzipped files
ls *gz | while read i; do zcat $i | wc -l & done
```
