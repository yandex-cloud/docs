```bash
sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
    --connect "jdbc:postgresql://c-c9qgcd6lplrsjt9jhtuu.rw.{{ dns-zone }}:{{ port-mpg }}/db1" \
    --username "user1" \
    --P \
    --table "persons" \
    --target-dir "s3a://my-bucket/import-directory" \
    --split-by "age"
```
