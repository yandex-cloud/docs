# Uploading a data schema

To simplify repetitive actions related to data schema setup and [data binding](../concepts/glossary.md#binding), you can prepare a file with data schemas and upload it. For this, follow these steps:

1. In the [management console]({{ link-console-main }}), select the folder where you want to change a data binding.
1. In the list of services, select **{{ yq-full-name }}**.
1. On the left-hand panel, select **Bindings**.
1. Click ![pencil](../../_assets/console-icons/pencil.svg) next to the name of the desired binding.
1. Click the **Upload from file** button and select the [data schema](#schema) file.
1. Click **Edit**.

## Data schemas {#schema}

We support multiple data schema formats:
1. [Text format](#txt_schema)
1. [JSON format](#json_schema)
1. [{{ data-transfer-name }}](../../data-transfer/operations/endpoint/source/data-streams.md#additional-settings) compatible [JSON format](#json_schema_data_transfer)

### Text format {#txt_schema}

The textual data schema format is most close to the SQL data definition syntax and consists of the `SCHEMA` keyword and a list of fields with types. Existing data schemas can only be exported from {{ yq-full-name }} in this format.

Here is an example of a data schema in text format:

```
SCHEMA=(
    billing_account_id String NOT NULL,
    billing_account_name String
    )
```

Where:
* `billing_account_id`: Field name.
* `String`: Field type.
* `NOT NULL`: Flag indicating that the field is required in the source data.

### JSON format {#json_schema}

JSON schema format is designed for importing data schemas from external systems. The JSON format consists of records defining fields, their types, and flags showing whether fields are required.


Here is an example of a data schema in JSON format:

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
* `required: true`: Flag indicating that the field is required in the source data.

### {{ data-transfer-name }} compatible JSON format {#json_schema_data_transfer}

This format is intended for compatible description of data schemas across various systems. This JSON format consists of a set of records defining fields and their types, with all fields considered optional in the source data.

Here is an example of a data schema:

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

To ensure compatibility between {{ yq-full-name }} and {{ data-transfer-name }}, we recommend the following data types:
* INT64
* INT32
* INT16
* UINT64
* UINT32
* UINT16
* DOUBLE
* STRING
* UTF8
