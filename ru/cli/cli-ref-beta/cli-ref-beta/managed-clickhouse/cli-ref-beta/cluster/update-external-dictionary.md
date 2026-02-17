---
editable: false
noIndex: true
---

# yc beta managed-clickhouse cluster update-external-dictionary

Updates an external dictionary for the specified ClickHouse cluster.

#### Command Usage

Syntax:

`yc beta managed-clickhouse cluster update-external-dictionary <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the ClickHouse cluster to update the external dictionary for. To get the cluster ID, use a [List] request. ||
|| `--external-dictionary` | `shorthand/json`

Configuration of the external dictionary.

Shorthand Syntax:

```hcl
{
  layout = {
    access-to-key-from-attributes = bool,
    allow-read-expired-keys = bool,
    initial-array-size = int,
    max-array-size = int,
    max-threads-for-updates = int,
    max-update-queue-size = int,
    query-wait-timeout-milliseconds = int,
    size-in-cells = int,
    type = FLAT|HASHED|COMPLEX_KEY_HASHED|RANGE_HASHED|CACHE|COMPLEX_KEY_CACHE|SPARSE_HASHED|COMPLEX_KEY_SPARSE_HASHED|COMPLEX_KEY_RANGE_HASHED|DIRECT|COMPLEX_KEY_DIRECT|IP_TRIE,
    update-queue-push-timeout-milliseconds = int
  },
  lifetime = fixed-lifetime=int | lifetime-range={
    max = int,
    min = int
  },
  name = str,
  source = clickhouse-source={
    db = str,
    host = str,
    password = str,
    port = int,
    secure = bool,
    table = str,
    user = str,
    where = str
  } | http-source={
    format = str,
    headers = [
      {
        name = str,
        value = str
      }, ...
    ],
    url = str
  } | mongodb-source={
    collection = str,
    db = str,
    host = str,
    options = str,
    password = str,
    port = int,
    user = str
  } | mysql-source={
    close-connection = bool,
    db = str,
    invalidate-query = str,
    password = str,
    port = int,
    replicas = [
      {
        host = str,
        password = str,
        port = int,
        priority = int,
        user = str
      }, ...
    ],
    share-connection = bool,
    table = str,
    user = str,
    where = str
  } | postgresql-source={
    db = str,
    hosts = str,...,
    invalidate-query = str,
    password = str,
    port = int,
    ssl-mode = DISABLE|ALLOW|PREFER|VERIFY_CA|VERIFY_FULL,
    table = str,
    user = str
  },
  structure = {
    attributes = [
      {
        expression = str,
        hierarchical = bool,
        injective = bool,
        name = str,
        null-value = str,
        type = str
      }, ...
    ],
    id = {
      name = str
    },
    key = {
      attributes = [
        {
          expression = str,
          hierarchical = bool,
          injective = bool,
          name = str,
          null-value = str,
          type = str
        }, ...
      ]
    },
    range-max = {
      expression = str,
      hierarchical = bool,
      injective = bool,
      name = str,
      null-value = str,
      type = str
    },
    range-min = {
      expression = str,
      hierarchical = bool,
      injective = bool,
      name = str,
      null-value = str,
      type = str
    }
  }
}
```

JSON Syntax:

```json
{
  "layout": {
    "access-to-key-from-attributes": "bool",
    "allow-read-expired-keys": "bool",
    "initial-array-size": "int",
    "max-array-size": "int",
    "max-threads-for-updates": "int",
    "max-update-queue-size": "int",
    "query-wait-timeout-milliseconds": "int",
    "size-in-cells": "int",
    "type": "FLAT|HASHED|COMPLEX_KEY_HASHED|RANGE_HASHED|CACHE|COMPLEX_KEY_CACHE|SPARSE_HASHED|COMPLEX_KEY_SPARSE_HASHED|COMPLEX_KEY_RANGE_HASHED|DIRECT|COMPLEX_KEY_DIRECT|IP_TRIE",
    "update-queue-push-timeout-milliseconds": "int"
  },
  "lifetime": {
    "fixed-lifetime": "int",
    "lifetime-range": {
      "max": "int",
      "min": "int"
    }
  },
  "name": "str",
  "source": {
    "clickhouse-source": {
      "db": "str",
      "host": "str",
      "password": "str",
      "port": "int",
      "secure": "bool",
      "table": "str",
      "user": "str",
      "where": "str"
    },
    "http-source": {
      "format": "str",
      "headers": [
        {
          "name": "str",
          "value": "str"
        }, ...
      ],
      "url": "str"
    },
    "mongodb-source": {
      "collection": "str",
      "db": "str",
      "host": "str",
      "options": "str",
      "password": "str",
      "port": "int",
      "user": "str"
    },
    "mysql-source": {
      "close-connection": "bool",
      "db": "str",
      "invalidate-query": "str",
      "password": "str",
      "port": "int",
      "replicas": [
        {
          "host": "str",
          "password": "str",
          "port": "int",
          "priority": "int",
          "user": "str"
        }, ...
      ],
      "share-connection": "bool",
      "table": "str",
      "user": "str",
      "where": "str"
    },
    "postgresql-source": {
      "db": "str",
      "hosts": [
        "str", ...
      ],
      "invalidate-query": "str",
      "password": "str",
      "port": "int",
      "ssl-mode": "DISABLE|ALLOW|PREFER|VERIFY_CA|VERIFY_FULL",
      "table": "str",
      "user": "str"
    }
  },
  "structure": {
    "attributes": [
      {
        "expression": "str",
        "hierarchical": "bool",
        "injective": "bool",
        "name": "str",
        "null-value": "str",
        "type": "str"
      }, ...
    ],
    "id": {
      "name": "str"
    },
    "key": {
      "attributes": [
        {
          "expression": "str",
          "hierarchical": "bool",
          "injective": "bool",
          "name": "str",
          "null-value": "str",
          "type": "str"
        }, ...
      ]
    },
    "range-max": {
      "expression": "str",
      "hierarchical": "bool",
      "injective": "bool",
      "name": "str",
      "null-value": "str",
      "type": "str"
    },
    "range-min": {
      "expression": "str",
      "hierarchical": "bool",
      "injective": "bool",
      "name": "str",
      "null-value": "str",
      "type": "str"
    }
  }
}
```

Fields:

```
layout -> (struct)
  Layout determining how to store the dictionary in memory. For details, see https://clickhouse.com/docs/sql-reference/dictionaries#ways-to-store-dictionaries-in-memory.
  access-to-key-from-attributes -> (bool)
    Allows to retrieve key attribute using **dictGetString** function. Enabling this option increases memory usage. Applicable only for **IP_TRIE** layout type. For details, see ClickHouse documentation.
  allow-read-expired-keys -> (bool)
    Allows to read expired keys. Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types. Default value: **false**. For details, see ClickHouse documentation.
  initial-array-size -> (int)
    Initial dictionary key size. Applicable only for **FLAT** layout type. Default value: **1024**. For details, see ClickHouse documentation.
  max-array-size -> (int)
    Maximum dictionary key size. Applicable only for **FLAT** layout type. Default value: **500000**. For details, see ClickHouse documentation.
  max-threads-for-updates -> (int)
    Max threads for cache dictionary update. Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types. Default value: **4**. For details, see ClickHouse documentation.
  max-update-queue-size -> (int)
    Max size of update queue. Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types. Default value: **100000**. For details, see ClickHouse documentation.
  query-wait-timeout-milliseconds -> (int)
    Max wait timeout in milliseconds for update task to complete. Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types. Default value: **60000** (1 minute). For details, see ClickHouse documentation.
  size-in-cells -> (int)
    Number of cells in the cache. Rounded up to a power of two. Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types. Default value: **1000000000**. For details, see ClickHouse documentation.
  type -> (struct)
    Layout type. For details, see ClickHouse documentation.
  update-queue-push-timeout-milliseconds -> (int)
    Max timeout in milliseconds for push update task into queue. Applicable only for **CACHE** and **COMPLEX_KEY_CACHE** layout types. Default value: **10**. For details, see ClickHouse documentation.
