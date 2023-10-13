Get the ID of the required digital signature key pair by specifying the folder ID:

```bash
yc kms asymmetric-signature-key list \
  --folder-id <folder_ID>
```

Result:

```bash
+----------------------+----------------------+---------------------------+---------------------+--------+
|          ID          |         NAME         |    SIGNATURE ALGORITHM    |     CREATED AT      | STATUS |
+----------------------+----------------------+---------------------------+---------------------+--------+
| abj9g2dil5sj******** | sample-signature-key | RSA_2048_SIGN_PSS_SHA_512 | 2023-08-16 09:06:57 | ACTIVE |
+----------------------+----------------------+---------------------------+---------------------+--------+
```
