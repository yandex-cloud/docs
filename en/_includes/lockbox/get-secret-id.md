Get the secret ID (the `ID` column in the command output):

```bash
yc lockbox secret list
```

Result:

```bash
+----------------------+-------------+------------+---------------------+----------------------+--------+
|          ID          |    NAME     | KMS KEY ID |     CREATED AT      |  CURRENT VERSION ID  | STATUS |
+----------------------+-------------+------------+---------------------+----------------------+--------+
| e6qetpqfe8vvag9h7jkr | test-secret |            | 2023-12-06 15:12:13 | e6qdnt9t2qsdggusve4g | ACTIVE |
+----------------------+-------------+------------+---------------------+----------------------+--------+
```
