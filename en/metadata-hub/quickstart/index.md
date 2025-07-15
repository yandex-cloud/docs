---
title: How do I get started with {{ metadata-hub-full-name }}
description: In this tutorial, you will learn how to create your first connection and how to get started with a data registry.
---

# Getting started with {{ metadata-hub-full-name }} services

{% include notitle [preview](../../_includes/note-preview.md) %}


{{ metadata-hub-full-name }} allows you to manage data in {{ yandex-cloud }}. You can:

* Create database connections and manage their parameters.
* Get and store data exchange schemas and check their evolution.
* Get, categorize, and visualize metadata about data storages and links between them.

Get started with {{ metadata-hub-name }} tools:

* [{{ connection-manager-full-name }}](connection-manager.md). Use it to manage database connection parameters. For more information on {{ connection-manager-name }} features, see [Concepts](../concepts/connection-manager.md).

* [{{ metastore-full-name }}](metastore.md). Use it to manage data in applications supporting integration with {{ metastore-name }}. For more information about {{ metastore-name }} clusters, see [Concepts](../concepts/metastore.md).

* [{{ schema-registry-name }}](schema-registry.md). With its help, you can create subjects and schemas for management purposes, set schema evolution parameters, add references, and compare schema versions. For more information about schema registry, see [Concepts](../concepts/schema-registry.md).


* Data Catalog. You can use it to collect, search, and visualize metadata about {{ yandex-cloud }} objects and links between them. For more information about schema registry, see [Concepts](../concepts/data-catalog.md).

  You can access Data Catalog in any of these roles:

  * [Metadata steward](data-steward-quickstart.md)
  * [Metadata analyst](data-analyst-quickstart.md)

