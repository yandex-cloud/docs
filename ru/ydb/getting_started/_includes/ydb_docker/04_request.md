---
sourcePath: core/getting_started/_includes/ydb_docker/04_request.md
---
## Выполните запрос к базе данных {#request}

Выполните запрос к базе данных YDB в Docker-контейнере:

```bash
ydb \
  -e grpcs://localhost:2135 \
  --ca-file $(pwd)/ydb_certs/ca.pem \
  -d /local table query execute -q 'select 1;'
```

Где:

* `-e` — эндпоинт базы данных.
* `--ca-file` — путь к TLS-сертификату.
* `-d` — имя базы данных и параметры запроса.

Результат выполнения:

```text
┌─────────┐
| column0 |
├─────────┤
| 1       |
└─────────┘
```

Предсобранная версия [YDB CLI](../../../reference/ydb-cli/index.md) также доступа внутри образа:

```bash
sudo docker exec <CONTAINER-ID> /ydb -e localhost:2135 -d /local table query execute -q 'select 1;'
┌─────────┐
| column0 |
├─────────┤
| 1       |
└─────────┘
```