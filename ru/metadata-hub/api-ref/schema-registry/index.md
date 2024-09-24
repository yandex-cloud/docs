---
title: "Справочник API {{ schema-registry-name }}"
description: "Сервис {{ schema-registry-name }} реализует API Confluent Schema Registry"
---

# API {{ schema-registry-name }}

После [авторизации с помощью IAM-токена](../authentication.md) вы можете использовать следующие HTTP-запросы:

## NamespaceService {#namespace-service}

| Параметр               | Команда                                                                                                                                                           | Описание                           |
|------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------|
| `/compatibility/rules` | GET    | Get default compatibility rules    |
| `/compatibility/rules` | PUT | Update default compatibility rules |
| `/config`              | GET                | Get default compatibility level    |
| `/config`              | PUT             | Update default compatibility level |
| `/v1/namespace`        | GET                     | Get the list of namespaces         |
| `/v1/namespace`        | POST                 | Register a namespace               |
| `/v1/namespace/{id}`   | GET                      | Get the namespace by its ID        |
| `/v1/namespace/{id}`   | DELETE             | Delete the specified namespace     |
| `/v1/namespace/{id}`   | PATCH               | Delete the specified namespace     |

## SubjectService {#subject-service}

| Параметр                                               | Команда                                                                                                                                                        | Описание                                                              |
|--------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------|
| `/compatibility/subjects/{subject}/versions`           | POST      | Test schema compatibility                                             |
| `/compatibility/subjects/{subject}/versions/{version}` | POST       | Test schema compatibility                                             |
| `/config/{subject}`                                    | GET                 | Get compatibility level for the subject                               |
| `/config/{subject}`                                    | PUT              | Update subject compatibility level                                    |
| `/config/{subject}`                                    | DELETE        | Delete subject compatibility level                                    |
| `/subjects`                                            | GET                      | Retrieves a list of registered subjects matching specified parameters |
| `subjects/{subject}`                                   | POST            | Lookup schema under subject                                           |
| `subjects/{subject}`                                   | DELETE              | Delete the specified subject                                          |
| `/subjects/{subject}/versions`                         | GET        | List versions under subject                                           |
| `/subjects/{subject}/versions`                         | POST  | Register schema under a subject                                       |
| `/subjects/{subject}/versions/{version}`               | GET        | Get schema by version                                                 |
| `/subjects/{subject}/versions/{version}`               | DELETE | Delete schema version.                                                |
| `/subjects/{subject}/versions/{version}/referencedby`  | GET           | List schemas referencing a schema                                     |
| `/subjects/{subject}/versions/{version}/schema`        | GET       | Get schema by version                                                 | 

## SchemaService {#schema-service}

| Параметр                     | Команда                                                                                                                                        | Описание                                      |
|------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|
| `/schemas`                   | GET        | List schemas                                  |
| `/schemas/ids/{id}`          | GET         | Get schema string by ID                       |
| `/schemas/ids/{id}/schema`   | GET        | Get schema string by ID                       |
| `/schemas/ids/{id}/subjects` | GET | List subjects associated to schema ID         |
| `/schemas/ids/{id}/versions` | GET | List subject-versions associated to schema ID |
| `/schemas/types`             | GET    | List supported schema types                   |


См. следующие документы для подробной информации о работе с Confluent-совместимом API:

* [Справочник API Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/develop/api.html#schemaregistry-api)
* [Примеры использования API Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/develop/using.html#schemaregistry-using)
* [Пpактическое руководство по использованию curl для взаимодействия с Schema Registry](https://docs.confluent.io/platform/current/schema-registry/schema_registry_onprem_tutorial.html#tutorial-use-curl-with-schema-registry)