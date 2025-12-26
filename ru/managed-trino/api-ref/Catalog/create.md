---
editable: false
apiPlayground:
  - url: https://trino.{{ api-host }}/managed-trino/v1/clusters/{clusterId}/catalogs
    method: post
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the Trino Cluster where the catalog should be created.
            The maximum string length in characters is 50.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        catalog:
          description: |-
            **[CatalogSpec](#yandex.cloud.trino.v1.CatalogSpec)**
            Required field. Specification of the catalog to be created.
          $ref: '#/definitions/CatalogSpec'
      required:
        - catalog
      additionalProperties: false
    definitions:
      HiveMetastore:
        type: object
        properties:
          uri:
            description: |-
              **string**
              URI or cluster ID of the Hive Metastore.
              Includes only one of the fields `uri`.
            type: string
        oneOf:
          - required:
              - uri
      Metastore:
        type: object
        properties:
          hive:
            description: |-
              **[HiveMetastore](#yandex.cloud.trino.v1.Metastore.HiveMetastore)**
              Apache Hive Metastore.
              Includes only one of the fields `hive`.
            $ref: '#/definitions/HiveMetastore'
        oneOf:
          - required:
              - hive
      S3FileSystem:
        type: object
        properties: {}
      ExternalS3FileSystem:
        type: object
        properties:
          awsAccessKey:
            description: |-
              **string**
              Required field. AWS access key.
            type: string
          awsSecretKey:
            description: |-
              **string**
              Required field. AWS secret key.
            type: string
          awsEndpoint:
            description: |-
              **string**
              Required field. AWS endpoint.
            type: string
          awsRegion:
            description: |-
              **string**
              Required field. AWS region.
            type: string
        required:
          - awsAccessKey
          - awsSecretKey
          - awsEndpoint
          - awsRegion
      FileSystem:
        type: object
        properties:
          s3:
            description: |-
              **object**
              Yandex Cloud S3 filesystem.
              Includes only one of the fields `s3`, `externalS3`.
            $ref: '#/definitions/S3FileSystem'
          externalS3:
            description: |-
              **[ExternalS3FileSystem](#yandex.cloud.trino.v1.FileSystem.ExternalS3FileSystem)**
              External S3 filesystem.
              Includes only one of the fields `s3`, `externalS3`.
            $ref: '#/definitions/ExternalS3FileSystem'
        oneOf:
          - required:
              - s3
          - required:
              - externalS3
      HiveConnector:
        type: object
        properties:
          metastore:
            description: |-
              **[Metastore](#yandex.cloud.trino.v1.Metastore)**
              Required field. Metastore configuration.
            $ref: '#/definitions/Metastore'
          filesystem:
            description: |-
              **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**
              Required field. File system configuration.
            $ref: '#/definitions/FileSystem'
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
              No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ ]*'
              maxLength: 128
            propertyNames:
              type: string
              pattern: '[a-z][-_0-9a-z.]*'
              maxLength: 128
              minLength: 1
            maxProperties: 256
        required:
          - metastore
          - filesystem
      IcebergConnector:
        type: object
        properties:
          metastore:
            description: |-
              **[Metastore](#yandex.cloud.trino.v1.Metastore)**
              Required field. Metastore configuration.
            $ref: '#/definitions/Metastore'
          filesystem:
            description: |-
              **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**
              Required field. File system configuration.
            $ref: '#/definitions/FileSystem'
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
              No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ ]*'
              maxLength: 128
            propertyNames:
              type: string
              pattern: '[a-z][-_0-9a-z.]*'
              maxLength: 128
              minLength: 1
            maxProperties: 256
        required:
          - metastore
          - filesystem
      DeltaLakeConnector:
        type: object
        properties:
          metastore:
            description: |-
              **[Metastore](#yandex.cloud.trino.v1.Metastore)**
              Required field. Metastore configuration.
            $ref: '#/definitions/Metastore'
          filesystem:
            description: |-
              **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**
              Required field. File system configuration.
            $ref: '#/definitions/FileSystem'
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
              No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ ]*'
              maxLength: 128
            propertyNames:
              type: string
              pattern: '[a-z][-_0-9a-z.]*'
              maxLength: 128
              minLength: 1
            maxProperties: 256
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
              Value must match the regular expression ` ^jdbc:postgresql://(?:.+:\d+)/(?:.*)$ `.
            pattern: ^jdbc:postgresql://(?:.+:\d+)/(?:.*)$
            type: string
          userName:
            description: |-
              **string**
              Required field. Name of the Postgresql user.
              The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
            pattern: '[a-zA-Z0-9_-]*'
            type: string
          password:
            description: |-
              **string**
              Required field. Password of the Postgresql user.
              The string length in characters must be 0-128.
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
              The string length in characters must be 1-50.
            type: string
          database:
            description: |-
              **string**
              Required field. Database.
              The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
            pattern: '[a-zA-Z0-9_-]*'
            type: string
          connectionProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional connection properties.
              No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z]* `.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_]*'
              maxLength: 128
            propertyNames:
              type: string
              pattern: '[a-zA-Z]*'
              maxLength: 128
              minLength: 1
            maxProperties: 256
        required:
          - connectionId
          - database
      PostgresqlConnection:
        type: object
        properties:
          onPremise:
            description: |-
              **[OnPremise](#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise)**
              Connection configured manually.
              Includes only one of the fields `onPremise`, `connectionManager`.
            $ref: '#/definitions/OnPremise'
          connectionManager:
            description: |-
              **[ConnectionManager](#yandex.cloud.trino.v1.PostgresqlConnection.ConnectionManager)**
              Connection configured using Yandex Cloud Connection Manager.
              Includes only one of the fields `onPremise`, `connectionManager`.
            $ref: '#/definitions/ConnectionManager'
        oneOf:
          - required:
              - onPremise
          - required:
              - connectionManager
      PostgresqlConnector:
        type: object
        properties:
          connection:
            description: |-
              **[PostgresqlConnection](#yandex.cloud.trino.v1.PostgresqlConnection)**
              Connection configuration.
            $ref: '#/definitions/PostgresqlConnection'
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
              No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ ]*'
              maxLength: 128
            propertyNames:
              type: string
              pattern: '[a-z][-_0-9a-z.]*'
              maxLength: 128
              minLength: 1
            maxProperties: 256
      ClickhouseConnection:
        type: object
        properties:
          onPremise:
            description: |-
              **[OnPremise](#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise)**
              Connection configured manually.
              Includes only one of the fields `onPremise`, `connectionManager`.
            $ref: '#/definitions/OnPremise'
          connectionManager:
            description: |-
              **[ConnectionManager](#yandex.cloud.trino.v1.PostgresqlConnection.ConnectionManager)**
              Connection configured using Yandex Cloud Connection Manager.
              Includes only one of the fields `onPremise`, `connectionManager`.
            $ref: '#/definitions/ConnectionManager'
        oneOf:
          - required:
              - onPremise
          - required:
              - connectionManager
      ClickhouseConnector:
        type: object
        properties:
          connection:
            description: |-
              **[ClickhouseConnection](#yandex.cloud.trino.v1.ClickhouseConnection)**
              Connection configuration.
            $ref: '#/definitions/ClickhouseConnection'
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
              No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ ]*'
              maxLength: 128
            propertyNames:
              type: string
              pattern: '[a-z][-_0-9a-z.]*'
              maxLength: 128
              minLength: 1
            maxProperties: 256
      TPCHConnector:
        type: object
        properties:
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
              No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ ]*'
              maxLength: 128
            propertyNames:
              type: string
              pattern: '[a-z][-_0-9a-z.]*'
              maxLength: 128
              minLength: 1
            maxProperties: 256
      TPCDSConnector:
        type: object
        properties:
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
              No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ ]*'
              maxLength: 128
            propertyNames:
              type: string
              pattern: '[a-z][-_0-9a-z.]*'
              maxLength: 128
              minLength: 1
            maxProperties: 256
      OracleConnection:
        type: object
        properties:
          onPremise:
            description: |-
              **[OnPremise](#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise)**
              Connection configured manually.
              Includes only one of the fields `onPremise`.
            $ref: '#/definitions/OnPremise'
        oneOf:
          - required:
              - onPremise
      OracleConnector:
        type: object
        properties:
          connection:
            description: |-
              **[OracleConnection](#yandex.cloud.trino.v1.OracleConnection)**
              Connection configuration.
            $ref: '#/definitions/OracleConnection'
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
              No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ ]*'
              maxLength: 128
            propertyNames:
              type: string
              pattern: '[a-z][-_0-9a-z.]*'
              maxLength: 128
              minLength: 1
            maxProperties: 256
      SQLServerConnection:
        type: object
        properties:
          onPremise:
            description: |-
              **[OnPremise](#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise)**
              Connection configured manually.
              Includes only one of the fields `onPremise`.
            $ref: '#/definitions/OnPremise'
        oneOf:
          - required:
              - onPremise
      SQLServerConnector:
        type: object
        properties:
          connection:
            description: |-
              **[SQLServerConnection](#yandex.cloud.trino.v1.SQLServerConnection)**
              Connection configuration.
            $ref: '#/definitions/SQLServerConnection'
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
              No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ ]*'
              maxLength: 128
            propertyNames:
              type: string
              pattern: '[a-z][-_0-9a-z.]*'
              maxLength: 128
              minLength: 1
            maxProperties: 256
      HudiConnector:
        type: object
        properties:
          metastore:
            description: |-
              **[Metastore](#yandex.cloud.trino.v1.Metastore)**
              Required field. Metastore configuration.
            $ref: '#/definitions/Metastore'
          filesystem:
            description: |-
              **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**
              Required field. File system configuration.
            $ref: '#/definitions/FileSystem'
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
              No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ ]*'
              maxLength: 128
            propertyNames:
              type: string
              pattern: '[a-z][-_0-9a-z.]*'
              maxLength: 128
              minLength: 1
            maxProperties: 256
        required:
          - metastore
          - filesystem
      MysqlConnection:
        type: object
        properties:
          onPremise:
            description: |-
              **[OnPremise](#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise)**
              Connection configured manually.
              Includes only one of the fields `onPremise`, `connectionManager`.
            $ref: '#/definitions/OnPremise'
          connectionManager:
            description: |-
              **[ConnectionManager](#yandex.cloud.trino.v1.PostgresqlConnection.ConnectionManager)**
              Connection configured using Yandex Cloud Connection Manager.
              Includes only one of the fields `onPremise`, `connectionManager`.
            $ref: '#/definitions/ConnectionManager'
        oneOf:
          - required:
              - onPremise
          - required:
              - connectionManager
      MysqlConnector:
        type: object
        properties:
          connection:
            description: |-
              **[MysqlConnection](#yandex.cloud.trino.v1.MysqlConnection)**
              Connection configuration.
            $ref: '#/definitions/MysqlConnection'
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
              No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ ]*'
              maxLength: 128
            propertyNames:
              type: string
              pattern: '[a-z][-_0-9a-z.]*'
              maxLength: 128
              minLength: 1
            maxProperties: 256
      GreenplumConnection:
        type: object
        properties:
          onPremise:
            description: |-
              **[OnPremise](#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise)**
              Connection configured manually.
              Includes only one of the fields `onPremise`, `connectionManager`.
            $ref: '#/definitions/OnPremise'
          connectionManager:
            description: |-
              **[ConnectionManager](#yandex.cloud.trino.v1.PostgresqlConnection.ConnectionManager)**
              Connection configured using Yandex Cloud Connection Manager.
              Includes only one of the fields `onPremise`, `connectionManager`.
            $ref: '#/definitions/ConnectionManager'
        oneOf:
          - required:
              - onPremise
          - required:
              - connectionManager
      GreenplumConnector:
        type: object
        properties:
          connection:
            description: |-
              **[GreenplumConnection](#yandex.cloud.trino.v1.GreenplumConnection)**
              Connection configuration
            $ref: '#/definitions/GreenplumConnection'
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
              No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ ]*'
              maxLength: 128
            propertyNames:
              type: string
              pattern: '[a-z][-_0-9a-z.]*'
              maxLength: 128
              minLength: 1
            maxProperties: 256
      Connector:
        type: object
        properties:
          hive:
            description: |-
              **[HiveConnector](#yandex.cloud.trino.v1.HiveConnector)**
              Hive connector configuration.
              Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`.
            $ref: '#/definitions/HiveConnector'
          iceberg:
            description: |-
              **[IcebergConnector](#yandex.cloud.trino.v1.IcebergConnector)**
              Iceberg connector configuration.
              Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`.
            $ref: '#/definitions/IcebergConnector'
          deltaLake:
            description: |-
              **[DeltaLakeConnector](#yandex.cloud.trino.v1.DeltaLakeConnector)**
              Delta Lake connector configuration.
              Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`.
            $ref: '#/definitions/DeltaLakeConnector'
          postgresql:
            description: |-
              **[PostgresqlConnector](#yandex.cloud.trino.v1.PostgresqlConnector)**
              PostgreSQL connector configuration.
              Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`.
            $ref: '#/definitions/PostgresqlConnector'
          clickhouse:
            description: |-
              **[ClickhouseConnector](#yandex.cloud.trino.v1.ClickhouseConnector)**
              ClickHouse connector configuration.
              Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`.
            $ref: '#/definitions/ClickhouseConnector'
          tpch:
            description: |-
              **[TPCHConnector](#yandex.cloud.trino.v1.TPCHConnector)**
              TPC-H connector for synthetic benchmarking.
              Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`.
            $ref: '#/definitions/TPCHConnector'
          tpcds:
            description: |-
              **[TPCDSConnector](#yandex.cloud.trino.v1.TPCDSConnector)**
              TPC-DS connector for synthetic benchmarking.
              Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`.
            $ref: '#/definitions/TPCDSConnector'
          oracle:
            description: |-
              **[OracleConnector](#yandex.cloud.trino.v1.OracleConnector)**
              Oracle connector configuration for connecting to Oracle Database instances.
              Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`.
            $ref: '#/definitions/OracleConnector'
          sqlserver:
            description: |-
              **[SQLServerConnector](#yandex.cloud.trino.v1.SQLServerConnector)**
              SQLServer connector configuration for connecting to SQLServer Database instances.
              Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`.
            $ref: '#/definitions/SQLServerConnector'
          hudi:
            description: |-
              **[HudiConnector](#yandex.cloud.trino.v1.HudiConnector)**
              Hudi connector configuration.
              Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`.
            $ref: '#/definitions/HudiConnector'
          mysql:
            description: |-
              **[MysqlConnector](#yandex.cloud.trino.v1.MysqlConnector)**
              MySQL connector configuration for connecting to MySQL Database instances.
              Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`.
            $ref: '#/definitions/MysqlConnector'
          greenplum:
            description: |-
              **[GreenplumConnector](#yandex.cloud.trino.v1.GreenplumConnector)**
              Greenplum connector configuration for connecting to Greenplum or Cloudberry Database instances.
              Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`.
            $ref: '#/definitions/GreenplumConnector'
        oneOf:
          - required:
              - hive
          - required:
              - iceberg
          - required:
              - deltaLake
          - required:
              - postgresql
          - required:
              - clickhouse
          - required:
              - tpch
          - required:
              - tpcds
          - required:
              - oracle
          - required:
              - sqlserver
          - required:
              - hudi
          - required:
              - mysql
          - required:
              - greenplum
      CatalogSpec:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the catalog.
              Must be unique within a Trino cluster.
              The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
            pattern: '[a-zA-Z0-9_-]*'
            type: string
          connector:
            description: |-
              **[Connector](#yandex.cloud.trino.v1.Connector)**
              Required field. Connector backing this catalog.
            $ref: '#/definitions/Connector'
          description:
            description: |-
              **string**
              Description of the catalog.
              The maximum string length in characters is 256.
            type: string
          labels:
            description: |-
              **object** (map<**string**, **string**>)
              Labels associated with the catalog.
              No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-z]*'
              maxLength: 63
            propertyNames:
              type: string
              pattern: '[a-z][-_0-9a-z]*'
              maxLength: 63
              minLength: 1
            maxProperties: 64
        required:
          - name
          - connector
sourcePath: en/_api-ref/trino/v1/api-ref/Catalog/create.md
---

# Managed Service for Trino API, REST: Catalog.Create

Creates a new Trino Catalog.

## HTTP request

```
POST https://trino.{{ api-host }}/managed-trino/v1/clusters/{clusterId}/catalogs
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Trino Cluster where the catalog should be created.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.trino.v1.CreateCatalogRequest}

```json
{
  "catalog": {
    "name": "string",
    "connector": {
      // Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`
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
      },
      "hudi": {
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
      "mysql": {
        "connection": {
          // Includes only one of the fields `onPremise`, `connectionManager`
          "onPremise": {
            "connectionUrl": "string",
            "userName": "string",
            "password": "string"
          },
          "connectionManager": {
            "connectionId": "string",
            "connectionProperties": "object"
          }
          // end of the list of possible fields
        },
        "additionalProperties": "object"
      },
      "greenplum": {
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
      }
      // end of the list of possible fields
    },
    "description": "string",
    "labels": "object"
  }
}
```

#|
||Field | Description ||
|| catalog | **[CatalogSpec](#yandex.cloud.trino.v1.CatalogSpec)**

Required field. Specification of the catalog to be created. ||
|#

## CatalogSpec {#yandex.cloud.trino.v1.CatalogSpec}

CatalogSpec defines the desired state of a new catalog.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the catalog.
Must be unique within a Trino cluster.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| connector | **[Connector](#yandex.cloud.trino.v1.Connector)**

Required field. Connector backing this catalog. ||
|| description | **string**

Description of the catalog.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Labels associated with the catalog.

No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. ||
|#

## Connector {#yandex.cloud.trino.v1.Connector}

Connector configuration. Exactly one connector type must be specified.

#|
||Field | Description ||
|| hive | **[HiveConnector](#yandex.cloud.trino.v1.HiveConnector)**

Hive connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| iceberg | **[IcebergConnector](#yandex.cloud.trino.v1.IcebergConnector)**

Iceberg connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| deltaLake | **[DeltaLakeConnector](#yandex.cloud.trino.v1.DeltaLakeConnector)**

Delta Lake connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| postgresql | **[PostgresqlConnector](#yandex.cloud.trino.v1.PostgresqlConnector)**

PostgreSQL connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| clickhouse | **[ClickhouseConnector](#yandex.cloud.trino.v1.ClickhouseConnector)**

ClickHouse connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| tpch | **[TPCHConnector](#yandex.cloud.trino.v1.TPCHConnector)**

TPC-H connector for synthetic benchmarking.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| tpcds | **[TPCDSConnector](#yandex.cloud.trino.v1.TPCDSConnector)**

TPC-DS connector for synthetic benchmarking.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| oracle | **[OracleConnector](#yandex.cloud.trino.v1.OracleConnector)**

Oracle connector configuration for connecting to Oracle Database instances.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| sqlserver | **[SQLServerConnector](#yandex.cloud.trino.v1.SQLServerConnector)**

SQLServer connector configuration for connecting to SQLServer Database instances.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| hudi | **[HudiConnector](#yandex.cloud.trino.v1.HudiConnector)**

Hudi connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| mysql | **[MysqlConnector](#yandex.cloud.trino.v1.MysqlConnector)**

MySQL connector configuration for connecting to MySQL Database instances.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| greenplum | **[GreenplumConnector](#yandex.cloud.trino.v1.GreenplumConnector)**

Greenplum connector configuration for connecting to Greenplum or Cloudberry Database instances.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|#

## HiveConnector {#yandex.cloud.trino.v1.HiveConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**

Required field. File system configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## Metastore {#yandex.cloud.trino.v1.Metastore}

Metastore configuration.

#|
||Field | Description ||
|| hive | **[HiveMetastore](#yandex.cloud.trino.v1.Metastore.HiveMetastore)**

Apache Hive Metastore.

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

Yandex Cloud S3 filesystem.

Includes only one of the fields `s3`, `externalS3`. ||
|| externalS3 | **[ExternalS3FileSystem](#yandex.cloud.trino.v1.FileSystem.ExternalS3FileSystem)**

External S3 filesystem.

Includes only one of the fields `s3`, `externalS3`. ||
|#

## ExternalS3FileSystem {#yandex.cloud.trino.v1.FileSystem.ExternalS3FileSystem}

Describes External S3 compatible file system.

#|
||Field | Description ||
|| awsAccessKey | **string**

Required field. AWS access key. ||
|| awsSecretKey | **string**

Required field. AWS secret key. ||
|| awsEndpoint | **string**

Required field. AWS endpoint. ||
|| awsRegion | **string**

Required field. AWS region. ||
|#

## IcebergConnector {#yandex.cloud.trino.v1.IcebergConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**

Required field. File system configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## DeltaLakeConnector {#yandex.cloud.trino.v1.DeltaLakeConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**

Required field. File system configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## PostgresqlConnector {#yandex.cloud.trino.v1.PostgresqlConnector}

#|
||Field | Description ||
|| connection | **[PostgresqlConnection](#yandex.cloud.trino.v1.PostgresqlConnection)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## PostgresqlConnection {#yandex.cloud.trino.v1.PostgresqlConnection}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise)**

Connection configured manually.

Includes only one of the fields `onPremise`, `connectionManager`. ||
|| connectionManager | **[ConnectionManager](#yandex.cloud.trino.v1.PostgresqlConnection.ConnectionManager)**

Connection configured using Yandex Cloud Connection Manager.

Includes only one of the fields `onPremise`, `connectionManager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the Postgresql.

Value must match the regular expression ` ^jdbc:postgresql://(?:.+:\d+)/(?:.*)$ `. ||
|| userName | **string**

Required field. Name of the Postgresql user.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

Required field. Password of the Postgresql user.

The string length in characters must be 0-128. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.PostgresqlConnection.ConnectionManager}

#|
||Field | Description ||
|| connectionId | **string**

Required field. Connection ID.

The string length in characters must be 1-50. ||
|| database | **string**

Required field. Database.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| connectionProperties | **object** (map<**string**, **string**>)

Additional connection properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z]* `. ||
|#

## ClickhouseConnector {#yandex.cloud.trino.v1.ClickhouseConnector}

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.trino.v1.ClickhouseConnection)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## ClickhouseConnection {#yandex.cloud.trino.v1.ClickhouseConnection}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.ClickhouseConnection.OnPremise)**

Connection configured manually.

Includes only one of the fields `onPremise`, `connectionManager`. ||
|| connectionManager | **[ConnectionManager](#yandex.cloud.trino.v1.ClickhouseConnection.ConnectionManager)**

Connection configured using Yandex Cloud Connection Manager.

Includes only one of the fields `onPremise`, `connectionManager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.ClickhouseConnection.OnPremise}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the Clickhouse.

Value must match the regular expression ` ^jdbc:clickhouse://(?:.+:\d+)/(?:.*)$ `. ||
|| userName | **string**

Required field. Name of the Clickhouse user.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

Required field. Password of the Clickhouse user.

The string length in characters must be 0-128. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.ClickhouseConnection.ConnectionManager}

