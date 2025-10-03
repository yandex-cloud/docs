---
editable: false
apiPlayground:
  - url: https://trino.{{ api-host }}/managed-trino/v1/clusters/{clusterId}
    method: patch
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the Trino cluster.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
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
        name:
          description: |-
            **string**
            Name of the Trino cluster. The name must be unique within the folder.
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
        deletionProtection:
          description: |-
            **boolean**
            Deletion Protection inhibits deletion of the cluster.
          type: boolean
        trino:
          description: |-
            **[UpdateTrinoConfigSpec](#yandex.cloud.trino.v1.UpdateTrinoConfigSpec)**
            Configuration of Trino components.
          $ref: '#/definitions/UpdateTrinoConfigSpec'
        networkSpec:
          description: |-
            **[UpdateNetworkConfigSpec](#yandex.cloud.trino.v1.UpdateNetworkConfigSpec)**
            Network related configuration options.
          $ref: '#/definitions/UpdateNetworkConfigSpec'
        serviceAccountId:
          description: |-
            **string**
            Service account used to access Cloud resources.
          type: string
        logging:
          description: |-
            **[LoggingConfig](#yandex.cloud.trino.v1.LoggingConfig)**
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
            **[MaintenanceWindow](#yandex.cloud.trino.v1.MaintenanceWindow)**
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
                    **[WeeklyMaintenanceWindow](#yandex.cloud.trino.v1.WeeklyMaintenanceWindow)**
                    Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
                  $ref: '#/definitions/WeeklyMaintenanceWindow'
      additionalProperties: false
    definitions:
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
      UpdateCoordinatorConfig:
        type: object
        properties:
          resources:
            description: |-
              **[Resources](#yandex.cloud.trino.v1.Resources)**
              Configuration for computational resources assigned to the coordinator instance.
            $ref: '#/definitions/Resources'
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
      UpdateWorkerConfig:
        type: object
        properties:
          resources:
            description: |-
              **[Resources](#yandex.cloud.trino.v1.Resources)**
              Configuration for computational resources for worker instances.
            $ref: '#/definitions/Resources'
          scalePolicy:
            description: |-
              **[WorkerScalePolicy](#yandex.cloud.trino.v1.UpdateWorkerConfig.WorkerScalePolicy)**
              Configuration for scaling policy for worker instances.
            oneOf:
              - type: object
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
          storage:
            description: '**[ExchangeManagerStorage](#yandex.cloud.trino.v1.ExchangeManagerStorage)**'
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
              **[ExchangeManagerConfig](#yandex.cloud.trino.v1.ExchangeManagerConfig)**
              Configuration for exchange manager.
            $ref: '#/definitions/ExchangeManagerConfig'
          additionalProperties:
            description: |-
              **object** (map<**string**, **string**>)
              Additional properties.
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
      CatalogIds:
        type: object
        properties:
          any:
            description: '**string**'
            uniqueItems: true
            type: array
            items:
              type: string
      CatalogNames:
        type: object
        properties:
          any:
            description: '**string**'
            uniqueItems: true
            type: array
            items:
              type: string
      CatalogAccessRule:
        type: object
        properties:
          users:
            description: |-
              **string**
              IAM user IDs the rule is applied to.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          groups:
            description: |-
              **string**
              IAM group IDs the rule is applied to.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          catalog:
            description: |-
              **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**
              Catalog matcher specifying what catalogs the rule is applied to.
            oneOf:
              - type: object
                properties:
                  nameRegexp:
                    description: |-
                      **string**
                      Catalog name regexp the rule is applied to.
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
          permission:
            description: |-
              **enum** (Permission)
              Required field. Permission granted by the rule.
              - `PERMISSION_UNSPECIFIED`
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
            type: string
        required:
          - permission
      SchemaNames:
        type: object
        properties:
          any:
            description: '**string**'
            pattern: '[a-z0-9_-]+'
            uniqueItems: true
            type: array
            items:
              type: string
      SchemaAccessRule:
        type: object
        properties:
          users:
            description: |-
              **string**
              IAM user IDs the rule is applied to.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          groups:
            description: |-
              **string**
              IAM group IDs the rule is applied to.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          catalog:
            description: |-
              **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**
              Catalog matcher specifying what catalogs the rule is applied to.
            oneOf:
              - type: object
                properties:
                  nameRegexp:
                    description: |-
                      **string**
                      Catalog name regexp the rule is applied to.
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
          schema:
            description: |-
              **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**
              Schema matcher specifying what schemas the rule is applied to.
            oneOf:
              - type: object
                properties:
                  nameRegexp:
                    description: |-
                      **string**
                      Schema name regexp the rule is applied to.
                      Includes only one of the fields `nameRegexp`, `names`.
                    type: string
                  names:
                    description: |-
                      **[SchemaNames](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher.SchemaNames)**
                      Schema names the rule is applied to.
                      Includes only one of the fields `nameRegexp`, `names`.
                    $ref: '#/definitions/SchemaNames'
          owner:
            description: |-
              **enum** (Owner)
              Required field. Ownership granted by the rule.
              - `OWNER_UNSPECIFIED`
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
            type: string
        required:
          - owner
      TableNames:
        type: object
        properties:
          any:
            description: '**string**'
            pattern: '[a-z0-9_-]+'
            uniqueItems: true
            type: array
            items:
              type: string
      Column:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Column name.
            pattern: '[a-z0-9_-]+'
            type: string
          access:
            description: |-
              **enum** (AccessMode)
              Required field. Column access mode.
              - `ACCESS_MODE_UNSPECIFIED`
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
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          groups:
            description: |-
              **string**
              IAM group IDs the rule is applied to.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          catalog:
            description: |-
              **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**
              Catalog matcher specifying what catalogs the rule is applied to.
            oneOf:
              - type: object
                properties:
                  nameRegexp:
                    description: |-
                      **string**
                      Catalog name regexp the rule is applied to.
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
          schema:
            description: |-
              **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**
              Schema matcher specifying what schemas the rule is applied to.
            oneOf:
              - type: object
                properties:
                  nameRegexp:
                    description: |-
                      **string**
                      Schema name regexp the rule is applied to.
                      Includes only one of the fields `nameRegexp`, `names`.
                    type: string
                  names:
                    description: |-
                      **[SchemaNames](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher.SchemaNames)**
                      Schema names the rule is applied to.
                      Includes only one of the fields `nameRegexp`, `names`.
                    $ref: '#/definitions/SchemaNames'
          table:
            description: |-
              **[TableAccessRuleMatcher](#yandex.cloud.trino.v1.TableAccessRuleMatcher)**
              Table matcher specifying what tables the rule is applied to.
            oneOf:
              - type: object
                properties:
                  nameRegexp:
                    description: |-
                      **string**
                      Table name regexp the rule is applied to.
                      Includes only one of the fields `nameRegexp`, `names`.
                    type: string
                  names:
                    description: |-
                      **[TableNames](#yandex.cloud.trino.v1.TableAccessRuleMatcher.TableNames)**
                      Table names the rule is applied to.
                      Includes only one of the fields `nameRegexp`, `names`.
                    $ref: '#/definitions/TableNames'
          privileges:
            description: |-
              **enum** (Privilege)
              Permission granted by the rule.
              - `PRIVILEGE_UNSPECIFIED`
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
            type: string
          description:
            description: |-
              **string**
              Rule description.
            type: string
      FunctionNames:
        type: object
        properties:
          any:
            description: '**string**'
            pattern: '[a-z0-9_-]+'
            uniqueItems: true
            type: array
            items:
              type: string
      FunctionAccessRule:
        type: object
        properties:
          users:
            description: |-
              **string**
              IAM user IDs the rule is applied to.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          groups:
            description: |-
              **string**
              IAM group IDs the rule is applied to.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          catalog:
            description: |-
              **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**
              Catalog matcher specifying what catalogs the rule is applied to.
            oneOf:
              - type: object
                properties:
                  nameRegexp:
                    description: |-
                      **string**
                      Catalog name regexp the rule is applied to.
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
          schema:
            description: |-
              **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**
              Schema matcher specifying what schema the rule is applied to.
            oneOf:
              - type: object
                properties:
                  nameRegexp:
                    description: |-
                      **string**
                      Schema name regexp the rule is applied to.
                      Includes only one of the fields `nameRegexp`, `names`.
                    type: string
                  names:
                    description: |-
                      **[SchemaNames](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher.SchemaNames)**
                      Schema names the rule is applied to.
                      Includes only one of the fields `nameRegexp`, `names`.
                    $ref: '#/definitions/SchemaNames'
          function:
            description: |-
              **[FunctionAccessRuleMatcher](#yandex.cloud.trino.v1.FunctionAccessRuleMatcher)**
              Function matcher specifying what functions the rule is applied to.
            oneOf:
              - type: object
                properties:
                  nameRegexp:
                    description: |-
                      **string**
                      Function name regexp the rule is applied to.
                      Includes only one of the fields `nameRegexp`, `names`.
                    type: string
                  names:
                    description: |-
                      **[FunctionNames](#yandex.cloud.trino.v1.FunctionAccessRuleMatcher.FunctionNames)**
                      Function names the rule is applied to.
                      Includes only one of the fields `nameRegexp`, `names`.
                    $ref: '#/definitions/FunctionNames'
          privileges:
            description: |-
              **enum** (Privilege)
              Privileges granted by the rule.
              - `PRIVILEGE_UNSPECIFIED`
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
            type: string
      ProcedureNames:
        type: object
        properties:
          any:
            description: '**string**'
            pattern: '[a-z0-9_-]+'
            uniqueItems: true
            type: array
            items:
              type: string
      ProcedureAccessRule:
        type: object
        properties:
          users:
            description: |-
              **string**
              IAM user IDs the rule is applied to.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          groups:
            description: |-
              **string**
              IAM group IDs the rule is applied to.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          catalog:
            description: |-
              **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**
              Catalog matcher specifying what catalogs the rule is applied to.
            oneOf:
              - type: object
                properties:
                  nameRegexp:
                    description: |-
                      **string**
                      Catalog name regexp the rule is applied to.
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
          schema:
            description: |-
              **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**
              Schema matcher specifying what schema the rule is applied to.
            oneOf:
              - type: object
                properties:
                  nameRegexp:
                    description: |-
                      **string**
                      Schema name regexp the rule is applied to.
                      Includes only one of the fields `nameRegexp`, `names`.
                    type: string
                  names:
                    description: |-
                      **[SchemaNames](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher.SchemaNames)**
                      Schema names the rule is applied to.
                      Includes only one of the fields `nameRegexp`, `names`.
                    $ref: '#/definitions/SchemaNames'
          procedure:
            description: |-
              **[ProcedureAccessRuleMatcher](#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher)**
              Procedure matcher specifying what functions the rule is applied to.
            oneOf:
              - type: object
                properties:
                  nameRegexp:
                    description: |-
                      **string**
                      Procedure name regexp the rule is applied to.
                      Includes only one of the fields `nameRegexp`, `names`.
                    type: string
                  names:
                    description: |-
                      **[ProcedureNames](#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher.ProcedureNames)**
                      Procedure names the rule is applied to.
                      Includes only one of the fields `nameRegexp`, `names`.
                    $ref: '#/definitions/ProcedureNames'
          privileges:
            description: |-
              **enum** (Privilege)
              Privileges granted by the rule.
              - `PRIVILEGE_UNSPECIFIED`
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
            type: string
      QueryAccessRule:
        type: object
        properties:
          users:
            description: |-
              **string**
              IAM user IDs the rule is applied to.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          groups:
            description: |-
              **string**
              IAM group IDs the rule is applied to.
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
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          privileges:
            description: |-
              **enum** (Privilege)
              Privileges granted by the user.
              - `PRIVILEGE_UNSPECIFIED`
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
            type: string
      PropertyNames:
        type: object
        properties:
          any:
            description: '**string**'
            pattern: '[a-z_]+'
            uniqueItems: true
            type: array
            items:
              type: string
      SystemSessionPropertyAccessRule:
        type: object
        properties:
          users:
            description: |-
              **string**
              IAM user IDs the rule is applied to.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          groups:
            description: |-
              **string**
              IAM group IDs the rule is applied to.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          property:
            description: |-
              **[PropertyAccessRuleMatcher](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher)**
              Property matcher specifying what properties the rule is applied to.
            oneOf:
              - type: object
                properties:
                  nameRegexp:
                    description: |-
                      **string**
                      Property name regexp the rule is applied to.
                      Includes only one of the fields `nameRegexp`, `names`.
                    type: string
                  names:
                    description: |-
                      **[PropertyNames](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher.PropertyNames)**
                      Property names the rule is applied to.
                      Includes only one of the fields `nameRegexp`, `names`.
                    $ref: '#/definitions/PropertyNames'
          allow:
            description: |-
              **enum** (Allow)
              Required field. Whether the rule allows setting the property.
              - `ALLOW_UNSPECIFIED`
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
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          groups:
            description: |-
              **string**
              IAM group IDs the rule is applied to.
            pattern: '[-_0-9a-z]+'
            uniqueItems: true
            type: array
            items:
              type: string
          catalog:
            description: |-
              **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**
              Catalog matcher specifying what catalogs the rule is applied to.
            oneOf:
              - type: object
                properties:
                  nameRegexp:
                    description: |-
                      **string**
                      Catalog name regexp the rule is applied to.
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
          property:
            description: |-
              **[PropertyAccessRuleMatcher](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher)**
              Property matcher specifying what properties the rule is applied to.
            oneOf:
              - type: object
                properties:
                  nameRegexp:
                    description: |-
                      **string**
                      Property name regexp the rule is applied to.
                      Includes only one of the fields `nameRegexp`, `names`.
                    type: string
                  names:
                    description: |-
                      **[PropertyNames](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher.PropertyNames)**
                      Property names the rule is applied to.
                      Includes only one of the fields `nameRegexp`, `names`.
                    $ref: '#/definitions/PropertyNames'
          allow:
            description: |-
              **enum** (Allow)
              Required field. Whether the rule allows setting the property.
              - `ALLOW_UNSPECIFIED`
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
      UpdateTrinoConfigSpec:
        type: object
        properties:
          coordinatorConfig:
            description: |-
              **[UpdateCoordinatorConfig](#yandex.cloud.trino.v1.UpdateCoordinatorConfig)**
              Configuration for the coordinator, specifying computational resources and other settings.
            $ref: '#/definitions/UpdateCoordinatorConfig'
          workerConfig:
            description: |-
              **[UpdateWorkerConfig](#yandex.cloud.trino.v1.UpdateWorkerConfig)**
              Configuration for worker nodes, including scaling policy and computational resources.
            $ref: '#/definitions/UpdateWorkerConfig'
          version:
            description: |-
              **string**
              Trino version.
              Format: "Number".
            type: string
          retryPolicy:
            description: |-
              **[RetryPolicyConfig](#yandex.cloud.trino.v1.RetryPolicyConfig)**
              Configuration for retry policy, specifying the spooling storage destination and other settings.
            $ref: '#/definitions/RetryPolicyConfig'
          accessControl:
            description: |-
              **[AccessControlConfig](#yandex.cloud.trino.v1.AccessControlConfig)**
              Configuration for access control, specifying the fine-grained access rules.
            $ref: '#/definitions/AccessControlConfig'
      UpdateNetworkConfigSpec:
        type: object
        properties:
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
sourcePath: en/_api-ref/trino/v1/api-ref/Cluster/update.md
---

# Managed Service for Trino API, REST: Cluster.Update

Updates configuration of the specified Trino cluster.

## HTTP request

```
PATCH https://trino.{{ api-host }}/managed-trino/v1/clusters/{clusterId}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Trino cluster. ||
|#

## Body parameters {#yandex.cloud.trino.v1.UpdateClusterRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "deletionProtection": "boolean",
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
    },
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
    }
  },
  "networkSpec": {
    "securityGroupIds": [
      "string"
    ]
  },
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
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

Name of the Trino cluster. The name must be unique within the folder. ||
|| description | **string**

Description of the Trino cluster. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the Trino cluster as `` key:value `` pairs.
For example: {"env": "prod"}. ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster. ||
|| trino | **[UpdateTrinoConfigSpec](#yandex.cloud.trino.v1.UpdateTrinoConfigSpec)**

Configuration of Trino components. ||
|| networkSpec | **[UpdateNetworkConfigSpec](#yandex.cloud.trino.v1.UpdateNetworkConfigSpec)**

Network related configuration options. ||
|| serviceAccountId | **string**

Service account used to access Cloud resources. ||
|| logging | **[LoggingConfig](#yandex.cloud.trino.v1.LoggingConfig)**

Cloud logging configuration. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.trino.v1.MaintenanceWindow)**

Window of maintenance operations. ||
|#

## UpdateTrinoConfigSpec {#yandex.cloud.trino.v1.UpdateTrinoConfigSpec}

#|
||Field | Description ||
|| coordinatorConfig | **[UpdateCoordinatorConfig](#yandex.cloud.trino.v1.UpdateCoordinatorConfig)**

Configuration for the coordinator, specifying computational resources and other settings. ||
|| workerConfig | **[UpdateWorkerConfig](#yandex.cloud.trino.v1.UpdateWorkerConfig)**

Configuration for worker nodes, including scaling policy and computational resources. ||
|| version | **string**

Trino version.
Format: "Number". ||
|| retryPolicy | **[RetryPolicyConfig](#yandex.cloud.trino.v1.RetryPolicyConfig)**

Configuration for retry policy, specifying the spooling storage destination and other settings. ||
|| accessControl | **[AccessControlConfig](#yandex.cloud.trino.v1.AccessControlConfig)**

Configuration for access control, specifying the fine-grained access rules. ||
|#

## UpdateCoordinatorConfig {#yandex.cloud.trino.v1.UpdateCoordinatorConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.trino.v1.Resources)**

Configuration for computational resources assigned to the coordinator instance. ||
|#

## Resources {#yandex.cloud.trino.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

Required field. ID of the preset for computational resources allocated to a instance (e.g., CPU, memory, etc.). ||
|#

## UpdateWorkerConfig {#yandex.cloud.trino.v1.UpdateWorkerConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.trino.v1.Resources)**

Configuration for computational resources for worker instances. ||
|| scalePolicy | **[WorkerScalePolicy](#yandex.cloud.trino.v1.UpdateWorkerConfig.WorkerScalePolicy)**

Configuration for scaling policy for worker instances. ||
|#

## WorkerScalePolicy {#yandex.cloud.trino.v1.UpdateWorkerConfig.WorkerScalePolicy}

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

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| permission | **enum** (Permission)

Required field. Permission granted by the rule.

- `PERMISSION_UNSPECIFIED`
- `NONE`: Denies all operations on the catalog entities.
- `ALL`: Allows all operations on catalog entities.
- `READ_ONLY`: Allows only read operations on catalog entities. ||
|| description | **string**

Rule description. ||
|#

## CatalogAccessRuleMatcher {#yandex.cloud.trino.v1.CatalogAccessRuleMatcher}

#|
||Field | Description ||
|| nameRegexp | **string**

Catalog name regexp the rule is applied to.

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
|| any[] | **string** ||
|#

## CatalogNames {#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogNames}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## SchemaAccessRule {#yandex.cloud.trino.v1.SchemaAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**

Schema matcher specifying what schemas the rule is applied to. ||
|| owner | **enum** (Owner)

Required field. Ownership granted by the rule.

- `OWNER_UNSPECIFIED`
- `NO`: User is not considered an owner of the schema.
- `YES`: User is considered an owner of the schema. ||
|| description | **string**

Rule description. ||
|#

## SchemaAccessRuleMatcher {#yandex.cloud.trino.v1.SchemaAccessRuleMatcher}

#|
||Field | Description ||
|| nameRegexp | **string**

Schema name regexp the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|| names | **[SchemaNames](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher.SchemaNames)**

Schema names the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|#

## SchemaNames {#yandex.cloud.trino.v1.SchemaAccessRuleMatcher.SchemaNames}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## TableAccessRule {#yandex.cloud.trino.v1.TableAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**

Schema matcher specifying what schemas the rule is applied to. ||
|| table | **[TableAccessRuleMatcher](#yandex.cloud.trino.v1.TableAccessRuleMatcher)**

Table matcher specifying what tables the rule is applied to. ||
|| privileges[] | **enum** (Privilege)

Permission granted by the rule.

- `PRIVILEGE_UNSPECIFIED`
- `SELECT`: Allows SELECT statements on the table.
- `INSERT`: Allows INSERT statements on the table.
- `DELETE`: Allows DELETE statements on the table.
- `UPDATE`: Allows UPDATE statements on the table.
- `OWNERSHIP`: Allows CREATE, DROP, COMMENT ON and ALTER statements on the table.
- `GRANT_SELECT`: Allows SELECT statements on the table while creating view. ||
|| columns[] | **[Column](#yandex.cloud.trino.v1.TableAccessRule.Column)**

Column rules. ||
|| filter | **string**

Boolean SQL expression to filter table rows for particular user. ||
|| description | **string**

Rule description. ||
|#

## TableAccessRuleMatcher {#yandex.cloud.trino.v1.TableAccessRuleMatcher}

#|
||Field | Description ||
|| nameRegexp | **string**

Table name regexp the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|| names | **[TableNames](#yandex.cloud.trino.v1.TableAccessRuleMatcher.TableNames)**

Table names the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|#

## TableNames {#yandex.cloud.trino.v1.TableAccessRuleMatcher.TableNames}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## Column {#yandex.cloud.trino.v1.TableAccessRule.Column}

#|
||Field | Description ||
|| name | **string**

Required field. Column name. ||
|| access | **enum** (AccessMode)

Required field. Column access mode.

- `ACCESS_MODE_UNSPECIFIED`
- `NONE`: Access to column is denied.
- `ALL`: Access to column is allowed. ||
|| mask | **string**

SQL expression mask to evaluate instead of original column values.
Mask should have the same type as original column. ||
|#

## FunctionAccessRule {#yandex.cloud.trino.v1.FunctionAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**

Schema matcher specifying what schema the rule is applied to. ||
|| function | **[FunctionAccessRuleMatcher](#yandex.cloud.trino.v1.FunctionAccessRuleMatcher)**

Function matcher specifying what functions the rule is applied to. ||
|| privileges[] | **enum** (Privilege)

Privileges granted by the rule.

- `PRIVILEGE_UNSPECIFIED`
- `EXECUTE`: Allows to execute the function.
- `GRANT_EXECUTE`: Allows to use the function while view creation.
- `OWNERSHIP`: Allows to CREATE and DROP the function. ||
|| description | **string**

Rule description. ||
|#

## FunctionAccessRuleMatcher {#yandex.cloud.trino.v1.FunctionAccessRuleMatcher}

#|
||Field | Description ||
|| nameRegexp | **string**

Function name regexp the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|| names | **[FunctionNames](#yandex.cloud.trino.v1.FunctionAccessRuleMatcher.FunctionNames)**

Function names the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|#

## FunctionNames {#yandex.cloud.trino.v1.FunctionAccessRuleMatcher.FunctionNames}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## ProcedureAccessRule {#yandex.cloud.trino.v1.ProcedureAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher)**

Schema matcher specifying what schema the rule is applied to. ||
|| procedure | **[ProcedureAccessRuleMatcher](#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher)**

Procedure matcher specifying what functions the rule is applied to. ||
|| privileges[] | **enum** (Privilege)

Privileges granted by the rule.

- `PRIVILEGE_UNSPECIFIED`
- `EXECUTE`: Allows to execute the procedure. ||
|| description | **string**

Rule description. ||
|#

## ProcedureAccessRuleMatcher {#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher}

#|
||Field | Description ||
|| nameRegexp | **string**

Procedure name regexp the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|| names | **[ProcedureNames](#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher.ProcedureNames)**

Procedure names the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|#

## ProcedureNames {#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher.ProcedureNames}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## QueryAccessRule {#yandex.cloud.trino.v1.QueryAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| queryOwners[] | **string**

Owners of queries the rule is applied to.
Cannot be combined with EXECUTE privilege. ||
|| privileges[] | **enum** (Privilege)

Privileges granted by the user.

- `PRIVILEGE_UNSPECIFIED`
- `VIEW`: Allows to view the query.
- `EXECUTE`: Allows to execute the query.
- `KILL`: Allows to kill the query. ||
|| description | **string**

Rule description. ||
|#

## SystemSessionPropertyAccessRule {#yandex.cloud.trino.v1.SystemSessionPropertyAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| property | **[PropertyAccessRuleMatcher](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher)**

Property matcher specifying what properties the rule is applied to. ||
|| allow | **enum** (Allow)

Required field. Whether the rule allows setting the property.

- `ALLOW_UNSPECIFIED`
- `NO`: Denies setting the system session property.
- `YES`: Allows to set the system session property. ||
|| description | **string**

Rule description. ||
|#

## PropertyAccessRuleMatcher {#yandex.cloud.trino.v1.PropertyAccessRuleMatcher}

#|
||Field | Description ||
|| nameRegexp | **string**

Property name regexp the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|| names | **[PropertyNames](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher.PropertyNames)**

Property names the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|#

## PropertyNames {#yandex.cloud.trino.v1.PropertyAccessRuleMatcher.PropertyNames}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## CatalogSessionPropertyAccessRule {#yandex.cloud.trino.v1.CatalogSessionPropertyAccessRule}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| property | **[PropertyAccessRuleMatcher](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher)**

Property matcher specifying what properties the rule is applied to. ||
|| allow | **enum** (Allow)

Required field. Whether the rule allows setting the property.

- `ALLOW_UNSPECIFIED`
- `NO`: Denies setting the catalog session property.
- `YES`: Allows to set the catalog session property. ||
|| description | **string**

Rule description. ||
|#

## UpdateNetworkConfigSpec {#yandex.cloud.trino.v1.UpdateNetworkConfigSpec}

#|
||Field | Description ||
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
      },
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
|| metadata | **[UpdateClusterMetadata](#yandex.cloud.trino.v1.UpdateClusterMetadata)**

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

## UpdateClusterMetadata {#yandex.cloud.trino.v1.UpdateClusterMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the Trino cluster that is being updated. ||
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
|| network | **[NetworkConfig](#yandex.cloud.trino.v1.NetworkConfig)**

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
|| coordinatorConfig | **[CoordinatorConfig](#yandex.cloud.trino.v1.CoordinatorConfig)**

Required field. Configuration for the coordinator, specifying computational resources and other settings. ||
|| workerConfig | **[WorkerConfig](#yandex.cloud.trino.v1.WorkerConfig)**

Required field. Configuration for worker nodes, including scaling policy and computational resources. ||
|| version | **string**

Version of Trino. ||
|| retryPolicy | **[RetryPolicyConfig](#yandex.cloud.trino.v1.RetryPolicyConfig2)**

Configuration for retry policy, specifying the spooling storage destination and other settings. ||
|| accessControl | **[AccessControlConfig](#yandex.cloud.trino.v1.AccessControlConfig2)**

Configuration for access control, specifying the fine-grained rules of accesses. ||
|#

## CoordinatorConfig {#yandex.cloud.trino.v1.CoordinatorConfig}

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

## WorkerConfig {#yandex.cloud.trino.v1.WorkerConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.trino.v1.Resources2)**

Required field. Configuration for computational resources for worker instances. ||
|| scalePolicy | **[WorkerScalePolicy](#yandex.cloud.trino.v1.WorkerConfig.WorkerScalePolicy)**

Required field. Configuration for scaling policy for worker instances. ||
|#

## WorkerScalePolicy {#yandex.cloud.trino.v1.WorkerConfig.WorkerScalePolicy}

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

## AccessControlConfig {#yandex.cloud.trino.v1.AccessControlConfig2}

#|
||Field | Description ||
|| catalogs[] | **[CatalogAccessRule](#yandex.cloud.trino.v1.CatalogAccessRule2)**

Catalog access control rules. ||
|| schemas[] | **[SchemaAccessRule](#yandex.cloud.trino.v1.SchemaAccessRule2)**

Schema access control rules. ||
|| tables[] | **[TableAccessRule](#yandex.cloud.trino.v1.TableAccessRule2)**

Table access control rules. ||
|| functions[] | **[FunctionAccessRule](#yandex.cloud.trino.v1.FunctionAccessRule2)**

Function access control rules. ||
|| procedures[] | **[ProcedureAccessRule](#yandex.cloud.trino.v1.ProcedureAccessRule2)**

Procedures access control rules. ||
|| queries[] | **[QueryAccessRule](#yandex.cloud.trino.v1.QueryAccessRule2)**

Queries access control rules. ||
|| systemSessionProperties[] | **[SystemSessionPropertyAccessRule](#yandex.cloud.trino.v1.SystemSessionPropertyAccessRule2)**

System session property access control rules. ||
|| catalogSessionProperties[] | **[CatalogSessionPropertyAccessRule](#yandex.cloud.trino.v1.CatalogSessionPropertyAccessRule2)**

Catalog session property access control rules. ||
|#

## CatalogAccessRule {#yandex.cloud.trino.v1.CatalogAccessRule2}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher2)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| permission | **enum** (Permission)

Required field. Permission granted by the rule.

- `PERMISSION_UNSPECIFIED`
- `NONE`: Denies all operations on the catalog entities.
- `ALL`: Allows all operations on catalog entities.
- `READ_ONLY`: Allows only read operations on catalog entities. ||
|| description | **string**

Rule description. ||
|#

## CatalogAccessRuleMatcher {#yandex.cloud.trino.v1.CatalogAccessRuleMatcher2}

#|
||Field | Description ||
|| nameRegexp | **string**

Catalog name regexp the rule is applied to.

Includes only one of the fields `nameRegexp`, `ids`, `names`. ||
|| ids | **[CatalogIds](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogIds2)**

Catalog IDs rule is applied to.

Includes only one of the fields `nameRegexp`, `ids`, `names`. ||
|| names | **[CatalogNames](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogNames2)**

Catalog names rule is applied to.

Includes only one of the fields `nameRegexp`, `ids`, `names`. ||
|#

## CatalogIds {#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogIds2}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## CatalogNames {#yandex.cloud.trino.v1.CatalogAccessRuleMatcher.CatalogNames2}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## SchemaAccessRule {#yandex.cloud.trino.v1.SchemaAccessRule2}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher2)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher2)**

Schema matcher specifying what schemas the rule is applied to. ||
|| owner | **enum** (Owner)

Required field. Ownership granted by the rule.

- `OWNER_UNSPECIFIED`
- `NO`: User is not considered an owner of the schema.
- `YES`: User is considered an owner of the schema. ||
|| description | **string**

Rule description. ||
|#

## SchemaAccessRuleMatcher {#yandex.cloud.trino.v1.SchemaAccessRuleMatcher2}

#|
||Field | Description ||
|| nameRegexp | **string**

Schema name regexp the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|| names | **[SchemaNames](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher.SchemaNames2)**

Schema names the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|#

## SchemaNames {#yandex.cloud.trino.v1.SchemaAccessRuleMatcher.SchemaNames2}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## TableAccessRule {#yandex.cloud.trino.v1.TableAccessRule2}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher2)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher2)**

Schema matcher specifying what schemas the rule is applied to. ||
|| table | **[TableAccessRuleMatcher](#yandex.cloud.trino.v1.TableAccessRuleMatcher2)**

Table matcher specifying what tables the rule is applied to. ||
|| privileges[] | **enum** (Privilege)

Permission granted by the rule.

- `PRIVILEGE_UNSPECIFIED`
- `SELECT`: Allows SELECT statements on the table.
- `INSERT`: Allows INSERT statements on the table.
- `DELETE`: Allows DELETE statements on the table.
- `UPDATE`: Allows UPDATE statements on the table.
- `OWNERSHIP`: Allows CREATE, DROP, COMMENT ON and ALTER statements on the table.
- `GRANT_SELECT`: Allows SELECT statements on the table while creating view. ||
|| columns[] | **[Column](#yandex.cloud.trino.v1.TableAccessRule.Column2)**

Column rules. ||
|| filter | **string**

Boolean SQL expression to filter table rows for particular user. ||
|| description | **string**

Rule description. ||
|#

## TableAccessRuleMatcher {#yandex.cloud.trino.v1.TableAccessRuleMatcher2}

#|
||Field | Description ||
|| nameRegexp | **string**

Table name regexp the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|| names | **[TableNames](#yandex.cloud.trino.v1.TableAccessRuleMatcher.TableNames2)**

Table names the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|#

## TableNames {#yandex.cloud.trino.v1.TableAccessRuleMatcher.TableNames2}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## Column {#yandex.cloud.trino.v1.TableAccessRule.Column2}

#|
||Field | Description ||
|| name | **string**

Required field. Column name. ||
|| access | **enum** (AccessMode)

Required field. Column access mode.

- `ACCESS_MODE_UNSPECIFIED`
- `NONE`: Access to column is denied.
- `ALL`: Access to column is allowed. ||
|| mask | **string**

SQL expression mask to evaluate instead of original column values.
Mask should have the same type as original column. ||
|#

## FunctionAccessRule {#yandex.cloud.trino.v1.FunctionAccessRule2}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher2)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher2)**

Schema matcher specifying what schema the rule is applied to. ||
|| function | **[FunctionAccessRuleMatcher](#yandex.cloud.trino.v1.FunctionAccessRuleMatcher2)**

Function matcher specifying what functions the rule is applied to. ||
|| privileges[] | **enum** (Privilege)

Privileges granted by the rule.

- `PRIVILEGE_UNSPECIFIED`
- `EXECUTE`: Allows to execute the function.
- `GRANT_EXECUTE`: Allows to use the function while view creation.
- `OWNERSHIP`: Allows to CREATE and DROP the function. ||
|| description | **string**

Rule description. ||
|#

## FunctionAccessRuleMatcher {#yandex.cloud.trino.v1.FunctionAccessRuleMatcher2}

#|
||Field | Description ||
|| nameRegexp | **string**

Function name regexp the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|| names | **[FunctionNames](#yandex.cloud.trino.v1.FunctionAccessRuleMatcher.FunctionNames2)**

Function names the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|#

## FunctionNames {#yandex.cloud.trino.v1.FunctionAccessRuleMatcher.FunctionNames2}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## ProcedureAccessRule {#yandex.cloud.trino.v1.ProcedureAccessRule2}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher2)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| schema | **[SchemaAccessRuleMatcher](#yandex.cloud.trino.v1.SchemaAccessRuleMatcher2)**

Schema matcher specifying what schema the rule is applied to. ||
|| procedure | **[ProcedureAccessRuleMatcher](#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher2)**

Procedure matcher specifying what functions the rule is applied to. ||
|| privileges[] | **enum** (Privilege)

Privileges granted by the rule.

- `PRIVILEGE_UNSPECIFIED`
- `EXECUTE`: Allows to execute the procedure. ||
|| description | **string**

Rule description. ||
|#

## ProcedureAccessRuleMatcher {#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher2}

#|
||Field | Description ||
|| nameRegexp | **string**

Procedure name regexp the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|| names | **[ProcedureNames](#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher.ProcedureNames2)**

Procedure names the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|#

## ProcedureNames {#yandex.cloud.trino.v1.ProcedureAccessRuleMatcher.ProcedureNames2}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## QueryAccessRule {#yandex.cloud.trino.v1.QueryAccessRule2}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| queryOwners[] | **string**

Owners of queries the rule is applied to.
Cannot be combined with EXECUTE privilege. ||
|| privileges[] | **enum** (Privilege)

Privileges granted by the user.

- `PRIVILEGE_UNSPECIFIED`
- `VIEW`: Allows to view the query.
- `EXECUTE`: Allows to execute the query.
- `KILL`: Allows to kill the query. ||
|| description | **string**

Rule description. ||
|#

## SystemSessionPropertyAccessRule {#yandex.cloud.trino.v1.SystemSessionPropertyAccessRule2}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| property | **[PropertyAccessRuleMatcher](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher2)**

Property matcher specifying what properties the rule is applied to. ||
|| allow | **enum** (Allow)

Required field. Whether the rule allows setting the property.

- `ALLOW_UNSPECIFIED`
- `NO`: Denies setting the system session property.
- `YES`: Allows to set the system session property. ||
|| description | **string**

Rule description. ||
|#

## PropertyAccessRuleMatcher {#yandex.cloud.trino.v1.PropertyAccessRuleMatcher2}

#|
||Field | Description ||
|| nameRegexp | **string**

Property name regexp the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|| names | **[PropertyNames](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher.PropertyNames2)**

Property names the rule is applied to.

Includes only one of the fields `nameRegexp`, `names`. ||
|#

## PropertyNames {#yandex.cloud.trino.v1.PropertyAccessRuleMatcher.PropertyNames2}

#|
||Field | Description ||
|| any[] | **string** ||
|#

## CatalogSessionPropertyAccessRule {#yandex.cloud.trino.v1.CatalogSessionPropertyAccessRule2}

#|
||Field | Description ||
|| users[] | **string**

IAM user IDs the rule is applied to. ||
|| groups[] | **string**

IAM group IDs the rule is applied to. ||
|| catalog | **[CatalogAccessRuleMatcher](#yandex.cloud.trino.v1.CatalogAccessRuleMatcher2)**

Catalog matcher specifying what catalogs the rule is applied to. ||
|| property | **[PropertyAccessRuleMatcher](#yandex.cloud.trino.v1.PropertyAccessRuleMatcher2)**

Property matcher specifying what properties the rule is applied to. ||
|| allow | **enum** (Allow)

Required field. Whether the rule allows setting the property.

- `ALLOW_UNSPECIFIED`
- `NO`: Denies setting the catalog session property.
- `YES`: Allows to set the catalog session property. ||
|| description | **string**

Rule description. ||
|#

## NetworkConfig {#yandex.cloud.trino.v1.NetworkConfig}

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