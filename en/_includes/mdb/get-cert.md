```bash
mkdir ~/.postgresql
wget "{{ crt-web-path }}" -O ~/.postgresql/root.crt
chmod 0600 ~/.postgresql/root.crt
```