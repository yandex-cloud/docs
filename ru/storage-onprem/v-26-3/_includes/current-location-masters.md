Определите текущее расположение мастеров всех баз `s3-db0x`:

```bash
for i in {1..4} ; do kubectl cnpg -n cnpg-system status s3-db0$i | grep '^s3.*Primary' ; done
```

Результат:

```text
s3-db01-1  22/591A2F50  Primary  OK  Burstable  1.24.1  s3-0-1
s3-db02-4  22/8A009D00  Primary  OK  Burstable  1.24.1  s3-0-4
s3-db03-2  22/43003580  Primary  OK  Burstable  1.24.1  s3-0-1
s3-db04-2  22/65088C8C  Primary  OK  Burstable  1.24.1  s3-0-2
```