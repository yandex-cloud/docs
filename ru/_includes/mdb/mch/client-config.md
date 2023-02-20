```bash
mkdir --parents ~/.clickhouse-client && \
wget "https://{{ s3-storage-host }}/doc-files/clickhouse-client.conf.example" \
  --output-document ~/.clickhouse-client/config.xml
```
