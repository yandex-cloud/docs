---
title: '{{ metadata-hub-full-name }}. Решение проблем'
description: Как исправить ошибку при создании БД в {{ metastore-name }}? Ответы на этот и другие вопросы в данной статье.
---

# Решение проблем в {{ metadata-hub-name }} 

В этом разделе описаны проблемы, возникающие в сервисе, а также способы их устранения.

* [{{ metastore-full-name }}](#metastore)
* [{{ schema-registry-full-name }}](#schema-registry-full-name)

## Решение проблем в {{ metastore-full-name }} {#metastore}

### Ошибка при создании базы данных в {{ metastore-full-name }} {#create-db-in-hive}

{% include notitle [create-db-in-hive](../../_qa/metadata-hub/create-db-in-hive.md) %}

### Отсутствие прав при подключении сервисного аккаунта к кластеру {#attach-service-account}

{% include notitle [attach-sa-create-update](../../_qa/attach-sa-create-update.md) %}

## Решение проблем в {{ schema-registry-full-name }} {#schema-registry-full-name}

### Ошибка при добавлении и удалении опциональных параметров {#avoid-errors-while-evolving-schema}

{% include notitle [optional-parameter-error](../../_qa/metadata-hub/optional-parameter-error.md) %}
