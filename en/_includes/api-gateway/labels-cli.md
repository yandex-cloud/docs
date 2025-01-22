```bash
yc serverless api-gateway update <API_gateway_name> \
  --labels <key>=<value>[,<key>=<value>]
```

Result:

```text
id: d5de8465hjvo********
folder_id: b1g681qpemb4********
created_at: "2024-11-26T20:16:50.785Z"
name: my-gateway
labels:
  test: test
  version: beta
status: ACTIVE
domain: {{ api-host-apigw }}
connectivity: {}
log_options:
  folder_id: b1g681qpemb4********
execution_timeout: 300s
```