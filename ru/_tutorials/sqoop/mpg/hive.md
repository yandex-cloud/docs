```bash
sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
  --connect "jdbc:postgresql://c-c9qgcd6lplrsjt9jhtuu.rw.{{ dns-zone }}:{{ port-mpg }}/db1" \
  --username "user1" \
  --P \
  --table "persons" \
  --hive-import \
  --create-hive-table \
  --hive-database "db-hive" \
  --hive-table "import-table" \
  --split-by "age"
```
