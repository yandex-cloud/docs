---
title: '{{ metadata-hub-full-name }} concepts'
description: In this tutorial, you will learn about connection and schema registry.
---

# About {{ metadata-hub-full-name }}

{% include notitle [preview](../../_includes/note-preview.md) %}

{{ metadata-hub-full-name }} is a service that provides data management capabilities in {{ yandex-cloud }}:

* Automatic creation and management of database connection parameters.
* Storing, getting schemas, and checking the evolution of data exchange schemas.
* Creating and managing {{ metastore-full-name }} clusters.
* Search and visualization of meta information about data storages and links between them.


## Connection management {#connection-manager}

{% include [connection](../../_includes/metadata-hub/connection-definition.md) %}

## Storing table data {#metastore}

{% include [connection](../../_includes/metadata-hub/metastore-definition.md) %}


## Data schema registry {#schema-registry}

{% include [connection](../../_includes/metadata-hub/schema-registry-definition.md) %}

With a schema registry, you can define schemas for your data formats and versions and register them in the registry. After registering a schema, you can use it jointly in various systems and applications. When a supplier sends data to a message recipient, the data schema is included in the message title, and the schema registry ensures that the schema is valid and compatible with the expected one for the subject.



