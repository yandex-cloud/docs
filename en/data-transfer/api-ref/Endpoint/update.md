---
editable: false
apiPlayground:
  - url: https://{{ api-host-data-transfer }}/v1/endpoint/{endpointId}
    method: patch
    path:
      type: object
      properties:
        endpointId:
          description: |-
            **string**
            Identifier of the endpoint to be updated.
          type: string
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        name:
          description: |-
            **string**
            The new endpoint name. Must be unique within the folder.
          type: string
        description:
          description: |-
            **string**
            The new description for the endpoint.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Endpoint labels as `key:value` pairs.
            For details about the concept, see [documentation]({{ api-url-prefix
            }}/resource-manager/concepts/labels).
          type: object
          additionalProperties:
            type: string
        settings:
          description: |-
            **[EndpointSettings](#yandex.cloud.datatransfer.v1.EndpointSettings)**
            The new endpoint settings.
          $ref: '#/definitions/EndpointSettings'
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
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
              certificate, in PEM format. When CA certificate is specified, TLS is used to
              connect to the server. If CA certificate is empty, the server's certificate must
              be signed by a well-known CA
            type: string
      TLSMode:
        type: object
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
              **[TLSConfig](#yandex.cloud.datatransfer.v1.endpoint.TLSConfig)**
              TLS is used for the server connection
              Includes only one of the fields `enabled`.
            $ref: '#/definitions/TLSConfig'
        oneOf:
          - required:
              - disabled
          - required:
              - enabled
      OnPremiseMysql:
        type: object
        properties:
          port:
            description: |-
              **string** (int64)
              Port for the database connection
            type: string
            format: int64
          subnetId:
            description: |-
              **string**
              Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
              database.
              If omitted, the server has to be accessible via Internet
            type: string
          hosts:
            description: |-
              **string**
              List of host names of the MySQL server. Exactly one host is expected
            type: array
            items:
              type: string
          tlsMode:
            description: |-
              **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**
              TLS settings for server connection. Disabled by default.
            $ref: '#/definitions/TLSMode'
      ConnectionManagerConnection:
        type: object
        properties:
          connectionId:
            description: |-
              **string**
              ID of connection in Connection Manager with installation params and credetials
            type: string
          subnetId:
            description: |-
              **string**
              Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
              database.
              If omitted, the server has to be accessible via Internet
            type: string
      MysqlConnection:
        type: object
        properties:
          mdbClusterId:
            description: |-
              **string**
              Managed Service for MySQL cluster ID
              Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
            type: string
          onPremise:
            description: |-
              **[OnPremiseMysql](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMysql)**
              Connection options for on-premise MySQL
              Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
            $ref: '#/definitions/OnPremiseMysql'
          connectionManagerConnection:
            description: |-
              **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**
              Get Mysql installation params and credentials from Connection Manager
              Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
            $ref: '#/definitions/ConnectionManagerConnection'
        oneOf:
          - required:
              - mdbClusterId
          - required:
              - onPremise
          - required:
              - connectionManagerConnection
      Secret:
        type: object
        properties:
          raw:
            description: |-
              **string**
              Raw secret value
              Includes only one of the fields `raw`.
            type: string
        oneOf:
          - required:
              - raw
      MysqlObjectTransferSettings:
        type: object
        properties:
          view:
            description: |-
              **enum** (ObjectTransferStage)
              Views
              CREATE VIEW ...
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
              **[MysqlConnection](#yandex.cloud.datatransfer.v1.endpoint.MysqlConnection)**
              Database connection settings
            $ref: '#/definitions/MysqlConnection'
          database:
            description: |-
              **string**
              Name of the database to transfer
              You can leave it empty, then it will be possible to transfer tables from several
              databases at the same time from this source.
            type: string
          user:
            description: |-
              **string**
              User for database access. Required unless connection manager connection is used
            type: string
          password:
            description: |-
              **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**
              Password for database access.
            $ref: '#/definitions/Secret'
          timezone:
            description: |-
              **string**
              Database timezone
              Is used for parsing timestamps for saving source timezones. Accepts values from
              IANA timezone database. Default: local timezone.
            default: local timezone
            type: string
          objectTransferSettings:
            description: |-
              **[MysqlObjectTransferSettings](#yandex.cloud.datatransfer.v1.endpoint.MysqlObjectTransferSettings)**
              Schema migration
              Defines which database schema objects should be transferred, e.g. views,
              routines, etc.
              All of the attrubutes in the block are optional and should be either
              `BEFORE_DATA`, `AFTER_DATA` or `NEVER`."
            $ref: '#/definitions/MysqlObjectTransferSettings'
          includeTablesRegex:
            description: |-
              **string**
              List of regular expressions of table names which should be transferred. A table
              name is formatted as schemaname.tablename. For example, a single regular
              expression may look like `^mydb.employees$`
            type: array
            items:
              type: string
          excludeTablesRegex:
            description: |-
              **string**
              Opposite of `include_table_regex`. The tables matching the specified regular
              expressions will not be transferred
            type: array
            items:
              type: string
          securityGroups:
            description: |-
              **string**
              List of security groups that the transfer associated with this endpoint should
              use
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
              PG port. Will be used if the cluster ID is not specified.
            type: string
            format: int64
          subnetId:
            description: |-
              **string**
              Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
              database.
              If omitted, the server has to be accessible via Internet
            type: string
          hosts:
            description: |-
              **string**
              PG installation hosts
            type: array
            items:
              type: string
          tlsMode:
            description: |-
              **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**
              TLS settings for server connection. Disabled by default.
            $ref: '#/definitions/TLSMode'
      PostgresConnection:
        type: object
        properties:
          mdbClusterId:
            description: |-
              **string**
              Managed Service for PostgreSQL cluster ID
              Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
            type: string
          onPremise:
            description: |-
              **[OnPremisePostgres](#yandex.cloud.datatransfer.v1.endpoint.OnPremisePostgres)**
              Connection options for on-premise PostgreSQL
              Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
            $ref: '#/definitions/OnPremisePostgres'
          connectionManagerConnection:
            description: |-
              **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**
              Get Postgres installation params and credentials from Connection Manager
              Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
            $ref: '#/definitions/ConnectionManagerConnection'
        oneOf:
          - required:
              - mdbClusterId
          - required:
              - onPremise
          - required:
              - connectionManagerConnection
      PostgresObjectTransferSettings:
        type: object
        properties:
          sequence:
            description: |-
              **enum** (ObjectTransferStage)
              Sequences
              CREATE SEQUENCE ...
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
              **[PostgresConnection](#yandex.cloud.datatransfer.v1.endpoint.PostgresConnection)**
              Database connection settings
            $ref: '#/definitions/PostgresConnection'
          database:
            description: |-
              **string**
              Name of the database to transfer
            type: string
          user:
            description: |-
              **string**
              User for database access. Required unless Connection Manager connection is used.
            type: string
          password:
            description: |-
              **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**
              Password for database access.
            $ref: '#/definitions/Secret'
          includeTables:
            description: |-
              **string**
              List of tables to transfer, formatted as `schemaname.tablename`.
              If omitted or an empty list is specified, all tables will be transferred.
              Can contain schema_name.* patterns.
            type: array
            items:
              type: string
          excludeTables:
            description: |-
              **string**
              List of tables which will not be transfered, formatted as `schemaname.tablename`
              If omitted or empty list is specified, all tables are replicated.
              Can contain schema_name.* patterns.
            type: array
            items:
              type: string
          slotByteLagLimit:
            description: |-
              **string** (int64)
              Maximum WAL size held by the replication slot (API - in bytes, terraform - in
              gigabytes);
              Exceeding this limit will result in a replication failure and deletion of the
              replication slot.
              Default is 50 gigabytes
            type: string
            format: int64
          serviceSchema:
            description: |-
              **string**
              Name of the database schema in which auxiliary tables needed for the transfer
              will be created (__consumer_keeper, __data_transfer_mole_finder).
              Empty `service_schema` implies schema `public`
            type: string
          objectTransferSettings:
            description: |-
              **[PostgresObjectTransferSettings](#yandex.cloud.datatransfer.v1.endpoint.PostgresObjectTransferSettings)**
              Defines which database schema objects should be transferred, e.g. views,
              functions, etc.
              All of the attributes in this block are optional and should be either
              `BEFORE_DATA`, `AFTER_DATA` or `NEVER`
            $ref: '#/definitions/PostgresObjectTransferSettings'
          securityGroups:
            description: |-
              **string**
              List of security groups that the transfer associated with this endpoint should
              use
            type: array
            items:
              type: string
      YdbSource:
        type: object
        properties:
          database:
            description: |-
              **string**
              Database path in YDB where tables are stored.
              Example: `/ru/transfer_manager/prod/data-transfer-yt`
            type: string
          instance:
            description: |-
              **string**
              Instance of YDB. example: ydb-ru-prestable.yandex.net:2135.
              If not specified, will be determined by database
            type: string
          paths:
            description: |-
              **string**
              A list of paths which should be uploaded. When not specified, all available
              tables are uploaded
            type: array
            items:
              type: string
          serviceAccountId:
            description: |-
              **string**
              Service account ID for interaction with database
            type: string
          subnetId:
            description: |-
              **string**
              Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
              database. If omitted, the server has to be accessible via Internet
            type: string
          saKeyContent:
            description: |-
              **string**
              Authorization Key
            type: string
          securityGroups:
            description: |-
              **string**
              List of security groups that the transfer associated with this endpoint should
              use
            type: array
            items:
              type: string
          changefeedCustomName:
            description: |-
              **string**
              Pre-created change feed if any
            type: string
          changefeedCustomConsumerName:
            description: |-
              **string**
              Consumer for pre-created change feed if any
            type: string
      ColSchema:
        type: object
        properties:
          name:
            description: |-
              **string**
              Field name
            type: string
          type:
            description: |-
              **enum** (ColumnType)
              Field type, one of: `INT64`, `INT32`, `INT16`, `INT8`, `UINT64`, `UINT32`,
              `UINT16`, `UINT8`, `DOUBLE`, `BOOLEAN`, `STRING`, `UTF8`, `ANY`, `DATETIME`.
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
            description: |-
              **boolean**
              Mark field as Primary Key
            type: boolean
          required:
            description: |-
              **boolean**
              Mark field as required
            type: boolean
          path:
            description: |-
              **string**
              Path to the field
            type: string
      FieldList:
        type: object
        properties:
          fields:
            description: |-
              **[ColSchema](#yandex.cloud.datatransfer.v1.endpoint.ColSchema)**
              Description of the column schema in the array of `fields` structure
            type: array
            items:
              $ref: '#/definitions/ColSchema'
      DataSchema:
        type: object
        properties:
          jsonFields:
            description: |-
              **string**
              Description of the data schema as JSON specification
              Includes only one of the fields `jsonFields`, `fields`.
            type: string
          fields:
            description: |-
              **[FieldList](#yandex.cloud.datatransfer.v1.endpoint.FieldList)**
              Description of the data schema in the array of `fields` structure
              Includes only one of the fields `jsonFields`, `fields`.
            $ref: '#/definitions/FieldList'
        oneOf:
          - required:
              - jsonFields
          - required:
              - fields
      GenericParserCommon:
        type: object
        properties:
          dataSchema:
            description: |-
              **[DataSchema](#yandex.cloud.datatransfer.v1.endpoint.DataSchema)**
              Data parsing scheme
            $ref: '#/definitions/DataSchema'
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
      Parser:
        type: object
        properties:
          jsonParser:
            description: |-
              **[GenericParserCommon](#yandex.cloud.datatransfer.v1.endpoint.GenericParserCommon)**
              Parse data in json format
              Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`.
            $ref: '#/definitions/GenericParserCommon'
          auditTrailsV1Parser:
            description: |-
              **object**
              Parse Audit Trails data. Empty struct
              Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`.
            $ref: '#/definitions/AuditTrailsV1Parser'
          cloudLoggingParser:
            description: |-
              **object**
              Parse Cloud Logging data. Empty struct
              Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`.
            $ref: '#/definitions/CloudLoggingParser'
          tskvParser:
            description: |-
              **[GenericParserCommon](#yandex.cloud.datatransfer.v1.endpoint.GenericParserCommon)**
              Parse data in tskv format
              Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`.
            $ref: '#/definitions/GenericParserCommon'
        oneOf:
          - required:
              - jsonParser
          - required:
              - auditTrailsV1Parser
          - required:
              - cloudLoggingParser
          - required:
              - tskvParser
      YDSSource:
        type: object
        properties:
          database:
            description: |-
              **string**
              Database path in YDB for streams
              Example: `/ru/transfer_manager/prod/data-transfer`
            type: string
          stream:
            description: |-
              **string**
              Stream to read
            type: string
          serviceAccountId:
            description: |-
              **string**
              Service account ID which has read access to the stream.
            type: string
          supportedCodecs:
            description: |-
              **enum** (YdsCompressionCodec)
              List of supported compression codecs
              Options: YDS_COMPRESSION_CODEC_RAW, YDS_COMPRESSION_CODEC_ZSTD,
              YDS_COMPRESSION_CODEC_GZIP
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
              **[Parser](#yandex.cloud.datatransfer.v1.endpoint.Parser)**
              Data parsing rules
            $ref: '#/definitions/Parser'
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
              YDS Endpoint for dedicated db
            type: string
          subnetId:
            description: |-
              **string**
              Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
              database. If omitted, the server has to be accessible via Internet
            type: string
          securityGroups:
            description: |-
              **string**
              List of security groups that the transfer associated with this endpoint should
              use
            type: array
            items:
              type: string
          consumer:
            description: |-
              **string**
              Custom consumer - for important streams
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
              Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
              database.
              If omitted, the server has to be accessible via Internet
            type: string
          tlsMode:
            description: |-
              **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**
              TLS settings for broker connection. Disabled by default.
            $ref: '#/definitions/TLSMode'
      KafkaConnectionOptions:
        type: object
        properties:
          clusterId:
            description: |-
              **string**
              Managed Service for Kafka cluster ID.
              Set only one of: cluster_id/on_premise/connection_manager_connection
              Includes only one of the fields `clusterId`, `onPremise`, `connectionManagerConnection`.
            type: string
          onPremise:
            description: |-
              **[OnPremiseKafka](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseKafka)**
              Connection options for on-premise Kafka
              Set only one of: cluster_id/on_premise/connection_manager_connection
              Includes only one of the fields `clusterId`, `onPremise`, `connectionManagerConnection`.
            $ref: '#/definitions/OnPremiseKafka'
          connectionManagerConnection:
            description: |-
              **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**
              Get Kafka installation params and credentials from Connection Manager
              Set only one of: cluster_id/on_premise/connection_manager_connection
              Includes only one of the fields `clusterId`, `onPremise`, `connectionManagerConnection`.
            $ref: '#/definitions/ConnectionManagerConnection'
        oneOf:
          - required:
              - clusterId
          - required:
              - onPremise
          - required:
              - connectionManagerConnection
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
              SASL mechanism for authentication, use one of: KAFKA_MECHANISM_SHA256,
              KAFKA_MECHANISM_SHA512
              - `KAFKA_MECHANISM_SHA256`
              - `KAFKA_MECHANISM_SHA512`
            type: string
            enum:
              - KAFKA_MECHANISM_UNSPECIFIED
              - KAFKA_MECHANISM_SHA256
              - KAFKA_MECHANISM_SHA512
          password:
            description: |-
              **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**
              Password for user
            $ref: '#/definitions/Secret'
      NoAuth:
        type: object
        properties: {}
      KafkaAuth:
        type: object
        properties:
          sasl:
            description: |-
              **[KafkaSaslSecurity](#yandex.cloud.datatransfer.v1.endpoint.KafkaSaslSecurity)**
              Authentication with SASL
              Includes only one of the fields `sasl`, `noAuth`.
            $ref: '#/definitions/KafkaSaslSecurity'
          noAuth:
            description: |-
              **object**
              No authentication
              Includes only one of the fields `sasl`, `noAuth`.
            $ref: '#/definitions/NoAuth'
        oneOf:
          - required:
              - sasl
          - required:
              - noAuth
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
              Buffer size for function. Maximum 4 GB.  Use value with units, i.e. 10 B, 20 kB,
              2.0 MB, 30 MB, 1.0 GB
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
              **[KafkaConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions)**
              Connection settings
            $ref: '#/definitions/KafkaConnectionOptions'
          auth:
            description: |-
              **[KafkaAuth](#yandex.cloud.datatransfer.v1.endpoint.KafkaAuth)**
              Authentication settings
            $ref: '#/definitions/KafkaAuth'
          securityGroups:
            description: |-
              **string**
              List of security groups that the transfer associated with this endpoint should
              use
            type: array
            items:
              type: string
          topicName:
            description: |-
              **string**
              *Deprecated**. Please use `topic_names` instead
              Full source topic name
            deprecated: true
            type: string
          transformer:
            description: |-
              **[DataTransformationOptions](#yandex.cloud.datatransfer.v1.endpoint.DataTransformationOptions)**
              Transform data with a custom Cloud Function
            $ref: '#/definitions/DataTransformationOptions'
          parser:
            description: |-
              **[Parser](#yandex.cloud.datatransfer.v1.endpoint.Parser)**
              Data parsing parameters. If not set, the source messages are read in raw
            $ref: '#/definitions/Parser'
          topicNames:
            description: |-
              **string**
              List of full source topic names to read
            type: array
            items:
              type: string
      OnPremiseMongo:
        type: object
        properties:
          hosts:
            description: |-
              **string**
              Host names of the replica set
            type: array
            items:
              type: string
          port:
            description: |-
              **string** (int64)
              TCP Port number
            type: string
            format: int64
          replicaSet:
            description: |-
              **string**
              Replica set name
            type: string
          tlsMode:
            description: |-
              **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**
              TLS settings for the server connection. Empty implies plaintext connection
            $ref: '#/definitions/TLSMode'
      MongoConnectionManagerConnection:
        type: object
        properties:
          connectionId:
            description: |-
              **string**
              ID of connectionmanager connection with mongodb/Yandex Storedoc installation
              parameters and credentials
            type: string
          replicaSet:
            description: |-
              **string**
              Replica set name, used only for on-premise mongodb installations
            type: string
      MongoConnectionOptions:
        type: object
        properties:
          mdbClusterId:
            description: |-
              **string**
              Identifier of the Yandex StoreDoc cluster
              Use one of:  mdb_cluster_id/on_premise/connection_manager_connection
              Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
            type: string
          onPremise:
            description: |-
              **[OnPremiseMongo](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMongo)**
              Connection settings of the on-premise MongoDB server
              Use one of:  mdb_cluster_id/on_premise/connection_manager_connection
              Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
            $ref: '#/definitions/OnPremiseMongo'
          connectionManagerConnection:
            description: |-
              **[MongoConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnectionManagerConnection)**
              Get StoreDoc/MongoDB installation params and credentials from Connection Manager
              Use one of:  mdb_cluster_id/on_premise/connection_manager_connection
              Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`.
            $ref: '#/definitions/MongoConnectionManagerConnection'
          user:
            description: |-
              **string**
              User name, required unless connection_manager_connection is used
            type: string
          password:
            description: |-
              **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**
              Password for user
            $ref: '#/definitions/Secret'
          authSource:
            description: |-
              **string**
              Database name associated with the credentials
            type: string
        oneOf:
          - required:
              - mdbClusterId
          - required:
              - onPremise
          - required:
              - connectionManagerConnection
      MongoConnection:
        type: object
        properties:
          connectionOptions:
            description: |-
              **[MongoConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.MongoConnectionOptions)**
              Includes only one of the fields `connectionOptions`.
            $ref: '#/definitions/MongoConnectionOptions'
        oneOf:
          - required:
              - connectionOptions
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
            description: |-
              **[MongoConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnection)**
              Connection settings
            $ref: '#/definitions/MongoConnection'
          subnetId:
            description: |-
              **string**
              Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
              database.
              If omitted, the server has to be accessible via Internet
            type: string
          collections:
            description: |-
              **[MongoCollection](#yandex.cloud.datatransfer.v1.endpoint.MongoCollection)**
              List of collections for replication. Empty list implies replication of all
              tables on the deployment. Allowed to use * as collection name.
            type: array
            items:
              $ref: '#/definitions/MongoCollection'
          excludedCollections:
            description: |-
              **[MongoCollection](#yandex.cloud.datatransfer.v1.endpoint.MongoCollection)**
              List of forbidden collections for replication. Allowed to use * as collection
              name for forbid all collections of concrete schema.
            type: array
            items:
              $ref: '#/definitions/MongoCollection'
          secondaryPreferredMode:
            description: |-
              **boolean**
              Read mode for mongo client: whether the secondary server should be preferred to
              the primary when copying data
            type: boolean
          securityGroups:
            description: |-
              **string**
              List of security groups that the transfer associated with this endpoint should
              use
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
            description: '**[ClickhouseShard](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseShard)**'
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
            description: |-
              **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**
              TLS settings for server connection. Disabled by default
            $ref: '#/definitions/TLSMode'
      ClickhouseConnectionOptions:
        type: object
        properties:
          onPremise:
            description: |-
              **[OnPremiseClickhouse](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseClickhouse)**
              Connection settings of the on-premise ClickHouse server
              Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`.
            $ref: '#/definitions/OnPremiseClickhouse'
          connectionManagerConnection:
            description: |-
              **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**
              Get ClickHouse installation params and credentials from Connection Manager
              Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`.
            $ref: '#/definitions/ConnectionManagerConnection'
          mdbClusterId:
            description: |-
              **string**
              Identifier of the Managed ClickHouse cluster
              Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`.
            type: string
          user:
            description: |-
              **string**
              User for database access. Required unless connection_manager_connection is used
            type: string
          password:
            description: |-
              **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**
              Password for the database access
            $ref: '#/definitions/Secret'
          database:
            description: |-
              **string**
              Database name
            type: string
        oneOf:
          - required:
              - onPremise
          - required:
              - connectionManagerConnection
          - required:
              - mdbClusterId
      ClickhouseConnection:
        type: object
        properties:
          connectionOptions:
            description: |-
              **[ClickhouseConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnectionOptions)**
              Includes only one of the fields `connectionOptions`.
            $ref: '#/definitions/ClickhouseConnectionOptions'
        oneOf:
          - required:
              - connectionOptions
      ClickhouseSource:
        type: object
        properties:
          connection:
            description: |-
              **[ClickhouseConnection](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnection)**
              Connection settings
            $ref: '#/definitions/ClickhouseConnection'
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
            description: |-
              **string**
              Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
              database.
              If omitted, the server has to be accessible via Internet
            type: string
          securityGroups:
            description: |-
              **string**
              List of security groups that the transfer associated with this endpoint should
              use
            type: array
            items:
              type: string
          clickhouseClusterName:
            description: |-
              **string**
              Name of the ClickHouse cluster. For Managed ClickHouse that is name of
              ShardGroup or managed cluster ID by default
            type: string
      MysqlTarget:
        type: object
        properties:
          connection:
            description: |-
              **[MysqlConnection](#yandex.cloud.datatransfer.v1.endpoint.MysqlConnection)**
              Database connection settings
            $ref: '#/definitions/MysqlConnection'
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
              User for database access. Required unless connection manager connection is used
            type: string
          password:
            description: |-
              **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**
              Password for database access.
            $ref: '#/definitions/Secret'
          sqlMode:
            description: |-
              **string**
              [sql_mode](https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html) to use when
              interacting with the server.
              Defaults to `NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION`
            type: string
          skipConstraintChecks:
            description: |-
              **boolean**
              Disable constraints checks
              When `true`, disables foreign key checks and unique checks. `False` by default.
              See
              [foreign_key_checks](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_foreign_key_checks).
              Recommend to disable for increase replication speed unless schema contains
              cascading operations
            type: boolean
          timezone:
            description: |-
              **string**
              Database timezone
              Is used for parsing timestamps for saving source timezones. Accepts values from
              IANA timezone database. Default: local timezone.
            default: local timezone
            type: string
          cleanupPolicy:
            description: |-
              **enum** (CleanupPolicy)
              Cleanup policy for activate, reactivate and reupload processes.
              One of `DISABLED`, `DROP` or `TRUNCATE` Default is `DISABLED`.
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
            default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper)
            type: string
          securityGroups:
            description: |-
              **string**
              List of security groups that the transfer associated with this endpoint should
              use
            type: array
            items:
              type: string
          isSchemaMigrationDisabled:
            description: |-
              **boolean**
              Whether can change table schema if schema changed on source
            type: boolean
      PostgresTarget:
        type: object
        properties:
          connection:
            description: |-
              **[PostgresConnection](#yandex.cloud.datatransfer.v1.endpoint.PostgresConnection)**
              Database connection settings
            $ref: '#/definitions/PostgresConnection'
          database:
            description: |-
              **string**
              Target database name
            type: string
          user:
            description: |-
              **string**
              User for database access. Required unless Connection Manager connection is used
            type: string
          password:
            description: |-
              **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**
              Password for database access.
            $ref: '#/definitions/Secret'
          cleanupPolicy:
            description: |-
              **enum** (CleanupPolicy)
              Cleanup policy for activate, reactivate and reupload processes.
              One of: DISABLED, DROP, TRUNCATE. Default is TRUNCATE
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
              List of security groups that the transfer associated with this endpoint should
              use
            type: array
            items:
              type: string
          isSchemaMigrationDisabled:
            description: |-
              **boolean**
              Whether can change table schema if schema changed on source
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
            description: |-
              **string**
              The name of the column to calculate hash from
            type: string
      ColumnValue:
        type: object
        properties:
          stringValue:
            description: |-
              **string**
              Includes only one of the fields `stringValue`.
            type: string
        oneOf:
          - required:
              - stringValue
      ValueToShard:
        type: object
        properties:
          columnValue:
            description: |-
              **[ColumnValue](#yandex.cloud.datatransfer.v1.endpoint.ColumnValue)**
              The value of the column. Currently only the string columns are supported
            $ref: '#/definitions/ColumnValue'
          shardName:
            description: |-
              **string**
              The name of the shard into which all the rows with the specified `column_value`
              will be written
            type: string
      ColumnValueMapping:
        type: object
        properties:
          columnName:
            description: |-
              **string**
              The name of the column to inspect when deciding the shard to chose for an
              incoming row
            type: string
          mapping:
            description: |-
              **[ValueToShard](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping.ValueToShard)**
              The mapping of the specified column values to the shard names
            type: array
            items:
              $ref: '#/definitions/ValueToShard'
      ClickhouseSharding:
        type: object
        properties:
          columnValueHash:
            description: |-
              **[ColumnValueHash](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueHash)**
              Shard data by the hash value of the specified column
              Includes only one of the fields `columnValueHash`, `customMapping`.
            $ref: '#/definitions/ColumnValueHash'
          customMapping:
            description: |-
              **[ColumnValueMapping](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping)**
              A custom shard mapping by the value of the specified column
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
        oneOf:
          - required:
              - columnValueHash
          - required:
              - customMapping
          - required:
              - transferId
          - required:
              - roundRobin
      ClickhouseTarget:
        type: object
        properties:
          connection:
            description: |-
              **[ClickhouseConnection](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnection)**
              Connection settings
            $ref: '#/definitions/ClickhouseConnection'
          subnetId:
            description: |-
              **string**
              Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
              database.
              If omitted, the server has to be accessible via Internet
            type: string
          altNames:
            description: |-
              **[AltName](#yandex.cloud.datatransfer.v1.endpoint.AltName)**
              Table renaming rules in target
            type: array
            items:
              $ref: '#/definitions/AltName'
          cleanupPolicy:
            description: |-
              **enum** (ClickhouseCleanupPolicy)
              How to clean collections when activating the transfer. One of
              `CLICKHOUSE_CLEANUP_POLICY_DISABLED` or `CLICKHOUSE_CLEANUP_POLICY_DROP`
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
            description: |-
              **[ClickhouseSharding](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding)**
              Shard selection rules for the data being transferred
            $ref: '#/definitions/ClickhouseSharding'
          isSchemaMigrationDisabled:
            description: |-
              **boolean**
              Whether can change table schema if schema changed on source
            type: boolean
          clickhouseClusterName:
            description: |-
              **string**
              Name of the ClickHouse cluster. For Managed ClickHouse that is name of
              ShardGroup or managed cluster ID by default.
            type: string
          securityGroups:
            description: |-
              **string**
              List of security groups that the transfer associated with this endpoint should
              use
            type: array
            items:
              type: string
      YdbTarget:
        type: object
        properties:
          database:
            description: |-
              **string**
              Database path in YDB where tables are stored.
              Example: `/ru/transfer_manager/prod/data-transfer`
            type: string
          instance:
            description: |-
              **string**
              Instance of YDB. example: ydb-ru-prestable.yandex.net:2135.
              If not specified, will be determined by database
            type: string
          path:
            description: |-
              **string**
              Path extension for database, each table will be layouted into this path
            type: string
          serviceAccountId:
            description: |-
              **string**
              Service account ID for interaction with database
            type: string
          cleanupPolicy:
            description: |-
              **enum** (YdbCleanupPolicy)
              Cleanup policy determine how to clean collections when activating the transfer.
              One of `YDB_CLEANUP_POLICY_DISABLED` or `YDB_CLEANUP_POLICY_DROP`
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
              Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
              database.
              If omitted, the server has to be accessible via Internet
            type: string
          saKeyContent:
            description: |-
              **string**
              Authentication key
            type: string
          securityGroups:
            description: |-
              **string**
              List of security groups that the transfer associated with this endpoint should
              use
            type: array
            items:
              type: string
          isTableColumnOriented:
            description: |-
              **boolean**
              Whether a column-oriented (i.e. OLAP) tables should be created.
              Default is `false` (create row-oriented OLTP tables)
            type: boolean
          defaultCompression:
            description: |-
              **enum** (YdbDefaultCompression)
              Compression that will be used for default columns family on YDB table creation.
              One of `YDB_DEFAULT_COMPRESSION_UNSPECIFIED`,
              `YDB_DEFAULT_COMPRESSION_DISABLED`, `YDB_DEFAULT_COMPRESSION_LZ4`
              - `YDB_DEFAULT_COMPRESSION_DISABLED`
              - `YDB_DEFAULT_COMPRESSION_LZ4`
            type: string
            enum:
              - YDB_DEFAULT_COMPRESSION_UNSPECIFIED
              - YDB_DEFAULT_COMPRESSION_DISABLED
              - YDB_DEFAULT_COMPRESSION_LZ4
          isSchemaMigrationDisabled:
            description: |-
              **boolean**
              Whether can change table schema if schema changed on source
            type: boolean
      KafkaTargetTopic:
        type: object
        properties:
          topicName:
            description: |-
              **string**
              Full topic name
            type: string
          saveTxOrder:
            description: |-
              **boolean**
              Save transactions order
              Not to split events queue into separate per-table queues.
            type: boolean
      KafkaTargetTopicSettings:
        type: object
        properties:
          topic:
            description: |-
              **[KafkaTargetTopic](#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopic)**
              All messages will be sent to one topic
              Includes only one of the fields `topic`, `topicPrefix`.
            $ref: '#/definitions/KafkaTargetTopic'
          topicPrefix:
            description: |-
              **string**
              Topic prefix
              Messages will be sent to topic with name &lt;topic_prefix&gt;.&lt;schema&gt;.&lt;table_name&gt;.
              Analogue of the Debezium setting database.server.name.
              Includes only one of the fields `topic`, `topicPrefix`.
            type: string
        oneOf:
          - required:
              - topic
          - required:
              - topicPrefix
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
              **[DebeziumSerializerParameter](#yandex.cloud.datatransfer.v1.endpoint.DebeziumSerializerParameter)**
              A list of Debezium parameters set by the structure of the `key` and `value`
              string fields
            type: array
            items:
              $ref: '#/definitions/DebeziumSerializerParameter'
      Serializer:
        type: object
        properties:
          serializerAuto:
            description: |-
              **object**
              Empty block. Select the serialization format automatically
              Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`.
            $ref: '#/definitions/SerializerAuto'
          serializerJson:
            description: |-
              **object**
              Empty block. Serialize data in json format
              Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`.
            $ref: '#/definitions/SerializerJSON'
          serializerDebezium:
            description: |-
              **[SerializerDebezium](#yandex.cloud.datatransfer.v1.endpoint.SerializerDebezium)**
              Serialize data in debezium json format
              Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`.
            $ref: '#/definitions/SerializerDebezium'
        oneOf:
          - required:
              - serializerAuto
          - required:
              - serializerJson
          - required:
              - serializerDebezium
      KafkaTarget:
        type: object
        properties:
          connection:
            description: |-
              **[KafkaConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions)**
              Connection settings
            $ref: '#/definitions/KafkaConnectionOptions'
          auth:
            description: |-
              **[KafkaAuth](#yandex.cloud.datatransfer.v1.endpoint.KafkaAuth)**
              Authentication settings
            $ref: '#/definitions/KafkaAuth'
          securityGroups:
            description: |-
              **string**
              List of security groups that the transfer associated with this endpoint should
              use
            type: array
            items:
              type: string
          topicSettings:
            description: |-
              **[KafkaTargetTopicSettings](#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopicSettings)**
              Target topic settings
            $ref: '#/definitions/KafkaTargetTopicSettings'
          serializer:
            description: |-
              **[Serializer](#yandex.cloud.datatransfer.v1.endpoint.Serializer)**
              Data serialization format settings
            $ref: '#/definitions/Serializer'
      MongoTarget:
        type: object
        properties:
          connection:
            description: |-
              **[MongoConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnection)**
              Connection settings
            $ref: '#/definitions/MongoConnection'
          database:
            description: |-
              **string**
              Database name. If not empty, then all the data will be written to the database
              with the specified name; otherwise the database name is the same as in the
              source endpoint
            type: string
          cleanupPolicy:
            description: |-
              **enum** (CleanupPolicy)
              How to clean collections when activating the transfer. One of `DISABLED`, `DROP`
              or `TRUNCATE`
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
            description: |-
              **string**
              Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
              database.
              If omitted, the server has to be accessible via Internet
            type: string
          securityGroups:
            description: |-
              **string**
              List of security groups that the transfer associated with this endpoint should
              use
            type: array
            items:
              type: string
      MetrikaStream:
        type: object
        properties:
          type:
            description: |-
              **enum** (MetrikaStreamType)
              Stream type, one of: METRIKA_STREAM_TYPE_HITS, METRIKA_STREAM_TYPE_VISITS,
              METRIKA_STREAM_TYPE_HITS_V2
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
            description: |-
              **string**
              Column names
            type: array
            items:
              type: string
      MetrikaSource:
        type: object
        properties:
          counterIds:
            description: |-
              **string** (int64)
              Counter IDs
            type: array
            items:
              type: string
              format: int64
          token:
            description: |-
              **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**
              Authentication token
            $ref: '#/definitions/Secret'
          streams:
            description: |-
              **[MetrikaStream](#yandex.cloud.datatransfer.v1.endpoint.MetrikaStream)**
              Streams
            type: array
            items:
              $ref: '#/definitions/MetrikaStream'
      YDSTarget:
        type: object
        properties:
          database:
            description: |-
              **string**
              Database path in YDB for streams
              Example: `/ru/transfer_manager/prod/data-transfer`
            type: string
          stream:
            description: |-
              **string**
              Stream to write to
            type: string
          serviceAccountId:
            description: |-
              **string**
              Service account ID which has read access to the stream
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
              Codec to use for output data compression. If not specified, no compression will
              be done
              Options: YDS_COMPRESSION_CODEC_RAW, YDS_COMPRESSION_CODEC_ZSTD,
              YDS_COMPRESSION_CODEC_GZIP
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
              **[Serializer](#yandex.cloud.datatransfer.v1.endpoint.Serializer)**
              Data serialization format
            $ref: '#/definitions/Serializer'
          endpoint:
            description: |-
              **string**
              YDS Endpoint for dedicated db
            type: string
          subnetId:
            description: |-
              **string**
              Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
              database. If omitted, the server has to be accessible via Internet
            type: string
          securityGroups:
            description: |-
              **string**
              List of security groups that the transfer associated with this endpoint should
              use
            type: array
            items:
              type: string
      EndpointSettings:
        type: object
        properties:
          mysqlSource:
            description: |-
              **[MysqlSource](#yandex.cloud.datatransfer.v1.endpoint.MysqlSource)**
              Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
            $ref: '#/definitions/MysqlSource'
          postgresSource:
            description: |-
              **[PostgresSource](#yandex.cloud.datatransfer.v1.endpoint.PostgresSource)**
              Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
            $ref: '#/definitions/PostgresSource'
          ydbSource:
            description: |-
              **[YdbSource](#yandex.cloud.datatransfer.v1.endpoint.YdbSource)**
              Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
            $ref: '#/definitions/YdbSource'
          ydsSource:
            description: |-
              **[YDSSource](#yandex.cloud.datatransfer.v1.endpoint.YDSSource)**
              Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
            $ref: '#/definitions/YDSSource'
          kafkaSource:
            description: |-
              **[KafkaSource](#yandex.cloud.datatransfer.v1.endpoint.KafkaSource)**
              Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
            $ref: '#/definitions/KafkaSource'
          mongoSource:
            description: |-
              **[MongoSource](#yandex.cloud.datatransfer.v1.endpoint.MongoSource)**
              Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
            $ref: '#/definitions/MongoSource'
          clickhouseSource:
            description: |-
              **[ClickhouseSource](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSource)**
              Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
            $ref: '#/definitions/ClickhouseSource'
          mysqlTarget:
            description: |-
              **[MysqlTarget](#yandex.cloud.datatransfer.v1.endpoint.MysqlTarget)**
              Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
            $ref: '#/definitions/MysqlTarget'
          postgresTarget:
            description: |-
              **[PostgresTarget](#yandex.cloud.datatransfer.v1.endpoint.PostgresTarget)**
              Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
            $ref: '#/definitions/PostgresTarget'
          clickhouseTarget:
            description: |-
              **[ClickhouseTarget](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseTarget)**
              Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
            $ref: '#/definitions/ClickhouseTarget'
          ydbTarget:
            description: |-
              **[YdbTarget](#yandex.cloud.datatransfer.v1.endpoint.YdbTarget)**
              Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
            $ref: '#/definitions/YdbTarget'
          kafkaTarget:
            description: |-
              **[KafkaTarget](#yandex.cloud.datatransfer.v1.endpoint.KafkaTarget)**
              Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
            $ref: '#/definitions/KafkaTarget'
          mongoTarget:
            description: |-
              **[MongoTarget](#yandex.cloud.datatransfer.v1.endpoint.MongoTarget)**
              Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
            $ref: '#/definitions/MongoTarget'
          metrikaSource:
            description: |-
              **[MetrikaSource](#yandex.cloud.datatransfer.v1.endpoint.MetrikaSource)**
              Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
            $ref: '#/definitions/MetrikaSource'
          ydsTarget:
            description: |-
              **[YDSTarget](#yandex.cloud.datatransfer.v1.endpoint.YDSTarget)**
              Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`.
            $ref: '#/definitions/YDSTarget'
        oneOf:
          - required:
              - mysqlSource
          - required:
              - postgresSource
          - required:
              - ydbSource
          - required:
              - ydsSource
          - required:
              - kafkaSource
          - required:
              - mongoSource
          - required:
              - clickhouseSource
          - required:
              - mysqlTarget
          - required:
              - postgresTarget
          - required:
              - clickhouseTarget
          - required:
              - ydbTarget
          - required:
              - kafkaTarget
          - required:
              - mongoTarget
          - required:
              - metrikaSource
          - required:
              - ydsTarget
---

# Data Transfer API, REST: Endpoint.Update

Updates the specified endpoint.

## HTTP request

```
PATCH https://{{ api-host-data-transfer }}/v1/endpoint/{endpointId}
```

## Path parameters

#|
||Field | Description ||
|| endpointId | **string**

Required field. Identifier of the endpoint to be updated. ||
|#

## Body parameters {#yandex.cloud.datatransfer.v1.UpdateEndpointRequest}

```json
{
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
          "connectionId": "string",
          "subnetId": "string"
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
          "connectionId": "string",
          "subnetId": "string"
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
        // Includes only one of the fields `clusterId`, `onPremise`, `connectionManagerConnection`
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
        },
        "connectionManagerConnection": {
          "connectionId": "string",
          "subnetId": "string"
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
            "connectionId": "string",
            "subnetId": "string"
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
          "connectionId": "string",
          "subnetId": "string"
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
          "connectionId": "string",
          "subnetId": "string"
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
            "connectionId": "string",
            "subnetId": "string"
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
        // Includes only one of the fields `clusterId`, `onPremise`, `connectionManagerConnection`
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
        },
        "connectionManagerConnection": {
          "connectionId": "string",
          "subnetId": "string"
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
  },
  "updateMask": "string"
}
```

#|
||Field | Description ||
|| name | **string**

The new endpoint name. Must be unique within the folder. ||
|| description | **string**

The new description for the endpoint. ||
|| labels | **object** (map<**string**, **string**>)

Endpoint labels as `key:value` pairs.

For details about the concept, see [documentation]({{ api-url-prefix
}}/resource-manager/concepts/labels). ||
|| settings | **[EndpointSettings](#yandex.cloud.datatransfer.v1.EndpointSettings)**

The new endpoint settings. ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
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

Settings specific to the MySQL source endpoint

#|
||Field | Description ||
|| connection | **[MysqlConnection](#yandex.cloud.datatransfer.v1.endpoint.MysqlConnection)**

Database connection settings ||
|| database | **string**

Name of the database to transfer

You can leave it empty, then it will be possible to transfer tables from several
databases at the same time from this source. ||
|| user | **string**

User for database access. Required unless connection manager connection is used ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| timezone | **string**

Database timezone

Is used for parsing timestamps for saving source timezones. Accepts values from
IANA timezone database. Default: local timezone. ||
|| objectTransferSettings | **[MysqlObjectTransferSettings](#yandex.cloud.datatransfer.v1.endpoint.MysqlObjectTransferSettings)**

Schema migration
Defines which database schema objects should be transferred, e.g. views,
routines, etc.
All of the attrubutes in the block are optional and should be either
`BEFORE_DATA`, `AFTER_DATA` or `NEVER`." ||
|| includeTablesRegex[] | **string**

List of regular expressions of table names which should be transferred. A table
name is formatted as schemaname.tablename. For example, a single regular
expression may look like `^mydb.employees$` ||
|| excludeTablesRegex[] | **string**

Opposite of `include_table_regex`. The tables matching the specified regular
expressions will not be transferred ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
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

Get Mysql installation params and credentials from Connection Manager

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|#

## OnPremiseMysql {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMysql}

#|
||Field | Description ||
|| port | **string** (int64)

Port for the database connection ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
|| hosts[] | **string**

List of host names of the MySQL server. Exactly one host is expected ||
|| tlsMode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**

TLS settings for server connection. Disabled by default. ||
|#

## TLSMode {#yandex.cloud.datatransfer.v1.endpoint.TLSMode}

TLS configuration

#|
||Field | Description ||
|| enabled | **[TLSConfig](#yandex.cloud.datatransfer.v1.endpoint.TLSConfig)**

TLS is used for the server connection

Includes only one of the fields `enabled`. ||
|#

## TLSConfig {#yandex.cloud.datatransfer.v1.endpoint.TLSConfig}

#|
||Field | Description ||
|| caCertificate | **string**

CA certificate

X.509 certificate of the certificate authority which issued the server's
certificate, in PEM format. When CA certificate is specified, TLS is used to
connect to the server. If CA certificate is empty, the server's certificate must
be signed by a well-known CA ||
|#

## ConnectionManagerConnection {#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection}

Use Connection Manager connection

#|
||Field | Description ||
|| connectionId | **string**

ID of connection in Connection Manager with installation params and credetials ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
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

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| routine | **enum** (ObjectTransferStage)

Routines

CREATE PROCEDURE ... ; CREATE FUNCTION ... ;

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| trigger | **enum** (ObjectTransferStage)

Triggers

CREATE TRIGGER ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| tables | **enum** (ObjectTransferStage)

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|#

## PostgresSource {#yandex.cloud.datatransfer.v1.endpoint.PostgresSource}

Settings specific to the PostgreSQL source endpoint.

#|
||Field | Description ||
|| connection | **[PostgresConnection](#yandex.cloud.datatransfer.v1.endpoint.PostgresConnection)**

Database connection settings ||
|| database | **string**

Name of the database to transfer ||
|| user | **string**

User for database access. Required unless Connection Manager connection is used. ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| includeTables[] | **string**

List of tables to transfer, formatted as `schemaname.tablename`.
If omitted or an empty list is specified, all tables will be transferred.
Can contain schema_name.* patterns. ||
|| excludeTables[] | **string**

List of tables which will not be transfered, formatted as `schemaname.tablename`
If omitted or empty list is specified, all tables are replicated.
Can contain schema_name.* patterns. ||
|| slotByteLagLimit | **string** (int64)

Maximum WAL size held by the replication slot (API - in bytes, terraform - in
gigabytes);
Exceeding this limit will result in a replication failure and deletion of the
replication slot.
Default is 50 gigabytes ||
|| serviceSchema | **string**

Name of the database schema in which auxiliary tables needed for the transfer
will be created (__consumer_keeper, __data_transfer_mole_finder).
Empty `service_schema` implies schema `public` ||
|| objectTransferSettings | **[PostgresObjectTransferSettings](#yandex.cloud.datatransfer.v1.endpoint.PostgresObjectTransferSettings)**

Defines which database schema objects should be transferred, e.g. views,
functions, etc.
All of the attributes in this block are optional and should be either
`BEFORE_DATA`, `AFTER_DATA` or `NEVER` ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
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

Get Postgres installation params and credentials from Connection Manager

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|#

## OnPremisePostgres {#yandex.cloud.datatransfer.v1.endpoint.OnPremisePostgres}

#|
||Field | Description ||
|| port | **string** (int64)

PG port. Will be used if the cluster ID is not specified. ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
|| hosts[] | **string**

PG installation hosts ||
|| tlsMode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**

TLS settings for server connection. Disabled by default. ||
|#

## PostgresObjectTransferSettings {#yandex.cloud.datatransfer.v1.endpoint.PostgresObjectTransferSettings}

#|
||Field | Description ||
|| sequence | **enum** (ObjectTransferStage)

Sequences

CREATE SEQUENCE ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| sequenceOwnedBy | **enum** (ObjectTransferStage)

Owned sequences

CREATE SEQUENCE ... OWNED BY ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| table | **enum** (ObjectTransferStage)

Tables

CREATE TABLE ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| primaryKey | **enum** (ObjectTransferStage)

Primary keys

ALTER TABLE ... ADD PRIMARY KEY ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| fkConstraint | **enum** (ObjectTransferStage)

Foreign keys

ALTER TABLE ... ADD FOREIGN KEY ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| defaultValues | **enum** (ObjectTransferStage)

Default values

ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| constraint | **enum** (ObjectTransferStage)

Constraints

ALTER TABLE ... ADD CONSTRAINT ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| index | **enum** (ObjectTransferStage)

Indexes

CREATE INDEX ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| view | **enum** (ObjectTransferStage)

Views

CREATE VIEW ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| function | **enum** (ObjectTransferStage)

Functions

CREATE FUNCTION ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| trigger | **enum** (ObjectTransferStage)

Triggers

CREATE TRIGGER ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| type | **enum** (ObjectTransferStage)

Types

CREATE TYPE ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| rule | **enum** (ObjectTransferStage)

Rules

CREATE RULE ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| collation | **enum** (ObjectTransferStage)

Collations

CREATE COLLATION ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| policy | **enum** (ObjectTransferStage)

Policies

CREATE POLICY ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| cast | **enum** (ObjectTransferStage)

Casts

CREATE CAST ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| materializedView | **enum** (ObjectTransferStage)

Materialized views

CREATE MATERIALIZED VIEW ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| sequenceSet | **enum** (ObjectTransferStage)

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|#

## YdbSource {#yandex.cloud.datatransfer.v1.endpoint.YdbSource}

Settings specific to the YDB source endpoint

#|
||Field | Description ||
|| database | **string**

Database path in YDB where tables are stored.
Example: `/ru/transfer_manager/prod/data-transfer-yt` ||
|| instance | **string**

Instance of YDB. example: ydb-ru-prestable.yandex.net:2135.
If not specified, will be determined by database ||
|| paths[] | **string**

A list of paths which should be uploaded. When not specified, all available
tables are uploaded ||
|| serviceAccountId | **string**

Service account ID for interaction with database ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database. If omitted, the server has to be accessible via Internet ||
|| saKeyContent | **string**

Authorization Key ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| changefeedCustomName | **string**

Pre-created change feed if any ||
|| changefeedCustomConsumerName | **string**

Consumer for pre-created change feed if any ||
|#

## YDSSource {#yandex.cloud.datatransfer.v1.endpoint.YDSSource}

Settings specific to the YDS source endpoint

#|
||Field | Description ||
|| database | **string**

Database path in YDB for streams
Example: `/ru/transfer_manager/prod/data-transfer` ||
|| stream | **string**

Stream to read ||
|| serviceAccountId | **string**

Service account ID which has read access to the stream. ||
|| supportedCodecs[] | **enum** (YdsCompressionCodec)

List of supported compression codecs
Options: YDS_COMPRESSION_CODEC_RAW, YDS_COMPRESSION_CODEC_ZSTD,
YDS_COMPRESSION_CODEC_GZIP

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

YDS Endpoint for dedicated db ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database. If omitted, the server has to be accessible via Internet ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| consumer | **string**

Custom consumer - for important streams ||
|#

## Parser {#yandex.cloud.datatransfer.v1.endpoint.Parser}

#|
||Field | Description ||
|| jsonParser | **[GenericParserCommon](#yandex.cloud.datatransfer.v1.endpoint.GenericParserCommon)**

Parse data in json format

Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`. ||
|| auditTrailsV1Parser | **object**

Parse Audit Trails data. Empty struct

Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`. ||
|| cloudLoggingParser | **object**

Parse Cloud Logging data. Empty struct

Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`. ||
|| tskvParser | **[GenericParserCommon](#yandex.cloud.datatransfer.v1.endpoint.GenericParserCommon)**

Parse data in tskv format

Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`. ||
|#

## GenericParserCommon {#yandex.cloud.datatransfer.v1.endpoint.GenericParserCommon}

#|
||Field | Description ||
|| dataSchema | **[DataSchema](#yandex.cloud.datatransfer.v1.endpoint.DataSchema)**

Data parsing scheme ||
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

Description of the data schema as JSON specification

Includes only one of the fields `jsonFields`, `fields`. ||
|| fields | **[FieldList](#yandex.cloud.datatransfer.v1.endpoint.FieldList)**

Description of the data schema in the array of `fields` structure

Includes only one of the fields `jsonFields`, `fields`. ||
|#

## FieldList {#yandex.cloud.datatransfer.v1.endpoint.FieldList}

#|
||Field | Description ||
|| fields[] | **[ColSchema](#yandex.cloud.datatransfer.v1.endpoint.ColSchema)**

Description of the column schema in the array of `fields` structure ||
|#

## ColSchema {#yandex.cloud.datatransfer.v1.endpoint.ColSchema}

#|
||Field | Description ||
|| name | **string**

Field name ||
|| type | **enum** (ColumnType)

Field type, one of: `INT64`, `INT32`, `INT16`, `INT8`, `UINT64`, `UINT32`,
`UINT16`, `UINT8`, `DOUBLE`, `BOOLEAN`, `STRING`, `UTF8`, `ANY`, `DATETIME`.

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
|| key | **boolean**

Mark field as Primary Key ||
|| required | **boolean**

Mark field as required ||
|| path | **string**

Path to the field ||
|#

## KafkaSource {#yandex.cloud.datatransfer.v1.endpoint.KafkaSource}

Settings specific to the Kafka source endpoint

#|
||Field | Description ||
|| connection | **[KafkaConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions)**

Connection settings ||
|| auth | **[KafkaAuth](#yandex.cloud.datatransfer.v1.endpoint.KafkaAuth)**

Authentication settings ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| topicName | **string**

*Deprecated**. Please use `topic_names` instead
Full source topic name ||
|| transformer | **[DataTransformationOptions](#yandex.cloud.datatransfer.v1.endpoint.DataTransformationOptions)**

Transform data with a custom Cloud Function ||
|| parser | **[Parser](#yandex.cloud.datatransfer.v1.endpoint.Parser)**

Data parsing parameters. If not set, the source messages are read in raw ||
|| topicNames[] | **string**

List of full source topic names to read ||
|#

## KafkaConnectionOptions {#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions}

#|
||Field | Description ||
|| clusterId | **string**

Managed Service for Kafka cluster ID.
Set only one of: cluster_id/on_premise/connection_manager_connection

Includes only one of the fields `clusterId`, `onPremise`, `connectionManagerConnection`. ||
|| onPremise | **[OnPremiseKafka](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseKafka)**

Connection options for on-premise Kafka
Set only one of: cluster_id/on_premise/connection_manager_connection

Includes only one of the fields `clusterId`, `onPremise`, `connectionManagerConnection`. ||
|| connectionManagerConnection | **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**

Get Kafka installation params and credentials from Connection Manager
Set only one of: cluster_id/on_premise/connection_manager_connection

Includes only one of the fields `clusterId`, `onPremise`, `connectionManagerConnection`. ||
|#

## OnPremiseKafka {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseKafka}

On-premise Kafka installation options

#|
||Field | Description ||
|| brokerUrls[] | **string**

Kafka broker URLs ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
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

SASL mechanism for authentication, use one of: KAFKA_MECHANISM_SHA256,
KAFKA_MECHANISM_SHA512

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

Buffer size for function. Maximum 4 GB.  Use value with units, i.e. 10 B, 20 kB,
2.0 MB, 30 MB, 1.0 GB ||
|| bufferFlushInterval | **string**

Flush interval ||
|| invocationTimeout | **string**

Invocation timeout ||
|| serviceAccountId | **string**

Service account ||
|#

## MongoSource {#yandex.cloud.datatransfer.v1.endpoint.MongoSource}

Settings specific to the MongoDB source endpoint

#|
||Field | Description ||
|| connection | **[MongoConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnection)**

Connection settings ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
|| collections[] | **[MongoCollection](#yandex.cloud.datatransfer.v1.endpoint.MongoCollection)**

List of collections for replication. Empty list implies replication of all
tables on the deployment. Allowed to use * as collection name. ||
|| excludedCollections[] | **[MongoCollection](#yandex.cloud.datatransfer.v1.endpoint.MongoCollection)**

List of forbidden collections for replication. Allowed to use * as collection
name for forbid all collections of concrete schema. ||
|| secondaryPreferredMode | **boolean**

Read mode for mongo client: whether the secondary server should be preferred to
the primary when copying data ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
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

Identifier of the Yandex StoreDoc cluster
Use one of:  mdb_cluster_id/on_premise/connection_manager_connection

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| onPremise | **[OnPremiseMongo](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMongo)**

Connection settings of the on-premise MongoDB server
Use one of:  mdb_cluster_id/on_premise/connection_manager_connection

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| connectionManagerConnection | **[MongoConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnectionManagerConnection)**

Get StoreDoc/MongoDB installation params and credentials from Connection Manager
Use one of:  mdb_cluster_id/on_premise/connection_manager_connection

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| user | **string**

User name, required unless connection_manager_connection is used ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for user ||
|| authSource | **string**

Database name associated with the credentials ||
|#

## OnPremiseMongo {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMongo}

#|
||Field | Description ||
|| hosts[] | **string**

Host names of the replica set ||
|| port | **string** (int64)

TCP Port number ||
|| replicaSet | **string**

Replica set name ||
|| tlsMode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**

TLS settings for the server connection. Empty implies plaintext connection ||
|#

## MongoConnectionManagerConnection {#yandex.cloud.datatransfer.v1.endpoint.MongoConnectionManagerConnection}

#|
||Field | Description ||
|| connectionId | **string**

ID of connectionmanager connection with mongodb/Yandex Storedoc installation
parameters and credentials ||
|| replicaSet | **string**

Replica set name, used only for on-premise mongodb installations ||
|#

## MongoCollection {#yandex.cloud.datatransfer.v1.endpoint.MongoCollection}

#|
||Field | Description ||
|| databaseName | **string** ||
|| collectionName | **string** ||
|#

## ClickhouseSource {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSource}

Settings specific to the ClickHouse source endpoint

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnection)**

Connection settings ||
|| includeTables[] | **string**

White list of tables for replication. If none or empty list is presented - will
replicate all tables. Can contain * patterns. ||
|| excludeTables[] | **string**

Exclude list of tables for replication. If none or empty list is presented -
will replicate all tables. Can contain * patterns. ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| clickhouseClusterName | **string**

Name of the ClickHouse cluster. For Managed ClickHouse that is name of
ShardGroup or managed cluster ID by default ||
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

Connection settings of the on-premise ClickHouse server

Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`. ||
|| connectionManagerConnection | **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**

Get ClickHouse installation params and credentials from Connection Manager

Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`. ||
|| mdbClusterId | **string**

Identifier of the Managed ClickHouse cluster

Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`. ||
|| user | **string**

User for database access. Required unless connection_manager_connection is used ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for the database access ||
|| database | **string**

Database name ||
|#

## OnPremiseClickhouse {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseClickhouse}

#|
||Field | Description ||
|| shards[] | **[ClickhouseShard](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseShard)** ||
|| httpPort | **string** (int64) ||
|| nativePort | **string** (int64) ||
|| tlsMode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**

TLS settings for server connection. Disabled by default ||
|#

## ClickhouseShard {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseShard}

#|
||Field | Description ||
|| name | **string** ||
|| hosts[] | **string** ||
|#

## MysqlTarget {#yandex.cloud.datatransfer.v1.endpoint.MysqlTarget}

Settings specific to the MySQL target endpoint

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

User for database access. Required unless connection manager connection is used ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| sqlMode | **string**

[sql_mode](https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html) to use when
interacting with the server.
Defaults to `NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION` ||
|| skipConstraintChecks | **boolean**

Disable constraints checks
When `true`, disables foreign key checks and unique checks. `False` by default.
See
[foreign_key_checks](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_foreign_key_checks).
Recommend to disable for increase replication speed unless schema contains
cascading operations ||
|| timezone | **string**

Database timezone

Is used for parsing timestamps for saving source timezones. Accepts values from
IANA timezone database. Default: local timezone. ||
|| cleanupPolicy | **enum** (CleanupPolicy)

Cleanup policy for activate, reactivate and reupload processes.
One of `DISABLED`, `DROP` or `TRUNCATE` Default is `DISABLED`.

- `DISABLED`: Don't cleanup
- `DROP`: Drop
- `TRUNCATE`: Truncate ||
|| serviceDatabase | **string**

Database schema for service table
Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper). ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| isSchemaMigrationDisabled | **boolean**

Whether can change table schema if schema changed on source ||
|#

## PostgresTarget {#yandex.cloud.datatransfer.v1.endpoint.PostgresTarget}

Settings specific to the PostgreSQL target endpoint

#|
||Field | Description ||
|| connection | **[PostgresConnection](#yandex.cloud.datatransfer.v1.endpoint.PostgresConnection)**

Database connection settings ||
|| database | **string**

Target database name ||
|| user | **string**

User for database access. Required unless Connection Manager connection is used ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| cleanupPolicy | **enum** (CleanupPolicy)

Cleanup policy for activate, reactivate and reupload processes.
One of: DISABLED, DROP, TRUNCATE. Default is TRUNCATE

- `DISABLED`: Don't cleanup
- `DROP`: Drop
- `TRUNCATE`: Truncate ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| isSchemaMigrationDisabled | **boolean**

Whether can change table schema if schema changed on source ||
|#

## ClickhouseTarget {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseTarget}

Settings specific to the ClickHouse target endpoint

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnection)**

Connection settings ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
|| altNames[] | **[AltName](#yandex.cloud.datatransfer.v1.endpoint.AltName)**

Table renaming rules in target ||
|| cleanupPolicy | **enum** (ClickhouseCleanupPolicy)

How to clean collections when activating the transfer. One of
`CLICKHOUSE_CLEANUP_POLICY_DISABLED` or `CLICKHOUSE_CLEANUP_POLICY_DROP`

- `CLICKHOUSE_CLEANUP_POLICY_DISABLED`
- `CLICKHOUSE_CLEANUP_POLICY_DROP`
- `CLICKHOUSE_CLEANUP_POLICY_TRUNCATE` ||
|| sharding | **[ClickhouseSharding](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding)**

Shard selection rules for the data being transferred ||
|| isSchemaMigrationDisabled | **boolean**

Whether can change table schema if schema changed on source ||
|| clickhouseClusterName | **string**

Name of the ClickHouse cluster. For Managed ClickHouse that is name of
ShardGroup or managed cluster ID by default. ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
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

Shard data by the hash value of the specified column

Includes only one of the fields `columnValueHash`, `customMapping`. ||
|| customMapping | **[ColumnValueMapping](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping)**

A custom shard mapping by the value of the specified column

Includes only one of the fields `columnValueHash`, `customMapping`. ||
|#

## ColumnValueHash {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueHash}

#|
||Field | Description ||
|| columnName | **string**

The name of the column to calculate hash from ||
|#

## ColumnValueMapping {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping}

#|
||Field | Description ||
|| columnName | **string**

The name of the column to inspect when deciding the shard to chose for an
incoming row ||
|| mapping[] | **[ValueToShard](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping.ValueToShard)**

The mapping of the specified column values to the shard names ||
|#

## ValueToShard {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping.ValueToShard}

#|
||Field | Description ||
|| columnValue | **[ColumnValue](#yandex.cloud.datatransfer.v1.endpoint.ColumnValue)**

The value of the column. Currently only the string columns are supported ||
|| shardName | **string**

The name of the shard into which all the rows with the specified `column_value`
will be written ||
|#

## ColumnValue {#yandex.cloud.datatransfer.v1.endpoint.ColumnValue}

#|
||Field | Description ||
|| stringValue | **string**

Includes only one of the fields `stringValue`. ||
|#

## YdbTarget {#yandex.cloud.datatransfer.v1.endpoint.YdbTarget}

Settings specific to the YDB target endpoint

#|
||Field | Description ||
|| database | **string**

Database path in YDB where tables are stored.
Example: `/ru/transfer_manager/prod/data-transfer` ||
|| instance | **string**

Instance of YDB. example: ydb-ru-prestable.yandex.net:2135.
If not specified, will be determined by database ||
|| path | **string**

Path extension for database, each table will be layouted into this path ||
|| serviceAccountId | **string**

Service account ID for interaction with database ||
|| cleanupPolicy | **enum** (YdbCleanupPolicy)

Cleanup policy determine how to clean collections when activating the transfer.
One of `YDB_CLEANUP_POLICY_DISABLED` or `YDB_CLEANUP_POLICY_DROP`

- `YDB_CLEANUP_POLICY_DISABLED`
- `YDB_CLEANUP_POLICY_DROP` ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
|| saKeyContent | **string**

Authentication key ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| isTableColumnOriented | **boolean**

Whether a column-oriented (i.e. OLAP) tables should be created.
Default is `false` (create row-oriented OLTP tables) ||
|| defaultCompression | **enum** (YdbDefaultCompression)

Compression that will be used for default columns family on YDB table creation.
One of `YDB_DEFAULT_COMPRESSION_UNSPECIFIED`,
`YDB_DEFAULT_COMPRESSION_DISABLED`, `YDB_DEFAULT_COMPRESSION_LZ4`

- `YDB_DEFAULT_COMPRESSION_DISABLED`
- `YDB_DEFAULT_COMPRESSION_LZ4` ||
|| isSchemaMigrationDisabled | **boolean**

Whether can change table schema if schema changed on source ||
|#

## KafkaTarget {#yandex.cloud.datatransfer.v1.endpoint.KafkaTarget}

Settings specific to the Kafka target endpoint

#|
||Field | Description ||
|| connection | **[KafkaConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions)**

Connection settings ||
|| auth | **[KafkaAuth](#yandex.cloud.datatransfer.v1.endpoint.KafkaAuth)**

Authentication settings ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| topicSettings | **[KafkaTargetTopicSettings](#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopicSettings)**

Target topic settings ||
|| serializer | **[Serializer](#yandex.cloud.datatransfer.v1.endpoint.Serializer)**

Data serialization format settings ||
|#

## KafkaTargetTopicSettings {#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopicSettings}

#|
||Field | Description ||
|| topic | **[KafkaTargetTopic](#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopic)**

All messages will be sent to one topic

Includes only one of the fields `topic`, `topicPrefix`. ||
|| topicPrefix | **string**

Topic prefix
Messages will be sent to topic with name &lt;topic_prefix&gt;.&lt;schema&gt;.&lt;table_name&gt;.
Analogue of the Debezium setting database.server.name.

Includes only one of the fields `topic`, `topicPrefix`. ||
|#

## KafkaTargetTopic {#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopic}

#|
||Field | Description ||
|| topicName | **string**

Full topic name ||
|| saveTxOrder | **boolean**

Save transactions order
Not to split events queue into separate per-table queues. ||
|#

## Serializer {#yandex.cloud.datatransfer.v1.endpoint.Serializer}

Data serialization format

#|
||Field | Description ||
|| serializerAuto | **object**

Empty block. Select the serialization format automatically

Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`. ||
|| serializerJson | **object**

Empty block. Serialize data in json format

Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`. ||
|| serializerDebezium | **[SerializerDebezium](#yandex.cloud.datatransfer.v1.endpoint.SerializerDebezium)**

Serialize data in debezium json format

Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`. ||
|#

## SerializerDebezium {#yandex.cloud.datatransfer.v1.endpoint.SerializerDebezium}

Serialize data in json format

#|
||Field | Description ||
|| serializerParameters[] | **[DebeziumSerializerParameter](#yandex.cloud.datatransfer.v1.endpoint.DebeziumSerializerParameter)**

A list of Debezium parameters set by the structure of the `key` and `value`
string fields ||
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

Settings specific to the MongoDB target endpoint

#|
||Field | Description ||
|| connection | **[MongoConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnection)**

Connection settings ||
|| database | **string**

Database name. If not empty, then all the data will be written to the database
with the specified name; otherwise the database name is the same as in the
source endpoint ||
|| cleanupPolicy | **enum** (CleanupPolicy)

How to clean collections when activating the transfer. One of `DISABLED`, `DROP`
or `TRUNCATE`

- `DISABLED`: Don't cleanup
- `DROP`: Drop
- `TRUNCATE`: Truncate ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|#

## MetrikaSource {#yandex.cloud.datatransfer.v1.endpoint.MetrikaSource}

Settings specific to the Yandex Metrika source endpoint

#|
||Field | Description ||
|| counterIds[] | **string** (int64)

Counter IDs ||
|| token | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Authentication token ||
|| streams[] | **[MetrikaStream](#yandex.cloud.datatransfer.v1.endpoint.MetrikaStream)**

Streams ||
|#

## MetrikaStream {#yandex.cloud.datatransfer.v1.endpoint.MetrikaStream}

#|
||Field | Description ||
|| type | **enum** (MetrikaStreamType)

Stream type, one of: METRIKA_STREAM_TYPE_HITS, METRIKA_STREAM_TYPE_VISITS,
METRIKA_STREAM_TYPE_HITS_V2

- `METRIKA_STREAM_TYPE_HITS`
- `METRIKA_STREAM_TYPE_VISITS`
- `METRIKA_STREAM_TYPE_HITS_V2` ||
|| columns[] | **string**

Column names ||
|#

## YDSTarget {#yandex.cloud.datatransfer.v1.endpoint.YDSTarget}

Settings specific to the YDS target endpoint

#|
||Field | Description ||
|| database | **string**

Database path in YDB for streams
Example: `/ru/transfer_manager/prod/data-transfer` ||
|| stream | **string**

Stream to write to ||
|| serviceAccountId | **string**

Service account ID which has read access to the stream ||
|| saveTxOrder | **boolean**

Save transaction order
Not to split events queue into separate per-table queues.
Incompatible with setting Topic prefix, only with Topic full name. ||
|| compressionCodec | **enum** (YdsCompressionCodec)

Codec to use for output data compression. If not specified, no compression will
be done
Options: YDS_COMPRESSION_CODEC_RAW, YDS_COMPRESSION_CODEC_ZSTD,
YDS_COMPRESSION_CODEC_GZIP

- `YDS_COMPRESSION_CODEC_RAW`
- `YDS_COMPRESSION_CODEC_GZIP`
- `YDS_COMPRESSION_CODEC_ZSTD` ||
|| serializer | **[Serializer](#yandex.cloud.datatransfer.v1.endpoint.Serializer)**

Data serialization format ||
|| endpoint | **string**

YDS Endpoint for dedicated db ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database. If omitted, the server has to be accessible via Internet ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
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