name -> (string)
  Name of the external dictionary.
structure -> (struct)
  Structure of the external dictionary.
  attributes -> ([]struct)
    Description of the fields available for database queries. For details, see ClickHouse documentation.
    expression -> (string)
      Expression, describing the attribute, if applicable.
    hierarchical -> (bool)
      Indication of hierarchy support. Default value: **false**.
    injective -> (bool)
      Indication of injective mapping "id -> attribute". Default value: **false**.
    name -> (string)
      Name of the column.
    null-value -> (string)
      Default value for an element without data (for example, an empty string).
    type -> (string)
      Type of the column.
  id -> (struct)
    Single numeric key column for the dictionary.
    name -> (string)
      Name of the numeric key.
  key -> (struct)
    Composite key for the dictionary, containing of one or more key columns. For details, see ClickHouse documentation.
    attributes -> ([]struct)
      Attributes of a complex key.
      expression -> (string)
        Expression, describing the attribute, if applicable.
      hierarchical -> (bool)
        Indication of hierarchy support. Default value: **false**.
      injective -> (bool)
        Indication of injective mapping "id -> attribute". Default value: **false**.
      name -> (string)
        Name of the column.
      null-value -> (string)
        Default value for an element without data (for example, an empty string).
      type -> (string)
        Type of the column.
  range-max -> (struct)
    Field holding the end of the range for dictionaries with **RANGE_HASHED** layout. For details, see ClickHouse documentation.
    expression -> (string)
      Expression, describing the attribute, if applicable.
    hierarchical -> (bool)
      Indication of hierarchy support. Default value: **false**.
    injective -> (bool)
      Indication of injective mapping "id -> attribute". Default value: **false**.
    name -> (string)
      Name of the column.
    null-value -> (string)
      Default value for an element without data (for example, an empty string).
    type -> (string)
      Type of the column.
  range-min -> (struct)
    Field holding the beginning of the range for dictionaries with **RANGE_HASHED** layout. For details, see ClickHouse documentation.
    expression -> (string)
      Expression, describing the attribute, if applicable.
    hierarchical -> (bool)
      Indication of hierarchy support. Default value: **false**.
    injective -> (bool)
      Indication of injective mapping "id -> attribute". Default value: **false**.
    name -> (string)
      Name of the column.
    null-value -> (string)
      Default value for an element without data (for example, an empty string).
    type -> (string)
      Type of the column.
