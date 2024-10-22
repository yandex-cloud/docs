---
title: '{{ schema-registry-name }} API reference'
description: '{{ schema-registry-name }} implements the Confluent Schema Registry API.'
---

# {{ schema-registry-name }} API

After you [authenticate with an IAM token](../authentication.md), you can use the following HTTP requests:

## NamespaceService {#namespace-service}

| Parameter               | Command                                                                                                                                                           | Description                           |
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

| Parameter                                               | Command                                                                                                                                                        | Description                                                              |
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

| Parameter                     | Command                                                                                                                                        | Description                                      |
|------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|
| `/schemas`                   | GET        | List schemas                                  |
| `/schemas/ids/{id}`          | GET         | Get schema string by ID                       |
| `/schemas/ids/{id}/schema`   | GET        | Get schema string by ID                       |
| `/schemas/ids/{id}/subjects` | GET | List subjects associated to schema ID         |
| `/schemas/ids/{id}/versions` | GET | List subject-versions associated to schema ID |
| `/schemas/types`             | GET    | List supported schema types                   |


See the following documents for detailed information about working with a Confluent-compatible API:

* [Confluent Schema Registry API reference](https://docs.confluent.io/platform/current/schema-registry/develop/api.html#schemaregistry-api)
* [Examples of using the Confluent Schema Registry API](https://docs.confluent.io/platform/current/schema-registry/develop/using.html#schemaregistry-using)
* [Tutorial on using curl to communicate with Schema Registry](https://docs.confluent.io/platform/current/schema-registry/schema_registry_onprem_tutorial.html#tutorial-use-curl-with-schema-registry)