```sql
CREATE TABLE sample_table (a int)
    DISTRIBUTED BY (a);

INSERT INTO sample_table
    SELECT * FROM GENERATE_SERIES(1, 10000);
```