#|
||Field | Description ||
|| connectionId | **string**

Required field. Connection ID.

The string length in characters must be 1-50. ||
|| database | **string**

Required field. Database.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| connectionProperties | **object** (map<**string**, **string**>)

Additional connection properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z_]* `. ||
|#

## TPCHConnector {#yandex.cloud.trino.v1.TPCHConnector}

#|
||Field | Description ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## TPCDSConnector {#yandex.cloud.trino.v1.TPCDSConnector}

#|
||Field | Description ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## OracleConnector {#yandex.cloud.trino.v1.OracleConnector}

#|
||Field | Description ||
|| connection | **[OracleConnection](#yandex.cloud.trino.v1.OracleConnection)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## OracleConnection {#yandex.cloud.trino.v1.OracleConnection}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.OracleConnection.OnPremise)**

Connection configured manually.

Includes only one of the fields `onPremise`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.OracleConnection.OnPremise}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the Oracle.

Value must match the regular expression ` ^jdbc:oracle:(?s:.*)$ `. ||
|| userName | **string**

Required field. Name of the Oracle user.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

Required field. Password of the Oracle user.

The string length in characters must be 0-128. ||
|#

## SQLServerConnector {#yandex.cloud.trino.v1.SQLServerConnector}

#|
||Field | Description ||
|| connection | **[SQLServerConnection](#yandex.cloud.trino.v1.SQLServerConnection)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## SQLServerConnection {#yandex.cloud.trino.v1.SQLServerConnection}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.SQLServerConnection.OnPremise)**

Connection configured manually.

Includes only one of the fields `onPremise`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.SQLServerConnection.OnPremise}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the SQLServer.

Value must match the regular expression ` ^jdbc:sqlserver:(?s:.*)$ `. ||
|| userName | **string**

Required field. Name of the SQLServer user.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

Required field. Password of the SQLServer user.

The string length in characters must be 0-128. ||
|#

## HudiConnector {#yandex.cloud.trino.v1.HudiConnector}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem)**

Required field. File system configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## MysqlConnector {#yandex.cloud.trino.v1.MysqlConnector}

#|
||Field | Description ||
|| connection | **[MysqlConnection](#yandex.cloud.trino.v1.MysqlConnection)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## MysqlConnection {#yandex.cloud.trino.v1.MysqlConnection}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.MysqlConnection.OnPremise)**

Connection configured manually.

Includes only one of the fields `onPremise`, `connectionManager`. ||
|| connectionManager | **[ConnectionManager](#yandex.cloud.trino.v1.MysqlConnection.ConnectionManager)**

Connection configured using Yandex Cloud Connection Manager.

Includes only one of the fields `onPremise`, `connectionManager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.MysqlConnection.OnPremise}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the MySQL.

