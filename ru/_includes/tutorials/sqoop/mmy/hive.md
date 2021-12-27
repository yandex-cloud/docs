```bash
sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
    --connect "jdbc:mysql://c-c9qo26aher8lc71ns36p.rw.{{ dns-zone }}:{{ port-mmy }}/db1" \
    --username "user1" \
    --P \
    --table "persons" \
    --hive-import \
    --create-hive-table \
    --hive-database "db-hive" \
    --hive-table "import-table" \
    --split-by "age"
```
