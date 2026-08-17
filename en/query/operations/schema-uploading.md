---
title: Uploading a data schema to {{ yq-full-name }}
description: In this tutorial, you will learn how to upload a data schema.
---

# Uploading a data schema

To streamline the repetitive steps when configuring schemas for [data bindings](../concepts/glossary.md#binding), you can prepare a file with schemas and then upload it. To do this, follow these steps:

1. In the [management console]({{ link-console-main }}), select the folder containing the data binding you want to update.
1. [Navigate]({{ link-console-yq }}) to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
1. Locate the binding you need in the list, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) in its row, and select **{{ ui-key.yql.yq-binding-actions.edit-binding.menu-item-text }}**.
1. Click **{{ ui-key.yql.yq-binding-form.action_upload-schema-file }}** and select your [schema](#schema) file.
1. Click **{{ ui-key.yql.yq-binding-form.binding-modify.button-text }}**.

## Data schemas {#schema}

We support multiple schema formats:
1. [Plain text](#txt_schema).
1. [JSON](#json_schema).
1. [JSON](#json_schema_data_transfer) compatible with [{{ data-transfer-name }}](../../data-transfer/operations/endpoint/source/data-streams.md#additional-settings).

### Plain text {#txt_schema}

The plain-text schema format is very similar to the SQL DDL syntax: it includes the `SCHEMA` keyword, a list of fields, and their corresponding data types. This is the only export format for data schemas in {{ yq-full-name }}.

Here is an example of a schema in plain-text format:

```
SCHEMA=(
    billing_account_id String NOT NULL,
    billing_account_name String
    )
```

Where:
* `billing_account_id`: Field name.
* `String`: Field type.
* `NOT NULL`: Required field.

### JSON {#json_schema}

JSON format is used for importing schemas from external systems. A schema in JSON format is a set of properties defining field names, data types, and required flags.


Here is an example of a schema in JSON format:

```
[
    {
        "name": "billing_account_id",
        "type": "String",
        "required": true
    },
    {
        "name": "billing_account_name",
        "type": "String",
        "required": false
    }
]
```

Where:
* `billing_account_id`: Field name.
* `String`: Field type.
* `required: true`: Required field.

### {{ data-transfer-name }}-compatible JSON format {#json_schema_data_transfer}

This format allows you to describe schemas in a way that ensures compatibility across different systems. A schema in this format is a set of properties defining field names and data types. All fields are considered optional.

Schema example:

```
[
    {
        "name": "billing_account_id",
        "typeName": "String"
    },
    {
        "name": "billing_account_name",
        "typeName": "String"
    }
]
```

Where:
* `billing_account_id`: Field name.
* `String`: Field type.

To ensure compatibility between {{ yq-full-name }} and {{ data-transfer-name }}, we recommend using the following data types:
* INT64
* INT32
* INT16
* UINT64
* UINT32
* UINT16
* DOUBLE
* STRING
* UTF8
