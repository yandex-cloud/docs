---
editable: false
apiPlayground:
  - url: https://trino.{{ api-host }}/managed-trino/v1/clusters
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create Trino cluster in.
          type: string
        name:
          description: |-
            **string**
            Required field. Name of the Trino cluster. The name must be unique within the folder.
          pattern: '[a-zA-Z0-9_-]*'
          type: string
        description:
          description: |-
            **string**
            Description of the Trino cluster.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Custom labels for the Trino cluster as `` key:value `` pairs.
            For example: {"env": "prod"}.
          pattern: '[a-z][-_0-9a-z]*'
          type: string
        trino:
          description: |-
            **[TrinoConfigSpec](/docs/managed-trino/api-ref/Cluster/create#yandex.cloud.trino.v1.TrinoConfigSpec)**
            Required field. Configuration of Trino components.
          $ref: '#/definitions/TrinoConfigSpec'
        network:
          description: |-
            **[NetworkConfig](/docs/managed-trino/api-ref/Cluster/get#yandex.cloud.trino.v1.NetworkConfig)**
            Required field. Network related configuration options.
          $ref: '#/definitions/NetworkConfig'
        deletionProtection:
          description: |-
            **boolean**
            Deletion Protection inhibits deletion of the cluster.
          type: boolean
        serviceAccountId:
          description: |-
            **string**
            Required field. Service account used to access Cloud resources.
          type: string
        logging:
          description: |-
            **[LoggingConfig](/docs/managed-trino/api-ref/Cluster/get#yandex.cloud.trino.v1.LoggingConfig)**
            Cloud logging configuration.
          oneOf:
            - type: object
              properties:
                folderId:
                  description: |-
                    **string**
                    Logs should be written to default log group for specified folder.
                    Includes only one of the fields `folderId`, `logGroupId`.
                    Destination of log records.
                  pattern: ([a-zA-Z][-a-zA-Z0-9_.]{0,63})?
                  type: string
                logGroupId:
                  description: |-
                    **string**
                    Logs should be written to log group resolved by ID.
                    Includes only one of the fields `folderId`, `logGroupId`.
                    Destination of log records.
                  pattern: ([a-zA-Z][-a-zA-Z0-9_.]{0,63})?
                  type: string
        maintenanceWindow:
          description: |-
            **[MaintenanceWindow](/docs/managed-trino/api-ref/Cluster/get#yandex.cloud.trino.v1.MaintenanceWindow)**
            Window of maintenance operations.
          oneOf:
            - type: object
              properties:
                anytime:
                  description: |-
                    **object**
                    Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
                  $ref: '#/definitions/AnytimeMaintenanceWindow'
                weeklyMaintenanceWindow:
                  description: |-
                    **[WeeklyMaintenanceWindow](/docs/managed-trino/api-ref/Cluster/get#yandex.cloud.trino.v1.WeeklyMaintenanceWindow)**
                    Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
                  $ref: '#/definitions/WeeklyMaintenanceWindow'
      required:
        - folderId
        - name
        - trino
        - network
        - serviceAccountId
      additionalProperties: false
    definitions:
      S3FileSystem:
        type: object
        properties: {}
      ExternalS3FileSystem:
        type: object
        properties:
          awsAccessKey:
            description: |-
              **string**
              Required field. 
            type: string
          awsSecretKey:
            description: |-
              **string**
              Required field. 
            type: string
          awsEndpoint:
            description: |-
              **string**
              Required field. 
            type: string
          awsRegion:
            description: |-
              **string**
              Required field. 
            type: string
        required:
          - awsAccessKey
          - awsSecretKey
          - awsEndpoint
          - awsRegion
      HiveConnector:
        type: object
        properties:
          metastore:
            description: |-
              **[Metastore](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.Metastore)**
              Required field. Metastore configuration.
            oneOf:
              - type: object
                properties:
                  hive:
                    description: |-
                      **[HiveMetastore](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.Metastore.HiveMetastore)**
                      Includes only one of the fields `hive`.
                    oneOf:
                      - type: object
                        properties:
                          uri:
                            description: |-
                              **string**
                              URI or cluster ID of the Hive Metastore.
                              Includes only one of the fields `uri`.
                            type: string
          filesystem:
            description: |-
              **[FileSystem](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.FileSystem)**
              Required field. File system configuration.
            oneOf:
              - type: object
                properties:
                  s3:
                    description: |-
                      **object**
                      Includes only one of the fields `s3`, `externalS3`.
                    $ref: '#/definitions/S3FileSystem'
                  externalS3:
                    description: |-
                      **[ExternalS3FileSystem](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.FileSystem.ExternalS3FileSystem)**
                      Includes only one of the fields `s3`, `externalS3`.
                    $ref: '#/definitions/ExternalS3FileSystem'
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
            pattern: '[a-z][-_0-9a-z.]*'
            type: string
        required:
          - metastore
          - filesystem
      IcebergConnector:
        type: object
        properties:
          metastore:
            description: |-
              **[Metastore](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.Metastore)**
              Required field. Metastore configuration.
            oneOf:
              - type: object
                properties:
                  hive:
                    description: |-
                      **[HiveMetastore](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.Metastore.HiveMetastore)**
                      Includes only one of the fields `hive`.
                    oneOf:
                      - type: object
                        properties:
                          uri:
                            description: |-
                              **string**
                              URI or cluster ID of the Hive Metastore.
                              Includes only one of the fields `uri`.
                            type: string
          filesystem:
            description: |-
              **[FileSystem](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.FileSystem)**
              Required field. File system configuration.
            oneOf:
              - type: object
                properties:
                  s3:
                    description: |-
                      **object**
                      Includes only one of the fields `s3`, `externalS3`.
                    $ref: '#/definitions/S3FileSystem'
                  externalS3:
                    description: |-
                      **[ExternalS3FileSystem](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.FileSystem.ExternalS3FileSystem)**
                      Includes only one of the fields `s3`, `externalS3`.
                    $ref: '#/definitions/ExternalS3FileSystem'
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
            pattern: '[a-z][-_0-9a-z.]*'
            type: string
        required:
          - metastore
          - filesystem
      DeltaLakeConnector:
        type: object
        properties:
          metastore:
            description: |-
              **[Metastore](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.Metastore)**
              Required field. Metastore configuration.
            oneOf:
              - type: object
                properties:
                  hive:
                    description: |-
                      **[HiveMetastore](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.Metastore.HiveMetastore)**
                      Includes only one of the fields `hive`.
                    oneOf:
                      - type: object
                        properties:
                          uri:
                            description: |-
                              **string**
                              URI or cluster ID of the Hive Metastore.
                              Includes only one of the fields `uri`.
                            type: string
          filesystem:
            description: |-
              **[FileSystem](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.FileSystem)**
              Required field. File system configuration.
            oneOf:
              - type: object
                properties:
                  s3:
                    description: |-
                      **object**
                      Includes only one of the fields `s3`, `externalS3`.
                    $ref: '#/definitions/S3FileSystem'
                  externalS3:
                    description: |-
                      **[ExternalS3FileSystem](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.FileSystem.ExternalS3FileSystem)**
                      Includes only one of the fields `s3`, `externalS3`.
                    $ref: '#/definitions/ExternalS3FileSystem'
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
            pattern: '[a-z][-_0-9a-z.]*'
            type: string
        required:
          - metastore
          - filesystem
      OnPremise:
        type: object
        properties:
          connectionUrl:
            description: |-
              **string**
              Required field. Connection to the Postgresql.
            pattern: ^jdbc:[a-z0-9]+://(?:.+:\d+)/(?:.*)$
            type: string
          userName:
            description: |-
              **string**
              Required field. Name of the Postgresql user.
            pattern: '[a-zA-Z0-9_-]*'
            type: string
          password:
            description: |-
              **string**
              Required field. Password of the Postgresql user.
            type: string
        required:
          - connectionUrl
          - userName
          - password
      ConnectionManager:
        type: object
        properties:
          connectionId:
            description: |-
              **string**
              Required field. Connection ID.
            type: string
          database:
            description: |-
              **string**
              Required field. Database.
            pattern: '[a-zA-Z0-9_-]*'
            type: string
          connectionProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional connection properties.
            pattern: '[a-zA-Z]*'
            type: string
        required:
          - connectionId
          - database
      PostgresqlConnector:
        type: object
        properties:
          connection:
            description: |-
              **[PostgresqlConnection](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.PostgresqlConnection)**
              Connection configuration.
            oneOf:
              - type: object
                properties:
                  onPremise:
                    description: |-
                      **[OnPremise](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise)**
                      Includes only one of the fields `onPremise`, `connectionManager`.
                    $ref: '#/definitions/OnPremise'
                  connectionManager:
                    description: |-
                      **[ConnectionManager](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.PostgresqlConnection.ConnectionManager)**
                      Includes only one of the fields `onPremise`, `connectionManager`.
                    $ref: '#/definitions/ConnectionManager'
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
            pattern: '[a-z][-_0-9a-z.]*'
            type: string
      ClickhouseConnector:
        type: object
        properties:
          connection:
            description: |-
              **[ClickhouseConnection](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.ClickhouseConnection)**
              Connection configuration.
            oneOf:
              - type: object
                properties:
                  onPremise:
                    description: |-
                      **[OnPremise](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise)**
                      Includes only one of the fields `onPremise`, `connectionManager`.
                    $ref: '#/definitions/OnPremise'
                  connectionManager:
                    description: |-
                      **[ConnectionManager](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.PostgresqlConnection.ConnectionManager)**
                      Includes only one of the fields `onPremise`, `connectionManager`.
                    $ref: '#/definitions/ConnectionManager'
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
            pattern: '[a-z][-_0-9a-z.]*'
            type: string
      TPCHConnector:
        type: object
        properties:
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
            pattern: '[a-z][-_0-9a-z.]*'
            type: string
      TPCDSConnector:
        type: object
        properties:
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
            pattern: '[a-z][-_0-9a-z.]*'
            type: string
      OracleConnector:
        type: object
        properties:
          connection:
            description: |-
              **[OracleConnection](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.OracleConnection)**
              Connection configuration.
            oneOf:
              - type: object
                properties:
                  onPremise:
                    description: |-
                      **[OnPremise](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise)**
                      Includes only one of the fields `onPremise`.
                    $ref: '#/definitions/OnPremise'
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
            pattern: '[a-z][-_0-9a-z.]*'
            type: string
      SQLServerConnector:
        type: object
        properties:
          connection:
            description: |-
              **[SQLServerConnection](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.SQLServerConnection)**
              Connection configuration.
            oneOf:
              - type: object
                properties:
                  onPremise:
                    description: |-
                      **[OnPremise](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise)**
                      Includes only one of the fields `onPremise`.
                    $ref: '#/definitions/OnPremise'
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
            pattern: '[a-z][-_0-9a-z.]*'
            type: string
      CatalogSpec:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the catalog.
              Must be unique within a Trino cluster.
            pattern: '[a-zA-Z0-9_-]*'
            type: string
          connector:
            description: |-
              **[Connector](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.Connector)**
              Required field. Connector backing this catalog.
            oneOf:
              - type: object
                properties:
                  hive:
                    description: |-
                      **[HiveConnector](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.HiveConnector)**
                      Hive connector configuration.
                      Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`.
                    $ref: '#/definitions/HiveConnector'
                  iceberg:
                    description: |-
                      **[IcebergConnector](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.IcebergConnector)**
                      Iceberg connector configuration.
                      Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`.
                    $ref: '#/definitions/IcebergConnector'
                  deltaLake:
                    description: |-
                      **[DeltaLakeConnector](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.DeltaLakeConnector)**
                      Delta Lake connector configuration.
                      Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`.
                    $ref: '#/definitions/DeltaLakeConnector'
                  postgresql:
                    description: |-
                      **[PostgresqlConnector](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.PostgresqlConnector)**
                      PostgreSQL connector configuration.
                      Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`.
                    $ref: '#/definitions/PostgresqlConnector'
                  clickhouse:
                    description: |-
                      **[ClickhouseConnector](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.ClickhouseConnector)**
                      ClickHouse connector configuration.
                      Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`.
                    $ref: '#/definitions/ClickhouseConnector'
                  tpch:
                    description: |-
                      **[TPCHConnector](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.TPCHConnector)**
                      TPC-H connector for synthetic benchmarking.
                      Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`.
                    $ref: '#/definitions/TPCHConnector'
                  tpcds:
                    description: |-
                      **[TPCDSConnector](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.TPCDSConnector)**
                      TPC-DS connector for synthetic benchmarking.
                      Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`.
                    $ref: '#/definitions/TPCDSConnector'
                  oracle:
                    description: |-
                      **[OracleConnector](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.OracleConnector)**
                      Oracle connector configuration for connecting to Oracle Database instances.
                      Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`.
                    $ref: '#/definitions/OracleConnector'
                  sqlserver:
                    description: |-
                      **[SQLServerConnector](/docs/managed-trino/api-ref/Catalog/get#yandex.cloud.trino.v1.SQLServerConnector)**
                      SQLServer connector configuration for connecting to SQLServer Database instances.
                      Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`.
                    $ref: '#/definitions/SQLServerConnector'
          description:
            description: |-
              **string**
              Description of the catalog.
            type: string
          labels:
            description: |-
              **object** (map<**string**, **string**>)
              Labels associated with the catalog.
            pattern: '[a-z][-_0-9a-z]*'
            type: string
        required:
          - name
          - connector
      Resources:
        type: object
        properties:
          resourcePresetId:
            description: |-
              **string**
              Required field. ID of the preset for computational resources allocated to a instance (e.g., CPU, memory, etc.).
            type: string
        required:
          - resourcePresetId
      CoordinatorConfig:
        type: object
        properties:
          resources:
            description: |-
              **[Resources](/docs/managed-trino/api-ref/Cluster/get#yandex.cloud.trino.v1.Resources)**
              Required field. Configuration for computational resources assigned to the coordinator instance.
            $ref: '#/definitions/Resources'
        required:
          - resources
      FixedScalePolicy:
        type: object
        properties:
          count:
            description: |-
              **string** (int64)
              Specifies the number of worker instances.
            type: string
            format: int64
      AutoScalePolicy:
        type: object
        properties:
          minCount:
            description: '**string** (int64)'
            type: string
            format: int64
          maxCount:
            description: '**string** (int64)'
            type: string
            format: int64
      WorkerConfig:
        type: object
        properties:
          resources:
            description: |-
              **[Resources](/docs/managed-trino/api-ref/Cluster/get#yandex.cloud.trino.v1.Resources)**
              Required field. Configuration for computational resources for worker instances.
            $ref: '#/definitions/Resources'
          scalePolicy:
            description: |-
              **[WorkerScalePolicy](/docs/managed-trino/api-ref/Cluster/update#yandex.cloud.trino.v1.UpdateWorkerConfig.WorkerScalePolicy)**
              Required field. Configuration for scaling policy for worker instances.
            oneOf:
              - type: object
                properties:
                  fixedScale:
                    description: |-
                      **[FixedScalePolicy](/docs/managed-trino/api-ref/Cluster/get#yandex.cloud.trino.v1.FixedScalePolicy)**
                      A fixed scaling policy that specifies a fixed number of worker instances.
                      Includes only one of the fields `fixedScale`, `autoScale`.
                      Defines the scaling type for worker instances.
                      Only one type of scaling can be specified at a time.
                    $ref: '#/definitions/FixedScalePolicy'
                  autoScale:
                    description: |-
                      **[AutoScalePolicy](/docs/managed-trino/api-ref/Cluster/get#yandex.cloud.trino.v1.AutoScalePolicy)**
                      A scaling policy that dynamically adjusts the number of worker instances
                      based on the cluster's workload. The system automatically increases or
                      decreases the number of instances within the defined range.
                      Includes only one of the fields `fixedScale`, `autoScale`.
                      Defines the scaling type for worker instances.
                      Only one type of scaling can be specified at a time.
                    $ref: '#/definitions/AutoScalePolicy'
        required:
          - resources
          - scalePolicy
      ServiceS3:
        type: object
        properties: {}
      ExchangeManagerConfig:
        type: object
        properties:
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
            pattern: '[a-z][-_0-9a-z.]*'
            type: string
          storage:
            description: '**[ExchangeManagerStorage](/docs/managed-trino/api-ref/Cluster/get#yandex.cloud.trino.v1.ExchangeManagerStorage)**'
            oneOf:
              - type: object
                properties:
                  serviceS3:
                    description: |-
                      **object**
                      Use service side s3 bucket for exchange manager.
                      Includes only one of the fields `serviceS3`.
                    $ref: '#/definitions/ServiceS3'
      RetryPolicyConfig:
        type: object
        properties:
          policy:
            description: |-
              **enum** (RetryPolicy)
              Retry policy level.
              - `RETRY_POLICY_UNSPECIFIED`
              - `QUERY`
              - `TASK`
            type: string
            enum:
              - RETRY_POLICY_UNSPECIFIED
              - QUERY
              - TASK
          exchangeManager:
            description: |-
              **[ExchangeManagerConfig](/docs/managed-trino/api-ref/Cluster/get#yandex.cloud.trino.v1.ExchangeManagerConfig)**
              Configuration for exchange manager.
            $ref: '#/definitions/ExchangeManagerConfig'
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
            pattern: '[a-z][-_0-9a-z.]*'
            type: string
      TrinoConfigSpec:
        type: object
        properties:
          catalogs:
            description: |-
              **[CatalogSpec](/docs/managed-trino/api-ref/Catalog/create#yandex.cloud.trino.v1.CatalogSpec)**
              List of catalogs that enable integration with various data sources.
              Each catalog defines a connection to an external data source that Trino can query.
            type: array
            items:
              $ref: '#/definitions/CatalogSpec'
          coordinatorConfig:
            description: |-
              **[CoordinatorConfig](/docs/managed-trino/api-ref/Cluster/get#yandex.cloud.trino.v1.CoordinatorConfig)**
              Required field. Configuration for the coordinator, specifying computational resources and other settings.
            $ref: '#/definitions/CoordinatorConfig'
          workerConfig:
            description: |-
              **[WorkerConfig](/docs/managed-trino/api-ref/Cluster/get#yandex.cloud.trino.v1.WorkerConfig)**
              Required field. Configuration for worker nodes, including scaling policy and computational resources.
            $ref: '#/definitions/WorkerConfig'
          retryPolicy:
            description: |-
              **[RetryPolicyConfig](/docs/managed-trino/api-ref/Cluster/get#yandex.cloud.trino.v1.RetryPolicyConfig)**
              Configuration for retry policy, specifying the spooling storage destination and other settings.
            $ref: '#/definitions/RetryPolicyConfig'
          version:
            description: |-
              **string**
              Trino version.
              Format: "Number".
            type: string
        required:
          - coordinatorConfig
          - workerConfig
      NetworkConfig:
        type: object
        properties:
          subnetIds:
            description: |-
              **string**
              IDs of VPC network subnets where instances of the cluster are attached.
            type: array
            items:
              type: string
          securityGroupIds:
            description: |-
              **string**
              User security groups.
            type: array
            items:
              type: string
      AnytimeMaintenanceWindow:
        type: object
        properties: {}
      WeeklyMaintenanceWindow:
        type: object
        properties:
          day:
            description: |-
              **enum** (WeekDay)
              - `WEEK_DAY_UNSPECIFIED`
              - `MON`
              - `TUE`
              - `WED`
              - `THU`
              - `FRI`
              - `SAT`
              - `SUN`
            type: string
            enum:
              - WEEK_DAY_UNSPECIFIED
              - MON
              - TUE
              - WED
              - THU
              - FRI
              - SAT
              - SUN
          hour:
            description: |-
              **string** (int64)
              Hour of the day in UTC.
            type: string
            format: int64
sourcePath: en/_api-ref/trino/v1/api-ref/Cluster/create.md
---

# Managed Service for Trino API, REST: Cluster.Create

Creates a Trino Cluster resource.

## HTTP request

```
POST https://trino.{{ api-host }}/managed-trino/v1/clusters
```

## Body parameters {#yandex.cloud.trino.v1.CreateClusterRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "trino": {
    "catalogs": [
      {
        "name": "string",
        "connector": {
          // Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`
          "hive": {
            "metastore": {
              // Includes only one of the fields `hive`
              "hive": {
                // Includes only one of the fields `uri`
                "uri": "string"
                // end of the list of possible fields
              }
              // end of the list of possible fields
            },
            "filesystem": {
              // Includes only one of the fields `s3`, `externalS3`
              "s3": "object",
              "externalS3": {
                "awsAccessKey": "string",
                "awsSecretKey": "string",
                "awsEndpoint": "string",
                "awsRegion": "string"
              }
              // end of the list of possible fields
            },
            "additionalProperties": "object"
          },
          "iceberg": {
            "metastore": {
              // Includes only one of the fields `hive`
              "hive": {
                // Includes only one of the fields `uri`
                "uri": "string"
                // end of the list of possible fields
              }
              // end of the list of possible fields
            },
            "filesystem": {
              // Includes only one of the fields `s3`, `externalS3`
              "s3": "object",
              "externalS3": {
                "awsAccessKey": "string",
                "awsSecretKey": "string",
                "awsEndpoint": "string",
                "awsRegion": "string"
              }
              // end of the list of possible fields
            },
            "additionalProperties": "object"
          },
          "deltaLake": {
            "metastore": {
              // Includes only one of the fields `hive`
              "hive": {
                // Includes only one of the fields `uri`
                "uri": "string"
                // end of the list of possible fields
              }
              // end of the list of possible fields
            },
            "filesystem": {
              // Includes only one of the fields `s3`, `externalS3`
              "s3": "object",
              "externalS3": {
                "awsAccessKey": "string",
                "awsSecretKey": "string",
                "awsEndpoint": "string",
                "awsRegion": "string"
              }
              // end of the list of possible fields
            },
            "additionalProperties": "object"
          },
          "postgresql": {
            "connection": {
              // Includes only one of the fields `onPremise`, `connectionManager`
              "onPremise": {
                "connectionUrl": "string",
                "userName": "string",
                "password": "string"
              },
              "connectionManager": {
                "connectionId": "string",
                "database": "string",
                "connectionProperties": "object"
              }
              // end of the list of possible fields
            },
            "additionalProperties": "object"
          },
          "clickhouse": {
            "connection": {
              // Includes only one of the fields `onPremise`, `connectionManager`
              "onPremise": {
                "connectionUrl": "string",
                "userName": "string",
                "password": "string"
              },
              "connectionManager": {
                "connectionId": "string",
                "database": "string",
                "connectionProperties": "object"
              }
              // end of the list of possible fields
            },
            "additionalProperties": "object"
          },
          "tpch": {
            "additionalProperties": "object"
          },
          "tpcds": {
            "additionalProperties": "object"
          },
          "oracle": {
            "connection": {
              // Includes only one of the fields `onPremise`
              "onPremise": {
                "connectionUrl": "string",
                "userName": "string",
                "password": "string"
              }
              // end of the list of possible fields
            },
            "additionalProperties": "object"
          },
          "sqlserver": {
            "connection": {
              // Includes only one of the fields `onPremise`
              "onPremise": {
                "connectionUrl": "string",
                "userName": "string",
                "password": "string"
              }
              // end of the list of possible fields
            },
            "additionalProperties": "object"
          }
          // end of the list of possible fields
        },
        "description": "string",
        "labels": "object"
      }
    ],
    "coordinatorConfig": {
      "resources": {
        "resourcePresetId": "string"
      }
    },
    "workerConfig": {
      "resources": {
        "resourcePresetId": "string"
      },
      "scalePolicy": {
        // Includes only one of the fields `fixedScale`, `autoScale`
        "fixedScale": {
          "count": "string"
        },
        "autoScale": {
          "minCount": "string",
          "maxCount": "string"
        }
        // end of the list of possible fields
      }
    },
    "retryPolicy": {
      "policy": "string",
      "exchangeManager": {
        "additionalProperties": "object",
        "storage": {
          // Includes only one of the fields `serviceS3`
          "serviceS3": "object"
          // end of the list of possible fields
        }
      },
      "additionalProperties": "object"
    },
    "version": "string"
  },
  "network": {
    "subnetIds": [
      "string"
    ],
    "securityGroupIds": [
      "string"
    ]
  },
  "deletionProtection": "boolean",
  "serviceAccountId": "string",
  "logging": {
    "enabled": "boolean",
    // Includes only one of the fields `folderId`, `logGroupId`
    "folderId": "string",
    "logGroupId": "string",
    // end of the list of possible fields
    "minLevel": "string"
  },
  "maintenanceWindow": {
    // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": "object",
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create Trino cluster in. ||
|| name | **string**

Required field. Name of the Trino cluster. The name must be unique within the folder. ||
|| description | **string**

Description of the Trino cluster. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the Trino cluster as `` key:value `` pairs.
For example: {"env": "prod"}. ||
|| trino | **[TrinoConfigSpec](#yandex.cloud.trino.v1.TrinoConfigSpec)**

Required field. Configuration of Trino components. ||
|| network | **[NetworkConfig](#yandex.cloud.trino.v1.NetworkConfig)**

Required field. Network related configuration options. ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster. ||
|| serviceAccountId | **string**

Required field. Service account used to access Cloud resources. ||
|| logging | **[LoggingConfig](#yandex.cloud.trino.v1.LoggingConfig)**

Cloud logging configuration. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.trino.v1.MaintenanceWindow)**

Window of maintenance operations. ||
|#

## TrinoConfigSpec {#yandex.cloud.trino.v1.TrinoConfigSpec}

#|
||Field | Description ||
|| catalogs[] | **[CatalogSpec](#yandex.cloud.trino.v1.CatalogSpec)**

List of catalogs that enable integration with various data sources.
Each catalog defines a connection to an external data source that Trino can query. ||
|| coordinatorConfig | **[CoordinatorConfig](#yandex.cloud.trino.v1.CoordinatorConfig)**

Required field. Configuration for the coordinator, specifying computational resources and other settings. ||
|| workerConfig | **[WorkerConfig](#yandex.cloud.trino.v1.WorkerConfig)**

Required field. Configuration for worker nodes, including scaling policy and computational resources. ||
|| retryPolicy | **[RetryPolicyConfig](#yandex.cloud.trino.v1.RetryPolicyConfig)**

Configuration for retry policy, specifying the spooling storage destination and other settings. ||
|| version | **string**

Trino version.
Format: "Number". ||
|#

## CatalogSpec {#yandex.cloud.trino.v1.CatalogSpec}

CatalogSpec defines the desired state of a new catalog.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the catalog.
Must be unique within a Trino cluster. ||
|| connector | **[Connector](#yandex.cloud.trino.v1.Connector)**

Required field. Connector backing this catalog. ||
|| description | **string**

Description of the catalog. ||
|| labels | **object** (map<**string**, **string**>)

Labels associated with the catalog. ||
|#

## Connector {#yandex.cloud.trino.v1.Connector}

Connector configuration. Exactly one connector type must be specified.

#|
||Field | Description ||
|| hive | **[HiveConnector](#yandex.cloud.trino.v1.HiveConnector)**

Hive connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| iceberg | **[IcebergConnector](#yandex.cloud.trino.v1.IcebergConnector)**

Iceberg connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| deltaLake | **[DeltaLakeConnector](#yandex.cloud.trino.v1.DeltaLakeConnector)**

Delta Lake connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| postgresql | **[PostgresqlConnector](#yandex.cloud.trino.v1.PostgresqlConnector)**

PostgreSQL connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| clickhouse | **[ClickhouseConnector](#yandex.cloud.trino.v1.ClickhouseConnector)**

ClickHouse connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| tpch | **[TPCHConnector](#yandex.cloud.trino.v1.TPCHConnector)**

TPC-H connector for synthetic benchmarking.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| tpcds | **[TPCDSConnector](#yandex.cloud.trino.v1.TPCDSConnector)**

TPC-DS connector for synthetic benchmarking.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| oracle | **[OracleConnector](#yandex.cloud.trino.v1.OracleConnector)**

Oracle connector configuration for connecting to Oracle Database instances.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|| sqlserver | **[SQLServerConnector](#yandex.cloud.trino.v1.SQLServerConnector)**

SQLServer connector configuration for connecting to SQLServer Database instances.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`. ||
|#

## HiveConnector {#yandex.cloud.trino.v1.HiveConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**

Required field. File system configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## Metastore {#yandex.cloud.trino.v1.Metastore}

Metastore configuration.

#|
||Field | Description ||
|| hive | **[HiveMetastore](#yandex.cloud.trino.v1.Metastore.HiveMetastore)**

Includes only one of the fields `hive`. ||
|#

## HiveMetastore {#yandex.cloud.trino.v1.Metastore.HiveMetastore}

Configuration of Hive's metastore type.

#|
||Field | Description ||
|| uri | **string**

URI or cluster ID of the Hive Metastore.

Includes only one of the fields `uri`. ||
|#

## FileSystem {#yandex.cloud.trino.v1.FileSystem}

Configuration of file system used by a connector.

#|
||Field | Description ||
|| s3 | **object**

Includes only one of the fields `s3`, `externalS3`. ||
|| externalS3 | **[ExternalS3FileSystem](#yandex.cloud.trino.v1.FileSystem.ExternalS3FileSystem)**

Includes only one of the fields `s3`, `externalS3`. ||
|#

## ExternalS3FileSystem {#yandex.cloud.trino.v1.FileSystem.ExternalS3FileSystem}

Describes External S3 compatible file system.

#|
||Field | Description ||
|| awsAccessKey | **string**

Required field.  ||
|| awsSecretKey | **string**

Required field.  ||
|| awsEndpoint | **string**

Required field.  ||
|| awsRegion | **string**

Required field.  ||
|#

## IcebergConnector {#yandex.cloud.trino.v1.IcebergConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**

Required field. File system configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## DeltaLakeConnector {#yandex.cloud.trino.v1.DeltaLakeConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**

Required field. File system configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## PostgresqlConnector {#yandex.cloud.trino.v1.PostgresqlConnector}

#|
||Field | Description ||
|| connection | **[PostgresqlConnection](#yandex.cloud.trino.v1.PostgresqlConnection)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## PostgresqlConnection {#yandex.cloud.trino.v1.PostgresqlConnection}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise)**

Includes only one of the fields `onPremise`, `connectionManager`. ||
|| connectionManager | **[ConnectionManager](#yandex.cloud.trino.v1.PostgresqlConnection.ConnectionManager)**

Includes only one of the fields `onPremise`, `connectionManager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the Postgresql. ||
|| userName | **string**

Required field. Name of the Postgresql user. ||
|| password | **string**

Required field. Password of the Postgresql user. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.PostgresqlConnection.ConnectionManager}

#|
||Field | Description ||
|| connectionId | **string**

Required field. Connection ID. ||
|| database | **string**

Required field. Database. ||
|| connectionProperties | **object** (map<**string**, **string**>)

Additional connection properties. ||
|#

## ClickhouseConnector {#yandex.cloud.trino.v1.ClickhouseConnector}

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.trino.v1.ClickhouseConnection)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## ClickhouseConnection {#yandex.cloud.trino.v1.ClickhouseConnection}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.ClickhouseConnection.OnPremise)**

Includes only one of the fields `onPremise`, `connectionManager`. ||
|| connectionManager | **[ConnectionManager](#yandex.cloud.trino.v1.ClickhouseConnection.ConnectionManager)**

Includes only one of the fields `onPremise`, `connectionManager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.ClickhouseConnection.OnPremise}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the Clickhouse. ||
|| userName | **string**

Required field. Name of the Clickhouse user. ||
|| password | **string**

Required field. Password of the Clickhouse user. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.ClickhouseConnection.ConnectionManager}

#|
||Field | Description ||
|| connectionId | **string**

Required field. Connection ID. ||
|| database | **string**

Required field. Database. ||
|| connectionProperties | **object** (map<**string**, **string**>)

Additional connection properties. ||
|#

## TPCHConnector {#yandex.cloud.trino.v1.TPCHConnector}

#|
||Field | Description ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## TPCDSConnector {#yandex.cloud.trino.v1.TPCDSConnector}

#|
||Field | Description ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## OracleConnector {#yandex.cloud.trino.v1.OracleConnector}

#|
||Field | Description ||
|| connection | **[OracleConnection](#yandex.cloud.trino.v1.OracleConnection)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## OracleConnection {#yandex.cloud.trino.v1.OracleConnection}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.OracleConnection.OnPremise)**

Includes only one of the fields `onPremise`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.OracleConnection.OnPremise}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the Oracle. ||
|| userName | **string**

Required field. Name of the Oracle user. ||
|| password | **string**

Required field. Password of the Oracle user. ||
|#

## SQLServerConnector {#yandex.cloud.trino.v1.SQLServerConnector}

#|
||Field | Description ||
|| connection | **[SQLServerConnection](#yandex.cloud.trino.v1.SQLServerConnection)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## SQLServerConnection {#yandex.cloud.trino.v1.SQLServerConnection}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.SQLServerConnection.OnPremise)**

Includes only one of the fields `onPremise`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.SQLServerConnection.OnPremise}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the SQLServer. ||
|| userName | **string**

Required field. Name of the SQLServer user. ||
|| password | **string**

Required field. Password of the SQLServer user. ||
|#

## CoordinatorConfig {#yandex.cloud.trino.v1.CoordinatorConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.trino.v1.Resources)**

Required field. Configuration for computational resources assigned to the coordinator instance. ||
|#

## Resources {#yandex.cloud.trino.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

Required field. ID of the preset for computational resources allocated to a instance (e.g., CPU, memory, etc.). ||
|#

## WorkerConfig {#yandex.cloud.trino.v1.WorkerConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.trino.v1.Resources)**

Required field. Configuration for computational resources for worker instances. ||
|| scalePolicy | **[WorkerScalePolicy](#yandex.cloud.trino.v1.WorkerConfig.WorkerScalePolicy)**

Required field. Configuration for scaling policy for worker instances. ||
|#

## WorkerScalePolicy {#yandex.cloud.trino.v1.WorkerConfig.WorkerScalePolicy}

#|
||Field | Description ||
|| fixedScale | **[FixedScalePolicy](#yandex.cloud.trino.v1.FixedScalePolicy)**

A fixed scaling policy that specifies a fixed number of worker instances.

Includes only one of the fields `fixedScale`, `autoScale`.

Defines the scaling type for worker instances.
Only one type of scaling can be specified at a time. ||
|| autoScale | **[AutoScalePolicy](#yandex.cloud.trino.v1.AutoScalePolicy)**

A scaling policy that dynamically adjusts the number of worker instances
based on the cluster's workload. The system automatically increases or
decreases the number of instances within the defined range.

Includes only one of the fields `fixedScale`, `autoScale`.

Defines the scaling type for worker instances.
Only one type of scaling can be specified at a time. ||
|#

## FixedScalePolicy {#yandex.cloud.trino.v1.FixedScalePolicy}

#|
||Field | Description ||
|| count | **string** (int64)

Specifies the number of worker instances. ||
|#

## AutoScalePolicy {#yandex.cloud.trino.v1.AutoScalePolicy}

#|
||Field | Description ||
|| minCount | **string** (int64) ||
|| maxCount | **string** (int64) ||
|#

## RetryPolicyConfig {#yandex.cloud.trino.v1.RetryPolicyConfig}

#|
||Field | Description ||
|| policy | **enum** (RetryPolicy)

Retry policy level.

- `RETRY_POLICY_UNSPECIFIED`
- `QUERY`
- `TASK` ||
|| exchangeManager | **[ExchangeManagerConfig](#yandex.cloud.trino.v1.ExchangeManagerConfig)**

Configuration for exchange manager. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## ExchangeManagerConfig {#yandex.cloud.trino.v1.ExchangeManagerConfig}

#|
||Field | Description ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|| storage | **[ExchangeManagerStorage](#yandex.cloud.trino.v1.ExchangeManagerStorage)** ||
|#

## ExchangeManagerStorage {#yandex.cloud.trino.v1.ExchangeManagerStorage}

#|
||Field | Description ||
|| serviceS3 | **object**

Use service side s3 bucket for exchange manager.

Includes only one of the fields `serviceS3`. ||
|#

## NetworkConfig {#yandex.cloud.trino.v1.NetworkConfig}

#|
||Field | Description ||
|| subnetIds[] | **string**

IDs of VPC network subnets where instances of the cluster are attached. ||
|| securityGroupIds[] | **string**

User security groups. ||
|#

## LoggingConfig {#yandex.cloud.trino.v1.LoggingConfig}

#|
||Field | Description ||
|| enabled | **boolean**

Logs generated by the Trino components are delivered to Cloud Logging. ||
|| folderId | **string**

Logs should be written to default log group for specified folder.

Includes only one of the fields `folderId`, `logGroupId`.

Destination of log records. ||
|| logGroupId | **string**

Logs should be written to log group resolved by ID.

Includes only one of the fields `folderId`, `logGroupId`.

Destination of log records. ||
|| minLevel | **enum** (Level)

Minimum log entry level.

See [LogLevel.Level](/docs/logging/api-ref/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

- `LEVEL_UNSPECIFIED`: Default log level.

  Equivalent to not specifying log level at all.
- `TRACE`: Trace log level.

  Possible use case: verbose logging of some business logic.
- `DEBUG`: Debug log level.

  Possible use case: debugging special cases in application logic.
- `INFO`: Info log level.

  Mostly used for information messages.
- `WARN`: Warn log level.

  May be used to alert about significant events.
- `ERROR`: Error log level.

  May be used to alert about errors in infrastructure, logic, etc.
- `FATAL`: Fatal log level.

  May be used to alert about unrecoverable failures and events. ||
|#

## MaintenanceWindow {#yandex.cloud.trino.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **object**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.trino.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.trino.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| day | **enum** (WeekDay)

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Hour of the day in UTC. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "clusterId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "monitoring": [
      {
        "name": "string",
        "description": "string",
        "link": "string"
      }
    ],
    "trino": {
      "coordinatorConfig": {
        "resources": {
          "resourcePresetId": "string"
        }
      },
      "workerConfig": {
        "resources": {
          "resourcePresetId": "string"
        },
        "scalePolicy": {
          // Includes only one of the fields `fixedScale`, `autoScale`
          "fixedScale": {
            "count": "string"
          },
          "autoScale": {
            "minCount": "string",
            "maxCount": "string"
          }
          // end of the list of possible fields
        }
      },
      "version": "string",
      "retryPolicy": {
        "policy": "string",
        "exchangeManager": {
          "additionalProperties": "object",
          "storage": {
            // Includes only one of the fields `serviceS3`
            "serviceS3": "object"
            // end of the list of possible fields
          }
        },
        "additionalProperties": "object"
      }
    },
    "health": "string",
    "status": "string",
    "network": {
      "subnetIds": [
        "string"
      ],
      "securityGroupIds": [
        "string"
      ]
    },
    "deletionProtection": "boolean",
    "serviceAccountId": "string",
    "logging": {
      "enabled": "boolean",
      // Includes only one of the fields `folderId`, `logGroupId`
      "folderId": "string",
      "logGroupId": "string",
      // end of the list of possible fields
      "minLevel": "string"
    },
    "coordinatorUrl": "string",
    "maintenanceWindow": {
      // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
      "anytime": "object",
      "weeklyMaintenanceWindow": {
        "day": "string",
        "hour": "string"
      }
      // end of the list of possible fields
    },
    "plannedOperation": {
      "info": "string",
      "delayedUntil": "string",
      "latestMaintenanceTime": "string",
      "nextMaintenanceWindowTime": "string"
    }
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateClusterMetadata](#yandex.cloud.trino.v1.CreateClusterMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Cluster](#yandex.cloud.trino.v1.Cluster)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateClusterMetadata {#yandex.cloud.trino.v1.CreateClusterMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the Trino cluster that is being created. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## Cluster {#yandex.cloud.trino.v1.Cluster}

Trino cluster.

#|
||Field | Description ||
|| id | **string**

Unique ID of the Trino cluster.
This ID is assigned by Cloud in the process of creating a Trino cluster. ||
|| folderId | **string**

ID of the folder that the Trino cluster belongs to. ||
|| createdAt | **string** (date-time)

The time when the Trino cluster was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the Trino cluster.
The name is unique within the folder. 1-64 characters long. ||
|| description | **string**

Description of the Trino cluster. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.trino.v1.Monitoring)**

Monitoring systems relevant to the Trino cluster. ||
|| trino | **[TrinoConfig](#yandex.cloud.trino.v1.TrinoConfig)**

Configuration of the Trino cluster. ||
|| health | **enum** (Health)

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Object is in unknown state (we have no data)
- `ALIVE`: Object is alive and well (all hosts are alive)
- `DEAD`: Object is inoperable (it cannot perform any of its essential functions)
- `DEGRADED`: Object is partially alive (it can perform some of its essential functions) ||
|| status | **enum** (Status)

Cluster status.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster is stopped.
- `STARTING`: Cluster is starting.
- `UPDATING`: Cluster is being updated. ||
|| network | **[NetworkConfig](#yandex.cloud.trino.v1.NetworkConfig2)**

Network related configuration options. ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster. ||
|| serviceAccountId | **string**

Service account used to access Cloud resources. ||
|| logging | **[LoggingConfig](#yandex.cloud.trino.v1.LoggingConfig2)**

Cloud logging configuration. ||
|| coordinatorUrl | **string**

Address of Trino Coordinator. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.trino.v1.MaintenanceWindow2)**

Window of maintenance operations. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.trino.v1.MaintenanceOperation)**

Maintenance operation planned at nearest maintenance_window. ||
|#

## Monitoring {#yandex.cloud.trino.v1.Monitoring}

Monitoring system.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system. ||
|#

## TrinoConfig {#yandex.cloud.trino.v1.TrinoConfig}

#|
||Field | Description ||
|| coordinatorConfig | **[CoordinatorConfig](#yandex.cloud.trino.v1.CoordinatorConfig2)**

Required field. Configuration for the coordinator, specifying computational resources and other settings. ||
|| workerConfig | **[WorkerConfig](#yandex.cloud.trino.v1.WorkerConfig2)**

Required field. Configuration for worker nodes, including scaling policy and computational resources. ||
|| version | **string**

Version of Trino. ||
|| retryPolicy | **[RetryPolicyConfig](#yandex.cloud.trino.v1.RetryPolicyConfig2)**

Configuration for retry policy, specifying the spooling storage destination and other settings. ||
|#

## CoordinatorConfig {#yandex.cloud.trino.v1.CoordinatorConfig2}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.trino.v1.Resources2)**

Required field. Configuration for computational resources assigned to the coordinator instance. ||
|#

## Resources {#yandex.cloud.trino.v1.Resources2}

#|
||Field | Description ||
|| resourcePresetId | **string**

Required field. ID of the preset for computational resources allocated to a instance (e.g., CPU, memory, etc.). ||
|#

## WorkerConfig {#yandex.cloud.trino.v1.WorkerConfig2}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.trino.v1.Resources2)**

Required field. Configuration for computational resources for worker instances. ||
|| scalePolicy | **[WorkerScalePolicy](#yandex.cloud.trino.v1.WorkerConfig.WorkerScalePolicy2)**

Required field. Configuration for scaling policy for worker instances. ||
|#

## WorkerScalePolicy {#yandex.cloud.trino.v1.WorkerConfig.WorkerScalePolicy2}

#|
||Field | Description ||
|| fixedScale | **[FixedScalePolicy](#yandex.cloud.trino.v1.FixedScalePolicy2)**

A fixed scaling policy that specifies a fixed number of worker instances.

Includes only one of the fields `fixedScale`, `autoScale`.

Defines the scaling type for worker instances.
Only one type of scaling can be specified at a time. ||
|| autoScale | **[AutoScalePolicy](#yandex.cloud.trino.v1.AutoScalePolicy2)**

A scaling policy that dynamically adjusts the number of worker instances
based on the cluster's workload. The system automatically increases or
decreases the number of instances within the defined range.

Includes only one of the fields `fixedScale`, `autoScale`.

Defines the scaling type for worker instances.
Only one type of scaling can be specified at a time. ||
|#

## FixedScalePolicy {#yandex.cloud.trino.v1.FixedScalePolicy2}

#|
||Field | Description ||
|| count | **string** (int64)

Specifies the number of worker instances. ||
|#

## AutoScalePolicy {#yandex.cloud.trino.v1.AutoScalePolicy2}

#|
||Field | Description ||
|| minCount | **string** (int64) ||
|| maxCount | **string** (int64) ||
|#

## RetryPolicyConfig {#yandex.cloud.trino.v1.RetryPolicyConfig2}

#|
||Field | Description ||
|| policy | **enum** (RetryPolicy)

Retry policy level.

- `RETRY_POLICY_UNSPECIFIED`
- `QUERY`
- `TASK` ||
|| exchangeManager | **[ExchangeManagerConfig](#yandex.cloud.trino.v1.ExchangeManagerConfig2)**

Configuration for exchange manager. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|#

## ExchangeManagerConfig {#yandex.cloud.trino.v1.ExchangeManagerConfig2}

#|
||Field | Description ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties. ||
|| storage | **[ExchangeManagerStorage](#yandex.cloud.trino.v1.ExchangeManagerStorage2)** ||
|#

## ExchangeManagerStorage {#yandex.cloud.trino.v1.ExchangeManagerStorage2}

#|
||Field | Description ||
|| serviceS3 | **object**

Use service side s3 bucket for exchange manager.

Includes only one of the fields `serviceS3`. ||
|#

## NetworkConfig {#yandex.cloud.trino.v1.NetworkConfig2}

#|
||Field | Description ||
|| subnetIds[] | **string**

IDs of VPC network subnets where instances of the cluster are attached. ||
|| securityGroupIds[] | **string**

User security groups. ||
|#

## LoggingConfig {#yandex.cloud.trino.v1.LoggingConfig2}

#|
||Field | Description ||
|| enabled | **boolean**

Logs generated by the Trino components are delivered to Cloud Logging. ||
|| folderId | **string**

Logs should be written to default log group for specified folder.

Includes only one of the fields `folderId`, `logGroupId`.

Destination of log records. ||
|| logGroupId | **string**

Logs should be written to log group resolved by ID.

Includes only one of the fields `folderId`, `logGroupId`.

Destination of log records. ||
|| minLevel | **enum** (Level)

Minimum log entry level.

See [LogLevel.Level](/docs/logging/api-ref/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

- `LEVEL_UNSPECIFIED`: Default log level.

  Equivalent to not specifying log level at all.
- `TRACE`: Trace log level.

  Possible use case: verbose logging of some business logic.
- `DEBUG`: Debug log level.

  Possible use case: debugging special cases in application logic.
- `INFO`: Info log level.

  Mostly used for information messages.
- `WARN`: Warn log level.

  May be used to alert about significant events.
- `ERROR`: Error log level.

  May be used to alert about errors in infrastructure, logic, etc.
- `FATAL`: Fatal log level.

  May be used to alert about unrecoverable failures and events. ||
|#

## MaintenanceWindow {#yandex.cloud.trino.v1.MaintenanceWindow2}

#|
||Field | Description ||
|| anytime | **object**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.trino.v1.WeeklyMaintenanceWindow2)**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.trino.v1.WeeklyMaintenanceWindow2}

#|
||Field | Description ||
|| day | **enum** (WeekDay)

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Hour of the day in UTC. ||
|#

## MaintenanceOperation {#yandex.cloud.trino.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string** ||
|| delayedUntil | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| latestMaintenanceTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| nextMaintenanceWindowTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#