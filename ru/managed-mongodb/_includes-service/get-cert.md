```bash
$ mkdir ~/.postgresql
$ wget "https://[!KEYREF s3-storage-host][!KEYREF pem-path]" -O ~/.postgresql/root.crt
$ chmod 0600 ~/.postgresql/root.crt
```