lifetime -> (oneof<fixed-lifetime|lifetime-range>)
  Oneof lifetime field
  fixed-lifetime -> (int)
    Fixed interval between dictionary updates.
  lifetime-range -> (struct)
    Range of intervals between dictionary updates for ClickHouse to choose from.
    max -> (int)
      Maximum dictionary lifetime.
    min -> (int)
      Minimum dictionary lifetime.
source -> (oneof<clickhouse-source|http-source|mongodb-source|mysql-source|postgresql-source>)
  Oneof source field
  http-source -> (struct)
    HTTP source for the dictionary.
    format -> (string)
      The data format. Valid values are all formats supported by ClickHouse SQL dialect.
    headers -> ([]struct)
      HTTP headers.
      name -> (string)
        Header name.
      value -> (string)
        Header value.
    url -> (string)
      URL of the source dictionary available over HTTP.
  mysql-source -> (struct)
    MySQL source for the dictionary.
    close-connection -> (bool)
      Should a connection be closed after each request.
    db -> (string)
      Database name.
    invalidate-query -> (string)
      Query for checking the dictionary status, to pull only updated data.
    password -> (string)
      Password of the user for replicas of the dictionary source.
    port -> (int)
      Port to use when connecting to a replica of the dictionary source.
    replicas -> ([]struct)
      List of MySQL replicas of the database used as dictionary source.
      host -> (string)
        MySQL host of the replica.
      password -> (string)
        Password of the MySQL database user. If a password is not specified for a replica, ClickHouse uses the password specified for the source.
      port -> (int)
        Port to use when connecting to the replica. If a port is not specified for a replica, ClickHouse uses the port specified for the source.
      priority -> (int)
        The priority of the replica that ClickHouse takes into account when connecting. Replica with the highest priority should have this field set to the lowest number.
      user -> (string)
        Name of the MySQL database user. If a user is not specified for a replica, ClickHouse uses the user specified for the source.
    share-connection -> (bool)
      Should a connection be shared for some requests.
    table -> (string)
      Table name.
    user -> (string)
      Name of the user for replicas of the dictionary source.
    where -> (string)
      Selection criteria for the data in the specified MySQL table.
  clickhouse-source -> (struct)
    ClickHouse source for the dictionary.
    db -> (string)
      Database name.
    host -> (string)
      ClickHouse host.
    password -> (string)
      Password of the ClickHouse database user.
    port -> (int)
      Port to use when connecting to the host.
    secure -> (bool)
      Determines whether to use TLS for connection.
    table -> (string)
      Table name.
    user -> (string)
      Name of the ClickHouse database user.
    where -> (string)
      Selection criteria for the data in the specified ClickHouse table.
  mongodb-source -> (struct)
    MongoDB source for the dictionary.
    collection -> (string)
      Collection name.
    db -> (string)
      Database name.
    host -> (string)
      MongoDB host.
    options -> (string)
      Dictionary source options.
    password -> (string)
      Password of the MongoDB database user.
    port -> (int)
      Port to use when connecting to the host.
    user -> (string)
      Name of the MongoDB database user.
  postgresql-source -> (struct)
    PostgreSQL source for the dictionary.
    db -> (string)
      Database name.
    hosts -> ([]string)
      PostgreSQL hosts.
    invalidate-query -> (string)
      Query for checking the dictionary status, to pull only updated data.
    password -> (string)
      Password of the PostrgreSQL database user.
    port -> (int)
      Port to use when connecting to the PostgreSQL hosts.
    ssl-mode -> (struct)
      Mode of SSL TCP/IP connection to the PostgreSQL host.
    table -> (string)
      Table name.
    user -> (string)
      Name of the PostrgreSQL database user.
``` ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary. ||
|| `--summary` | `strings`

Fields to include in summary output.
Each value is a dot-separated path to a field.
Examples:
  --summary instance.id                  # simple field
  --summary instance.type                # another simple field
  --summary instance.disks.size          # collect values from all list elements
  --summary instance.disks[0].size       # field from a specific list element ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#