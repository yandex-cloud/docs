---
title: '{{ metadata-hub-full-name }}. Ответы на вопросы'
description: Как исправить ошибку при создании БД в {{ metastore-name }}? Ответы на этот и другие вопросы в данной статье.
---

# Общие вопросы про {{ metadata-hub-name }}

#### Как исправить ошибку при создании базы данных в {{ metastore-full-name }}? {#create-db-in-hive}

Ошибка возникает, если создавать БД с помощью следующего запроса:

```sql
CREATE DATABASE IF NOT EXISTS <имя_БД>;
```

{{ metastore-name }} не позволяет создать базу данных или таблицу в Hive — они хранятся в [бакете {{ objstorage-full-name }}](../../storage/concepts/bucket.md), который привязан к кластеру {{ dataproc-name }}. Чтобы создать БД, выполните запрос:

```sql
CREATE DATABASE IF NOT EXISTS <имя_БД> LOCATION <местоположение_БД>;
```

В параметре `LOCATION` укажите путь до бакета и базы данных в нем в формате: `s3a://<имя_бакета>/<имя_папки>/<имя_БД>`. Указывать папку необязательно, но в нее объекты загружаются быстрее, чем в корень бакета.

#### Как исправить ошибку отсутствия прав при подключении сервисного аккаунта к кластеру? {#attach-service-account}

{% include notitle [attach-sa-create-update](../../_qa/attach-sa-create-update.md) %}
