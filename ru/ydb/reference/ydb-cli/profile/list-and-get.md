---
sourcePath: overlay/reference/ydb-cli/profile/list-and-get.md
---
# Получение информации о профиле

Чтобы указать профиль, используйте его имя. Узнать имя профиля можно, получив список профилей.

## Получение списка профилей {#profile-list}

Получите список профилей:

```bash
ydb config profile list
```

Результат:

```text
example (active)
```

## Получение подробной информации о профиле {#profile-get}

Получите подробную информацию о профиле с именем `example`:

```bash
ydb config profile get example
```

Результат:

```text
  endpoint: ydb.serverless.yandexcloud.net:2135
  database: /ru-central1/b1gia87mbaomkfvscrus/etn02j1mlm4vgjhij03e
  use-metadata-credentials
```
