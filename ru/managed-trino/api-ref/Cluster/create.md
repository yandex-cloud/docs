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
            The maximum string length in characters is 50.
          type: string
        name:
          description: |-
            **string**
            Required field. Name of the Trino cluster. The name must be unique within the folder.
            The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
          pattern: '[a-zA-Z0-9_-]*'
          type: string
        description:
          description: |-
            **string**
            Description of the Trino cluster.
            The maximum string length in characters is 256.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Custom labels for the Trino cluster as `` key:value `` pairs.
            For example: {"env": "prod"}.
            The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource.
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
        trino:
          description: |-
            **[TrinoConfigSpec](#yandex.cloud.trino.v1.TrinoConfigSpec)**
            Required field. Configuration of Trino components.
          $ref: '#/definitions/TrinoConfigSpec'
        network:
          description: |-
            **[NetworkConfig](#yandex.cloud.trino.v1.NetworkConfig)**
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
            The maximum string length in characters is 50.
          type: string
        logging:
          description: |-
            **[LoggingConfig](#yandex.cloud.trino.v1.LoggingConfig)**
            Cloud logging configuration.
          $ref: '#/definitions/LoggingConfig'
        maintenanceWindow:
          description: |-
            **[MaintenanceWindow](#yandex.cloud.trino.v1.MaintenanceWindow)**
            Window of maintenance operations.
          $ref: '#/definitions/MaintenanceWindow'
      required:
        - folderId
        - name
        - trino
        - network
        - serviceAccountId
      additionalProperties: false
    definitions:
      Thrift:
        type: object
        properties: {}
      IcebergRest:
        type: object
        properties: {}
      Protocol:
        type: object
        properties:
          thrift:
            description: |-
              **object**
              Thrift client protocol.
              Includes only one of the fields `thrift`, `rest`.
            $ref: '#/definitions/Thrift'
          rest:
            description: |-
              **object**
              Iceberg REST client protocol.
              Includes only one of the fields `thrift`, `rest`.
            $ref: '#/definitions/IcebergRest'
        oneOf:
          - required:
              - thrift
          - required:
              - rest
      HiveMetastore:
        type: object
        properties:
          uri:
            description: |-
              **string**
              URI of the Hive Metastore.
              Includes only one of the fields `uri`, `managedClusterId`.
            type: string
          managedClusterId:
            description: |-
              **string**
              ID of the Managed Hive Metastore cluster.
              Includes only one of the fields `uri`, `managedClusterId`.
            type: string
          protocol:
            description: |-
              **[Protocol](#yandex.cloud.trino.v1.Metastore.HiveMetastore.Protocol)**
              Hive metastore client protocol. If null, thrift protocol will be used.
            $ref: '#/definitions/Protocol'
        oneOf:
          - required:
              - uri
          - required:
              - managedClusterId
      NoneAuth:
        type: object
        properties: {}
      Authorization:
        type: object
        properties:
          none:
            description: |-
              **object**
              Disabled authorization
              Includes only one of the fields `none`.
            $ref: '#/definitions/NoneAuth'
        oneOf:
          - required:
              - none
      RestMetastore:
        type: object
        properties:
          uri:
            description: |-
              **string**
              URI of the REST Catalog metastore.
            type: string
          authorization:
            description: |-
              **[Authorization](#yandex.cloud.trino.v1.Metastore.RestMetastore.Authorization)**
              Authorization properties.
            $ref: '#/definitions/Authorization'
      Metastore:
        type: object
        properties:
          hive:
            description: |-
              **[HiveMetastore](#yandex.cloud.trino.v1.Metastore.HiveMetastore)**
              Apache Hive Metastore.
              Includes only one of the fields `hive`, `rest`.
            $ref: '#/definitions/HiveMetastore'
          rest:
            description: |-
              **[RestMetastore](#yandex.cloud.trino.v1.Metastore.RestMetastore)**
              Iceberg REST Catalog compatible Metastore.
              Includes only one of the fields `hive`, `rest`.
            $ref: '#/definitions/RestMetastore'
        oneOf:
          - required:
              - hive
          - required:
              - rest
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
              Value must match the regular expression ` ^https?://.+$ `.
            pattern: ^https?://.+$
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
              The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ *]*'
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
              The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ *]*'
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
              The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ *]*'
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
              The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. No more than 256 per resource.
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
              The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ *]*'
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
              The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ *]*'
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
              The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ *]*'
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
              The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ *]*'
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
              The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ *]*'
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
              The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ *]*'
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
              The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ *]*'
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
              The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ *]*'
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
              The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ *]*'
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
              The maximum string length in characters is 63. Value must match the regular expression ` [a-z]([a-z0-9_-]*[a-z0-9])? `.
            pattern: '[a-z]([a-z0-9_-]*[a-z0-9])?'
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
              The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource.
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
      Resources:
        type: object
        properties:
          resourcePresetId:
            description: |-
              **string**
              Required field. ID of the preset for computational resources allocated to a instance (e.g., CPU, memory, etc.).
              The maximum string length in characters is 50.
            type: string
        required:
          - resourcePresetId
      CoordinatorConfig:
        type: object
        properties:
          resources:
            description: |-
              **[Resources](#yandex.cloud.trino.v1.Resources)**
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
              Acceptable values are 1 to 512, inclusive.
            type: string
            format: int64
      AutoScalePolicy:
        type: object
        properties:
          minCount:
            description: |-
              **string** (int64)
              Minimum number of worker instances.
              Acceptable values are 0 to 512, inclusive.
            type: string
            format: int64
          maxCount:
            description: |-
              **string** (int64)
              Maximum number of worker instances.
              Acceptable values are 1 to 512, inclusive.
            type: string
            format: int64
      WorkerScalePolicy:
        type: object
        properties:
          fixedScale:
            description: |-
              **[FixedScalePolicy](#yandex.cloud.trino.v1.FixedScalePolicy)**
              A fixed scaling policy that specifies a fixed number of worker instances.
              Includes only one of the fields `fixedScale`, `autoScale`.
              Defines the scaling type for worker instances.
              Only one type of scaling can be specified at a time.
            $ref: '#/definitions/FixedScalePolicy'
          autoScale:
            description: |-
              **[AutoScalePolicy](#yandex.cloud.trino.v1.AutoScalePolicy)**
              A scaling policy that dynamically adjusts the number of worker instances
              based on the cluster's workload. The system automatically increases or
              decreases the number of instances within the defined range.
              Includes only one of the fields `fixedScale`, `autoScale`.
              Defines the scaling type for worker instances.
              Only one type of scaling can be specified at a time.
            $ref: '#/definitions/AutoScalePolicy'
        oneOf:
          - required:
              - fixedScale
          - required:
              - autoScale
      WorkerConfig:
        type: object
        properties:
          resources:
            description: |-
              **[Resources](#yandex.cloud.trino.v1.Resources)**
              Required field. Configuration for computational resources for worker instances.
            $ref: '#/definitions/Resources'
          scalePolicy:
            description: |-
              **[WorkerScalePolicy](/docs/managed-trino/api-ref/Cluster/update#yandex.cloud.trino.v1.UpdateWorkerConfig.WorkerScalePolicy)**
              Required field. Configuration for scaling policy for worker instances.
            $ref: '#/definitions/WorkerScalePolicy'
        required:
          - resources
          - scalePolicy
      ServiceS3:
        type: object
        properties: {}
      S3:
        type: object
        properties:
          bucket:
            description: |-
              **string**
              Required field. Name of the bucket to be used as the spool destination for exchange manager.
            type: string
        required:
          - bucket
      ExchangeManagerStorage:
        type: object
        properties:
          serviceS3:
            description: |-
              **object**
              Use a service side S3 bucket for exchange manager.
              Includes only one of the fields `serviceS3`, `s3`.
            $ref: '#/definitions/ServiceS3'
          s3:
            description: |-
              **[S3](#yandex.cloud.trino.v1.ExchangeManagerStorage.S3)**
              Use an S3 bucket for exchange manager.
              Includes only one of the fields `serviceS3`, `s3`.
            $ref: '#/definitions/S3'
        oneOf:
          - required:
              - serviceS3
          - required:
              - s3
      ExchangeManagerConfig:
        type: object
        properties:
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
              The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ *]*'
              maxLength: 128
            propertyNames:
              type: string
              pattern: '[a-z][-_0-9a-z.]*'
              maxLength: 128
              minLength: 1
            maxProperties: 256
          storage:
            description: |-
              **[ExchangeManagerStorage](#yandex.cloud.trino.v1.ExchangeManagerStorage)**
              Storage for spooled data by exchange manager.
            $ref: '#/definitions/ExchangeManagerStorage'
      RetryPolicyConfig:
        type: object
        properties:
          policy:
            description: |-
              **enum** (RetryPolicy)
              Retry policy level.
              - `QUERY`: Retry policy for queries.
              - `TASK`: Retry policy for tasks.
            type: string
            enum:
              - RETRY_POLICY_UNSPECIFIED
              - QUERY
              - TASK
          exchangeManager:
            description: |-
              **[ExchangeManagerConfig](#yandex.cloud.trino.v1.ExchangeManagerConfig)**
              Configuration for exchange manager.
            $ref: '#/definitions/ExchangeManagerConfig'
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
              The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-zA-Z.,:\/_ *]*'
              maxLength: 128
            propertyNames:
              type: string
              pattern: '[a-z][-_0-9a-z.]*'
              maxLength: 128
              minLength: 1
            maxProperties: 256
      CatalogIds:
        type: object
        properties:
          any:
            description: |-
              **string**
              List of table names. The rule will be applied if a table name is within this list.
              The maximum string length in characters for each value is 63. The maximum number of elements is 128.
            uniqueItems: true
            type: array
            items:
              type: string
      CatalogNames:
        type: object
        properties:
          any:
            description: |-
              **string**
              List of catalog names. The rule will be applied if a catalog name is within this list.
              The maximum string length in characters for each value is 63. The maximum number of elements is 128.
            uniqueItems: true
            type: array
            items:
              type: string
      CatalogAccessRuleMatcher:
        type: object
        properties:
          nameRegexp:
            description: |-
              **string**
              Catalog name regexp the rule is applied to.
              The maximum string length in characters is 256.
              Includes only one of the fields `nameRegexp`, `ids`, `names`.
            type: string
          ids:
            description: |-
              **[CatalogIds](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogIds)**
              Catalog IDs rule is applied to.
              Includes only one of the fields `nameRegexp`, `ids`, `names`.
            $ref: '#/definitions/CatalogIds'
          names:
            description: |-
              **[CatalogNames](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogNames)**
              Catalog names rule is applied to.
              Includes only one of the fields `nameRegexp`, `ids`, `names`.
            $ref: '#/definitions/CatalogNames'
        oneOf:
          - required:
              - nameRegexp
          - required:
              - ids
          - required:
              - names
      CatalogAccessRule:
        type: object
        properties:
          users:
            description: |-
              **string**
              IAM user IDs the rule is applied to.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          groups:
            description: |-
              **string**
              IAM group IDs the rule is applied to.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          catalog:
            description: |-
              **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**
              Catalog matcher specifying what catalogs the rule is applied to.
            $ref: '#/definitions/CatalogAccessRuleMatcher'
          permission:
            description: |-
              **enum** (Permission)
              Required field. Permission granted by the rule.
              - `NONE`: Denies all operations on the catalog entities.
              - `ALL`: Allows all operations on catalog entities.
              - `READ_ONLY`: Allows only read operations on catalog entities.
            type: string
            enum:
              - PERMISSION_UNSPECIFIED
              - NONE
              - ALL
              - READ_ONLY
          description:
            description: |-
              **string**
              Rule description.
              The maximum string length in characters is 128.
            type: string
        required:
          - permission
      SchemaNames:
        type: object
        properties:
          any:
            description: |-
              **string**
              List of schema names. The rule will be applied if a schema name is within this list.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-z0-9_-]+ `. The maximum number of elements is 128.
            pattern: '[a-z0-9_-]+'
            uniqueItems: true
            type: array
            items:
              type: string
      SchemaAccessRuleMatcher:
        type: object
        properties:
          nameRegexp:
            description: |-
              **string**
              Schema name regexp the rule is applied to.
              The maximum string length in characters is 256.
              Includes only one of the fields `nameRegexp`, `names`.
            type: string
          names:
            description: |-
              **[SchemaNames](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher.SchemaNames)**
              Schema names the rule is applied to.
              Includes only one of the fields `nameRegexp`, `names`.
            $ref: '#/definitions/SchemaNames'
        oneOf:
          - required:
              - nameRegexp
          - required:
              - names
      SchemaAccessRule:
        type: object
        properties:
          users:
            description: |-
              **string**
              IAM user IDs the rule is applied to.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          groups:
            description: |-
              **string**
              IAM group IDs the rule is applied to.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          catalog:
            description: |-
              **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**
              Catalog matcher specifying what catalogs the rule is applied to.
            $ref: '#/definitions/CatalogAccessRuleMatcher'
          schema:
            description: |-
              **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**
              Schema matcher specifying what schemas the rule is applied to.
            $ref: '#/definitions/SchemaAccessRuleMatcher'
          owner:
            description: |-
              **enum** (Owner)
              Required field. Ownership granted by the rule.
              - `NO`: User is not considered an owner of the schema.
              - `YES`: User is considered an owner of the schema.
            type: string
            enum:
              - OWNER_UNSPECIFIED
              - 'NO'
              - 'YES'
          description:
            description: |-
              **string**
              Rule description.
              The maximum string length in characters is 128.
            type: string
        required:
          - owner
      TableNames:
        type: object
        properties:
          any:
            description: |-
              **string**
              List of table names. The rule will be applied if a table name is within this list.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-z0-9_-]+ `. The maximum number of elements is 128.
            pattern: '[a-z0-9_-]+'
            uniqueItems: true
            type: array
            items:
              type: string
      TableAccessRuleMatcher:
        type: object
        properties:
          nameRegexp:
            description: |-
              **string**
              Table name regexp the rule is applied to.
              The maximum string length in characters is 256.
              Includes only one of the fields `nameRegexp`, `names`.
            type: string
          names:
            description: |-
              **[TableNames](#yandex.cloud.trino.v1.TableAccessRuleMatcher.TableNames)**
              Table names the rule is applied to.
              Includes only one of the fields `nameRegexp`, `names`.
            $ref: '#/definitions/TableNames'
        oneOf:
          - required:
              - nameRegexp
          - required:
              - names
      Column:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Column name.
              The maximum string length in characters is 63. Value must match the regular expression ` [a-z0-9_-]+ `.
            pattern: '[a-z0-9_-]+'
            type: string
          access:
            description: |-
              **enum** (AccessMode)
              Required field. Column access mode.
              - `NONE`: Access to column is denied.
              - `ALL`: Access to column is allowed.
            type: string
            enum:
              - ACCESS_MODE_UNSPECIFIED
              - NONE
              - ALL
          mask:
            description: |-
              **string**
              SQL expression mask to evaluate instead of original column values.
              Mask should have the same type as original column.
              The maximum string length in characters is 128.
            type: string
        required:
          - name
          - access
      TableAccessRule:
        type: object
        properties:
          users:
            description: |-
              **string**
              IAM user IDs the rule is applied to.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          groups:
            description: |-
              **string**
              IAM group IDs the rule is applied to.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          catalog:
            description: |-
              **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**
              Catalog matcher specifying what catalogs the rule is applied to.
            $ref: '#/definitions/CatalogAccessRuleMatcher'
          schema:
            description: |-
              **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**
              Schema matcher specifying what schemas the rule is applied to.
            $ref: '#/definitions/SchemaAccessRuleMatcher'
          table:
            description: |-
              **[TableAccessRuleMatcher](#yandex.cloud.trino.v1.TableAccessRuleMatcher)**
              Table matcher specifying what tables the rule is applied to.
            $ref: '#/definitions/TableAccessRuleMatcher'
          privileges:
            description: |-
              **enum** (Privilege)
              Permission granted by the rule.
              - `SELECT`: Allows SELECT statements on the table.
              - `INSERT`: Allows INSERT statements on the table.
              - `DELETE`: Allows DELETE statements on the table.
              - `UPDATE`: Allows UPDATE statements on the table.
              - `OWNERSHIP`: Allows CREATE, DROP, COMMENT ON and ALTER statements on the table.
              - `GRANT_SELECT`: Allows SELECT statements on the table while creating view.
            uniqueItems: true
            type: array
            items:
              type: string
              enum:
                - PRIVILEGE_UNSPECIFIED
                - SELECT
                - INSERT
                - DELETE
                - UPDATE
                - OWNERSHIP
                - GRANT_SELECT
          columns:
            description: |-
              **[Column](#yandex.cloud.trino.v1.TableAccessRule.Column)**
              Column rules.
            type: array
            items:
              $ref: '#/definitions/Column'
          filter:
            description: |-
              **string**
              Boolean SQL expression to filter table rows for particular user.
              The maximum string length in characters is 128.
            type: string
          description:
            description: |-
              **string**
              Rule description.
              The maximum string length in characters is 128.
            type: string
      FunctionNames:
        type: object
        properties:
          any:
            description: |-
              **string**
              List of function names. The rule will be applied if a function name is within this list.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-z0-9_-]+ `. The maximum number of elements is 128.
            pattern: '[a-z0-9_-]+'
            uniqueItems: true
            type: array
            items:
              type: string
      FunctionAccessRuleMatcher:
        type: object
        properties:
          nameRegexp:
            description: |-
              **string**
              Function name regexp the rule is applied to.
              The maximum string length in characters is 256.
              Includes only one of the fields `nameRegexp`, `names`.
            type: string
          names:
            description: |-
              **[FunctionNames](#yandex.cloud.trino.v1.FunctionAccessRuleMatcher.FunctionNames)**
              Function names the rule is applied to.
              Includes only one of the fields `nameRegexp`, `names`.
            $ref: '#/definitions/FunctionNames'
        oneOf:
          - required:
              - nameRegexp
          - required:
              - names
      FunctionAccessRule:
        type: object
        properties:
          users:
            description: |-
              **string**
              IAM user IDs the rule is applied to.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          groups:
            description: |-
              **string**
              IAM group IDs the rule is applied to.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          catalog:
            description: |-
              **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**
              Catalog matcher specifying what catalogs the rule is applied to.
            $ref: '#/definitions/CatalogAccessRuleMatcher'
          schema:
            description: |-
              **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**
              Schema matcher specifying what schema the rule is applied to.
            $ref: '#/definitions/SchemaAccessRuleMatcher'
          function:
            description: |-
              **[FunctionAccessRuleMatcher](#yandex.cloud.trino.v1.FunctionAccessRuleMatcher)**
              Function matcher specifying what functions the rule is applied to.
            $ref: '#/definitions/FunctionAccessRuleMatcher'
          privileges:
            description: |-
              **enum** (Privilege)
              Privileges granted by the rule.
              - `SELECT`: Allows SELECT statements on the table.
              - `INSERT`: Allows INSERT statements on the table.
              - `DELETE`: Allows DELETE statements on the table.
              - `UPDATE`: Allows UPDATE statements on the table.
              - `OWNERSHIP`: Allows CREATE, DROP, COMMENT ON and ALTER statements on the table.
              - `GRANT_SELECT`: Allows SELECT statements on the table while creating view.
            uniqueItems: true
            type: array
            items:
              type: string
              enum:
                - PRIVILEGE_UNSPECIFIED
                - SELECT
                - INSERT
                - DELETE
                - UPDATE
                - OWNERSHIP
                - GRANT_SELECT
          description:
            description: |-
              **string**
              Rule description.
              The maximum string length in characters is 128.
            type: string
      ProcedureNames:
        type: object
        properties:
          any:
            description: |-
              **string**
              List of procedure names. The rule will be applied if a procedure name is within this list.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-z0-9_-]+ `. The maximum number of elements is 128.
            pattern: '[a-z0-9_-]+'
            uniqueItems: true
            type: array
            items:
              type: string
      ProcedureAccessRuleMatcher:
        type: object
        properties:
          nameRegexp:
            description: |-
              **string**
              Procedure name regexp the rule is applied to.
              The maximum string length in characters is 256.
              Includes only one of the fields `nameRegexp`, `names`.
            type: string
          names:
            description: |-
              **[ProcedureNames](#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher.ProcedureNames)**
              Procedure names the rule is applied to.
              Includes only one of the fields `nameRegexp`, `names`.
            $ref: '#/definitions/ProcedureNames'
        oneOf:
          - required:
              - nameRegexp
          - required:
              - names
      ProcedureAccessRule:
        type: object
        properties:
          users:
            description: |-
              **string**
              IAM user IDs the rule is applied to.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          groups:
            description: |-
              **string**
              IAM group IDs the rule is applied to.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          catalog:
            description: |-
              **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**
              Catalog matcher specifying what catalogs the rule is applied to.
            $ref: '#/definitions/CatalogAccessRuleMatcher'
          schema:
            description: |-
              **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**
              Schema matcher specifying what schema the rule is applied to.
            $ref: '#/definitions/SchemaAccessRuleMatcher'
          procedure:
            description: |-
              **[ProcedureAccessRuleMatcher](#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher)**
              Procedure matcher specifying what functions the rule is applied to.
            $ref: '#/definitions/ProcedureAccessRuleMatcher'
          privileges:
            description: |-
              **enum** (Privilege)
              Privileges granted by the rule.
              - `SELECT`: Allows SELECT statements on the table.
              - `INSERT`: Allows INSERT statements on the table.
              - `DELETE`: Allows DELETE statements on the table.
              - `UPDATE`: Allows UPDATE statements on the table.
              - `OWNERSHIP`: Allows CREATE, DROP, COMMENT ON and ALTER statements on the table.
              - `GRANT_SELECT`: Allows SELECT statements on the table while creating view.
            uniqueItems: true
            type: array
            items:
              type: string
              enum:
                - PRIVILEGE_UNSPECIFIED
                - SELECT
                - INSERT
                - DELETE
                - UPDATE
                - OWNERSHIP
                - GRANT_SELECT
          description:
            description: |-
              **string**
              Rule description.
              The maximum string length in characters is 128.
            type: string
      QueryAccessRule:
        type: object
        properties:
          users:
            description: |-
              **string**
              IAM user IDs the rule is applied to.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          groups:
            description: |-
              **string**
              IAM group IDs the rule is applied to.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          queryOwners:
            description: |-
              **string**
              Owners of queries the rule is applied to.
              Cannot be combined with EXECUTE privilege.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          privileges:
            description: |-
              **enum** (Privilege)
              Privileges granted by the user.
              - `SELECT`: Allows SELECT statements on the table.
              - `INSERT`: Allows INSERT statements on the table.
              - `DELETE`: Allows DELETE statements on the table.
              - `UPDATE`: Allows UPDATE statements on the table.
              - `OWNERSHIP`: Allows CREATE, DROP, COMMENT ON and ALTER statements on the table.
              - `GRANT_SELECT`: Allows SELECT statements on the table while creating view.
            uniqueItems: true
            type: array
            items:
              type: string
              enum:
                - PRIVILEGE_UNSPECIFIED
                - SELECT
                - INSERT
                - DELETE
                - UPDATE
                - OWNERSHIP
                - GRANT_SELECT
          description:
            description: |-
              **string**
              Rule description.
              The maximum string length in characters is 128.
            type: string
      PropertyNames:
        type: object
        properties:
          any:
            description: |-
              **string**
              List of property names. The rule will be applied if a property name is within this list.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-z_]+ `. The maximum number of elements is 128.
            pattern: '[a-z_]+'
            uniqueItems: true
            type: array
            items:
              type: string
      PropertyAccessRuleMatcher:
        type: object
        properties:
          nameRegexp:
            description: |-
              **string**
              Property name regexp the rule is applied to.
              The maximum string length in characters is 256.
              Includes only one of the fields `nameRegexp`, `names`.
            type: string
          names:
            description: |-
              **[PropertyNames](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher.PropertyNames)**
              Property names the rule is applied to.
              Includes only one of the fields `nameRegexp`, `names`.
            $ref: '#/definitions/PropertyNames'
        oneOf:
          - required:
              - nameRegexp
          - required:
              - names
      SystemSessionPropertyAccessRule:
        type: object
        properties:
          users:
            description: |-
              **string**
              IAM user IDs the rule is applied to.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          groups:
            description: |-
              **string**
              IAM group IDs the rule is applied to.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          property:
            description: |-
              **[PropertyAccessRuleMatcher](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher)**
              Property matcher specifying what properties the rule is applied to.
            $ref: '#/definitions/PropertyAccessRuleMatcher'
          allow:
            description: |-
              **enum** (Allow)
              Required field. Whether the rule allows setting the property.
              - `NO`: Denies setting the system session property.
              - `YES`: Allows to set the system session property.
            type: string
            enum:
              - ALLOW_UNSPECIFIED
              - 'NO'
              - 'YES'
          description:
            description: |-
              **string**
              Rule description.
              The maximum string length in characters is 128.
            type: string
        required:
          - allow
      CatalogSessionPropertyAccessRule:
        type: object
        properties:
          users:
            description: |-
              **string**
              IAM user IDs the rule is applied to.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          groups:
            description: |-
              **string**
              IAM group IDs the rule is applied to.
              The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          catalog:
            description: |-
              **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**
              Catalog matcher specifying what catalogs the rule is applied to.
            $ref: '#/definitions/CatalogAccessRuleMatcher'
          property:
            description: |-
              **[PropertyAccessRuleMatcher](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher)**
              Property matcher specifying what properties the rule is applied to.
            $ref: '#/definitions/PropertyAccessRuleMatcher'
          allow:
            description: |-
              **enum** (Allow)
              Required field. Whether the rule allows setting the property.
              - `NO`: Denies setting the system session property.
              - `YES`: Allows to set the system session property.
            type: string
            enum:
              - ALLOW_UNSPECIFIED
              - 'NO'
              - 'YES'
          description:
            description: |-
              **string**
              Rule description.
              The maximum string length in characters is 128.
            type: string
        required:
          - allow
      AccessControlConfig:
        type: object
        properties:
          catalogs:
            description: |-
              **[CatalogAccessRule](#yandex.cloud.trino.v1.CatalogAccessRule)**
              Catalog access control rules.
            type: array
            items:
              $ref: '#/definitions/CatalogAccessRule'
          schemas:
            description: |-
              **[SchemaAccessRule](#yandex.cloud.trino.v1.SchemaAccessRule)**
              Schema access control rules.
            type: array
            items:
              $ref: '#/definitions/SchemaAccessRule'
          tables:
            description: |-
              **[TableAccessRule](#yandex.cloud.trino.v1.TableAccessRule)**
              Table access control rules.
            type: array
            items:
              $ref: '#/definitions/TableAccessRule'
          functions:
            description: |-
              **[FunctionAccessRule](#yandex.cloud.trino.v1.FunctionAccessRule)**
              Function access control rules.
            type: array
            items:
              $ref: '#/definitions/FunctionAccessRule'
          procedures:
            description: |-
              **[ProcedureAccessRule](#yandex.cloud.trino.v1.ProcedureAccessRule)**
              Procedures access control rules.
            type: array
            items:
              $ref: '#/definitions/ProcedureAccessRule'
          queries:
            description: |-
              **[QueryAccessRule](#yandex.cloud.trino.v1.QueryAccessRule)**
              Queries access control rules.
            type: array
            items:
              $ref: '#/definitions/QueryAccessRule'
          systemSessionProperties:
            description: |-
              **[SystemSessionPropertyAccessRule](#yandex.cloud.trino.v1.SystemSessionPropertyAccessRule)**
              System session property access control rules.
            type: array
            items:
              $ref: '#/definitions/SystemSessionPropertyAccessRule'
          catalogSessionProperties:
            description: |-
              **[CatalogSessionPropertyAccessRule](#yandex.cloud.trino.v1.CatalogSessionPropertyAccessRule)**
              Catalog session property access control rules.
            type: array
            items:
              $ref: '#/definitions/CatalogSessionPropertyAccessRule'
      ResourceGroupConfig:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Resource group name.
            type: string
          maxQueued:
            description: |-
              **string** (int64)
              Maximum number of queued queries.
              Value must be greater than 0.
            type: string
            format: int64
          softConcurrencyLimit:
            description: |-
              **string** (int64)
              Number of concurrently running queries after which new queries only run if peer groups are below soft limits.
            type: string
            format: int64
          hardConcurrencyLimit:
            description: |-
              **string** (int64)
              Maximum number of queries that can run concurrently.
              Value must be greater than 0.
            type: string
            format: int64
          softMemoryLimit:
            description: |-
              **string**
              Maximum amount of distributed memory this group can use.
            type: string
          softCpuLimit:
            description: |-
              **string**
              Maximum CPU time per period this group can use before applying penalty to running queries (requires hard_cpu_limit).
            type: string
          hardCpuLimit:
            description: |-
              **string**
              Maximum CPU time per period this group can use.
            type: string
          schedulingPolicy:
            description: |-
              **enum** (SchedulingPolicy)
              Policy for selecting queued queries and sub-group eligibility.
              - `FAIR`: Queued queries processed first-in-first-out, sub-groups take turns starting queries.
              - `WEIGHTED`: Queries selected stochastically by priority, sub-groups selected by schedulingWeight.
              - `WEIGHTED_FAIR`: Sub-groups selected by schedulingWeight and concurrency relative to their share.
              - `QUERY_PRIORITY`: Queued queries selected strictly by priority.
            type: string
            enum:
              - SCHEDULING_POLICY_UNSPECIFIED
              - FAIR
              - WEIGHTED
              - WEIGHTED_FAIR
              - QUERY_PRIORITY
          schedulingWeight:
            description: |-
              **string** (int64)
              Weight for weighted and weighted_fair scheduling policies.
            type: string
            format: int64
          subGroups:
            description: |-
              **[ResourceGroupConfig](#yandex.cloud.trino.v1.ResourceGroupConfig)**
              List of sub-groups.
            type: array
            items:
              $ref: '#/definitions/ResourceGroupConfig'
        required:
          - name
      SelectorRuleConfig:
        type: object
        properties:
          user:
            description: |-
              **string**
              Regex to match against username.
            type: string
          userGroup:
            description: |-
              **string**
              Regex to match against user groups.
            type: string
          source:
            description: |-
              **string**
              Regex to match against query source.
            type: string
          queryType:
            description: |-
              **enum** (QueryType)
              Type of query to match.
              - `SELECT`: SELECT query.
              - `EXPLAIN`: EXPLAIN query.
              - `DESCRIBE`: DESCRIBE query.
              - `INSERT`: INSERT query.
              - `UPDATE`: UPDATE query.
              - `MERGE`: MERGE query.
              - `DELETE`: DELECT query.
              - `ANALYZE`: ANALYZE query.
              - `DATA_DEFINITION`: Data definition query.
              - `ALTER_TABLE_EXECUTE`: ALTER TABLE EXECUTE query.
            type: string
            enum:
              - QUERY_TYPE_UNSPECIFIED
              - SELECT
              - EXPLAIN
              - DESCRIBE
              - INSERT
              - UPDATE
              - MERGE
              - DELETE
              - ANALYZE
              - DATA_DEFINITION
              - ALTER_TABLE_EXECUTE
          clientTags:
            description: |-
              **string**
              Tags that must all be present in the query's client tags.
            type: array
            items:
              type: string
          group:
            description: |-
              **string**
              Required field. Target resource group name.
            type: string
        required:
          - group
      ResourceGroupsConfig:
        type: object
        properties:
          rootGroups:
            description: |-
              **[ResourceGroupConfig](#yandex.cloud.trino.v1.ResourceGroupConfig)**
              Root resource groups configuration.
              The number of elements must be greater than 0.
            type: array
            items:
              $ref: '#/definitions/ResourceGroupConfig'
          selectors:
            description: |-
              **[SelectorRuleConfig](#yandex.cloud.trino.v1.SelectorRuleConfig)**
              Selector rules for routing queries to resource groups.
              The number of elements must be greater than 0.
            type: array
            items:
              $ref: '#/definitions/SelectorRuleConfig'
          cpuQuotaPeriod:
            description: |-
              **string**
              Period for CPU quota calculations.
            type: string
      QueryConfig:
        type: object
        properties:
          properties:
            description: |-
              **object** (map<**string**, **string**>)
              Query properties.
            type: object
            additionalProperties:
              type: string
      ResourceManagementConfig:
        type: object
        properties:
          resourceGroups:
            description: |-
              **[ResourceGroupsConfig](#yandex.cloud.trino.v1.ResourceGroupsConfig)**
              Resource groups configuration.
            $ref: '#/definitions/ResourceGroupsConfig'
          query:
            description: |-
              **[QueryConfig](#yandex.cloud.trino.v1.QueryConfig)**
              Query management confiugration.
            $ref: '#/definitions/QueryConfig'
      TLSConfig:
        type: object
        properties:
          trustedCertificates:
            description: |-
              **string**
              Trusted CA-certificates. Each element should contain single self-signed CA-certificate or
              chain of CA-certificates where first certificate is the leaf and last certificate is the self-signed root.
              The maximum string length in characters for each value is 8192. The maximum number of elements is 8.
            uniqueItems: true
            type: array
            items:
              type: string
      TrinoConfigSpec:
        type: object
        properties:
          catalogs:
            description: |-
              **[CatalogSpec](#yandex.cloud.trino.v1.CatalogSpec)**
              List of catalogs that enable integration with various data sources.
              Each catalog defines a connection to an external data source that Trino can query.
            type: array
            items:
              $ref: '#/definitions/CatalogSpec'
          coordinatorConfig:
            description: |-
              **[CoordinatorConfig](#yandex.cloud.trino.v1.CoordinatorConfig)**
              Required field. Configuration for the coordinator, specifying computational resources and other settings.
            $ref: '#/definitions/CoordinatorConfig'
          workerConfig:
            description: |-
              **[WorkerConfig](#yandex.cloud.trino.v1.WorkerConfig)**
              Required field. Configuration for worker nodes, including scaling policy and computational resources.
            $ref: '#/definitions/WorkerConfig'
          retryPolicy:
            description: |-
              **[RetryPolicyConfig](#yandex.cloud.trino.v1.RetryPolicyConfig)**
              Configuration for retry policy, specifying the spooling storage destination and other settings.
            $ref: '#/definitions/RetryPolicyConfig'
          version:
            description: |-
              **string**
              Trino version.
              Format: "Number".
            type: string
          accessControl:
            description: |-
              **[AccessControlConfig](#yandex.cloud.trino.v1.AccessControlConfig)**
              Configuration for access control, specifying the fine-grained access rules.
            $ref: '#/definitions/AccessControlConfig'
          resourceManagement:
            description: |-
              **[ResourceManagementConfig](#yandex.cloud.trino.v1.ResourceManagementConfig)**
              Configuration for cluster resource management, specifying the resource groups.
            $ref: '#/definitions/ResourceManagementConfig'
          tls:
            description: |-
              **[TLSConfig](#yandex.cloud.trino.v1.TLSConfig)**
              Configuration for TLS.
            $ref: '#/definitions/TLSConfig'
        required:
          - coordinatorConfig
          - workerConfig
      PrivateAccessConfig:
        type: object
        properties:
          enabled:
            description: |-
              **boolean**
              Enables access to the cluster only via private endpoint.
            type: boolean
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
          privateAccess:
            description: |-
              **[PrivateAccessConfig](#yandex.cloud.trino.v1.PrivateAccessConfig)**
              Private link configuration for secure connectivity to the cluster.
            $ref: '#/definitions/PrivateAccessConfig'
      LoggingConfig:
        type: object
        properties:
          folderId:
            description: |-
              **string**
              Logs should be written to default log group for specified folder.
              Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
              Includes only one of the fields `folderId`, `logGroupId`.
              Destination of log records.
            pattern: ([a-zA-Z][-a-zA-Z0-9_.]{0,63})?
            type: string
          logGroupId:
            description: |-
              **string**
              Logs should be written to log group resolved by ID.
              Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
              Includes only one of the fields `folderId`, `logGroupId`.
              Destination of log records.
            pattern: ([a-zA-Z][-a-zA-Z0-9_.]{0,63})?
            type: string
          enabled:
            description: |-
              **boolean**
              Logs generated by the Trino components are delivered to Cloud Logging.
            type: boolean
          minLevel:
            description: |-
              **enum** (Level)
              Minimum log entry level.
              See [LogLevel.Level](/docs/logging/api-ref/Export/get#yandex.cloud.logging.v1.LogLevel.Level) for details.
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
              May be used to alert about unrecoverable failures and events.
            type: string
            enum:
              - LEVEL_UNSPECIFIED
              - TRACE
              - DEBUG
              - INFO
              - WARN
              - ERROR
              - FATAL
        oneOf:
          - required:
              - folderId
          - required:
              - logGroupId
      AnytimeMaintenanceWindow:
        type: object
        properties: {}
      WeeklyMaintenanceWindow:
        type: object
        properties:
          day:
            description: |-
              **enum** (WeekDay)
              Day of the week when maintenance can occur.
              - `MON`: Monday.
              - `TUE`: Tuesday.
              - `WED`: Wednesday.
              - `THU`: Thursday.
              - `FRI`: Friday.
              - `SAT`: Saturday.
              - `SUN`: Sunday.
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
              Hour of the day in UTC when the maintenance window starts.
              Acceptable values are 1 to 24, inclusive.
            type: string
            format: int64
      MaintenanceWindow:
        type: object
        properties:
          anytime:
            description: |-
              **object**
              The cluster may be restarted for maintenance at any time.
              Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
            $ref: '#/definitions/AnytimeMaintenanceWindow'
          weeklyMaintenanceWindow:
            description: |-
              **[WeeklyMaintenanceWindow](#yandex.cloud.trino.v1.WeeklyMaintenanceWindow)**
              Maintenance is allowed only within the specified weekly window.
              Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
            $ref: '#/definitions/WeeklyMaintenanceWindow'
        oneOf:
          - required:
              - anytime
          - required:
              - weeklyMaintenanceWindow
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
          // Includes only one of the fields `hive`, `iceberg`, `deltaLake`, `postgresql`, `clickhouse`, `tpch`, `tpcds`, `oracle`, `sqlserver`, `hudi`, `mysql`, `greenplum`
          "hive": {
            "metastore": {
              // Includes only one of the fields `hive`, `rest`
              "hive": {
                // Includes only one of the fields `uri`, `managedClusterId`
                "uri": "string",
                "managedClusterId": "string",
                // end of the list of possible fields
                "protocol": {
                  // Includes only one of the fields `thrift`, `rest`
                  "thrift": "object",
                  "rest": "object"
                  // end of the list of possible fields
                }
              },
              "rest": {
                "uri": "string",
                "authorization": {
                  // Includes only one of the fields `none`
                  "none": "object"
                  // end of the list of possible fields
                }
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
              // Includes only one of the fields `hive`, `rest`
              "hive": {
                // Includes only one of the fields `uri`, `managedClusterId`
                "uri": "string",
                "managedClusterId": "string",
                // end of the list of possible fields
                "protocol": {
                  // Includes only one of the fields `thrift`, `rest`
                  "thrift": "object",
                  "rest": "object"
                  // end of the list of possible fields
                }
              },
              "rest": {
                "uri": "string",
                "authorization": {
                  // Includes only one of the fields `none`
                  "none": "object"
                  // end of the list of possible fields
                }
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
              // Includes only one of the fields `hive`, `rest`
              "hive": {
                // Includes only one of the fields `uri`, `managedClusterId`
                "uri": "string",
                "managedClusterId": "string",
                // end of the list of possible fields
                "protocol": {
                  // Includes only one of the fields `thrift`, `rest`
                  "thrift": "object",
                  "rest": "object"
                  // end of the list of possible fields
                }
              },
              "rest": {
                "uri": "string",
                "authorization": {
                  // Includes only one of the fields `none`
                  "none": "object"
                  // end of the list of possible fields
                }
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
              // Includes only one of the fields `hive`, `rest`
              "hive": {
                // Includes only one of the fields `uri`, `managedClusterId`
                "uri": "string",
                "managedClusterId": "string",
                // end of the list of possible fields
                "protocol": {
                  // Includes only one of the fields `thrift`, `rest`
                  "thrift": "object",
                  "rest": "object"
                  // end of the list of possible fields
                }
              },
              "rest": {
                "uri": "string",
                "authorization": {
                  // Includes only one of the fields `none`
                  "none": "object"
                  // end of the list of possible fields
                }
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
          // Includes only one of the fields `serviceS3`, `s3`
          "serviceS3": "object",
          "s3": {
            "bucket": "string"
          }
          // end of the list of possible fields
        }
      },
      "additionalProperties": "object"
    },
    "version": "string",
    "accessControl": {
      "catalogs": [
        {
          "users": [
            "string"
          ],
          "groups": [
            "string"
          ],
          "catalog": {
            // Includes only one of the fields `nameRegexp`, `ids`, `names`
            "nameRegexp": "string",
            "ids": {
              "any": [
                "string"
              ]
            },
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "permission": "string",
          "description": "string"
        }
      ],
      "schemas": [
        {
          "users": [
            "string"
          ],
          "groups": [
            "string"
          ],
          "catalog": {
            // Includes only one of the fields `nameRegexp`, `ids`, `names`
            "nameRegexp": "string",
            "ids": {
              "any": [
                "string"
              ]
            },
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "schema": {
            // Includes only one of the fields `nameRegexp`, `names`
            "nameRegexp": "string",
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "owner": "string",
          "description": "string"
        }
      ],
      "tables": [
        {
          "users": [
            "string"
          ],
          "groups": [
            "string"
          ],
          "catalog": {
            // Includes only one of the fields `nameRegexp`, `ids`, `names`
            "nameRegexp": "string",
            "ids": {
              "any": [
                "string"
              ]
            },
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "schema": {
            // Includes only one of the fields `nameRegexp`, `names`
            "nameRegexp": "string",
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "table": {
            // Includes only one of the fields `nameRegexp`, `names`
            "nameRegexp": "string",
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "privileges": [
            "string"
          ],
          "columns": [
            {
              "name": "string",
              "access": "string",
              "mask": "string"
            }
          ],
          "filter": "string",
          "description": "string"
        }
      ],
      "functions": [
        {
          "users": [
            "string"
          ],
          "groups": [
            "string"
          ],
          "catalog": {
            // Includes only one of the fields `nameRegexp`, `ids`, `names`
            "nameRegexp": "string",
            "ids": {
              "any": [
                "string"
              ]
            },
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "schema": {
            // Includes only one of the fields `nameRegexp`, `names`
            "nameRegexp": "string",
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "function": {
            // Includes only one of the fields `nameRegexp`, `names`
            "nameRegexp": "string",
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "privileges": [
            "string"
          ],
          "description": "string"
        }
      ],
      "procedures": [
        {
          "users": [
            "string"
          ],
          "groups": [
            "string"
          ],
          "catalog": {
            // Includes only one of the fields `nameRegexp`, `ids`, `names`
            "nameRegexp": "string",
            "ids": {
              "any": [
                "string"
              ]
            },
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "schema": {
            // Includes only one of the fields `nameRegexp`, `names`
            "nameRegexp": "string",
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "procedure": {
            // Includes only one of the fields `nameRegexp`, `names`
            "nameRegexp": "string",
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "privileges": [
            "string"
          ],
          "description": "string"
        }
      ],
      "queries": [
        {
          "users": [
            "string"
          ],
          "groups": [
            "string"
          ],
          "queryOwners": [
            "string"
          ],
          "privileges": [
            "string"
          ],
          "description": "string"
        }
      ],
      "systemSessionProperties": [
        {
          "users": [
            "string"
          ],
          "groups": [
            "string"
          ],
          "property": {
            // Includes only one of the fields `nameRegexp`, `names`
            "nameRegexp": "string",
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "allow": "string",
          "description": "string"
        }
      ],
      "catalogSessionProperties": [
        {
          "users": [
            "string"
          ],
          "groups": [
            "string"
          ],
          "catalog": {
            // Includes only one of the fields `nameRegexp`, `ids`, `names`
            "nameRegexp": "string",
            "ids": {
              "any": [
                "string"
              ]
            },
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "property": {
            // Includes only one of the fields `nameRegexp`, `names`
            "nameRegexp": "string",
            "names": {
              "any": [
                "string"
              ]
            }
            // end of the list of possible fields
          },
          "allow": "string",
          "description": "string"
        }
      ]
    },
    "resourceManagement": {
      "resourceGroups": {
        "rootGroups": [
          {
            "name": "string",
            "maxQueued": "string",
            "softConcurrencyLimit": "string",
            "hardConcurrencyLimit": "string",
            "softMemoryLimit": "string",
            "softCpuLimit": "string",
            "hardCpuLimit": "string",
            "schedulingPolicy": "string",
            "schedulingWeight": "string",
            "subGroups": [
              "object"
            ]
          }
        ],
        "selectors": [
          {
            "user": "string",
            "userGroup": "string",
            "source": "string",
            "queryType": "string",
            "clientTags": [
              "string"
            ],
            "group": "string"
          }
        ],
        "cpuQuotaPeriod": "string"
      },
      "query": {
        "properties": "object"
      }
    },
    "tls": {
      "trustedCertificates": [
        "string"
      ]
    }
  },
  "network": {
    "subnetIds": [
      "string"
    ],
    "securityGroupIds": [
      "string"
    ],
    "privateAccess": {
      "enabled": "boolean"
    }
  },
  "deletionProtection": "boolean",
  "serviceAccountId": "string",
  "logging": {
    // Includes only one of the fields `folderId`, `logGroupId`
    "folderId": "string",
    "logGroupId": "string",
    // end of the list of possible fields
    "enabled": "boolean",
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

Required field. ID of the folder to create Trino cluster in.

The maximum string length in characters is 50. ||
|| name | **string**

Required field. Name of the Trino cluster. The name must be unique within the folder.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| description | **string**

Description of the Trino cluster.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the Trino cluster as `` key:value `` pairs.
For example: {"env": "prod"}.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| trino | **[TrinoConfigSpec](#yandex.cloud.trino.v1.TrinoConfigSpec)**

Required field. Configuration of Trino components. ||
|| network | **[NetworkConfig](#yandex.cloud.trino.v1.NetworkConfig)**

Required field. Network related configuration options. ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster. ||
|| serviceAccountId | **string**

Required field. Service account used to access Cloud resources.

The maximum string length in characters is 50. ||
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
|| accessControl | **[AccessControlConfig](#yandex.cloud.trino.v1.AccessControlConfig)**

Configuration for access control, specifying the fine-grained access rules. ||
|| resourceManagement | **[ResourceManagementConfig](#yandex.cloud.trino.v1.ResourceManagementConfig)**

Configuration for cluster resource management, specifying the resource groups. ||
|| tls | **[TLSConfig](#yandex.cloud.trino.v1.TLSConfig)**

Configuration for TLS. ||
|#

## CatalogSpec {#yandex.cloud.trino.v1.CatalogSpec}

CatalogSpec defines the desired state of a new catalog.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the catalog.
Must be unique within a Trino cluster.

The maximum string length in characters is 63. Value must match the regular expression ` [a-z]([a-z0-9_-]*[a-z0-9])? `. ||
|| connector | **[Connector](#yandex.cloud.trino.v1.Connector)**

Required field. Connector backing this catalog. ||
|| description | **string**

Description of the catalog.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Labels associated with the catalog.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
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

The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource. ||
|#

## Metastore {#yandex.cloud.trino.v1.Metastore}

Metastore configuration.

#|
||Field | Description ||
|| hive | **[HiveMetastore](#yandex.cloud.trino.v1.Metastore.HiveMetastore)**

Apache Hive Metastore.

Includes only one of the fields `hive`, `rest`. ||
|| rest | **[RestMetastore](#yandex.cloud.trino.v1.Metastore.RestMetastore)**

Iceberg REST Catalog compatible Metastore.

Includes only one of the fields `hive`, `rest`. ||
|#

## HiveMetastore {#yandex.cloud.trino.v1.Metastore.HiveMetastore}

Configuration of Hive's metastore type.

#|
||Field | Description ||
|| uri | **string**

URI of the Hive Metastore.

Includes only one of the fields `uri`, `managedClusterId`. ||
|| managedClusterId | **string**

ID of the Managed Hive Metastore cluster.

Includes only one of the fields `uri`, `managedClusterId`. ||
|| protocol | **[Protocol](#yandex.cloud.trino.v1.Metastore.HiveMetastore.Protocol)**

Hive metastore client protocol. If null, thrift protocol will be used. ||
|#

## Protocol {#yandex.cloud.trino.v1.Metastore.HiveMetastore.Protocol}

Hive Metastore client protocol configuration.

#|
||Field | Description ||
|| thrift | **object**

Thrift client protocol.

Includes only one of the fields `thrift`, `rest`. ||
|| rest | **object**

Iceberg REST client protocol.

Includes only one of the fields `thrift`, `rest`. ||
|#

## RestMetastore {#yandex.cloud.trino.v1.Metastore.RestMetastore}

Configuration of Iceberg REST Catalog compatible metastore type.

#|
||Field | Description ||
|| uri | **string**

URI of the REST Catalog metastore. ||
|| authorization | **[Authorization](#yandex.cloud.trino.v1.Metastore.RestMetastore.Authorization)**

Authorization properties. ||
|#

## Authorization {#yandex.cloud.trino.v1.Metastore.RestMetastore.Authorization}

#|
||Field | Description ||
|| none | **object**

Disabled authorization

Includes only one of the fields `none`. ||
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

Required field. AWS endpoint.

Value must match the regular expression ` ^https?://.+$ `. ||
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

The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource. ||
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

The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource. ||
|#

## PostgresqlConnector {#yandex.cloud.trino.v1.PostgresqlConnector}

#|
||Field | Description ||
|| connection | **[PostgresqlConnection](#yandex.cloud.trino.v1.PostgresqlConnection)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource. ||
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

The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. No more than 256 per resource. ||
|#

## ClickhouseConnector {#yandex.cloud.trino.v1.ClickhouseConnector}

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.trino.v1.ClickhouseConnection)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource. ||
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

The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z_]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. No more than 256 per resource. ||
|#

## TPCHConnector {#yandex.cloud.trino.v1.TPCHConnector}

#|
||Field | Description ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource. ||
|#

## TPCDSConnector {#yandex.cloud.trino.v1.TPCDSConnector}

#|
||Field | Description ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource. ||
|#

## OracleConnector {#yandex.cloud.trino.v1.OracleConnector}

#|
||Field | Description ||
|| connection | **[OracleConnection](#yandex.cloud.trino.v1.OracleConnection)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource. ||
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

The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource. ||
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

The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource. ||
|#

## MysqlConnector {#yandex.cloud.trino.v1.MysqlConnector}

#|
||Field | Description ||
|| connection | **[MysqlConnection](#yandex.cloud.trino.v1.MysqlConnection)**

Connection configuration. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource. ||
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

The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z_]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. No more than 256 per resource. ||
|#

## GreenplumConnector {#yandex.cloud.trino.v1.GreenplumConnector}

#|
||Field | Description ||
|| connection | **[GreenplumConnection](#yandex.cloud.trino.v1.GreenplumConnection)**

Connection configuration ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource. ||
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

The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-zA-Z]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_]* `. No more than 256 per resource. ||
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

Required field. ID of the preset for computational resources allocated to a instance (e.g., CPU, memory, etc.).

The maximum string length in characters is 50. ||
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

Specifies the number of worker instances.

Acceptable values are 1 to 512, inclusive. ||
|#

## AutoScalePolicy {#yandex.cloud.trino.v1.AutoScalePolicy}

#|
||Field | Description ||
|| minCount | **string** (int64)

Minimum number of worker instances.

Acceptable values are 0 to 512, inclusive. ||
|| maxCount | **string** (int64)

Maximum number of worker instances.

Acceptable values are 1 to 512, inclusive. ||
|#

## RetryPolicyConfig {#yandex.cloud.trino.v1.RetryPolicyConfig}

#|
||Field | Description ||
|| policy | **enum** (RetryPolicy)

Retry policy level.

- `QUERY`: Retry policy for queries.
- `TASK`: Retry policy for tasks. ||
|| exchangeManager | **[ExchangeManagerConfig](#yandex.cloud.trino.v1.ExchangeManagerConfig)**

Configuration for exchange manager. ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource. ||
|#

## ExchangeManagerConfig {#yandex.cloud.trino.v1.ExchangeManagerConfig}

#|
||Field | Description ||
|| additionalProperties | **object** (map<**string**, **string**>)

Additional properties.

The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [a-z][-_0-9a-z.]* `. Each value must match the regular expression ` [-_0-9a-zA-Z.,:\/_ *]* `. No more than 256 per resource. ||
|| storage | **[ExchangeManagerStorage](#yandex.cloud.trino.v1.ExchangeManagerStorage)**

Storage for spooled data by exchange manager. ||
|#

## ExchangeManagerStorage {#yandex.cloud.trino.v1.ExchangeManagerStorage}

#|
||Field | Description ||
|| serviceS3 | **object**

Use a service side S3 bucket for exchange manager.

Includes only one of the fields `serviceS3`, `s3`. ||
|| s3 | **[S3](#yandex.cloud.trino.v1.ExchangeManagerStorage.S3)**

Use an S3 bucket for exchange manager.

Includes only one of the fields `serviceS3`, `s3`. ||
|#

## S3 {#yandex.cloud.trino.v1.ExchangeManagerStorage.S3}

#|
||Field | Description ||
|| bucket | **string**

Required field. Name of the bucket to be used as the spool destination for exchange manager. ||
|#

## AccessControlConfig {#yandex.cloud.trino.v1.AccessControlConfig}

#|
||Field | Description ||
|| catalogs[] | **[CatalogAccessRule](#yandex.cloud.trino.v1.CatalogAccessRule)**

Catalog access control rules. ||
|| schemas[] | **[SchemaAccessRule](#yandex.cloud.trino.v1.SchemaAccessRule)**

Schema access control rules. ||
|| tables[] | **[TableAccessRule](#yandex.cloud.trino.v1.TableAccessRule)**

Table access control rules. ||
|| functions[] | **[FunctionAccessRule](#yandex.cloud.trino.v1.FunctionAccessRule)**

Function access control rules. ||
|| procedures[] | **[ProcedureAccessRule](#yandex.cloud.trino.v1.ProcedureAccessRule)**

Procedures access control rules. ||
|| queries[] | **[QueryAccessRule](#yandex.cloud.trino.v1.QueryAccessRule)**

Queries access control rules. ||
|| systemSessionProperties[] | **[SystemSessionPropertyAccessRule](#yandex.cloud.trino.v1.SystemSessionPropertyAccessRule)**

System session property access control rules. ||
|| catalogSessionProperties[] | **[CatalogSessionPropertyAccessRule](#yandex.cloud.trino.v1.CatalogSessionPropertyAccessRule)**

Catalog session property access control rules. ||
|#

## CatalogAccessRule {#yandex.cloud.trino.v1.CatalogAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128. ||
|| groups[] | **string**

IAM group IDs the rule is applied to.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| permission | **enum** (Permission)

Required field. Permission granted by the rule.

- `NONE`: Denies all operations on the catalog entities.
- `ALL`: Allows all operations on catalog entities.
- `READ_ONLY`: Allows only read operations on catalog entities. ||
|| description | **string**

Rule description.

The maximum string length in characters is 128. ||
|#

## CatalogAccessRuleMatcher {#yandex.cloud.trino.v1.CatalogAccessRuleMatcher}

#|
||Field | Description ||
|| nameRegexp | **string**

Catalog name regexp the rule is applied to.

The maximum string length in characters is 256.

Includes only one of the fields `nameRegexp`, `ids`, `names`. ||
|| ids | **[CatalogIds](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogIds)**

Catalog IDs rule is applied to.

Includes only one of the fields `nameRegexp`, `ids`, `names`. ||
|| names | **[CatalogNames](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogNames)**

Catalog names rule is applied to.

Includes only one of the fields `nameRegexp`, `ids`, `names`. ||
|#

## CatalogIds {#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogIds}

#|
||Field | Description ||
|| any[] | **string**

List of table names. The rule will be applied if a table name is within this list.

The maximum string length in characters for each value is 63. The maximum number of elements is 128. ||
|#

## CatalogNames {#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogNames}

#|
||Field | Description ||
|| any[] | **string**

List of catalog names. The rule will be applied if a catalog name is within this list.

The maximum string length in characters for each value is 63. The maximum number of elements is 128. ||
|#

## SchemaAccessRule {#yandex.cloud.trino.v1.SchemaAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128. ||
|| groups[] | **string**

IAM group IDs the rule is applied to.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**

Schema matcher specifying what schemas the rule is applied to. ||
|| owner | **enum** (Owner)

Required field. Ownership granted by the rule.

- `NO`: User is not considered an owner of the schema.
- `YES`: User is considered an owner of the schema. ||
|| description | **string**

Rule description.

The maximum string length in characters is 128. ||
|#

## SchemaAccessRuleMatcher {#yandex.cloud.trino.v1.SchemaAccessRuleMatcher}

#|
||Field | Description ||
|| nameRegexp | **string**

Schema name regexp the rule is applied to.

The maximum string length in characters is 256.

Includes only one of the fields `nameRegexp`, `names`. ||
|| names | **[SchemaNames](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher.SchemaNames)**

Schema names the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|#

## SchemaNames {#yandex.cloud.trino.v1.SchemaAccessRuleMatcher.SchemaNames}

#|
||Field | Description ||
|| any[] | **string**

List of schema names. The rule will be applied if a schema name is within this list.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-z0-9_-]+ `. The maximum number of elements is 128. ||
|#

## TableAccessRule {#yandex.cloud.trino.v1.TableAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128. ||
|| groups[] | **string**

IAM group IDs the rule is applied to.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**

Schema matcher specifying what schemas the rule is applied to. ||
|| table | **[TableAccessRuleMatcher](#yandex.cloud.trino.v1.TableAccessRuleMatcher)**

Table matcher specifying what tables the rule is applied to. ||
|| privileges[] | **enum** (Privilege)

Permission granted by the rule.

- `SELECT`: Allows SELECT statements on the table.
- `INSERT`: Allows INSERT statements on the table.
- `DELETE`: Allows DELETE statements on the table.
- `UPDATE`: Allows UPDATE statements on the table.
- `OWNERSHIP`: Allows CREATE, DROP, COMMENT ON and ALTER statements on the table.
- `GRANT_SELECT`: Allows SELECT statements on the table while creating view. ||
|| columns[] | **[Column](#yandex.cloud.trino.v1.TableAccessRule.Column)**

Column rules. ||
|| filter | **string**

Boolean SQL expression to filter table rows for particular user.

The maximum string length in characters is 128. ||
|| description | **string**

Rule description.

The maximum string length in characters is 128. ||
|#

## TableAccessRuleMatcher {#yandex.cloud.trino.v1.TableAccessRuleMatcher}

#|
||Field | Description ||
|| nameRegexp | **string**

Table name regexp the rule is applied to.

The maximum string length in characters is 256.

Includes only one of the fields `nameRegexp`, `names`. ||
|| names | **[TableNames](#yandex.cloud.trino.v1.TableAccessRuleMatcher.TableNames)**

Table names the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|#

## TableNames {#yandex.cloud.trino.v1.TableAccessRuleMatcher.TableNames}

#|
||Field | Description ||
|| any[] | **string**

List of table names. The rule will be applied if a table name is within this list.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-z0-9_-]+ `. The maximum number of elements is 128. ||
|#

## Column {#yandex.cloud.trino.v1.TableAccessRule.Column}

#|
||Field | Description ||
|| name | **string**

Required field. Column name.

The maximum string length in characters is 63. Value must match the regular expression ` [a-z0-9_-]+ `. ||
|| access | **enum** (AccessMode)

Required field. Column access mode.

- `NONE`: Access to column is denied.
- `ALL`: Access to column is allowed. ||
|| mask | **string**

SQL expression mask to evaluate instead of original column values.
Mask should have the same type as original column.

The maximum string length in characters is 128. ||
|#

## FunctionAccessRule {#yandex.cloud.trino.v1.FunctionAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128. ||
|| groups[] | **string**

IAM group IDs the rule is applied to.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**

Schema matcher specifying what schema the rule is applied to. ||
|| function | **[FunctionAccessRuleMatcher](#yandex.cloud.trino.v1.FunctionAccessRuleMatcher)**

Function matcher specifying what functions the rule is applied to. ||
|| privileges[] | **enum** (Privilege)

Privileges granted by the rule.

- `EXECUTE`: Allows to execute the function.
- `GRANT_EXECUTE`: Allows to use the function while view creation.
- `OWNERSHIP`: Allows to CREATE and DROP the function. ||
|| description | **string**

Rule description.

The maximum string length in characters is 128. ||
|#

## FunctionAccessRuleMatcher {#yandex.cloud.trino.v1.FunctionAccessRuleMatcher}

#|
||Field | Description ||
|| nameRegexp | **string**

Function name regexp the rule is applied to.

The maximum string length in characters is 256.

Includes only one of the fields `nameRegexp`, `names`. ||
|| names | **[FunctionNames](#yandex.cloud.trino.v1.FunctionAccessRuleMatcher.FunctionNames)**

Function names the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|#

## FunctionNames {#yandex.cloud.trino.v1.FunctionAccessRuleMatcher.FunctionNames}

#|
||Field | Description ||
|| any[] | **string**

List of function names. The rule will be applied if a function name is within this list.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-z0-9_-]+ `. The maximum number of elements is 128. ||
|#

## ProcedureAccessRule {#yandex.cloud.trino.v1.ProcedureAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128. ||
|| groups[] | **string**

IAM group IDs the rule is applied to.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**

Schema matcher specifying what schema the rule is applied to. ||
|| procedure | **[ProcedureAccessRuleMatcher](#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher)**

Procedure matcher specifying what functions the rule is applied to. ||
|| privileges[] | **enum** (Privilege)

Privileges granted by the rule.

- `EXECUTE`: Allows to execute the procedure. ||
|| description | **string**

Rule description.

The maximum string length in characters is 128. ||
|#

## ProcedureAccessRuleMatcher {#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher}

#|
||Field | Description ||
|| nameRegexp | **string**

Procedure name regexp the rule is applied to.

The maximum string length in characters is 256.

Includes only one of the fields `nameRegexp`, `names`. ||
|| names | **[ProcedureNames](#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher.ProcedureNames)**

Procedure names the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|#

## ProcedureNames {#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher.ProcedureNames}

#|
||Field | Description ||
|| any[] | **string**

List of procedure names. The rule will be applied if a procedure name is within this list.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-z0-9_-]+ `. The maximum number of elements is 128. ||
|#

## QueryAccessRule {#yandex.cloud.trino.v1.QueryAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128. ||
|| groups[] | **string**

IAM group IDs the rule is applied to.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128. ||
|| queryOwners[] | **string**

Owners of queries the rule is applied to.
Cannot be combined with EXECUTE privilege.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128. ||
|| privileges[] | **enum** (Privilege)

Privileges granted by the user.

- `VIEW`: Allows to view the query.
- `EXECUTE`: Allows to execute the query.
- `KILL`: Allows to kill the query. ||
|| description | **string**

Rule description.

The maximum string length in characters is 128. ||
|#

## SystemSessionPropertyAccessRule {#yandex.cloud.trino.v1.SystemSessionPropertyAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128. ||
|| groups[] | **string**

IAM group IDs the rule is applied to.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128. ||
|| property | **[PropertyAccessRuleMatcher](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher)**

Property matcher specifying what properties the rule is applied to. ||
|| allow | **enum** (Allow)

Required field. Whether the rule allows setting the property.

- `NO`: Denies setting the system session property.
- `YES`: Allows to set the system session property. ||
|| description | **string**

Rule description.

The maximum string length in characters is 128. ||
|#

## PropertyAccessRuleMatcher {#yandex.cloud.trino.v1.PropertyAccessRuleMatcher}

#|
||Field | Description ||
|| nameRegexp | **string**

Property name regexp the rule is applied to.

The maximum string length in characters is 256.

Includes only one of the fields `nameRegexp`, `names`. ||
|| names | **[PropertyNames](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher.PropertyNames)**

Property names the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|#

## PropertyNames {#yandex.cloud.trino.v1.PropertyAccessRuleMatcher.PropertyNames}

#|
||Field | Description ||
|| any[] | **string**

List of property names. The rule will be applied if a property name is within this list.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [a-z_]+ `. The maximum number of elements is 128. ||
|#

## CatalogSessionPropertyAccessRule {#yandex.cloud.trino.v1.CatalogSessionPropertyAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128. ||
|| groups[] | **string**

IAM group IDs the rule is applied to.

The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]+ `. The maximum number of elements is 128. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| property | **[PropertyAccessRuleMatcher](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher)**

Property matcher specifying what properties the rule is applied to. ||
|| allow | **enum** (Allow)

Required field. Whether the rule allows setting the property.

- `NO`: Denies setting the catalog session property.
- `YES`: Allows to set the catalog session property. ||
|| description | **string**

Rule description.

The maximum string length in characters is 128. ||
|#

## ResourceManagementConfig {#yandex.cloud.trino.v1.ResourceManagementConfig}

#|
||Field | Description ||
|| resourceGroups | **[ResourceGroupsConfig](#yandex.cloud.trino.v1.ResourceGroupsConfig)**

Resource groups configuration. ||
|| query | **[QueryConfig](#yandex.cloud.trino.v1.QueryConfig)**

Query management confiugration. ||
|#

## ResourceGroupsConfig {#yandex.cloud.trino.v1.ResourceGroupsConfig}

#|
||Field | Description ||
|| rootGroups[] | **[ResourceGroupConfig](#yandex.cloud.trino.v1.ResourceGroupConfig)**

Root resource groups configuration.

The number of elements must be greater than 0. ||
|| selectors[] | **[SelectorRuleConfig](#yandex.cloud.trino.v1.SelectorRuleConfig)**

Selector rules for routing queries to resource groups.

The number of elements must be greater than 0. ||
|| cpuQuotaPeriod | **string**

Period for CPU quota calculations. ||
|#

## ResourceGroupConfig {#yandex.cloud.trino.v1.ResourceGroupConfig}

#|
||Field | Description ||
|| name | **string**

Required field. Resource group name. ||
|| maxQueued | **string** (int64)

Maximum number of queued queries.

Value must be greater than 0. ||
|| softConcurrencyLimit | **string** (int64)

Number of concurrently running queries after which new queries only run if peer groups are below soft limits. ||
|| hardConcurrencyLimit | **string** (int64)

Maximum number of queries that can run concurrently.

Value must be greater than 0. ||
|| softMemoryLimit | **string**

Maximum amount of distributed memory this group can use. ||
|| softCpuLimit | **string**

Maximum CPU time per period this group can use before applying penalty to running queries (requires hard_cpu_limit). ||
|| hardCpuLimit | **string**

Maximum CPU time per period this group can use. ||
|| schedulingPolicy | **enum** (SchedulingPolicy)

Policy for selecting queued queries and sub-group eligibility.

- `FAIR`: Queued queries processed first-in-first-out, sub-groups take turns starting queries.
- `WEIGHTED`: Queries selected stochastically by priority, sub-groups selected by schedulingWeight.
- `WEIGHTED_FAIR`: Sub-groups selected by schedulingWeight and concurrency relative to their share.
- `QUERY_PRIORITY`: Queued queries selected strictly by priority. ||
|| schedulingWeight | **string** (int64)

Weight for weighted and weighted_fair scheduling policies. ||
|| subGroups[] | **[ResourceGroupConfig](#yandex.cloud.trino.v1.ResourceGroupConfig)**

List of sub-groups. ||
|#

## SelectorRuleConfig {#yandex.cloud.trino.v1.SelectorRuleConfig}

#|
||Field | Description ||
|| user | **string**

Regex to match against username. ||
|| userGroup | **string**

Regex to match against user groups. ||
|| source | **string**

Regex to match against query source. ||
|| queryType | **enum** (QueryType)

Type of query to match.

- `SELECT`: SELECT query.
- `EXPLAIN`: EXPLAIN query.
- `DESCRIBE`: DESCRIBE query.
- `INSERT`: INSERT query.
- `UPDATE`: UPDATE query.
- `MERGE`: MERGE query.
- `DELETE`: DELECT query.
- `ANALYZE`: ANALYZE query.
- `DATA_DEFINITION`: Data definition query.
- `ALTER_TABLE_EXECUTE`: ALTER TABLE EXECUTE query. ||
|| clientTags[] | **string**

Tags that must all be present in the query's client tags. ||
|| group | **string**

Required field. Target resource group name. ||
|#

## QueryConfig {#yandex.cloud.trino.v1.QueryConfig}

#|
||Field | Description ||
|| properties | **object** (map<**string**, **string**>)

Query properties. ||
|#

## TLSConfig {#yandex.cloud.trino.v1.TLSConfig}

#|
||Field | Description ||
|| trustedCertificates[] | **string**

Trusted CA-certificates. Each element should contain single self-signed CA-certificate or
chain of CA-certificates where first certificate is the leaf and last certificate is the self-signed root.

The maximum string length in characters for each value is 8192. The maximum number of elements is 8. ||
|#

## NetworkConfig {#yandex.cloud.trino.v1.NetworkConfig}

#|
||Field | Description ||
|| subnetIds[] | **string**

IDs of VPC network subnets where instances of the cluster are attached. ||
|| securityGroupIds[] | **string**

User security groups. ||
|| privateAccess | **[PrivateAccessConfig](#yandex.cloud.trino.v1.PrivateAccessConfig)**

Private link configuration for secure connectivity to the cluster. ||
|#

## PrivateAccessConfig {#yandex.cloud.trino.v1.PrivateAccessConfig}

#|
||Field | Description ||
|| enabled | **boolean**

Enables access to the cluster only via private endpoint. ||
|#

## LoggingConfig {#yandex.cloud.trino.v1.LoggingConfig}

#|
||Field | Description ||
|| folderId | **string**

Logs should be written to default log group for specified folder.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folderId`, `logGroupId`.

Destination of log records. ||
|| logGroupId | **string**

Logs should be written to log group resolved by ID.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folderId`, `logGroupId`.

Destination of log records. ||
|| enabled | **boolean**

Logs generated by the Trino components are delivered to Cloud Logging. ||
|| minLevel | **enum** (Level)

Minimum log entry level.
See [LogLevel.Level](/docs/logging/api-ref/Export/get#yandex.cloud.logging.v1.LogLevel.Level) for details.

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

The cluster may be restarted for maintenance at any time.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.trino.v1.WeeklyMaintenanceWindow)**

Maintenance is allowed only within the specified weekly window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.trino.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week when maintenance can occur.

- `MON`: Monday.
- `TUE`: Tuesday.
- `WED`: Wednesday.
- `THU`: Thursday.
- `FRI`: Friday.
- `SAT`: Saturday.
- `SUN`: Sunday. ||
|| hour | **string** (int64)

Hour of the day in UTC when the maintenance window starts.

Acceptable values are 1 to 24, inclusive. ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| metadata | **object**

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
|| response | **object**

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