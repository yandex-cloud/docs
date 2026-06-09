# Решение проблем в {{ metadata-hub-name }} 

В этом разделе описаны проблемы, возникающие в сервисе, а также способы их устранения.

* [{{ metastore-full-name }}](#metastore)
* [{{ schema-registry-full-name }}](#schema-registry-full-name)

## Решение проблем в {{ metastore-full-name }} {#metastore}

### Ошибка при создании базы данных в {{ metastore-full-name }} {#create-db-in-hive}

Ошибка возникает, если создавать БД с помощью следующего запроса:

```sql
CREATE DATABASE IF NOT EXISTS <имя_БД>;
```

**Решение**
{{ metastore-name }} не позволяет создать базу данных или таблицу в Hive — они хранятся в [бакете {{ objstorage-full-name }}](../../storage/concepts/bucket.md), который привязан к кластеру {{ dataproc-name }}. Чтобы создать БД, выполните запрос:

```sql
CREATE DATABASE IF NOT EXISTS <имя_БД> LOCATION <местоположение_БД>;
```

В параметре `LOCATION` укажите путь до бакета и базы данных в нем в формате: `s3a://<имя_бакета>/<имя_папки>/<имя_БД>`. Указывать папку необязательно, но в нее объекты загружаются быстрее, чем в корень бакета.

### Отсутствие прав при подключении сервисного аккаунта к кластеру {#attach-service-account}

#### Как исправить ошибку отсутствия прав при подключении сервисного аккаунта к кластеру? {#attach-service-account}

Текст ошибки:

```text
ERROR: rpc error: code = PermissionDenied desc = you do not have permission to access the requested service account or service account does not exist
```

Ошибка возникает, если вы создаете или изменяете кластер и привязываете к нему сервисный аккаунт.

**Решение**
[Назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.

## Решение проблем в {{ schema-registry-full-name }} {#schema-registry-full-name}

### Ошибка при добавлении и удалении опциональных параметров {#avoid-errors-while-evolving-schema}

Если на уровне пространства имен настроена [политика проверки совместимости](../concepts/compatibility-check-policy.md) `Confluent`, при добавлении или удалении в схеме опциональных параметров возможны следующие ошибки:

* `PROPERTY_ADDED_TO_OPEN_CONTENT_MODEL`,
* `PROPERTY_REMOVED_FROM_CLOSED_CONTENT_MODEL`.

**Решение**
Политика проверки совместимости `Confluent` основывается на стандартах Confluent Schema Registry и реализует математически точную проверку совместимости. Такая политика не позволяет добавлять и удалять опциональные параметры в полях типа `object`, что приводит к указанным выше ошибкам.

Чтобы добавлять или удалять опциональные параметры, [выберите в пространстве имен](../operations/update-name-space.md) политику проверки совместимости для JSON `optional-friendly`. Она основывается на [использовании разных контентных моделей](../concepts/schema-registry-content-model.md#optional-parameters-compatibility-solution) для производителя и потребителя, причем регистрируется только схема для производителя. Для проверки совместимости схема потребителя конвертируется из открытой контентной модели в закрытую и сравнивается с зарегистрированными схемами производителя. Это позволяет поддерживать добавление и удаление опциональных параметров, сохраняя полную транзитивную совместимость.

_Apache® и [Apache Hive™](https://hive.apache.org/) являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._