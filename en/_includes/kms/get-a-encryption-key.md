Get the ID of your encryption key pair, specifying the folder ID:

```bash
yc kms asymmetric-encryption-key list \
  --folder-id <folder_ID>
```

Result:

```text
+----------------------+-----------------------+---------------------------+---------------------+--------+
|          ID          |          NAME         |   ENCRYPTION ALGORITHM    |     CREATED AT      | STATUS |
+----------------------+-----------------------+---------------------------+---------------------+--------+
| abjfmo5enqlr******** | sample-encryption-key | RSA_2048_ENC_OAEP_SHA_256 | 2023-08-16 18:10:03 | ACTIVE |
+----------------------+-----------------------+---------------------------+---------------------+--------+
```