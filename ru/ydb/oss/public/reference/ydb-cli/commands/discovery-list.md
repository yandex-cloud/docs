# Получение списка эндпоинтов для базы данных

Получите список эндпойнтов для базы данных:

```bash
{{ ydb-cli }} discovery list
```

Результат:

```text
grpcs://vm-etn03umae82ti1blr6in-ru-central1-a-odjg-ozyl.etn03umae82ti1blr6in.ydb.mdb.yandexcloud.net:2135 #table_service #scripting #discovery #rate_limiter #locking #kesus
```

Где `#table_service`, `#scripting`, `#discovery` и другие — это gRPC-сервисы, доступные на данном эндпоинте.