Value must match the regular expression ` ^jdbc:mysql://(?:.+:\d+)(?:/?.*)$ `. ||
|| userName | **string**

Required field. Name of the MySQL user.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

Required field. Password of the MySQL user.

The string length in characters must be 0-128. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.MysqlConnection.ConnectionManager}

#|
||Field | Description ||
|| connectionId | **string**

Required field. Connection ID.

The string length in characters must be 1-50. ||
|| connectionProperties | **object** (map<**string**, **string**>)

Additional connection properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z_]* `. ||
|#

## GreenplumConnector {#yandex.cloud.trino.v1.GreenplumConnector}

#|
||Field | Description ||
|| connection | **[GreenplumConnection](#yandex.cloud.trino.v1.GreenplumConnection)**

Connection configuration ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## GreenplumConnection {#yandex.cloud.trino.v1.GreenplumConnection}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.GreenplumConnection.OnPremise)**

Connection configured manually.

Includes only one of the fields `onPremise`, `connectionManager`. ||
|| connectionManager | **[ConnectionManager](#yandex.cloud.trino.v1.GreenplumConnection.ConnectionManager)**

Connection configured using Yandex Cloud Connection Manager.

Includes only one of the fields `onPremise`, `connectionManager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.GreenplumConnection.OnPremise}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the Greenplum/Cloudberry.

