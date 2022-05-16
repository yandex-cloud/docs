---
sourcePath: en/ydb/ydb-docs-core/en/core/getting_started/_includes/cli/ls_example_local.md
---
### Connecting to a local database

If you deployed a local YDB using a scenario for self-deployment [in Docker](../../self_hosted/ydb_docker.md) with the suggested configuration, you can check a YDB connection using the command:

```bash
{{ ydb-cli }} -e grpc://localhost:2136 -d /local scheme ls
```

