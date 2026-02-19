---
editable: false
noIndex: true
---

# yc beta managed-kafka connector create

Creates a new Apache Kafka® connector in a cluster.

#### Command Usage

Syntax:

`yc beta managed-kafka connector create <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--cluster-id` | `string`

ID of the Apache Kafka® cluster to create the connector in. To get this ID, make a [ClusterService.List] request. ||
|| `--connector-spec` | `shorthand/json`

Configuration of the connector to create.

Shorthand Syntax:

```hcl
{
  connector-config = connector-config-mirrormaker={
    replication-factor = integer,
    source-cluster = {
      alias = string,
      cluster-connection = external-cluster={
        bootstrap-servers = string,
        sasl-mechanism = string,
        sasl-password = string,
        sasl-username = string,
        security-protocol = string,
        ssl-truststore-certificates = string
      } | this-cluster={}
    },
    target-cluster = {
      alias = string,
      cluster-connection = external-cluster={
        bootstrap-servers = string,
        sasl-mechanism = string,
        sasl-password = string,
        sasl-username = string,
        security-protocol = string,
        ssl-truststore-certificates = string
      } | this-cluster={}
    },
    topics = string
  } | connector-config-s3-sink={
    file-compression-type = string,
    file-max-records = integer,
    s3-connection = {
      bucket-name = string,
      storage = external-s3={
        access-key-id = string,
        endpoint = string,
        region = string,
        secret-access-key = string
      }
    },
    topics = string
  },
  name = string,
  properties = {key=string, key=...},
  tasks-max = integer
}
```

JSON Syntax:

```json
{
  "connector-config": {
    "connector-config-mirrormaker": {
      "replication-factor": "integer",
      "source-cluster": {
        "alias": "string",
        "cluster-connection": {
          "external-cluster": {
            "bootstrap-servers": "string",
            "sasl-mechanism": "string",
            "sasl-password": "string",
            "sasl-username": "string",
            "security-protocol": "string",
            "ssl-truststore-certificates": "string"
          },
          "this-cluster": {}
        }
      },
      "target-cluster": {
        "alias": "string",
        "cluster-connection": {
          "external-cluster": {
            "bootstrap-servers": "string",
            "sasl-mechanism": "string",
            "sasl-password": "string",
            "sasl-username": "string",
            "security-protocol": "string",
            "ssl-truststore-certificates": "string"
          },
          "this-cluster": {}
        }
      },
      "topics": "string"
    },
    "connector-config-s3-sink": {
      "file-compression-type": "string",
      "file-max-records": "integer",
      "s3-connection": {
        "bucket-name": "string",
        "storage": {
          "external-s3": {
            "access-key-id": "string",
            "endpoint": "string",
            "region": "string",
            "secret-access-key": "string"
          }
        }
      },
      "topics": "string"
    }
  },
  "name": "string",
  "properties": {
    "<key>": "string", ...
  },
  "tasks-max": "integer"
}
```

Fields:

```
name -> (string)
  Name of the connector.
properties -> (map[string,string])
  A set of properties passed to Managed Service for Apache Kafka® with the connector configuration. Example: 'sync.topics.config.enabled: true'.
tasks-max -> (integer)
  Maximum number of connector tasks. Default value is the number of brokers.
connector-config -> (oneof<connector-config-mirrormaker|connector-config-s3-sink>)
  Oneof connector-config field
  connector-config-mirrormaker -> (struct)
    Configuration of the MirrorMaker connector.
    replication-factor -> (integer)
      Replication factor for automatically created topics.
    source-cluster -> (struct)
      Source cluster configuration for the MirrorMaker connector.
      alias -> (string)
        Alias of cluster connection configuration. Examples: 'source', 'target'.
      cluster-connection -> (oneof<external-cluster|this-cluster>)
        Oneof cluster-connection field
        this-cluster -> (struct)
          Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty.
        external-cluster -> (struct)
          Configuration of connection to an external cluster with all the necessary credentials.
          bootstrap-servers -> (string)
            List of bootstrap servers of the cluster, separated by ','.
          sasl-mechanism -> (string)
            SASL mechanism to use for connection to the cluster.
          sasl-password -> (string)
            SASL password to use for connection to the cluster.
          sasl-username -> (string)
            SASL username to use for connection to the cluster.
          security-protocol -> (string)
            Security protocol to use for connection to the cluster.
          ssl-truststore-certificates -> (string)
            CA in PEM format to connect to external cluster. Lines of certificate separated by '\n' symbol.
    target-cluster -> (struct)
      Target cluster configuration for the MirrorMaker connector.
      alias -> (string)
        Alias of cluster connection configuration. Examples: 'source', 'target'.
      cluster-connection -> (oneof<external-cluster|this-cluster>)
        Oneof cluster-connection field
        this-cluster -> (struct)
          Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty.
        external-cluster -> (struct)
          Configuration of connection to an external cluster with all the necessary credentials.
          bootstrap-servers -> (string)
            List of bootstrap servers of the cluster, separated by ','.
          sasl-mechanism -> (string)
            SASL mechanism to use for connection to the cluster.
          sasl-password -> (string)
            SASL password to use for connection to the cluster.
          sasl-username -> (string)
            SASL username to use for connection to the cluster.
          security-protocol -> (string)
            Security protocol to use for connection to the cluster.
          ssl-truststore-certificates -> (string)
            CA in PEM format to connect to external cluster. Lines of certificate separated by '\n' symbol.
    topics -> (string)
      List of Kafka topics, separated by ','.
  connector-config-s3-sink -> (struct)
    Configuration of S3-Sink connector.
    file-compression-type -> (string)
      The compression type used for files put on GCS. The supported values are: 'gzip', 'snappy', 'zstd', 'none'. Optional, the default is 'none'.
    file-max-records -> (integer)
      Max records per file.
    s3-connection -> (struct)
      Credentials for connecting to S3 storage.
      bucket-name -> (string)
      storage -> (oneof<external-s3>)
        Oneof storage field
        external-s3 -> (struct)
          access-key-id -> (string)
          endpoint -> (string)
          region -> (string)
            Default is 'us-east-1'.
          secret-access-key -> (string)
    topics -> (string)
      List of Kafka topics, separated by ','.
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

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
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