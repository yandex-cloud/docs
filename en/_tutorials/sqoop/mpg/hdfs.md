```bash
sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
    --connect "jdbc:postgresql://c-c9qgcd6lplrsjt9jhtuu.rw.{{ dns-zone }}:{{ port-mpg }}/db1" \
    --username "user1" \
    --table "persons" \
    --target-dir "import-directory" \
    --P \
    --split-by "age"
```
