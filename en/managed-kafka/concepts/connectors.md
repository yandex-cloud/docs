# Connectors

Connectors are {{ KFC }} components [built into {{ mkf-name }}](#supported-connectors) for streaming data between {{ KF }} and other data systems. You can use a connector for continuous data migration to and from {{ mkf-name }} clusters. Data in connectors is handled via separate {{ KFC }} *worker threads*. Learn more about {{ KFC }} in the [{{ KF }} documentation](https://kafka.apache.org/documentation/#connect).

Connectors perform the following functions:

* Connecting to {{ mkf-name }} clusters and other data stores.
* Reading and writing data.
* Coordinating data streaming.

For any type of connector, you can specify:

* Task limit. Determines the number of workers running simultaneously.
* Additional properties.

## Supported connectors {#supported-connectors}

### MirrorMaker {#mirrormaker-connector}

**MirrorMaker** is used for replicating {{ KF }} topics between clusters.

A worker accesses the broker hosts of a {{ mkf-name }} cluster and replicates the topics specified in the connector filtering template. Depending on the connector's replication factor, it connects to one or more brokers.

Topic names in the target cluster are the same as in the source.

For more information about how MirrorMaker transfers data, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#georeplication).