Value must match the regular expression ` ^jdbc:postgresql://(?:.+:\d+)/(?:.*)$ `. ||
|| userName | **string**

Required field. Name of the Greenplum/Cloudberry user.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

Required field. Password of the Greenplum/Cloudberry user.

The string length in characters must be 0-128. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.GreenplumConnection.ConnectionManager}

#|
||Field | Description ||
|| connectionId | **string**

Required field. Connection ID.

The string length in characters must be 1-50. ||
|| database | **string**

Required field. Database.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| connectionProperties | **object** (map<**string**, **string**>)

Additional connection properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z]* `. ||
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
    "clusterId": "string",
    "catalogId": "string"
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
    "name": "string",
    "connector": {
      // Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`
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
      },
      "hudi": {
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
      "mysql": {
        "connection": {
          // Includes only one of the fields `onPremise`, `connectionManager`
          "onPremise": {
            "connectionUrl": "string",
            "userName": "string",
            "password": "string"
          },
          "connectionManager": {
            "connectionId": "string",
            "connectionProperties": "object"
          }
          // end of the list of possible fields
        },
        "additionalProperties": "object"
      },
      "greenplum": {
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
      }
      // end of the list of possible fields
    },
    "description": "string",
    "labels": "object"
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
|| metadata | **[CreateCatalogMetadata](#yandex.cloud.trino.v1.CreateCatalogMetadata)**

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
|| response | **[Catalog](#yandex.cloud.trino.v1.Catalog)**

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

## CreateCatalogMetadata {#yandex.cloud.trino.v1.CreateCatalogMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the Trino cluster where a catalog is being created. ||
|| catalogId | **string**

ID of the catalog that is being created. ||
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

## Catalog {#yandex.cloud.trino.v1.Catalog}

Catalog is a logical Trino catalog backed by a specific connector.

#|
||Field | Description ||
|| id | **string**

ID of the catalog. ||
|| name | **string**

Name of the catalog. ||
|| connector | **[Connector](#yandex.cloud.trino.v1.Connector2)**

Connector backing this catalog. ||
|| description | **string**

Description of the catalog. ||
|| labels | **object** (map<**string**, **string**>)

Labels associated with the catalog. ||
|#

## Connector {#yandex.cloud.trino.v1.Connector2}

Connector configuration. Exactly one connector type must be specified.

#|
||Field | Description ||
|| hive | **[HiveConnector](#yandex.cloud.trino.v1.HiveConnector2)**

Hive connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| iceberg | **[IcebergConnector](#yandex.cloud.trino.v1.IcebergConnector2)**

Iceberg connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| deltaLake | **[DeltaLakeConnector](#yandex.cloud.trino.v1.DeltaLakeConnector2)**

Delta Lake connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| postgresql | **[PostgresqlConnector](#yandex.cloud.trino.v1.PostgresqlConnector2)**

PostgreSQL connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| clickhouse | **[ClickhouseConnector](#yandex.cloud.trino.v1.ClickhouseConnector2)**

ClickHouse connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| tpch | **[TPCHConnector](#yandex.cloud.trino.v1.TPCHConnector2)**

TPC-H connector for synthetic benchmarking.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| tpcds | **[TPCDSConnector](#yandex.cloud.trino.v1.TPCDSConnector2)**

TPC-DS connector for synthetic benchmarking.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| oracle | **[OracleConnector](#yandex.cloud.trino.v1.OracleConnector2)**

Oracle connector configuration for connecting to Oracle Database instances.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| sqlserver | **[SQLServerConnector](#yandex.cloud.trino.v1.SQLServerConnector2)**

SQLServer connector configuration for connecting to SQLServer Database instances.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| hudi | **[HudiConnector](#yandex.cloud.trino.v1.HudiConnector2)**

Hudi connector configuration.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| mysql | **[MysqlConnector](#yandex.cloud.trino.v1.MysqlConnector2)**

MySQL connector configuration for connecting to MySQL Database instances.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|| greenplum | **[GreenplumConnector](#yandex.cloud.trino.v1.GreenplumConnector2)**

Greenplum connector configuration for connecting to Greenplum or Cloudberry Database instances.

Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`. ||
|#

## HiveConnector {#yandex.cloud.trino.v1.HiveConnector2}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore2)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem2)**

Required field. File system configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## Metastore {#yandex.cloud.trino.v1.Metastore2}

Metastore configuration.

#|
||Field | Description ||
|| hive | **[HiveMetastore](#yandex.cloud.trino.v1.Metastore.HiveMetastore2)**

Apache Hive Metastore.

Includes only one of the fields `hive`. ||
|#

## HiveMetastore {#yandex.cloud.trino.v1.Metastore.HiveMetastore2}

Configuration of Hive's metastore type.

#|
||Field | Description ||
|| uri | **string**

URI or cluster ID of the Hive Metastore.

Includes only one of the fields `uri`. ||
|#

## FileSystem {#yandex.cloud.trino.v1.FileSystem2}

Configuration of file system used by a connector.

#|
||Field | Description ||
|| s3 | **object**

Yandex Cloud S3 filesystem.

Includes only one of the fields `s3`, `externalS3`. ||
|| externalS3 | **[ExternalS3FileSystem](#yandex.cloud.trino.v1.FileSystem.ExternalS3FileSystem2)**

External S3 filesystem.

Includes only one of the fields `s3`, `externalS3`. ||
|#

## ExternalS3FileSystem {#yandex.cloud.trino.v1.FileSystem.ExternalS3FileSystem2}

Describes External S3 compatible file system.

#|
||Field | Description ||
|| awsAccessKey | **string**

Required field. AWS access key. ||
|| awsSecretKey | **string**

Required field. AWS secret key. ||
|| awsEndpoint | **string**

Required field. AWS endpoint. ||
|| awsRegion | **string**

Required field. AWS region. ||
|#

## IcebergConnector {#yandex.cloud.trino.v1.IcebergConnector2}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore2)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem2)**

Required field. File system configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## DeltaLakeConnector {#yandex.cloud.trino.v1.DeltaLakeConnector2}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore2)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem2)**

Required field. File system configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## PostgresqlConnector {#yandex.cloud.trino.v1.PostgresqlConnector2}

#|
||Field | Description ||
|| connection | **[PostgresqlConnection](#yandex.cloud.trino.v1.PostgresqlConnection2)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## PostgresqlConnection {#yandex.cloud.trino.v1.PostgresqlConnection2}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise2)**

Connection configured manually.

Includes only one of the fields `onPremise`, `connectionManager`. ||
|| connectionManager | **[ConnectionManager](#yandex.cloud.trino.v1.PostgresqlConnection.ConnectionManager2)**

Connection configured using Yandex Cloud Connection Manager.

Includes only one of the fields `onPremise`, `connectionManager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.PostgresqlConnection.OnPremise2}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the Postgresql.

Value must match the regular expression ` ^jdbc:postgresql://(?:.+:\d+)/(?:.*)$ `. ||
|| userName | **string**

Required field. Name of the Postgresql user.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

Required field. Password of the Postgresql user.

The string length in characters must be 0-128. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.PostgresqlConnection.ConnectionManager2}

#|
||Field | Description ||
|| connectionId | **string**

Required field. Connection ID.

The string length in characters must be 1-50. ||
|| database | **string**

Required field. Database.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| connectionProperties | **object** (map<**string**, **string**>)

Additional connection properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z]* `. ||
|#

## ClickhouseConnector {#yandex.cloud.trino.v1.ClickhouseConnector2}

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.trino.v1.ClickhouseConnection2)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## ClickhouseConnection {#yandex.cloud.trino.v1.ClickhouseConnection2}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.ClickhouseConnection.OnPremise2)**

Connection configured manually.

Includes only one of the fields `onPremise`, `connectionManager`. ||
|| connectionManager | **[ConnectionManager](#yandex.cloud.trino.v1.ClickhouseConnection.ConnectionManager2)**

Connection configured using Yandex Cloud Connection Manager.

Includes only one of the fields `onPremise`, `connectionManager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.ClickhouseConnection.OnPremise2}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the Clickhouse.

Value must match the regular expression ` ^jdbc:clickhouse://(?:.+:\d+)/(?:.*)$ `. ||
|| userName | **string**

Required field. Name of the Clickhouse user.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

Required field. Password of the Clickhouse user.

The string length in characters must be 0-128. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.ClickhouseConnection.ConnectionManager2}

#|
||Field | Description ||
|| connectionId | **string**

Required field. Connection ID.

The string length in characters must be 1-50. ||
|| database | **string**

Required field. Database.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| connectionProperties | **object** (map<**string**, **string**>)

Additional connection properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z_]* `. ||
|#

## TPCHConnector {#yandex.cloud.trino.v1.TPCHConnector2}

#|
||Field | Description ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## TPCDSConnector {#yandex.cloud.trino.v1.TPCDSConnector2}

#|
||Field | Description ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## OracleConnector {#yandex.cloud.trino.v1.OracleConnector2}

#|
||Field | Description ||
|| connection | **[OracleConnection](#yandex.cloud.trino.v1.OracleConnection2)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## OracleConnection {#yandex.cloud.trino.v1.OracleConnection2}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.OracleConnection.OnPremise2)**

Connection configured manually.

Includes only one of the fields `onPremise`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.OracleConnection.OnPremise2}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the Oracle.

Value must match the regular expression ` ^jdbc:oracle:(?s:.*)$ `. ||
|| userName | **string**

Required field. Name of the Oracle user.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

Required field. Password of the Oracle user.

The string length in characters must be 0-128. ||
|#

## SQLServerConnector {#yandex.cloud.trino.v1.SQLServerConnector2}

#|
||Field | Description ||
|| connection | **[SQLServerConnection](#yandex.cloud.trino.v1.SQLServerConnection2)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## SQLServerConnection {#yandex.cloud.trino.v1.SQLServerConnection2}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.SQLServerConnection.OnPremise2)**

Connection configured manually.

Includes only one of the fields `onPremise`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.SQLServerConnection.OnPremise2}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the SQLServer.

Value must match the regular expression ` ^jdbc:sqlserver:(?s:.*)$ `. ||
|| userName | **string**

Required field. Name of the SQLServer user.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

Required field. Password of the SQLServer user.

The string length in characters must be 0-128. ||
|#

## HudiConnector {#yandex.cloud.trino.v1.HudiConnector2}

#|
||Field | Description ||
|| metastore | **[Metastore](#yandex.cloud.trino.v1.Metastore2)**

Required field. Metastore configuration. ||
|| filesystem | **[FileSystem](#yandex.cloud.trino.v1.FileSystem2)**

Required field. File system configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## MysqlConnector {#yandex.cloud.trino.v1.MysqlConnector2}

#|
||Field | Description ||
|| connection | **[MysqlConnection](#yandex.cloud.trino.v1.MysqlConnection2)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## MysqlConnection {#yandex.cloud.trino.v1.MysqlConnection2}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.MysqlConnection.OnPremise2)**

Connection configured manually.

Includes only one of the fields `onPremise`, `connectionManager`. ||
|| connectionManager | **[ConnectionManager](#yandex.cloud.trino.v1.MysqlConnection.ConnectionManager2)**

Connection configured using Yandex Cloud Connection Manager.

Includes only one of the fields `onPremise`, `connectionManager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.MysqlConnection.OnPremise2}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the MySQL.

Value must match the regular expression ` ^jdbc:mysql://(?:.+:\d+)(?:/?.*)$ `. ||
|| userName | **string**

Required field. Name of the MySQL user.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

Required field. Password of the MySQL user.

The string length in characters must be 0-128. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.MysqlConnection.ConnectionManager2}

#|
||Field | Description ||
|| connectionId | **string**

Required field. Connection ID.

The string length in characters must be 1-50. ||
|| connectionProperties | **object** (map<**string**, **string**>)

Additional connection properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z_]* `. ||
|#

## GreenplumConnector {#yandex.cloud.trino.v1.GreenplumConnector2}

#|
||Field | Description ||
|| connection | **[GreenplumConnection](#yandex.cloud.trino.v1.GreenplumConnection2)**

Connection configuration ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ ]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. ||
|#

## GreenplumConnection {#yandex.cloud.trino.v1.GreenplumConnection2}

#|
||Field | Description ||
|| onPremise | **[OnPremise](#yandex.cloud.trino.v1.GreenplumConnection.OnPremise2)**

Connection configured manually.

Includes only one of the fields `onPremise`, `connectionManager`. ||
|| connectionManager | **[ConnectionManager](#yandex.cloud.trino.v1.GreenplumConnection.ConnectionManager2)**

Connection configured using Yandex Cloud Connection Manager.

Includes only one of the fields `onPremise`, `connectionManager`. ||
|#

## OnPremise {#yandex.cloud.trino.v1.GreenplumConnection.OnPremise2}

#|
||Field | Description ||
|| connectionUrl | **string**

Required field. Connection to the Greenplum/Cloudberry.

Value must match the regular expression ` ^jdbc:postgresql://(?:.+:\d+)/(?:.*)$ `. ||
|| userName | **string**

Required field. Name of the Greenplum/Cloudberry user.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| password | **string**

Required field. Password of the Greenplum/Cloudberry user.

The string length in characters must be 0-128. ||
|#

## ConnectionManager {#yandex.cloud.trino.v1.GreenplumConnection.ConnectionManager2}

#|
||Field | Description ||
|| connectionId | **string**

Required field. Connection ID.

The string length in characters must be 1-50. ||
|| database | **string**

Required field. Database.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| connectionProperties | **object** (map<**string**, **string**>)

Additional connection properties.

No more than 256 per resource. The maximum string length in characters for each value is 128. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z]* `. ||
|#