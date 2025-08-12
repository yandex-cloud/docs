---
title: '{{ metadata-hub-full-name }}. Troubleshooting'
description: How do I fix the error I get when creating a DB in {{ metastore-name }}? Find the answer to this and other common questions below.
---

# Troubleshooting in {{ metadata-hub-name }}

This section describes issues you may encounter in the service and how to troubleshoot them.

* [{{ metastore-full-name }}](#metastore)
* [{{ schema-registry-full-name }}](#schema-registry-full-name)

## Troubleshooting in {{ metastore-full-name }} {#metastore}

### Error when creating a database in {{ metastore-full-name }} {#create-db-in-hive}

{% include notitle [create-db-in-hive](../../_qa/metadata-hub/create-db-in-hive.md) %}

### No permission error when connecting a service account to the cluster {#attach-service-account}

{% include notitle [attach-sa-create-update](../../_qa/attach-sa-create-update.md) %}

## Troubleshooting in {{ schema-registry-full-name }} {#schema-registry-full-name}

### Error when adding or deleting optional parameters {#avoid-errors-while-evolving-schema}

{% include notitle [optional-parameter-error](../../_qa/metadata-hub/optional-parameter-error.md) %}
