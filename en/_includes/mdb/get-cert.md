```bash
mkdir ~/.postgresql
wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.postgresql/root.crt
chmod 0600 ~/.postgresql/root.crt
```