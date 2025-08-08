---
editable: false
apiPlayground:
  - url: https://{{ api-host-data-transfer }}/v1/endpoint
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            ID of the folder to create the endpoint in.
            To get the folder ID, make a
            [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
        name:
          description: |-
            **string**
            Name of the endpoint.
            The name must be unique within the folder.
          type: string
        description:
          description: |-
            **string**
            Description of the endpoint.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Endpoint labels as `key:value` pairs.
            For details about the concept, see [documentation]({{ api-url-prefix }}/resource-manager/concepts/labels).
          type: string
        settings:
          description: '**[EndpointSettings](/docs/data-transfer/api-ref/Endpoint/get#yandex.cloud.datatransfer.v1.EndpointSettings)**'
          oneOf:
            - type: object
              properties:
                mysqlSource:
                  description: |-
                    **`MysqlSource`**
                    Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
                  $ref: '#/definitions/MysqlSource'
                postgresSource:
                  description: |-
                    **`PostgresSource`**
                    Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
                  $ref: '#/definitions/PostgresSource'
                ydbSource:
                  description: |-
                    **`YdbSource`**
                    Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
                  $ref: '#/definitions/YdbSource'
                ydsSource:
                  description: |-
                    **`YDSSource`**
                    Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
                  $ref: '#/definitions/YDSSource'
                kafkaSource:
                  description: |-
                    **`KafkaSource`**
                    Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
                  $ref: '#/definitions/KafkaSource'
                mongoSource:
                  description: |-
                    **`MongoSource`**
                    Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
                  $ref: '#/definitions/MongoSource'
                clickhouseSource:
                  description: |-
                    **`ClickhouseSource`**
                    Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
                  $ref: '#/definitions/ClickhouseSource'
                mysqlTarget:
                  description: |-
                    **`MysqlTarget`**
                    Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
                  $ref: '#/definitions/MysqlTarget'
                postgresTarget:
                  description: |-
                    **`PostgresTarget`**
                    Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
                  $ref: '#/definitions/PostgresTarget'
                clickhouseTarget:
                  description: |-
                    **`ClickhouseTarget`**
                    Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
                  $ref: '#/definitions/ClickhouseTarget'
                ydbTarget:
                  description: |-
                    **`YdbTarget`**
                    Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
                  $ref: '#/definitions/YdbTarget'
                kafkaTarget:
                  description: |-
                    **`KafkaTarget`**
                    Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
                  $ref: '#/definitions/KafkaTarget'
                mongoTarget:
                  description: |-
                    **`MongoTarget`**
                    Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
                  $ref: '#/definitions/MongoTarget'
                metrikaSource:
                  description: |-
                    **`MetrikaSource`**
                    Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
                  $ref: '#/definitions/MetrikaSource'
                ydsTarget:
                  description: |-
                    **`YDSTarget`**
                    Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
                  $ref: '#/definitions/YDSTarget'
      additionalProperties: false
    definitions:
      TLSConfig:
        type: object
        properties:
          caCertificate:
            description: |-
              **string**
              CA certificate
              X.509 certificate of the certificate authority which issued the server's
              certificate, in PEM format. When CA certificate is specified TLS is used to
              connect to the server.
            type: string
      OnPremiseMysql:
        type: object
        properties:
          port:
            description: |-
              **string** (int64)
              Database port
            type: string
            format: int64
          subnetId:
            description: |-
              **string**
              Network interface for endpoint. If none will assume public ipv4
            type: string
          hosts:
            description: '**string**'
            type: array
            items:
              type: string
          tlsMode:
            description: |-
              **`TLSMode`**
              TLS settings for server connection. Disabled by default.
            oneOf:
              - type: object
                properties:
                  disabled:
                    description: |-
                      **undefined** (empty)
                      Empty JSON object `` {} ``.
                      Includes only one of the fields `enabled`.
                    type: undefined
                    format: empty
                  enabled:
                    description: |-
                      **`TLSConfig`**
                      Includes only one of the fields `enabled`.
                    $ref: '#/definitions/TLSConfig'
      ConnectionManagerConnection:
        type: object
        properties:
          connectionId:
            description: '**string**'
            type: string
      MysqlObjectTransferSettings:
        type: object
        properties:
          view:
            description: |-
              **enum** (ObjectTransferStage)
              Views
              CREATE VIEW ...
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
          routine:
            description: |-
              **enum** (ObjectTransferStage)
              Routines
              CREATE PROCEDURE ... ; CREATE FUNCTION ... ;
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
          trigger:
            description: |-
              **enum** (ObjectTransferStage)
              Triggers
              CREATE TRIGGER ...
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
          tables:
            description: |-
              **enum** (ObjectTransferStage)
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
      MysqlSource:
        type: object
        properties:
          connection:
            description: |-
              **`MysqlConnection`**
              Database connection settings
            oneOf:
              - type: object
                properties:
                  mdbClusterId:
                    description: |-
                      **string**
                      Managed Service for MySQL cluster ID
                      Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
                    type: string
                  onPremise:
                    description: |-
                      **`OnPremiseMysql`**
                      Connection options for on-premise MySQL
                      Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
                    $ref: '#/definitions/OnPremiseMysql'
                  connectionManagerConnection:
                    description: |-
                      **`ConnectionManagerConnection`**
                      Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
                    $ref: '#/definitions/ConnectionManagerConnection'
          database:
            description: |-
              **string**
              Database name
              You can leave it empty, then it will be possible to transfer tables from several
              databases at the same time from this source.
            type: string
          user:
            description: |-
              **string**
              User for database access. not required as may be in connection
            type: string
          password:
            description: |-
              **`Secret`**
              Password for database access.
            oneOf:
              - type: object
                properties:
                  raw:
                    description: |-
                      **string**
                      Raw secret value
                      Includes only one of the fields `raw`.
                    type: string
          timezone:
            description: |-
              **string**
              Database timezone
              Is used for parsing timestamps for saving source timezones. Accepts values from
              IANA timezone database. Default: local timezone.
            type: string
          objectTransferSettings:
            description: |-
              **`MysqlObjectTransferSettings`**
              Schema migration
              Select database objects to be transferred during activation or deactivation.
            $ref: '#/definitions/MysqlObjectTransferSettings'
          includeTablesRegex:
            description: '**string**'
            type: array
            items:
              type: string
          excludeTablesRegex:
            description: '**string**'
            type: array
            items:
              type: string
          securityGroups:
            description: |-
              **string**
              Security groups
            type: array
            items:
              type: string
          serviceDatabase:
            description: |-
              **string**
              Database for service tables
              Default: data source database. Here created technical tables (__tm_keeper,
              __tm_gtid_keeper).
            type: string
      OnPremisePostgres:
        type: object
        properties:
          port:
            description: |-
              **string** (int64)
              Will be used if the cluster ID is not specified.
            type: string
            format: int64
          subnetId:
            description: |-
              **string**
              Network interface for endpoint. If none will assume public ipv4
            type: string
          hosts:
            description: '**string**'
            type: array
            items:
              type: string
          tlsMode:
            description: |-
              **`TLSMode`**
              TLS settings for server connection. Disabled by default.
            oneOf:
              - type: object
                properties:
                  disabled:
                    description: |-
                      **undefined** (empty)
                      Empty JSON object `` {} ``.
                      Includes only one of the fields `enabled`.
                    type: undefined
                    format: empty
                  enabled:
                    description: |-
                      **`TLSConfig`**
                      Includes only one of the fields `enabled`.
                    $ref: '#/definitions/TLSConfig'
      PostgresObjectTransferSettings:
        type: object
        properties:
          sequence:
            description: |-
              **enum** (ObjectTransferStage)
              Sequences
              CREATE SEQUENCE ...
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
          sequenceOwnedBy:
            description: |-
              **enum** (ObjectTransferStage)
              Owned sequences
              CREATE SEQUENCE ... OWNED BY ...
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
          table:
            description: |-
              **enum** (ObjectTransferStage)
              Tables
              CREATE TABLE ...
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
          primaryKey:
            description: |-
              **enum** (ObjectTransferStage)
              Primary keys
              ALTER TABLE ... ADD PRIMARY KEY ...
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
          fkConstraint:
            description: |-
              **enum** (ObjectTransferStage)
              Foreign keys
              ALTER TABLE ... ADD FOREIGN KEY ...
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
          defaultValues:
            description: |-
              **enum** (ObjectTransferStage)
              Default values
              ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ...
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
          constraint:
            description: |-
              **enum** (ObjectTransferStage)
              Constraints
              ALTER TABLE ... ADD CONSTRAINT ...
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
          index:
            description: |-
              **enum** (ObjectTransferStage)
              Indexes
              CREATE INDEX ...
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
          view:
            description: |-
              **enum** (ObjectTransferStage)
              Views
              CREATE VIEW ...
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
          function:
            description: |-
              **enum** (ObjectTransferStage)
              Functions
              CREATE FUNCTION ...
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
          trigger:
            description: |-
              **enum** (ObjectTransferStage)
              Triggers
              CREATE TRIGGER ...
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
          type:
            description: |-
              **enum** (ObjectTransferStage)
              Types
              CREATE TYPE ...
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
          rule:
            description: |-
              **enum** (ObjectTransferStage)
              Rules
              CREATE RULE ...
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
          collation:
            description: |-
              **enum** (ObjectTransferStage)
              Collations
              CREATE COLLATION ...
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
          policy:
            description: |-
              **enum** (ObjectTransferStage)
              Policies
              CREATE POLICY ...
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
          cast:
            description: |-
              **enum** (ObjectTransferStage)
              Casts
              CREATE CAST ...
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
          materializedView:
            description: |-
              **enum** (ObjectTransferStage)
              Materialized views
              CREATE MATERIALIZED VIEW ...
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
          sequenceSet:
            description: |-
              **enum** (ObjectTransferStage)
              - `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
              - `BEFORE_DATA`: Before data transfer
              - `AFTER_DATA`: After data transfer
              - `NEVER`: Don't copy
            type: string
            enum:
              - OBJECT_TRANSFER_STAGE_UNSPECIFIED
              - BEFORE_DATA
              - AFTER_DATA
              - NEVER
      PostgresSource:
        type: object
        properties:
          connection:
            description: |-
              **`PostgresConnection`**
              Database connection settings
            oneOf:
              - type: object
                properties:
                  mdbClusterId:
                    description: |-
                      **string**
                      Managed Service for PostgreSQL cluster ID
                      Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
                    type: string
                  onPremise:
                    description: |-
                      **`OnPremisePostgres`**
                      Connection options for on-premise PostgreSQL
                      Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
                    $ref: '#/definitions/OnPremisePostgres'
                  connectionManagerConnection:
                    description: |-
                      **`ConnectionManagerConnection`**
                      Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
                    $ref: '#/definitions/ConnectionManagerConnection'
          database:
            description: |-
              **string**
              Database name
            type: string
          user:
            description: |-
              **string**
              User for database access. not required as may be in connection
            type: string
          password:
            description: |-
              **`Secret`**
              Password for database access.
            oneOf:
              - type: object
                properties:
                  raw:
                    description: |-
                      **string**
                      Raw secret value
                      Includes only one of the fields `raw`.
                    type: string
          includeTables:
            description: |-
              **string**
              Included tables
              If none or empty list is presented, all tables are replicated. Full table name
              with schema. Can contain schema_name.* patterns.
            type: array
            items:
              type: string
          excludeTables:
            description: |-
              **string**
              Excluded tables
              If none or empty list is presented, all tables are replicated. Full table name
              with schema. Can contain schema_name.* patterns.
            type: array
            items:
              type: string
          slotByteLagLimit:
            description: |-
              **string** (int64)
              Maximum lag of replication slot (in bytes); after exceeding this limit
              replication will be aborted.
            type: string
            format: int64
          serviceSchema:
            description: |-
              **string**
              Database schema for service tables (__consumer_keeper,
              __data_transfer_mole_finder). Default is public
            type: string
          objectTransferSettings:
            description: |-
              **`PostgresObjectTransferSettings`**
              Select database objects to be transferred during activation or deactivation.
            $ref: '#/definitions/PostgresObjectTransferSettings'
          securityGroups:
            description: |-
              **string**
              Security groups
            type: array
            items:
              type: string
      YdbSource:
        type: object
        properties:
          database:
            description: |-
              **string**
              Path in YDB where to store tables
            type: string
          instance:
            description: |-
              **string**
              Instance of YDB. example: ydb-ru-prestable.yandex.net:2135
            type: string
          paths:
            description: '**string**'
            type: array
            items:
              type: string
          serviceAccountId:
            description: '**string**'
            type: string
          subnetId:
            description: |-
              **string**
              Network interface for endpoint. If none will assume public ipv4
            type: string
          saKeyContent:
            description: |-
              **string**
              Authorization Key
            type: string
          securityGroups:
            description: |-
              **string**
              Security groups
            type: array
            items:
              type: string
          changefeedCustomName:
            description: |-
              **string**
              Pre-created change feed
            type: string
          changefeedCustomConsumerName:
            description: '**string**'
            type: string
      ColSchema:
        type: object
        properties:
          name:
            description: '**string**'
            type: string
          type:
            description: |-
              **enum** (ColumnType)
              - `COLUMN_TYPE_UNSPECIFIED`
              - `INT32`
              - `INT16`
              - `INT8`
              - `UINT64`
              - `UINT32`
              - `UINT16`
              - `UINT8`
              - `DOUBLE`
              - `BOOLEAN`
              - `STRING`
              - `UTF8`
              - `ANY`
              - `DATETIME`
              - `INT64`
            type: string
            enum:
              - COLUMN_TYPE_UNSPECIFIED
              - INT32
              - INT16
              - INT8
              - UINT64
              - UINT32
              - UINT16
              - UINT8
              - DOUBLE
              - BOOLEAN
              - STRING
              - UTF8
              - ANY
              - DATETIME
              - INT64
          key:
            description: '**boolean**'
            type: boolean
          required:
            description: '**boolean**'
            type: boolean
          path:
            description: '**string**'
            type: string
      FieldList:
        type: object
        properties:
          fields:
            description: |-
              **`ColSchema`**
              Column schema
            type: array
            items:
              $ref: '#/definitions/ColSchema'
      GenericParserCommon:
        type: object
        properties:
          dataSchema:
            description: '**`DataSchema`**'
            oneOf:
              - type: object
                properties:
                  jsonFields:
                    description: |-
                      **string**
                      Includes only one of the fields `jsonFields`, `fields`.
                    type: string
                  fields:
                    description: |-
                      **`FieldList`**
                      Includes only one of the fields `jsonFields`, `fields`.
                    $ref: '#/definitions/FieldList'
          nullKeysAllowed:
            description: |-
              **boolean**
              Allow null keys, if no - null keys will be putted to unparsed data
            type: boolean
          addRestColumn:
            description: |-
              **boolean**
              Will add _rest column for all unknown fields
            type: boolean
          unescapeStringValues:
            description: |-
              **boolean**
              Unescape string values
            type: boolean
      AuditTrailsV1Parser:
        type: object
        properties: {}
      CloudLoggingParser:
        type: object
        properties: {}
      YDSSource:
        type: object
        properties:
          database:
            description: |-
              **string**
              Database
            type: string
          stream:
            description: |-
              **string**
              Stream
            type: string
          serviceAccountId:
            description: |-
              **string**
              SA which has read access to the stream.
            type: string
          supportedCodecs:
            description: |-
              **enum** (YdsCompressionCodec)
              Compression codec
              - `YDS_COMPRESSION_CODEC_UNSPECIFIED`
              - `YDS_COMPRESSION_CODEC_RAW`
              - `YDS_COMPRESSION_CODEC_GZIP`
              - `YDS_COMPRESSION_CODEC_ZSTD`
            type: array
            items:
              type: string
              enum:
                - YDS_COMPRESSION_CODEC_UNSPECIFIED
                - YDS_COMPRESSION_CODEC_RAW
                - YDS_COMPRESSION_CODEC_GZIP
                - YDS_COMPRESSION_CODEC_ZSTD
          parser:
            description: |-
              **`Parser`**
              Data parsing rules
            oneOf:
              - type: object
                properties:
                  jsonParser:
                    description: |-
                      **`GenericParserCommon`**
                      Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`.
                    $ref: '#/definitions/GenericParserCommon'
                  auditTrailsV1Parser:
                    description: |-
                      **object**
                      Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`.
                    $ref: '#/definitions/AuditTrailsV1Parser'
                  cloudLoggingParser:
                    description: |-
                      **object**
                      Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`.
                    $ref: '#/definitions/CloudLoggingParser'
                  tskvParser:
                    description: |-
                      **`GenericParserCommon`**
                      Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`.
                    $ref: '#/definitions/GenericParserCommon'
          allowTtlRewind:
            description: |-
              **boolean**
              Should continue working, if consumer read lag exceed TTL of topic
              False: stop the transfer in error state, if detected lost data. True: continue
              working with losing part of data
            type: boolean
          endpoint:
            description: |-
              **string**
              for dedicated db
            type: string
          subnetId:
            description: |-
              **string**
              Network interface for endpoint. If none will assume public ipv4
            type: string
          securityGroups:
            description: |-
              **string**
              Security groups
            type: array
            items:
              type: string
          consumer:
            description: |-
              **string**
              for important streams
            type: string
      OnPremiseKafka:
        type: object
        properties:
          brokerUrls:
            description: |-
              **string**
              Kafka broker URLs
            type: array
            items:
              type: string
          subnetId:
            description: |-
              **string**
              Network interface for endpoint. If none will assume public ipv4
            type: string
          tlsMode:
            description: |-
              **`TLSMode`**
              TLS settings for broker connection. Disabled by default.
            oneOf:
              - type: object
                properties:
                  disabled:
                    description: |-
                      **undefined** (empty)
                      Empty JSON object `` {} ``.
                      Includes only one of the fields `enabled`.
                    type: undefined
                    format: empty
                  enabled:
                    description: |-
                      **`TLSConfig`**
                      Includes only one of the fields `enabled`.
                    $ref: '#/definitions/TLSConfig'
      KafkaSaslSecurity:
        type: object
        properties:
          user:
            description: |-
              **string**
              User name
            type: string
          mechanism:
            description: |-
              **enum** (KafkaMechanism)
              SASL mechanism for authentication
              - `KAFKA_MECHANISM_UNSPECIFIED`
              - `KAFKA_MECHANISM_SHA256`
              - `KAFKA_MECHANISM_SHA512`
            type: string
            enum:
              - KAFKA_MECHANISM_UNSPECIFIED
              - KAFKA_MECHANISM_SHA256
              - KAFKA_MECHANISM_SHA512
          password:
            description: |-
              **`Secret`**
              Password for user
            oneOf:
              - type: object
                properties:
                  raw:
                    description: |-
                      **string**
                      Raw secret value
                      Includes only one of the fields `raw`.
                    type: string
      NoAuth:
        type: object
        properties: {}
      DataTransformationOptions:
        type: object
        properties:
          cloudFunction:
            description: |-
              **string**
              Cloud function
            type: string
          numberOfRetries:
            description: |-
              **string** (int64)
              Number of retries
            type: string
            format: int64
          bufferSize:
            description: |-
              **string**
              Buffer size for function
            type: string
          bufferFlushInterval:
            description: |-
              **string**
              Flush interval
            type: string
          invocationTimeout:
            description: |-
              **string**
              Invocation timeout
            type: string
          serviceAccountId:
            description: |-
              **string**
              Service account
            type: string
      KafkaSource:
        type: object
        properties:
          connection:
            description: |-
              **`KafkaConnectionOptions`**
              Connection settings
            oneOf:
              - type: object
                properties:
                  clusterId:
                    description: |-
                      **string**
                      Managed Service for Kafka cluster ID
                      Includes only one of the fields `clusterId`, `onPremise`.
                    type: string
                  onPremise:
                    description: |-
                      **`OnPremiseKafka`**
                      Connection options for on-premise Kafka
                      Includes only one of the fields `clusterId`, `onPremise`.
                    $ref: '#/definitions/OnPremiseKafka'
          auth:
            description: |-
              **`KafkaAuth`**
              Authentication settings
            oneOf:
              - type: object
                properties:
                  sasl:
                    description: |-
                      **`KafkaSaslSecurity`**
                      Authentication with SASL
                      Includes only one of the fields `sasl`, `noAuth`.
                    $ref: '#/definitions/KafkaSaslSecurity'
                  noAuth:
                    description: |-
                      **object**
                      No authentication
                      Includes only one of the fields `sasl`, `noAuth`.
                    $ref: '#/definitions/NoAuth'
          securityGroups:
            description: |-
              **string**
              Security groups
            type: array
            items:
              type: string
          topicName:
            description: |-
              **string**
              Full source topic name
              Deprecated in favor of topic names
            deprecated: true
            type: string
          transformer:
            description: |-
              **`DataTransformationOptions`**
              Data transformation rules
            $ref: '#/definitions/DataTransformationOptions'
          parser:
            description: |-
              **`Parser`**
              Data parsing rules
            oneOf:
              - type: object
                properties:
                  jsonParser:
                    description: |-
                      **`GenericParserCommon`**
                      Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`.
                    $ref: '#/definitions/GenericParserCommon'
                  auditTrailsV1Parser:
                    description: |-
                      **object**
                      Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`.
                    $ref: '#/definitions/AuditTrailsV1Parser'
                  cloudLoggingParser:
                    description: |-
                      **object**
                      Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`.
                    $ref: '#/definitions/CloudLoggingParser'
                  tskvParser:
                    description: |-
                      **`GenericParserCommon`**
                      Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`.
                    $ref: '#/definitions/GenericParserCommon'
          topicNames:
            description: |-
              **string**
              List of topic names to read
            type: array
            items:
              type: string
      OnPremiseMongo:
        type: object
        properties:
          hosts:
            description: '**string**'
            type: array
            items:
              type: string
          port:
            description: '**string** (int64)'
            type: string
            format: int64
          replicaSet:
            description: '**string**'
            type: string
          tlsMode:
            description: '**`TLSMode`**'
            oneOf:
              - type: object
                properties:
                  disabled:
                    description: |-
                      **undefined** (empty)
                      Empty JSON object `` {} ``.
                      Includes only one of the fields `enabled`.
                    type: undefined
                    format: empty
                  enabled:
                    description: |-
                      **`TLSConfig`**
                      Includes only one of the fields `enabled`.
                    $ref: '#/definitions/TLSConfig'
      MongoConnectionManagerConnection:
        type: object
        properties:
          connectionId:
            description: '**string**'
            type: string
          replicaSet:
            description: |-
              **string**
              Used only for on-premise connections
            type: string
      MongoCollection:
        type: object
        properties:
          databaseName:
            description: '**string**'
            type: string
          collectionName:
            description: '**string**'
            type: string
      MongoSource:
        type: object
        properties:
          connection:
            description: '**`MongoConnection`**'
            oneOf:
              - type: object
                properties:
                  connectionOptions:
                    description: |-
                      **`MongoConnectionOptions`**
                      Includes only one of the fields `connectionOptions`.
                    oneOf:
                      - type: object
                        properties:
                          mdbClusterId:
                            description: |-
                              **string**
                              Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
                            type: string
                          onPremise:
                            description: |-
                              **`OnPremiseMongo`**
                              Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
                            $ref: '#/definitions/OnPremiseMongo'
                          connectionManagerConnection:
                            description: |-
                              **`MongoConnectionManagerConnection`**
                              Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
                            $ref: '#/definitions/MongoConnectionManagerConnection'
          subnetId:
            description: '**string**'
            type: string
          collections:
            description: |-
              **`MongoCollection`**
              List of collections for replication. Empty list implies replication of all
              tables on the deployment. Allowed to use * as collection name.
            type: array
            items:
              $ref: '#/definitions/MongoCollection'
          excludedCollections:
            description: |-
              **`MongoCollection`**
              List of forbidden collections for replication. Allowed to use * as collection
              name for forbid all collections of concrete schema.
            type: array
            items:
              $ref: '#/definitions/MongoCollection'
          secondaryPreferredMode:
            description: |-
              **boolean**
              Read mode for mongo client
            type: boolean
          securityGroups:
            description: |-
              **string**
              Security groups
            type: array
            items:
              type: string
      ClickhouseShard:
        type: object
        properties:
          name:
            description: '**string**'
            type: string
          hosts:
            description: '**string**'
            type: array
            items:
              type: string
      OnPremiseClickhouse:
        type: object
        properties:
          shards:
            description: '**`ClickhouseShard`**'
            type: array
            items:
              $ref: '#/definitions/ClickhouseShard'
          httpPort:
            description: '**string** (int64)'
            type: string
            format: int64
          nativePort:
            description: '**string** (int64)'
            type: string
            format: int64
          tlsMode:
            description: '**`TLSMode`**'
            oneOf:
              - type: object
                properties:
                  disabled:
                    description: |-
                      **undefined** (empty)
                      Empty JSON object `` {} ``.
                      Includes only one of the fields `enabled`.
                    type: undefined
                    format: empty
                  enabled:
                    description: |-
                      **`TLSConfig`**
                      Includes only one of the fields `enabled`.
                    $ref: '#/definitions/TLSConfig'
      ClickhouseSource:
        type: object
        properties:
          connection:
            description: '**`ClickhouseConnection`**'
            oneOf:
              - type: object
                properties:
                  connectionOptions:
                    description: |-
                      **`ClickhouseConnectionOptions`**
                      Includes only one of the fields `connectionOptions`.
                    oneOf:
                      - type: object
                        properties:
                          onPremise:
                            description: |-
                              **`OnPremiseClickhouse`**
                              Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`.
                            $ref: '#/definitions/OnPremiseClickhouse'
                          connectionManagerConnection:
                            description: |-
                              **`ConnectionManagerConnection`**
                              Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`.
                            $ref: '#/definitions/ConnectionManagerConnection'
                          mdbClusterId:
                            description: |-
                              **string**
                              Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`.
                            type: string
          includeTables:
            description: |-
              **string**
              White list of tables for replication. If none or empty list is presented - will
              replicate all tables. Can contain * patterns.
            type: array
            items:
              type: string
          excludeTables:
            description: |-
              **string**
              Exclude list of tables for replication. If none or empty list is presented -
              will replicate all tables. Can contain * patterns.
            type: array
            items:
              type: string
          subnetId:
            description: '**string**'
            type: string
          securityGroups:
            description: '**string**'
            type: array
            items:
              type: string
          clickhouseClusterName:
            description: |-
              **string**
              Name of the ClickHouse cluster. For Managed ClickHouse that is name of
              ShardGroup.
            type: string
      MysqlTarget:
        type: object
        properties:
          connection:
            description: |-
              **`MysqlConnection`**
              Database connection settings
            oneOf:
              - type: object
                properties:
                  mdbClusterId:
                    description: |-
                      **string**
                      Managed Service for MySQL cluster ID
                      Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
                    type: string
                  onPremise:
                    description: |-
                      **`OnPremiseMysql`**
                      Connection options for on-premise MySQL
                      Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
                    $ref: '#/definitions/OnPremiseMysql'
                  connectionManagerConnection:
                    description: |-
                      **`ConnectionManagerConnection`**
                      Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
                    $ref: '#/definitions/ConnectionManagerConnection'
          database:
            description: |-
              **string**
              Database name
              Allowed to leave it empty, then the tables will be created in databases with the
              same names as on the source. If this field is empty, then you must fill below db
              schema for service table.
            type: string
          user:
            description: |-
              **string**
              User for database access. not required as may be in connection
            type: string
          password:
            description: |-
              **`Secret`**
              Password for database access.
            oneOf:
              - type: object
                properties:
                  raw:
                    description: |-
                      **string**
                      Raw secret value
                      Includes only one of the fields `raw`.
                    type: string
          sqlMode:
            description: |-
              **string**
              Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION.
            type: string
          skipConstraintChecks:
            description: |-
              **boolean**
              Disable constraints checks
              Recommend to disable for increase replication speed, but if schema contain
              cascading operations we don't recommend to disable. This option set
              FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0.
            type: boolean
          timezone:
            description: |-
              **string**
              Database timezone
              Is used for parsing timestamps for saving source timezones. Accepts values from
              IANA timezone database. Default: local timezone.
            type: string
          cleanupPolicy:
            description: |-
              **enum** (CleanupPolicy)
              Cleanup policy
              Cleanup policy for activate, reactivate and reupload processes. Default is
              DISABLED.
              - `CLEANUP_POLICY_UNSPECIFIED`
              - `DISABLED`: Don't cleanup
              - `DROP`: Drop
              - `TRUNCATE`: Truncate
            type: string
            enum:
              - CLEANUP_POLICY_UNSPECIFIED
              - DISABLED
              - DROP
              - TRUNCATE
          serviceDatabase:
            description: |-
              **string**
              Database schema for service table
              Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper).
            type: string
          securityGroups:
            description: |-
              **string**
              Security groups
            type: array
            items:
              type: string
          isSchemaMigrationDisabled:
            description: '**boolean**'
            type: boolean
      PostgresTarget:
        type: object
        properties:
          connection:
            description: |-
              **`PostgresConnection`**
              Database connection settings
            oneOf:
              - type: object
                properties:
                  mdbClusterId:
                    description: |-
                      **string**
                      Managed Service for PostgreSQL cluster ID
                      Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
                    type: string
                  onPremise:
                    description: |-
                      **`OnPremisePostgres`**
                      Connection options for on-premise PostgreSQL
                      Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
                    $ref: '#/definitions/OnPremisePostgres'
                  connectionManagerConnection:
                    description: |-
                      **`ConnectionManagerConnection`**
                      Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
                    $ref: '#/definitions/ConnectionManagerConnection'
          database:
            description: |-
              **string**
              Database name
            type: string
          user:
            description: |-
              **string**
              User for database access. not required as may be in connection
            type: string
          password:
            description: |-
              **`Secret`**
              Password for database access.
            oneOf:
              - type: object
                properties:
                  raw:
                    description: |-
                      **string**
                      Raw secret value
                      Includes only one of the fields `raw`.
                    type: string
          cleanupPolicy:
            description: |-
              **enum** (CleanupPolicy)
              Cleanup policy for activate, reactivate and reupload processes. Default is
              truncate.
              - `CLEANUP_POLICY_UNSPECIFIED`
              - `DISABLED`: Don't cleanup
              - `DROP`: Drop
              - `TRUNCATE`: Truncate
            type: string
            enum:
              - CLEANUP_POLICY_UNSPECIFIED
              - DISABLED
              - DROP
              - TRUNCATE
          securityGroups:
            description: |-
              **string**
              Security groups
            type: array
            items:
              type: string
          isSchemaMigrationDisabled:
            description: '**boolean**'
            type: boolean
      AltName:
        type: object
        properties:
          fromName:
            description: |-
              **string**
              Source table name
            type: string
          toName:
            description: |-
              **string**
              Target table name
            type: string
      ColumnValueHash:
        type: object
        properties:
          columnName:
            description: '**string**'
            type: string
      ValueToShard:
        type: object
        properties:
          columnValue:
            description: '**`ColumnValue`**'
            oneOf:
              - type: object
                properties:
                  stringValue:
                    description: |-
                      **string**
                      Includes only one of the fields `stringValue`.
                    type: string
          shardName:
            description: '**string**'
            type: string
      ColumnValueMapping:
        type: object
        properties:
          columnName:
            description: '**string**'
            type: string
          mapping:
            description: '**`ValueToShard`**'
            type: array
            items:
              $ref: '#/definitions/ValueToShard'
      ClickhouseTarget:
        type: object
        properties:
          connection:
            description: '**`ClickhouseConnection`**'
            oneOf:
              - type: object
                properties:
                  connectionOptions:
                    description: |-
                      **`ClickhouseConnectionOptions`**
                      Includes only one of the fields `connectionOptions`.
                    oneOf:
                      - type: object
                        properties:
                          onPremise:
                            description: |-
                              **`OnPremiseClickhouse`**
                              Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`.
                            $ref: '#/definitions/OnPremiseClickhouse'
                          connectionManagerConnection:
                            description: |-
                              **`ConnectionManagerConnection`**
                              Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`.
                            $ref: '#/definitions/ConnectionManagerConnection'
                          mdbClusterId:
                            description: |-
                              **string**
                              Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`.
                            type: string
          subnetId:
            description: '**string**'
            type: string
          altNames:
            description: |-
              **`AltName`**
              Alternative table names in target
            type: array
            items:
              $ref: '#/definitions/AltName'
          cleanupPolicy:
            description: |-
              **enum** (ClickhouseCleanupPolicy)
              - `CLICKHOUSE_CLEANUP_POLICY_UNSPECIFIED`
              - `CLICKHOUSE_CLEANUP_POLICY_DISABLED`
              - `CLICKHOUSE_CLEANUP_POLICY_DROP`
              - `CLICKHOUSE_CLEANUP_POLICY_TRUNCATE`
            type: string
            enum:
              - CLICKHOUSE_CLEANUP_POLICY_UNSPECIFIED
              - CLICKHOUSE_CLEANUP_POLICY_DISABLED
              - CLICKHOUSE_CLEANUP_POLICY_DROP
              - CLICKHOUSE_CLEANUP_POLICY_TRUNCATE
          sharding:
            description: '**`ClickhouseSharding`**'
            oneOf:
              - type: object
                properties:
                  columnValueHash:
                    description: |-
                      **`ColumnValueHash`**
                      Includes only one of the fields `columnValueHash`, `customMapping`.
                    $ref: '#/definitions/ColumnValueHash'
                  customMapping:
                    description: |-
                      **`ColumnValueMapping`**
                      Includes only one of the fields `columnValueHash`, `customMapping`.
                    $ref: '#/definitions/ColumnValueMapping'
                  transferId:
                    description: |-
                      **undefined** (empty)
                      Empty JSON object `` {} ``.
                      Includes only one of the fields `columnValueHash`, `customMapping`.
                    type: undefined
                    format: empty
                  roundRobin:
                    description: |-
                      **undefined** (empty)
                      Empty JSON object `` {} ``.
                      Includes only one of the fields `columnValueHash`, `customMapping`.
                    type: undefined
                    format: empty
          isSchemaMigrationDisabled:
            description: '**boolean**'
            type: boolean
          clickhouseClusterName:
            description: |-
              **string**
              Name of the ClickHouse cluster. For Managed ClickHouse that is name of
              ShardGroup.
            type: string
          securityGroups:
            description: '**string**'
            type: array
            items:
              type: string
      YdbTarget:
        type: object
        properties:
          database:
            description: |-
              **string**
              Path in YDB where to store tables
            type: string
          instance:
            description: |-
              **string**
              Instance of YDB. example: ydb-ru-prestable.yandex.net:2135
            type: string
          path:
            description: |-
              **string**
              Path extension for database, each table will be layouted into this path
            type: string
          serviceAccountId:
            description: '**string**'
            type: string
          cleanupPolicy:
            description: |-
              **enum** (YdbCleanupPolicy)
              Cleanup policy
              - `YDB_CLEANUP_POLICY_UNSPECIFIED`
              - `YDB_CLEANUP_POLICY_DISABLED`
              - `YDB_CLEANUP_POLICY_DROP`
            type: string
            enum:
              - YDB_CLEANUP_POLICY_UNSPECIFIED
              - YDB_CLEANUP_POLICY_DISABLED
              - YDB_CLEANUP_POLICY_DROP
          subnetId:
            description: |-
              **string**
              Network interface for endpoint. If none will assume public ipv4
            type: string
          saKeyContent:
            description: |-
              **string**
              SA content
            type: string
          securityGroups:
            description: |-
              **string**
              Security groups
            type: array
            items:
              type: string
          isTableColumnOriented:
            description: |-
              **boolean**
              Should create column-oriented table (OLAP). By default it creates row-oriented
              (OLTP)
            type: boolean
          defaultCompression:
            description: |-
              **enum** (YdbDefaultCompression)
              Compression that will be used for default columns family on YDB table creation
              - `YDB_DEFAULT_COMPRESSION_UNSPECIFIED`
              - `YDB_DEFAULT_COMPRESSION_DISABLED`
              - `YDB_DEFAULT_COMPRESSION_LZ4`
            type: string
            enum:
              - YDB_DEFAULT_COMPRESSION_UNSPECIFIED
              - YDB_DEFAULT_COMPRESSION_DISABLED
              - YDB_DEFAULT_COMPRESSION_LZ4
          isSchemaMigrationDisabled:
            description: '**boolean**'
            type: boolean
      KafkaTargetTopic:
        type: object
        properties:
          topicName:
            description: |-
              **string**
              Topic name
            type: string
          saveTxOrder:
            description: |-
              **boolean**
              Save transactions order
              Not to split events queue into separate per-table queues.
            type: boolean
      SerializerAuto:
        type: object
        properties: {}
      SerializerJSON:
        type: object
        properties: {}
      DebeziumSerializerParameter:
        type: object
        properties:
          key:
            description: |-
              **string**
              Name of the serializer parameter
            type: string
          value:
            description: |-
              **string**
              Value of the serializer parameter
            type: string
      SerializerDebezium:
        type: object
        properties:
          serializerParameters:
            description: |-
              **`DebeziumSerializerParameter`**
              Settings of sterilization parameters as key-value pairs
            type: array
            items:
              $ref: '#/definitions/DebeziumSerializerParameter'
      KafkaTarget:
        type: object
        properties:
          connection:
            description: |-
              **`KafkaConnectionOptions`**
              Connection settings
            oneOf:
              - type: object
                properties:
                  clusterId:
                    description: |-
                      **string**
                      Managed Service for Kafka cluster ID
                      Includes only one of the fields `clusterId`, `onPremise`.
                    type: string
                  onPremise:
                    description: |-
                      **`OnPremiseKafka`**
                      Connection options for on-premise Kafka
                      Includes only one of the fields `clusterId`, `onPremise`.
                    $ref: '#/definitions/OnPremiseKafka'
          auth:
            description: |-
              **`KafkaAuth`**
              Authentication settings
            oneOf:
              - type: object
                properties:
                  sasl:
                    description: |-
                      **`KafkaSaslSecurity`**
                      Authentication with SASL
                      Includes only one of the fields `sasl`, `noAuth`.
                    $ref: '#/definitions/KafkaSaslSecurity'
                  noAuth:
                    description: |-
                      **object**
                      No authentication
                      Includes only one of the fields `sasl`, `noAuth`.
                    $ref: '#/definitions/NoAuth'
          securityGroups:
            description: |-
              **string**
              Security groups
            type: array
            items:
              type: string
          topicSettings:
            description: |-
              **`KafkaTargetTopicSettings`**
              Target topic settings
            oneOf:
              - type: object
                properties:
                  topic:
                    description: |-
                      **`KafkaTargetTopic`**
                      Full topic name
                      Includes only one of the fields `topic`, `topicPrefix`.
                    $ref: '#/definitions/KafkaTargetTopic'
                  topicPrefix:
                    description: |-
                      **string**
                      Topic prefix
                      Analogue of the Debezium setting database.server.name.
                      Messages will be sent to topic with name <topic_prefix>.<schema>.<table_name>.
                      Includes only one of the fields `topic`, `topicPrefix`.
                    type: string
          serializer:
            description: |-
              **`Serializer`**
              Data serialization format settings
            oneOf:
              - type: object
                properties:
                  serializerAuto:
                    description: |-
                      **object**
                      Select the serialization format automatically
                      Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`.
                    $ref: '#/definitions/SerializerAuto'
                  serializerJson:
                    description: |-
                      **object**
                      Serialize data in json format
                      Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`.
                    $ref: '#/definitions/SerializerJSON'
                  serializerDebezium:
                    description: |-
                      **`SerializerDebezium`**
                      Serialize data in debezium format
                      Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`.
                    $ref: '#/definitions/SerializerDebezium'
      MongoTarget:
        type: object
        properties:
          connection:
            description: '**`MongoConnection`**'
            oneOf:
              - type: object
                properties:
                  connectionOptions:
                    description: |-
                      **`MongoConnectionOptions`**
                      Includes only one of the fields `connectionOptions`.
                    oneOf:
                      - type: object
                        properties:
                          mdbClusterId:
                            description: |-
                              **string**
                              Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
                            type: string
                          onPremise:
                            description: |-
                              **`OnPremiseMongo`**
                              Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
                            $ref: '#/definitions/OnPremiseMongo'
                          connectionManagerConnection:
                            description: |-
                              **`MongoConnectionManagerConnection`**
                              Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
                            $ref: '#/definitions/MongoConnectionManagerConnection'
          database:
            description: |-
              **string**
              Database name
            type: string
          cleanupPolicy:
            description: |-
              **enum** (CleanupPolicy)
              - `CLEANUP_POLICY_UNSPECIFIED`
              - `DISABLED`: Don't cleanup
              - `DROP`: Drop
              - `TRUNCATE`: Truncate
            type: string
            enum:
              - CLEANUP_POLICY_UNSPECIFIED
              - DISABLED
              - DROP
              - TRUNCATE
          subnetId:
            description: '**string**'
            type: string
          securityGroups:
            description: |-
              **string**
              Security groups
            type: array
            items:
              type: string
      MetrikaStream:
        type: object
        properties:
          type:
            description: |-
              **enum** (MetrikaStreamType)
              - `METRIKA_STREAM_TYPE_UNSPECIFIED`
              - `METRIKA_STREAM_TYPE_HITS`
              - `METRIKA_STREAM_TYPE_VISITS`
              - `METRIKA_STREAM_TYPE_HITS_V2`
            type: string
            enum:
              - METRIKA_STREAM_TYPE_UNSPECIFIED
              - METRIKA_STREAM_TYPE_HITS
              - METRIKA_STREAM_TYPE_VISITS
              - METRIKA_STREAM_TYPE_HITS_V2
          columns:
            description: '**string**'
            type: array
            items:
              type: string
      MetrikaSource:
        type: object
        properties:
          counterIds:
            description: '**string** (int64)'
            type: array
            items:
              type: string
              format: int64
          token:
            description: '**`Secret`**'
            oneOf:
              - type: object
                properties:
                  raw:
                    description: |-
                      **string**
                      Raw secret value
                      Includes only one of the fields `raw`.
                    type: string
          streams:
            description: '**`MetrikaStream`**'
            type: array
            items:
              $ref: '#/definitions/MetrikaStream'
      YDSTarget:
        type: object
        properties:
          database:
            description: |-
              **string**
              Database
            type: string
          stream:
            description: |-
              **string**
              Stream
            type: string
          serviceAccountId:
            description: |-
              **string**
              SA which has read access to the stream.
            type: string
          saveTxOrder:
            description: |-
              **boolean**
              Save transaction order
              Not to split events queue into separate per-table queues.
              Incompatible with setting Topic prefix, only with Topic full name.
            type: boolean
          compressionCodec:
            description: |-
              **enum** (YdsCompressionCodec)
              - `YDS_COMPRESSION_CODEC_UNSPECIFIED`
              - `YDS_COMPRESSION_CODEC_RAW`
              - `YDS_COMPRESSION_CODEC_GZIP`
              - `YDS_COMPRESSION_CODEC_ZSTD`
            type: string
            enum:
              - YDS_COMPRESSION_CODEC_UNSPECIFIED
              - YDS_COMPRESSION_CODEC_RAW
              - YDS_COMPRESSION_CODEC_GZIP
              - YDS_COMPRESSION_CODEC_ZSTD
          serializer:
            description: |-
              **`Serializer`**
              Data serialization format
            oneOf:
              - type: object
                properties:
                  serializerAuto:
                    description: |-
                      **object**
                      Select the serialization format automatically
                      Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`.
                    $ref: '#/definitions/SerializerAuto'
                  serializerJson:
                    description: |-
                      **object**
                      Serialize data in json format
                      Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`.
                    $ref: '#/definitions/SerializerJSON'
                  serializerDebezium:
                    description: |-
                      **`SerializerDebezium`**
                      Serialize data in debezium format
                      Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`.
                    $ref: '#/definitions/SerializerDebezium'
          endpoint:
            description: |-
              **string**
              for dedicated db
            type: string
          subnetId:
            description: |-
              **string**
              Network interface for endpoint. If none will assume public ipv4
            type: string
          securityGroups:
            description: |-
              **string**
              Security groups
            type: array
            items:
              type: string
sourcePath: en/_api-ref/datatransfer/v1/api-ref/Endpoint/create.md
---

# Data Transfer API, REST: Endpoint.Create

Creates an endpoint in the specified folder.

## HTTP request

```
POST https://{{ api-host-data-transfer }}/v1/endpoint
```

## Body parameters {#yandex.cloud.datatransfer.v1.CreateEndpointRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "settings": {
    // Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`
    "mysqlSource": {
      "connection": {
        // Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`
        "mdbClusterId": "string",
        "onPremise": {
          "port": "string",
          "subnetId": "string",
          "hosts": [
            "string"
          ],
          "tlsMode": {
            // Includes only one of the fields `enabled`
            "enabled": {
              "caCertificate": "string"
            }
            // end of the list of possible fields
          }
        },
        "connectionManagerConnection": {
          "connectionId": "string"
        }
        // end of the list of possible fields
      },
      "database": "string",
      "user": "string",
      "password": {
        // Includes only one of the fields `raw`
        "raw": "string"
        // end of the list of possible fields
      },
      "timezone": "string",
      "objectTransferSettings": {
        "view": "string",
        "routine": "string",
        "trigger": "string",
        "tables": "string"
      },
      "includeTablesRegex": [
        "string"
      ],
      "excludeTablesRegex": [
        "string"
      ],
      "securityGroups": [
        "string"
      ],
      "serviceDatabase": "string"
    },
    "postgresSource": {
      "connection": {
        // Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`
        "mdbClusterId": "string",
        "onPremise": {
          "port": "string",
          "subnetId": "string",
          "hosts": [
            "string"
          ],
          "tlsMode": {
            // Includes only one of the fields `enabled`
            "enabled": {
              "caCertificate": "string"
            }
            // end of the list of possible fields
          }
        },
        "connectionManagerConnection": {
          "connectionId": "string"
        }
        // end of the list of possible fields
      },
      "database": "string",
      "user": "string",
      "password": {
        // Includes only one of the fields `raw`
        "raw": "string"
        // end of the list of possible fields
      },
      "includeTables": [
        "string"
      ],
      "excludeTables": [
        "string"
      ],
      "slotByteLagLimit": "string",
      "serviceSchema": "string",
      "objectTransferSettings": {
        "sequence": "string",
        "sequenceOwnedBy": "string",
        "table": "string",
        "primaryKey": "string",
        "fkConstraint": "string",
        "defaultValues": "string",
        "constraint": "string",
        "index": "string",
        "view": "string",
        "function": "string",
        "trigger": "string",
        "type": "string",
        "rule": "string",
        "collation": "string",
        "policy": "string",
        "cast": "string",
        "materializedView": "string",
        "sequenceSet": "string"
      },
      "securityGroups": [
        "string"
      ]
    },
    "ydbSource": {
      "database": "string",
      "instance": "string",
      "paths": [
        "string"
      ],
      "serviceAccountId": "string",
      "subnetId": "string",
      "saKeyContent": "string",
      "securityGroups": [
        "string"
      ],
      "changefeedCustomName": "string",
      "changefeedCustomConsumerName": "string"
    },
    "ydsSource": {
      "database": "string",
      "stream": "string",
      "serviceAccountId": "string",
      "supportedCodecs": [
        "string"
      ],
      "parser": {
        // Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`
        "jsonParser": {
          "dataSchema": {
            // Includes only one of the fields `jsonFields`, `fields`
            "jsonFields": "string",
            "fields": {
              "fields": [
                {
                  "name": "string",
                  "type": "string",
                  "key": "boolean",
                  "required": "boolean",
                  "path": "string"
                }
              ]
            }
            // end of the list of possible fields
          },
          "nullKeysAllowed": "boolean",
          "addRestColumn": "boolean",
          "unescapeStringValues": "boolean"
        },
        "auditTrailsV1Parser": "object",
        "cloudLoggingParser": "object",
        "tskvParser": {
          "dataSchema": {
            // Includes only one of the fields `jsonFields`, `fields`
            "jsonFields": "string",
            "fields": {
              "fields": [
                {
                  "name": "string",
                  "type": "string",
                  "key": "boolean",
                  "required": "boolean",
                  "path": "string"
                }
              ]
            }
            // end of the list of possible fields
          },
          "nullKeysAllowed": "boolean",
          "addRestColumn": "boolean",
          "unescapeStringValues": "boolean"
        }
        // end of the list of possible fields
      },
      "allowTtlRewind": "boolean",
      "endpoint": "string",
      "subnetId": "string",
      "securityGroups": [
        "string"
      ],
      "consumer": "string"
    },
    "kafkaSource": {
      "connection": {
        // Includes only one of the fields `clusterId`, `onPremise`
        "clusterId": "string",
        "onPremise": {
          "brokerUrls": [
            "string"
          ],
          "subnetId": "string",
          "tlsMode": {
            // Includes only one of the fields `enabled`
            "enabled": {
              "caCertificate": "string"
            }
            // end of the list of possible fields
          }
        }
        // end of the list of possible fields
      },
      "auth": {
        // Includes only one of the fields `sasl`, `noAuth`
        "sasl": {
          "user": "string",
          "mechanism": "string",
          "password": {
            // Includes only one of the fields `raw`
            "raw": "string"
            // end of the list of possible fields
          }
        },
        "noAuth": "object"
        // end of the list of possible fields
      },
      "securityGroups": [
        "string"
      ],
      "topicName": "string",
      "transformer": {
        "cloudFunction": "string",
        "numberOfRetries": "string",
        "bufferSize": "string",
        "bufferFlushInterval": "string",
        "invocationTimeout": "string",
        "serviceAccountId": "string"
      },
      "parser": {
        // Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`
        "jsonParser": {
          "dataSchema": {
            // Includes only one of the fields `jsonFields`, `fields`
            "jsonFields": "string",
            "fields": {
              "fields": [
                {
                  "name": "string",
                  "type": "string",
                  "key": "boolean",
                  "required": "boolean",
                  "path": "string"
                }
              ]
            }
            // end of the list of possible fields
          },
          "nullKeysAllowed": "boolean",
          "addRestColumn": "boolean",
          "unescapeStringValues": "boolean"
        },
        "auditTrailsV1Parser": "object",
        "cloudLoggingParser": "object",
        "tskvParser": {
          "dataSchema": {
            // Includes only one of the fields `jsonFields`, `fields`
            "jsonFields": "string",
            "fields": {
              "fields": [
                {
                  "name": "string",
                  "type": "string",
                  "key": "boolean",
                  "required": "boolean",
                  "path": "string"
                }
              ]
            }
            // end of the list of possible fields
          },
          "nullKeysAllowed": "boolean",
          "addRestColumn": "boolean",
          "unescapeStringValues": "boolean"
        }
        // end of the list of possible fields
      },
      "topicNames": [
        "string"
      ]
    },
    "mongoSource": {
      "connection": {
        // Includes only one of the fields `connectionOptions`
        "connectionOptions": {
          // Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`
          "mdbClusterId": "string",
          "onPremise": {
            "hosts": [
              "string"
            ],
            "port": "string",
            "replicaSet": "string",
            "tlsMode": {
              // Includes only one of the fields `enabled`
              "enabled": {
                "caCertificate": "string"
              }
              // end of the list of possible fields
            }
          },
          "connectionManagerConnection": {
            "connectionId": "string",
            "replicaSet": "string"
          },
          // end of the list of possible fields
          "user": "string",
          "password": {
            // Includes only one of the fields `raw`
            "raw": "string"
            // end of the list of possible fields
          },
          "authSource": "string"
        }
        // end of the list of possible fields
      },
      "subnetId": "string",
      "collections": [
        {
          "databaseName": "string",
          "collectionName": "string"
        }
      ],
      "excludedCollections": [
        {
          "databaseName": "string",
          "collectionName": "string"
        }
      ],
      "secondaryPreferredMode": "boolean",
      "securityGroups": [
        "string"
      ]
    },
    "clickhouseSource": {
      "connection": {
        // Includes only one of the fields `connectionOptions`
        "connectionOptions": {
          // Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`
          "onPremise": {
            "shards": [
              {
                "name": "string",
                "hosts": [
                  "string"
                ]
              }
            ],
            "httpPort": "string",
            "nativePort": "string",
            "tlsMode": {
              // Includes only one of the fields `enabled`
              "enabled": {
                "caCertificate": "string"
              }
              // end of the list of possible fields
            }
          },
          "connectionManagerConnection": {
            "connectionId": "string"
          },
          "mdbClusterId": "string",
          // end of the list of possible fields
          "user": "string",
          "password": {
            // Includes only one of the fields `raw`
            "raw": "string"
            // end of the list of possible fields
          },
          "database": "string"
        }
        // end of the list of possible fields
      },
      "includeTables": [
        "string"
      ],
      "excludeTables": [
        "string"
      ],
      "subnetId": "string",
      "securityGroups": [
        "string"
      ],
      "clickhouseClusterName": "string"
    },
    "mysqlTarget": {
      "connection": {
        // Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`
        "mdbClusterId": "string",
        "onPremise": {
          "port": "string",
          "subnetId": "string",
          "hosts": [
            "string"
          ],
          "tlsMode": {
            // Includes only one of the fields `enabled`
            "enabled": {
              "caCertificate": "string"
            }
            // end of the list of possible fields
          }
        },
        "connectionManagerConnection": {
          "connectionId": "string"
        }
        // end of the list of possible fields
      },
      "database": "string",
      "user": "string",
      "password": {
        // Includes only one of the fields `raw`
        "raw": "string"
        // end of the list of possible fields
      },
      "sqlMode": "string",
      "skipConstraintChecks": "boolean",
      "timezone": "string",
      "cleanupPolicy": "string",
      "serviceDatabase": "string",
      "securityGroups": [
        "string"
      ],
      "isSchemaMigrationDisabled": "boolean"
    },
    "postgresTarget": {
      "connection": {
        // Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`
        "mdbClusterId": "string",
        "onPremise": {
          "port": "string",
          "subnetId": "string",
          "hosts": [
            "string"
          ],
          "tlsMode": {
            // Includes only one of the fields `enabled`
            "enabled": {
              "caCertificate": "string"
            }
            // end of the list of possible fields
          }
        },
        "connectionManagerConnection": {
          "connectionId": "string"
        }
        // end of the list of possible fields
      },
      "database": "string",
      "user": "string",
      "password": {
        // Includes only one of the fields `raw`
        "raw": "string"
        // end of the list of possible fields
      },
      "cleanupPolicy": "string",
      "securityGroups": [
        "string"
      ],
      "isSchemaMigrationDisabled": "boolean"
    },
    "clickhouseTarget": {
      "connection": {
        // Includes only one of the fields `connectionOptions`
        "connectionOptions": {
          // Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`
          "onPremise": {
            "shards": [
              {
                "name": "string",
                "hosts": [
                  "string"
                ]
              }
            ],
            "httpPort": "string",
            "nativePort": "string",
            "tlsMode": {
              // Includes only one of the fields `enabled`
              "enabled": {
                "caCertificate": "string"
              }
              // end of the list of possible fields
            }
          },
          "connectionManagerConnection": {
            "connectionId": "string"
          },
          "mdbClusterId": "string",
          // end of the list of possible fields
          "user": "string",
          "password": {
            // Includes only one of the fields `raw`
            "raw": "string"
            // end of the list of possible fields
          },
          "database": "string"
        }
        // end of the list of possible fields
      },
      "subnetId": "string",
      "altNames": [
        {
          "fromName": "string",
          "toName": "string"
        }
      ],
      "cleanupPolicy": "string",
      "sharding": {
        // Includes only one of the fields `columnValueHash`, `customMapping`
        "columnValueHash": {
          "columnName": "string"
        },
        "customMapping": {
          "columnName": "string",
          "mapping": [
            {
              "columnValue": {
                // Includes only one of the fields `stringValue`
                "stringValue": "string"
                // end of the list of possible fields
              },
              "shardName": "string"
            }
          ]
        }
        // end of the list of possible fields
      },
      "isSchemaMigrationDisabled": "boolean",
      "clickhouseClusterName": "string",
      "securityGroups": [
        "string"
      ]
    },
    "ydbTarget": {
      "database": "string",
      "instance": "string",
      "path": "string",
      "serviceAccountId": "string",
      "cleanupPolicy": "string",
      "subnetId": "string",
      "saKeyContent": "string",
      "securityGroups": [
        "string"
      ],
      "isTableColumnOriented": "boolean",
      "defaultCompression": "string",
      "isSchemaMigrationDisabled": "boolean"
    },
    "kafkaTarget": {
      "connection": {
        // Includes only one of the fields `clusterId`, `onPremise`
        "clusterId": "string",
        "onPremise": {
          "brokerUrls": [
            "string"
          ],
          "subnetId": "string",
          "tlsMode": {
            // Includes only one of the fields `enabled`
            "enabled": {
              "caCertificate": "string"
            }
            // end of the list of possible fields
          }
        }
        // end of the list of possible fields
      },
      "auth": {
        // Includes only one of the fields `sasl`, `noAuth`
        "sasl": {
          "user": "string",
          "mechanism": "string",
          "password": {
            // Includes only one of the fields `raw`
            "raw": "string"
            // end of the list of possible fields
          }
        },
        "noAuth": "object"
        // end of the list of possible fields
      },
      "securityGroups": [
        "string"
      ],
      "topicSettings": {
        // Includes only one of the fields `topic`, `topicPrefix`
        "topic": {
          "topicName": "string",
          "saveTxOrder": "boolean"
        },
        "topicPrefix": "string"
        // end of the list of possible fields
      },
      "serializer": {
        // Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`
        "serializerAuto": "object",
        "serializerJson": "object",
        "serializerDebezium": {
          "serializerParameters": [
            {
              "key": "string",
              "value": "string"
            }
          ]
        }
        // end of the list of possible fields
      }
    },
    "mongoTarget": {
      "connection": {
        // Includes only one of the fields `connectionOptions`
        "connectionOptions": {
          // Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`
          "mdbClusterId": "string",
          "onPremise": {
            "hosts": [
              "string"
            ],
            "port": "string",
            "replicaSet": "string",
            "tlsMode": {
              // Includes only one of the fields `enabled`
              "enabled": {
                "caCertificate": "string"
              }
              // end of the list of possible fields
            }
          },
          "connectionManagerConnection": {
            "connectionId": "string",
            "replicaSet": "string"
          },
          // end of the list of possible fields
          "user": "string",
          "password": {
            // Includes only one of the fields `raw`
            "raw": "string"
            // end of the list of possible fields
          },
          "authSource": "string"
        }
        // end of the list of possible fields
      },
      "database": "string",
      "cleanupPolicy": "string",
      "subnetId": "string",
      "securityGroups": [
        "string"
      ]
    },
    "metrikaSource": {
      "counterIds": [
        "string"
      ],
      "token": {
        // Includes only one of the fields `raw`
        "raw": "string"
        // end of the list of possible fields
      },
      "streams": [
        {
          "type": "string",
          "columns": [
            "string"
          ]
        }
      ]
    },
    "ydsTarget": {
      "database": "string",
      "stream": "string",
      "serviceAccountId": "string",
      "saveTxOrder": "boolean",
      "compressionCodec": "string",
      "serializer": {
        // Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`
        "serializerAuto": "object",
        "serializerJson": "object",
        "serializerDebezium": {
          "serializerParameters": [
            {
              "key": "string",
              "value": "string"
            }
          ]
        }
        // end of the list of possible fields
      },
      "endpoint": "string",
      "subnetId": "string",
      "securityGroups": [
        "string"
      ]
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to create the endpoint in.

To get the folder ID, make a
[yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| name | **string**

Name of the endpoint.

The name must be unique within the folder. ||
|| description | **string**

Description of the endpoint. ||
|| labels | **object** (map<**string**, **string**>)

Endpoint labels as `key:value` pairs.

For details about the concept, see [documentation]({{ api-url-prefix }}/resource-manager/concepts/labels). ||
|| settings | **[EndpointSettings](#yandex.cloud.datatransfer.v1.EndpointSettings)** ||
|#

## EndpointSettings {#yandex.cloud.datatransfer.v1.EndpointSettings}

#|
||Field | Description ||
|| mysqlSource | **[MysqlSource](#yandex.cloud.datatransfer.v1.endpoint.MysqlSource)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| postgresSource | **[PostgresSource](#yandex.cloud.datatransfer.v1.endpoint.PostgresSource)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| ydbSource | **[YdbSource](#yandex.cloud.datatransfer.v1.endpoint.YdbSource)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| ydsSource | **[YDSSource](#yandex.cloud.datatransfer.v1.endpoint.YDSSource)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| kafkaSource | **[KafkaSource](#yandex.cloud.datatransfer.v1.endpoint.KafkaSource)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| mongoSource | **[MongoSource](#yandex.cloud.datatransfer.v1.endpoint.MongoSource)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| clickhouseSource | **[ClickhouseSource](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSource)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| mysqlTarget | **[MysqlTarget](#yandex.cloud.datatransfer.v1.endpoint.MysqlTarget)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| postgresTarget | **[PostgresTarget](#yandex.cloud.datatransfer.v1.endpoint.PostgresTarget)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| clickhouseTarget | **[ClickhouseTarget](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseTarget)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| ydbTarget | **[YdbTarget](#yandex.cloud.datatransfer.v1.endpoint.YdbTarget)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| kafkaTarget | **[KafkaTarget](#yandex.cloud.datatransfer.v1.endpoint.KafkaTarget)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| mongoTarget | **[MongoTarget](#yandex.cloud.datatransfer.v1.endpoint.MongoTarget)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| metrikaSource | **[MetrikaSource](#yandex.cloud.datatransfer.v1.endpoint.MetrikaSource)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| ydsTarget | **[YDSTarget](#yandex.cloud.datatransfer.v1.endpoint.YDSTarget)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|#

## MysqlSource {#yandex.cloud.datatransfer.v1.endpoint.MysqlSource}

#|
||Field | Description ||
|| connection | **[MysqlConnection](#yandex.cloud.datatransfer.v1.endpoint.MysqlConnection)**

Database connection settings ||
|| database | **string**

Database name

You can leave it empty, then it will be possible to transfer tables from several
databases at the same time from this source. ||
|| user | **string**

User for database access. not required as may be in connection ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| timezone | **string**

Database timezone

Is used for parsing timestamps for saving source timezones. Accepts values from
IANA timezone database. Default: local timezone. ||
|| objectTransferSettings | **[MysqlObjectTransferSettings](#yandex.cloud.datatransfer.v1.endpoint.MysqlObjectTransferSettings)**

Schema migration

Select database objects to be transferred during activation or deactivation. ||
|| includeTablesRegex[] | **string** ||
|| excludeTablesRegex[] | **string** ||
|| securityGroups[] | **string**

Security groups ||
|| serviceDatabase | **string**

Database for service tables

Default: data source database. Here created technical tables (__tm_keeper,
__tm_gtid_keeper). ||
|#

## MysqlConnection {#yandex.cloud.datatransfer.v1.endpoint.MysqlConnection}

#|
||Field | Description ||
|| mdbClusterId | **string**

Managed Service for MySQL cluster ID

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| onPremise | **[OnPremiseMysql](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMysql)**

Connection options for on-premise MySQL

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| connectionManagerConnection | **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|#

## OnPremiseMysql {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMysql}

#|
||Field | Description ||
|| port | **string** (int64)

Database port ||
|| subnetId | **string**

Network interface for endpoint. If none will assume public ipv4 ||
|| hosts[] | **string** ||
|| tlsMode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**

TLS settings for server connection. Disabled by default. ||
|#

## TLSMode {#yandex.cloud.datatransfer.v1.endpoint.TLSMode}

#|
||Field | Description ||
|| enabled | **[TLSConfig](#yandex.cloud.datatransfer.v1.endpoint.TLSConfig)**

Includes only one of the fields `enabled`. ||
|#

## TLSConfig {#yandex.cloud.datatransfer.v1.endpoint.TLSConfig}

#|
||Field | Description ||
|| caCertificate | **string**

CA certificate

X.509 certificate of the certificate authority which issued the server's
certificate, in PEM format. When CA certificate is specified TLS is used to
connect to the server. ||
|#

## ConnectionManagerConnection {#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection}

#|
||Field | Description ||
|| connectionId | **string** ||
|#

## Secret {#yandex.cloud.datatransfer.v1.endpoint.Secret}

#|
||Field | Description ||
|| raw | **string**

Raw secret value

Includes only one of the fields `raw`. ||
|#

## MysqlObjectTransferSettings {#yandex.cloud.datatransfer.v1.endpoint.MysqlObjectTransferSettings}

#|
||Field | Description ||
|| view | **enum** (ObjectTransferStage)

Views

CREATE VIEW ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| routine | **enum** (ObjectTransferStage)

Routines

CREATE PROCEDURE ... ; CREATE FUNCTION ... ;

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| trigger | **enum** (ObjectTransferStage)

Triggers

CREATE TRIGGER ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| tables | **enum** (ObjectTransferStage)

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|#

## PostgresSource {#yandex.cloud.datatransfer.v1.endpoint.PostgresSource}

#|
||Field | Description ||
|| connection | **[PostgresConnection](#yandex.cloud.datatransfer.v1.endpoint.PostgresConnection)**

Database connection settings ||
|| database | **string**

Database name ||
|| user | **string**

User for database access. not required as may be in connection ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| includeTables[] | **string**

Included tables

If none or empty list is presented, all tables are replicated. Full table name
with schema. Can contain schema_name.* patterns. ||
|| excludeTables[] | **string**

Excluded tables

If none or empty list is presented, all tables are replicated. Full table name
with schema. Can contain schema_name.* patterns. ||
|| slotByteLagLimit | **string** (int64)

Maximum lag of replication slot (in bytes); after exceeding this limit
replication will be aborted. ||
|| serviceSchema | **string**

Database schema for service tables (__consumer_keeper,
__data_transfer_mole_finder). Default is public ||
|| objectTransferSettings | **[PostgresObjectTransferSettings](#yandex.cloud.datatransfer.v1.endpoint.PostgresObjectTransferSettings)**

Select database objects to be transferred during activation or deactivation. ||
|| securityGroups[] | **string**

Security groups ||
|#

## PostgresConnection {#yandex.cloud.datatransfer.v1.endpoint.PostgresConnection}

#|
||Field | Description ||
|| mdbClusterId | **string**

Managed Service for PostgreSQL cluster ID

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| onPremise | **[OnPremisePostgres](#yandex.cloud.datatransfer.v1.endpoint.OnPremisePostgres)**

Connection options for on-premise PostgreSQL

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| connectionManagerConnection | **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|#

## OnPremisePostgres {#yandex.cloud.datatransfer.v1.endpoint.OnPremisePostgres}

#|
||Field | Description ||
|| port | **string** (int64)

Will be used if the cluster ID is not specified. ||
|| subnetId | **string**

Network interface for endpoint. If none will assume public ipv4 ||
|| hosts[] | **string** ||
|| tlsMode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**

TLS settings for server connection. Disabled by default. ||
|#

## PostgresObjectTransferSettings {#yandex.cloud.datatransfer.v1.endpoint.PostgresObjectTransferSettings}

#|
||Field | Description ||
|| sequence | **enum** (ObjectTransferStage)

Sequences

CREATE SEQUENCE ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| sequenceOwnedBy | **enum** (ObjectTransferStage)

Owned sequences

CREATE SEQUENCE ... OWNED BY ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| table | **enum** (ObjectTransferStage)

Tables

CREATE TABLE ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| primaryKey | **enum** (ObjectTransferStage)

Primary keys

ALTER TABLE ... ADD PRIMARY KEY ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| fkConstraint | **enum** (ObjectTransferStage)

Foreign keys

ALTER TABLE ... ADD FOREIGN KEY ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| defaultValues | **enum** (ObjectTransferStage)

Default values

ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| constraint | **enum** (ObjectTransferStage)

Constraints

ALTER TABLE ... ADD CONSTRAINT ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| index | **enum** (ObjectTransferStage)

Indexes

CREATE INDEX ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| view | **enum** (ObjectTransferStage)

Views

CREATE VIEW ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| function | **enum** (ObjectTransferStage)

Functions

CREATE FUNCTION ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| trigger | **enum** (ObjectTransferStage)

Triggers

CREATE TRIGGER ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| type | **enum** (ObjectTransferStage)

Types

CREATE TYPE ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| rule | **enum** (ObjectTransferStage)

Rules

CREATE RULE ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| collation | **enum** (ObjectTransferStage)

Collations

CREATE COLLATION ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| policy | **enum** (ObjectTransferStage)

Policies

CREATE POLICY ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| cast | **enum** (ObjectTransferStage)

Casts

CREATE CAST ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| materializedView | **enum** (ObjectTransferStage)

Materialized views

CREATE MATERIALIZED VIEW ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| sequenceSet | **enum** (ObjectTransferStage)

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|#

## YdbSource {#yandex.cloud.datatransfer.v1.endpoint.YdbSource}

#|
||Field | Description ||
|| database | **string**

Path in YDB where to store tables ||
|| instance | **string**

Instance of YDB. example: ydb-ru-prestable.yandex.net:2135 ||
|| paths[] | **string** ||
|| serviceAccountId | **string** ||
|| subnetId | **string**

Network interface for endpoint. If none will assume public ipv4 ||
|| saKeyContent | **string**

Authorization Key ||
|| securityGroups[] | **string**

Security groups ||
|| changefeedCustomName | **string**

Pre-created change feed ||
|| changefeedCustomConsumerName | **string** ||
|#

## YDSSource {#yandex.cloud.datatransfer.v1.endpoint.YDSSource}

#|
||Field | Description ||
|| database | **string**

Database ||
|| stream | **string**

Stream ||
|| serviceAccountId | **string**

SA which has read access to the stream. ||
|| supportedCodecs[] | **enum** (YdsCompressionCodec)

Compression codec

- `YDS_COMPRESSION_CODEC_UNSPECIFIED`
- `YDS_COMPRESSION_CODEC_RAW`
- `YDS_COMPRESSION_CODEC_GZIP`
- `YDS_COMPRESSION_CODEC_ZSTD` ||
|| parser | **[Parser](#yandex.cloud.datatransfer.v1.endpoint.Parser)**

Data parsing rules ||
|| allowTtlRewind | **boolean**

Should continue working, if consumer read lag exceed TTL of topic
False: stop the transfer in error state, if detected lost data. True: continue
working with losing part of data ||
|| endpoint | **string**

for dedicated db ||
|| subnetId | **string**

Network interface for endpoint. If none will assume public ipv4 ||
|| securityGroups[] | **string**

Security groups ||
|| consumer | **string**

for important streams ||
|#

## Parser {#yandex.cloud.datatransfer.v1.endpoint.Parser}

#|
||Field | Description ||
|| jsonParser | **[GenericParserCommon](#yandex.cloud.datatransfer.v1.endpoint.GenericParserCommon)**

Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`. ||
|| auditTrailsV1Parser | **object**

Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`. ||
|| cloudLoggingParser | **object**

Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`. ||
|| tskvParser | **[GenericParserCommon](#yandex.cloud.datatransfer.v1.endpoint.GenericParserCommon)**

Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`. ||
|#

## GenericParserCommon {#yandex.cloud.datatransfer.v1.endpoint.GenericParserCommon}

#|
||Field | Description ||
|| dataSchema | **[DataSchema](#yandex.cloud.datatransfer.v1.endpoint.DataSchema)** ||
|| nullKeysAllowed | **boolean**

Allow null keys, if no - null keys will be putted to unparsed data ||
|| addRestColumn | **boolean**

Will add _rest column for all unknown fields ||
|| unescapeStringValues | **boolean**

Unescape string values ||
|#

## DataSchema {#yandex.cloud.datatransfer.v1.endpoint.DataSchema}

#|
||Field | Description ||
|| jsonFields | **string**

Includes only one of the fields `jsonFields`, `fields`. ||
|| fields | **[FieldList](#yandex.cloud.datatransfer.v1.endpoint.FieldList)**

Includes only one of the fields `jsonFields`, `fields`. ||
|#

## FieldList {#yandex.cloud.datatransfer.v1.endpoint.FieldList}

#|
||Field | Description ||
|| fields[] | **[ColSchema](#yandex.cloud.datatransfer.v1.endpoint.ColSchema)**

Column schema ||
|#

## ColSchema {#yandex.cloud.datatransfer.v1.endpoint.ColSchema}

#|
||Field | Description ||
|| name | **string** ||
|| type | **enum** (ColumnType)

- `COLUMN_TYPE_UNSPECIFIED`
- `INT32`
- `INT16`
- `INT8`
- `UINT64`
- `UINT32`
- `UINT16`
- `UINT8`
- `DOUBLE`
- `BOOLEAN`
- `STRING`
- `UTF8`
- `ANY`
- `DATETIME`
- `INT64` ||
|| key | **boolean** ||
|| required | **boolean** ||
|| path | **string** ||
|#

## KafkaSource {#yandex.cloud.datatransfer.v1.endpoint.KafkaSource}

#|
||Field | Description ||
|| connection | **[KafkaConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions)**

Connection settings ||
|| auth | **[KafkaAuth](#yandex.cloud.datatransfer.v1.endpoint.KafkaAuth)**

Authentication settings ||
|| securityGroups[] | **string**

Security groups ||
|| topicName | **string**

Full source topic name
Deprecated in favor of topic names ||
|| transformer | **[DataTransformationOptions](#yandex.cloud.datatransfer.v1.endpoint.DataTransformationOptions)**

Data transformation rules ||
|| parser | **[Parser](#yandex.cloud.datatransfer.v1.endpoint.Parser)**

Data parsing rules ||
|| topicNames[] | **string**

List of topic names to read ||
|#

## KafkaConnectionOptions {#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions}

#|
||Field | Description ||
|| clusterId | **string**

Managed Service for Kafka cluster ID

Includes only one of the fields `clusterId`, `onPremise`. ||
|| onPremise | **[OnPremiseKafka](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseKafka)**

Connection options for on-premise Kafka

Includes only one of the fields `clusterId`, `onPremise`. ||
|#

## OnPremiseKafka {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseKafka}

#|
||Field | Description ||
|| brokerUrls[] | **string**

Kafka broker URLs ||
|| subnetId | **string**

Network interface for endpoint. If none will assume public ipv4 ||
|| tlsMode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**

TLS settings for broker connection. Disabled by default. ||
|#

## KafkaAuth {#yandex.cloud.datatransfer.v1.endpoint.KafkaAuth}

#|
||Field | Description ||
|| sasl | **[KafkaSaslSecurity](#yandex.cloud.datatransfer.v1.endpoint.KafkaSaslSecurity)**

Authentication with SASL

Includes only one of the fields `sasl`, `noAuth`. ||
|| noAuth | **object**

No authentication

Includes only one of the fields `sasl`, `noAuth`. ||
|#

## KafkaSaslSecurity {#yandex.cloud.datatransfer.v1.endpoint.KafkaSaslSecurity}

#|
||Field | Description ||
|| user | **string**

User name ||
|| mechanism | **enum** (KafkaMechanism)

SASL mechanism for authentication

- `KAFKA_MECHANISM_UNSPECIFIED`
- `KAFKA_MECHANISM_SHA256`
- `KAFKA_MECHANISM_SHA512` ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for user ||
|#

## DataTransformationOptions {#yandex.cloud.datatransfer.v1.endpoint.DataTransformationOptions}

#|
||Field | Description ||
|| cloudFunction | **string**

Cloud function ||
|| numberOfRetries | **string** (int64)

Number of retries ||
|| bufferSize | **string**

Buffer size for function ||
|| bufferFlushInterval | **string**

Flush interval ||
|| invocationTimeout | **string**

Invocation timeout ||
|| serviceAccountId | **string**

Service account ||
|#

## MongoSource {#yandex.cloud.datatransfer.v1.endpoint.MongoSource}

#|
||Field | Description ||
|| connection | **[MongoConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnection)** ||
|| subnetId | **string** ||
|| collections[] | **[MongoCollection](#yandex.cloud.datatransfer.v1.endpoint.MongoCollection)**

List of collections for replication. Empty list implies replication of all
tables on the deployment. Allowed to use * as collection name. ||
|| excludedCollections[] | **[MongoCollection](#yandex.cloud.datatransfer.v1.endpoint.MongoCollection)**

List of forbidden collections for replication. Allowed to use * as collection
name for forbid all collections of concrete schema. ||
|| secondaryPreferredMode | **boolean**

Read mode for mongo client ||
|| securityGroups[] | **string**

Security groups ||
|#

## MongoConnection {#yandex.cloud.datatransfer.v1.endpoint.MongoConnection}

#|
||Field | Description ||
|| connectionOptions | **[MongoConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.MongoConnectionOptions)**

Includes only one of the fields `connectionOptions`. ||
|#

## MongoConnectionOptions {#yandex.cloud.datatransfer.v1.endpoint.MongoConnectionOptions}

#|
||Field | Description ||
|| mdbClusterId | **string**

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| onPremise | **[OnPremiseMongo](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMongo)**

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| connectionManagerConnection | **[MongoConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnectionManagerConnection)**

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| user | **string**

User name ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for user ||
|| authSource | **string**

Database name associated with the credentials ||
|#

## OnPremiseMongo {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMongo}

#|
||Field | Description ||
|| hosts[] | **string** ||
|| port | **string** (int64) ||
|| replicaSet | **string** ||
|| tlsMode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)** ||
|#

## MongoConnectionManagerConnection {#yandex.cloud.datatransfer.v1.endpoint.MongoConnectionManagerConnection}

#|
||Field | Description ||
|| connectionId | **string** ||
|| replicaSet | **string**

Used only for on-premise connections ||
|#

## MongoCollection {#yandex.cloud.datatransfer.v1.endpoint.MongoCollection}

#|
||Field | Description ||
|| databaseName | **string** ||
|| collectionName | **string** ||
|#

## ClickhouseSource {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSource}

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnection)** ||
|| includeTables[] | **string**

White list of tables for replication. If none or empty list is presented - will
replicate all tables. Can contain * patterns. ||
|| excludeTables[] | **string**

Exclude list of tables for replication. If none or empty list is presented -
will replicate all tables. Can contain * patterns. ||
|| subnetId | **string** ||
|| securityGroups[] | **string** ||
|| clickhouseClusterName | **string**

Name of the ClickHouse cluster. For Managed ClickHouse that is name of
ShardGroup. ||
|#

## ClickhouseConnection {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnection}

#|
||Field | Description ||
|| connectionOptions | **[ClickhouseConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnectionOptions)**

Includes only one of the fields `connectionOptions`. ||
|#

## ClickhouseConnectionOptions {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnectionOptions}

#|
||Field | Description ||
|| onPremise | **[OnPremiseClickhouse](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseClickhouse)**

Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`. ||
|| connectionManagerConnection | **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**

Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`. ||
|| mdbClusterId | **string**

Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`. ||
|| user | **string** ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)** ||
|| database | **string**

Database ||
|#

## OnPremiseClickhouse {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseClickhouse}

#|
||Field | Description ||
|| shards[] | **[ClickhouseShard](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseShard)** ||
|| httpPort | **string** (int64) ||
|| nativePort | **string** (int64) ||
|| tlsMode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)** ||
|#

## ClickhouseShard {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseShard}

#|
||Field | Description ||
|| name | **string** ||
|| hosts[] | **string** ||
|#

## MysqlTarget {#yandex.cloud.datatransfer.v1.endpoint.MysqlTarget}

#|
||Field | Description ||
|| connection | **[MysqlConnection](#yandex.cloud.datatransfer.v1.endpoint.MysqlConnection)**

Database connection settings ||
|| database | **string**

Database name

Allowed to leave it empty, then the tables will be created in databases with the
same names as on the source. If this field is empty, then you must fill below db
schema for service table. ||
|| user | **string**

User for database access. not required as may be in connection ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| sqlMode | **string**

Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION. ||
|| skipConstraintChecks | **boolean**

Disable constraints checks

Recommend to disable for increase replication speed, but if schema contain
cascading operations we don't recommend to disable. This option set
FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0. ||
|| timezone | **string**

Database timezone

Is used for parsing timestamps for saving source timezones. Accepts values from
IANA timezone database. Default: local timezone. ||
|| cleanupPolicy | **enum** (CleanupPolicy)

Cleanup policy

Cleanup policy for activate, reactivate and reupload processes. Default is
DISABLED.

- `CLEANUP_POLICY_UNSPECIFIED`
- `DISABLED`: Don't cleanup
- `DROP`: Drop
- `TRUNCATE`: Truncate ||
|| serviceDatabase | **string**

Database schema for service table

Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper). ||
|| securityGroups[] | **string**

Security groups ||
|| isSchemaMigrationDisabled | **boolean** ||
|#

## PostgresTarget {#yandex.cloud.datatransfer.v1.endpoint.PostgresTarget}

#|
||Field | Description ||
|| connection | **[PostgresConnection](#yandex.cloud.datatransfer.v1.endpoint.PostgresConnection)**

Database connection settings ||
|| database | **string**

Database name ||
|| user | **string**

User for database access. not required as may be in connection ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| cleanupPolicy | **enum** (CleanupPolicy)

Cleanup policy for activate, reactivate and reupload processes. Default is
truncate.

- `CLEANUP_POLICY_UNSPECIFIED`
- `DISABLED`: Don't cleanup
- `DROP`: Drop
- `TRUNCATE`: Truncate ||
|| securityGroups[] | **string**

Security groups ||
|| isSchemaMigrationDisabled | **boolean** ||
|#

## ClickhouseTarget {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseTarget}

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnection)** ||
|| subnetId | **string** ||
|| altNames[] | **[AltName](#yandex.cloud.datatransfer.v1.endpoint.AltName)**

Alternative table names in target ||
|| cleanupPolicy | **enum** (ClickhouseCleanupPolicy)

- `CLICKHOUSE_CLEANUP_POLICY_UNSPECIFIED`
- `CLICKHOUSE_CLEANUP_POLICY_DISABLED`
- `CLICKHOUSE_CLEANUP_POLICY_DROP`
- `CLICKHOUSE_CLEANUP_POLICY_TRUNCATE` ||
|| sharding | **[ClickhouseSharding](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding)** ||
|| isSchemaMigrationDisabled | **boolean** ||
|| clickhouseClusterName | **string**

Name of the ClickHouse cluster. For Managed ClickHouse that is name of
ShardGroup. ||
|| securityGroups[] | **string** ||
|#

## AltName {#yandex.cloud.datatransfer.v1.endpoint.AltName}

#|
||Field | Description ||
|| fromName | **string**

Source table name ||
|| toName | **string**

Target table name ||
|#

## ClickhouseSharding {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding}

#|
||Field | Description ||
|| columnValueHash | **[ColumnValueHash](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueHash)**

Includes only one of the fields `columnValueHash`, `customMapping`. ||
|| customMapping | **[ColumnValueMapping](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping)**

Includes only one of the fields `columnValueHash`, `customMapping`. ||
|#

## ColumnValueHash {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueHash}

#|
||Field | Description ||
|| columnName | **string** ||
|#

## ColumnValueMapping {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping}

#|
||Field | Description ||
|| columnName | **string** ||
|| mapping[] | **[ValueToShard](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping.ValueToShard)** ||
|#

## ValueToShard {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping.ValueToShard}

#|
||Field | Description ||
|| columnValue | **[ColumnValue](#yandex.cloud.datatransfer.v1.endpoint.ColumnValue)** ||
|| shardName | **string** ||
|#

## ColumnValue {#yandex.cloud.datatransfer.v1.endpoint.ColumnValue}

#|
||Field | Description ||
|| stringValue | **string**

Includes only one of the fields `stringValue`. ||
|#

## YdbTarget {#yandex.cloud.datatransfer.v1.endpoint.YdbTarget}

#|
||Field | Description ||
|| database | **string**

Path in YDB where to store tables ||
|| instance | **string**

Instance of YDB. example: ydb-ru-prestable.yandex.net:2135 ||
|| path | **string**

Path extension for database, each table will be layouted into this path ||
|| serviceAccountId | **string** ||
|| cleanupPolicy | **enum** (YdbCleanupPolicy)

Cleanup policy

- `YDB_CLEANUP_POLICY_UNSPECIFIED`
- `YDB_CLEANUP_POLICY_DISABLED`
- `YDB_CLEANUP_POLICY_DROP` ||
|| subnetId | **string**

Network interface for endpoint. If none will assume public ipv4 ||
|| saKeyContent | **string**

SA content ||
|| securityGroups[] | **string**

Security groups ||
|| isTableColumnOriented | **boolean**

Should create column-oriented table (OLAP). By default it creates row-oriented
(OLTP) ||
|| defaultCompression | **enum** (YdbDefaultCompression)

Compression that will be used for default columns family on YDB table creation

- `YDB_DEFAULT_COMPRESSION_UNSPECIFIED`
- `YDB_DEFAULT_COMPRESSION_DISABLED`
- `YDB_DEFAULT_COMPRESSION_LZ4` ||
|| isSchemaMigrationDisabled | **boolean** ||
|#

## KafkaTarget {#yandex.cloud.datatransfer.v1.endpoint.KafkaTarget}

#|
||Field | Description ||
|| connection | **[KafkaConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions)**

Connection settings ||
|| auth | **[KafkaAuth](#yandex.cloud.datatransfer.v1.endpoint.KafkaAuth)**

Authentication settings ||
|| securityGroups[] | **string**

Security groups ||
|| topicSettings | **[KafkaTargetTopicSettings](#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopicSettings)**

Target topic settings ||
|| serializer | **[Serializer](#yandex.cloud.datatransfer.v1.endpoint.Serializer)**

Data serialization format settings ||
|#

## KafkaTargetTopicSettings {#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopicSettings}

#|
||Field | Description ||
|| topic | **[KafkaTargetTopic](#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopic)**

Full topic name

Includes only one of the fields `topic`, `topicPrefix`. ||
|| topicPrefix | **string**

Topic prefix

Analogue of the Debezium setting database.server.name.
Messages will be sent to topic with name <topic_prefix>.<schema>.<table_name>.

Includes only one of the fields `topic`, `topicPrefix`. ||
|#

## KafkaTargetTopic {#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopic}

#|
||Field | Description ||
|| topicName | **string**

Topic name ||
|| saveTxOrder | **boolean**

Save transactions order
Not to split events queue into separate per-table queues. ||
|#

## Serializer {#yandex.cloud.datatransfer.v1.endpoint.Serializer}

Data serialization format

#|
||Field | Description ||
|| serializerAuto | **object**

Select the serialization format automatically

Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`. ||
|| serializerJson | **object**

Serialize data in json format

Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`. ||
|| serializerDebezium | **[SerializerDebezium](#yandex.cloud.datatransfer.v1.endpoint.SerializerDebezium)**

Serialize data in debezium format

Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`. ||
|#

## SerializerDebezium {#yandex.cloud.datatransfer.v1.endpoint.SerializerDebezium}

#|
||Field | Description ||
|| serializerParameters[] | **[DebeziumSerializerParameter](#yandex.cloud.datatransfer.v1.endpoint.DebeziumSerializerParameter)**

Settings of sterilization parameters as key-value pairs ||
|#

## DebeziumSerializerParameter {#yandex.cloud.datatransfer.v1.endpoint.DebeziumSerializerParameter}

#|
||Field | Description ||
|| key | **string**

Name of the serializer parameter ||
|| value | **string**

Value of the serializer parameter ||
|#

## MongoTarget {#yandex.cloud.datatransfer.v1.endpoint.MongoTarget}

#|
||Field | Description ||
|| connection | **[MongoConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnection)** ||
|| database | **string**

Database name ||
|| cleanupPolicy | **enum** (CleanupPolicy)

- `CLEANUP_POLICY_UNSPECIFIED`
- `DISABLED`: Don't cleanup
- `DROP`: Drop
- `TRUNCATE`: Truncate ||
|| subnetId | **string** ||
|| securityGroups[] | **string**

Security groups ||
|#

## MetrikaSource {#yandex.cloud.datatransfer.v1.endpoint.MetrikaSource}

#|
||Field | Description ||
|| counterIds[] | **string** (int64) ||
|| token | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)** ||
|| streams[] | **[MetrikaStream](#yandex.cloud.datatransfer.v1.endpoint.MetrikaStream)** ||
|#

## MetrikaStream {#yandex.cloud.datatransfer.v1.endpoint.MetrikaStream}

#|
||Field | Description ||
|| type | **enum** (MetrikaStreamType)

- `METRIKA_STREAM_TYPE_UNSPECIFIED`
- `METRIKA_STREAM_TYPE_HITS`
- `METRIKA_STREAM_TYPE_VISITS`
- `METRIKA_STREAM_TYPE_HITS_V2` ||
|| columns[] | **string** ||
|#

## YDSTarget {#yandex.cloud.datatransfer.v1.endpoint.YDSTarget}

#|
||Field | Description ||
|| database | **string**

Database ||
|| stream | **string**

Stream ||
|| serviceAccountId | **string**

SA which has read access to the stream. ||
|| saveTxOrder | **boolean**

Save transaction order
Not to split events queue into separate per-table queues.
Incompatible with setting Topic prefix, only with Topic full name. ||
|| compressionCodec | **enum** (YdsCompressionCodec)

- `YDS_COMPRESSION_CODEC_UNSPECIFIED`
- `YDS_COMPRESSION_CODEC_RAW`
- `YDS_COMPRESSION_CODEC_GZIP`
- `YDS_COMPRESSION_CODEC_ZSTD` ||
|| serializer | **[Serializer](#yandex.cloud.datatransfer.v1.endpoint.Serializer)**

Data serialization format ||
|| endpoint | **string**

for dedicated db ||
|| subnetId | **string**

Network interface for endpoint. If none will assume public ipv4 ||
|| securityGroups[] | **string**

Security groups ||
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