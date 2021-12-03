```bash
sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
    --connect "jdbc:postgresql://c-c9qgcd6lplrsjt9jhtuu.rw.{{ dns-zone }}:{{ port-mpg }}/db1" \
    --username "user1" \
    --P \
    --table "persons" \
    --hbase-create-table \
    --column-family "family1" \
    --hbase-table "import-table" \
    --split-by "age"
```
