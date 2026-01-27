---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-kafka/cli-ref-beta/connector/update.md
---

# yc beta managed-kafka connector update

Updates an Apache Kafka® connector.

#### Command Usage

Syntax:

`yc beta managed-kafka connector update <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the Apache Kafka® cluster to update the connector in. To get this ID, make a [ClusterService.List] request. ||
|| `--connector-name` | `string`

Name of the connector to update. To get this name, make a [ConnectorService.List] request. ||
|| `--connector-spec` | `shorthand/json`

Configuration of the connector to update.

Shorthand Syntax:

```hcl
{
  connector-config = connector-config-mirrormaker={
    replication-factor = int,
    source-cluster = {
      alias = str,
      cluster-connection = external-cluster={
        bootstrap-servers = str,
        sasl-mechanism = str,
        sasl-password = str,
        sasl-username = str,
        security-protocol = str,
        ssl-truststore-certificates = str
      } | this-cluster={}
    },
    target-cluster = {
      alias = str,
      cluster-connection = external-cluster={
        bootstrap-servers = str,
        sasl-mechanism = str,
        sasl-password = str,
        sasl-username = str,
        security-protocol = str,
        ssl-truststore-certificates = str
      } | this-cluster={}
    },
    topics = str
  } | connector-config-s3-sink={
    file-max-records = int,
    s3-connection = {
      bucket-name = str,
      storage = external-s3={
        access-key-id = str,
        endpoint = str,
        region = str,
        secret-access-key = str
      }
    },
    topics = str
  },
  properties = {key=str, key=...},
  tasks-max = int
}
```

JSON Syntax:

```json
{
  "connector-config": {
    "connector-config-mirrormaker": {
      "replication-factor": "int",
      "source-cluster": {
        "alias": "str",
        "cluster-connection": {
          "external-cluster": {
            "bootstrap-servers": "str",
            "sasl-mechanism": "str",
            "sasl-password": "str",
            "sasl-username": "str",
            "security-protocol": "str",
            "ssl-truststore-certificates": "str"
          },
          "this-cluster": {}
        }
      },
      "target-cluster": {
        "alias": "str",
        "cluster-connection": {
          "external-cluster": {
            "bootstrap-servers": "str",
            "sasl-mechanism": "str",
            "sasl-password": "str",
            "sasl-username": "str",
            "security-protocol": "str",
            "ssl-truststore-certificates": "str"
          },
          "this-cluster": {}
        }
      },
      "topics": "str"
    },
    "connector-config-s3-sink": {
      "file-max-records": "int",
      "s3-connection": {
        "bucket-name": "str",
        "storage": {
          "external-s3": {
            "access-key-id": "str",
            "endpoint": "str",
            "region": "str",
            "secret-access-key": "str"
          }
        }
      },
      "topics": "str"
    }
  },
  "properties": {
    "<key>": "str", ...
  },
  "tasks-max": "int"
}
```

Fields:

```
properties -> (map[string,string])
  A set of new or changed properties to update for the connector. They are passed with the connector configuration to Managed Service for Apache Kafka®. Example: 'sync.topics.config.enabled: false'.
tasks-max -> (int)
  Maximum number of connector tasks to update.
connector-config -> (oneof<connector-config-mirrormaker|connector-config-s3-sink>)
  Oneof connector-config field
  connector-config-mirrormaker -> (struct)
    Configuration of the MirrorMaker connector.
    replication-factor -> (int)
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
    Update specification for S3-Sink Connector.
    file-max-records -> (int)
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