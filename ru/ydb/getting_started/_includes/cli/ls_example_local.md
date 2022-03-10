---
sourcePath: ru/ydb/ydb-docs-core/ru/core/getting_started/_includes/cli/ls_example_local.md
---
### Соединение с локальной БД

Если вы развернули локальную YDB по одному из описанных сценариев [Самостоятельного развертывания](../../create_db.md#self-hosted) с предложенной конфигурацией, то соединение с ней можно проверить командой:

``` bash
$ {{ ydb-cli }} -e grpc://localhost:2136 -d /local scheme ls
.sys
```
