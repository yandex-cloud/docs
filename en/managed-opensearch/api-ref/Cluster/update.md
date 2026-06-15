---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}
    method: patch
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the OpenSearch cluster resource to update.
            To get the OpenSearch cluster ID, use a [ClusterService.List](/docs/managed-opensearch/api-ref/Cluster/list#List) request.
            The maximum string length in characters is 50.
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
        description:
          description: |-
            **string**
            New description of the OpenSearch cluster.
            The maximum string length in characters is 256.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Custom labels for the OpenSearch cluster as `key:value` pairs.
            For example, `"project": "mvp"` or `"source": "dictionary"`.
            The new set of labels completely replaces the old one. To add a label, request the current
            set with the [ClusterService.Get](/docs/managed-opensearch/api-ref/Cluster/get#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set.
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
        configSpec:
          description: |-
            **[ConfigUpdateSpec](#yandex.cloud.mdb.opensearch.v1.ConfigUpdateSpec)**
            New cluster configuration
          $ref: '#/definitions/ConfigUpdateSpec'
        name:
          description: |-
            **string**
            New name for the cluster. The name must be unique within the folder.
            The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
          pattern: '[a-zA-Z0-9_-]*'
          type: string
        securityGroupIds:
          description: |-
            **string**
            User security groups
          type: array
          items:
            type: string
        serviceAccountId:
          description: |-
            **string**
            ID of the service account used to access Object Storage.
          type: string
        deletionProtection:
          description: |-
            **boolean**
            Determines whether the cluster is protected from being deleted.
          type: boolean
        maintenanceWindow:
          description: |-
            **[MaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow)**
            Cluster maintenance window. Should be defined by either one of the two options.
          $ref: '#/definitions/MaintenanceWindow'
        networkId:
          description: |-
            **string**
            ID of the network to move the cluster to.
            The maximum string length in characters is 50.
          type: string
      additionalProperties: false
    definitions:
      OpenSearchConfig2:
        type: object
        properties:
          maxClauseCount:
            description: |-
              **string** (int64)
              Defines the maximum product of fields and terms that are queryable simultaneously.
              Default value: **1024**.
              Change of the setting is applied with restart.
              For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/install-and-configure/configuring-opensearch/index-settings/#dynamic-cluster-level-index-settings).
            type: string
            format: int64
          fielddataCacheSize:
            description: |-
              **string**
              The maximum size of the field data cache.
              May be specified as an absolute value (for example, 8GB) or a percentage of the node heap (for example, 50%).
              This setting is dynamic. If you don't specify this setting, the maximum size is 35%.
              This value should be smaller than the **indices.breaker.fielddata.limit**
              Change of the setting is applied with restart.
              For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/install-and-configure/configuring-opensearch/index-settings/#dynamic-cluster-level-index-settings).
            type: string
          searchMaxBuckets:
            description: |-
              **string** (int64)
              The maximum number of aggregation buckets allowed in a single response. Default is 65535
              Default value: **65535**.
              Change of the setting is applied with restart.
              For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/install-and-configure/configuring-opensearch/search-settings).
            type: string
            format: int64
          reindexRemoteWhitelist:
            description: |-
              **string**
              Allowed remote hosts
              Change of the setting is applied with restart.
              For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/api-reference/document-apis/reindex/#remote-cluster-allow-list).
            type: string
          httpMaxInitialLineLength:
            description: |-
              **string**
              Sets the maximum length allowed for HTTP URLs in the initial request line. URLs exceeding this limit will be rejected. Default is **4kb**.
              Default value: **4kb**.
              Change of the setting is applied with restart.
              For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/install-and-configure/configuring-opensearch/network-settings/#advanced-http-settings).
            type: string
      KeystoreSetting:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Keystore entry name.
            type: string
          value:
            description: |-
              **string**
              Required field. Keystore entry value.
            type: string
        required:
          - name
          - value
      OpenSearchClusterUpdateSpec:
        type: object
        properties:
          plugins:
            description: |-
              **string**
              Names of the cluster plugins.
            type: array
            items:
              type: string
          opensearchConfig_2:
            description: |-
              **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2)**
              OpenSearch server configuration settings.
              Includes only one of the fields `opensearchConfig_2`.
            $ref: '#/definitions/OpenSearchConfig2'
          setKeystoreSettings:
            description: |-
              **[KeystoreSetting](#yandex.cloud.mdb.opensearch.v1.KeystoreSetting)**
              Keystore settings to add/replace. Old entries not listed here will be left unchanged.
            type: array
            items:
              $ref: '#/definitions/KeystoreSetting'
          removeKeystoreSettings:
            description: |-
              **string**
              Keystore entries names to remove.
            type: array
            items:
              type: string
        oneOf:
          - required:
              - opensearchConfig_2
      DashboardsClusterUpdateSpec:
        type: object
        properties: {}
      Access:
        type: object
        properties:
          dataTransfer:
            description: |-
              **boolean**
              Determines whether the access to Data Transfer is allowed.
            type: boolean
          serverless:
            description: |-
              **boolean**
              Determines whether the access to Serverless is allowed.
            type: boolean
      HourlySnapshotSchedule:
        type: object
        properties:
          minute:
            description: |-
              **string** (int64)
              The minute of the hour at which the backup should be created.
              Acceptable values are 0 to 59, inclusive.
            type: string
            format: int64
      DailySnapshotSchedule:
        type: object
        properties:
          hour:
            description: |-
              **string** (int64)
              The hour of the day in UTC timezone at which the backup should be created.
              Acceptable values are 0 to 23, inclusive.
            type: string
            format: int64
          minute:
            description: |-
              **string** (int64)
              The minute of the hour at which the backup should be created.
              Acceptable values are 0 to 59, inclusive.
            type: string
            format: int64
      WeeklySnapshotSchedule:
        type: object
        properties:
          day:
            description: |-
              **enum** (WeekDay)
              Day of the week
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
              The hour of the day in UTC timezone at which the backup should be created.
              Acceptable values are 0 to 23, inclusive.
            type: string
            format: int64
          minute:
            description: |-
              **string** (int64)
              The minute of the hour at which the backup should be created.
              Acceptable values are 0 to 59, inclusive.
            type: string
            format: int64
      SnapshotSchedule:
        type: object
        properties:
          hourlySnapshotSchedule:
            description: |-
              **[HourlySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.HourlySnapshotSchedule)**
              Hourly based snapshot schedule
              Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`.
            $ref: '#/definitions/HourlySnapshotSchedule'
          dailySnapshotSchedule:
            description: |-
              **[DailySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.DailySnapshotSchedule)**
              Daily based snapshot schedule
              Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`.
            $ref: '#/definitions/DailySnapshotSchedule'
          weeklySnapshotSchedule:
            description: |-
              **[WeeklySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.WeeklySnapshotSchedule)**
              Weekly based snapshot schedule
              Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`.
            $ref: '#/definitions/WeeklySnapshotSchedule'
        oneOf:
          - required:
              - hourlySnapshotSchedule
          - required:
              - dailySnapshotSchedule
          - required:
              - weeklySnapshotSchedule
      SnapshotManagement:
        type: object
        properties:
          snapshotSchedule:
            description: |-
              **[SnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.SnapshotSchedule)**
              Snapshot creation schedule
            $ref: '#/definitions/SnapshotSchedule'
          snapshotMaxAgeDays:
            description: |-
              **string** (int64)
              Snapshot max age in days
              The minimum value is 7.
            type: string
            format: int64
      AuditLog:
        type: object
        properties:
          complianceEnabled:
            description: |-
              **boolean**
              Enables audit logging on changes to a security index, such as changes to roles mappings and role creation or deletion.
              For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/security/audit-logs/index/#audit-user-account-manipulation).
            type: boolean
          logRequestBody:
            description: |-
              **boolean**
              Includes the body of the request (if available) for both REST and the transport layer.
              For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/security/audit-logs/index/#disable-request-body-logging).
            type: boolean
          logSearchQueries:
            description: |-
              **boolean**
              Enables indices data read requests logging.
            type: boolean
          logDataModifications:
            description: |-
              **boolean**
              Enables indices data write request logging.
            type: boolean
          logIndexMetadataAccess:
            description: |-
              **boolean**
              Enables indices metadata requests logging.
            type: boolean
          logMonitoringChecks:
            description: |-
              **boolean**
              Enables monitoring data requests logging.
            type: boolean
          logIndexMaintenance:
            description: |-
              **boolean**
              Enables indices maintenance requests logging, such as indices refreshes, flushes and merges.
            type: boolean
          logBackupOperations:
            description: |-
              **boolean**
              Enables snapshots and repositories requests logging.
            type: boolean
      ConfigUpdateSpec:
        type: object
        properties:
          version:
            description: |-
              **string**
              OpenSearch version.
            type: string
          adminPassword:
            description: |-
              **string**
              Required field. OpenSearch admin password.
              The string length in characters must be 10-72.
            type: string
          opensearchSpec:
            description: |-
              **[OpenSearchClusterUpdateSpec](#yandex.cloud.mdb.opensearch.v1.OpenSearchClusterUpdateSpec)**
              OpenSearch configuration.
            $ref: '#/definitions/OpenSearchClusterUpdateSpec'
          dashboardsSpec:
            description: |-
              **object**
              Dashboards configuration.
            $ref: '#/definitions/DashboardsClusterUpdateSpec'
          access:
            description: |-
              **[Access](#yandex.cloud.mdb.opensearch.v1.Access)**
              Access policy for external services.
            $ref: '#/definitions/Access'
          snapshotManagement:
            description: |-
              **[SnapshotManagement](#yandex.cloud.mdb.opensearch.v1.SnapshotManagement)**
              Snapshot management configuration
            $ref: '#/definitions/SnapshotManagement'
          auditLog:
            description: |-
              **[AuditLog](#yandex.cloud.mdb.opensearch.v1.config.AuditLog)**
              Audit log settings
            $ref: '#/definitions/AuditLog'
        required:
          - adminPassword
      AnytimeMaintenanceWindow:
        type: object
        properties: {}
      WeeklyMaintenanceWindow:
        type: object
        properties:
          day:
            description: |-
              **enum** (WeekDay)
              Day of the week.
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
              Hour of the day in the UTC timezone.
              Acceptable values are 1 to 24, inclusive.
            type: string
            format: int64
      MaintenanceWindow:
        type: object
        properties:
          anytime:
            description: |-
              **object**
              An any-time maintenance window.
              Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
            $ref: '#/definitions/AnytimeMaintenanceWindow'
          weeklyMaintenanceWindow:
            description: |-
              **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow)**
              A weekly maintenance window.
              Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
            $ref: '#/definitions/WeeklyMaintenanceWindow'
        oneOf:
          - required:
              - anytime
          - required:
              - weeklyMaintenanceWindow
---

# Managed Service for OpenSearch API, REST: Cluster.Update

Updates the specified OpenSearch cluster.

## HTTP request

```
PATCH https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the OpenSearch cluster resource to update.
To get the OpenSearch cluster ID, use a [ClusterService.List](/docs/managed-opensearch/api-ref/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.mdb.opensearch.v1.UpdateClusterRequest}

```json
{
  "updateMask": "string",
  "description": "string",
  "labels": "object",
  "configSpec": {
    "version": "string",
    "adminPassword": "string",
    "opensearchSpec": {
      "plugins": [
        "string"
      ],
      // Includes only one of the fields `opensearchConfig_2`
      "opensearchConfig_2": {
        "maxClauseCount": "string",
        "fielddataCacheSize": "string",
        "searchMaxBuckets": "string",
        "reindexRemoteWhitelist": "string",
        "httpMaxInitialLineLength": "string"
      },
      // end of the list of possible fields
      "setKeystoreSettings": [
        {
          "name": "string",
          "value": "string"
        }
      ],
      "removeKeystoreSettings": [
        "string"
      ]
    },
    "dashboardsSpec": "object",
    "access": {
      "dataTransfer": "boolean",
      "serverless": "boolean"
    },
    "snapshotManagement": {
      "snapshotSchedule": {
        // Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`
        "hourlySnapshotSchedule": {
          "minute": "string"
        },
        "dailySnapshotSchedule": {
          "hour": "string",
          "minute": "string"
        },
        "weeklySnapshotSchedule": {
          "day": "string",
          "hour": "string",
          "minute": "string"
        }
        // end of the list of possible fields
      },
      "snapshotMaxAgeDays": "string"
    },
    "auditLog": {
      "complianceEnabled": "boolean",
      "logRequestBody": "boolean",
      "logSearchQueries": "boolean",
      "logDataModifications": "boolean",
      "logIndexMetadataAccess": "boolean",
      "logMonitoringChecks": "boolean",
      "logIndexMaintenance": "boolean",
      "logBackupOperations": "boolean"
    }
  },
  "name": "string",
  "securityGroupIds": [
    "string"
  ],
  "serviceAccountId": "string",
  "deletionProtection": "boolean",
  "maintenanceWindow": {
    // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": "object",
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    }
    // end of the list of possible fields
  },
  "networkId": "string"
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
|| description | **string**

New description of the OpenSearch cluster.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the OpenSearch cluster as `key:value` pairs.
For example, `"project": "mvp"` or `"source": "dictionary"`.
The new set of labels completely replaces the old one. To add a label, request the current
set with the [ClusterService.Get](/docs/managed-opensearch/api-ref/Cluster/get#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| configSpec | **[ConfigUpdateSpec](#yandex.cloud.mdb.opensearch.v1.ConfigUpdateSpec)**

New cluster configuration ||
|| name | **string**

New name for the cluster. The name must be unique within the folder.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| securityGroupIds[] | **string**

User security groups ||
|| serviceAccountId | **string**

ID of the service account used to access Object Storage. ||
|| deletionProtection | **boolean**

Determines whether the cluster is protected from being deleted. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow)**

Cluster maintenance window. Should be defined by either one of the two options. ||
|| networkId | **string**

ID of the network to move the cluster to.

The maximum string length in characters is 50. ||
|#

## ConfigUpdateSpec {#yandex.cloud.mdb.opensearch.v1.ConfigUpdateSpec}

#|
||Field | Description ||
|| version | **string**

OpenSearch version. ||
|| adminPassword | **string**

Required field. OpenSearch admin password.

The string length in characters must be 10-72. ||
|| opensearchSpec | **[OpenSearchClusterUpdateSpec](#yandex.cloud.mdb.opensearch.v1.OpenSearchClusterUpdateSpec)**

OpenSearch configuration. ||
|| dashboardsSpec | **object**

Dashboards configuration. ||
|| access | **[Access](#yandex.cloud.mdb.opensearch.v1.Access)**

Access policy for external services. ||
|| snapshotManagement | **[SnapshotManagement](#yandex.cloud.mdb.opensearch.v1.SnapshotManagement)**

Snapshot management configuration ||
|| auditLog | **[AuditLog](#yandex.cloud.mdb.opensearch.v1.config.AuditLog)**

Audit log settings ||
|#

## OpenSearchClusterUpdateSpec {#yandex.cloud.mdb.opensearch.v1.OpenSearchClusterUpdateSpec}

#|
||Field | Description ||
|| plugins[] | **string**

Names of the cluster plugins. ||
|| opensearchConfig_2 | **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2)**

OpenSearch server configuration settings.

Includes only one of the fields `opensearchConfig_2`. ||
|| setKeystoreSettings[] | **[KeystoreSetting](#yandex.cloud.mdb.opensearch.v1.KeystoreSetting)**

Keystore settings to add/replace. Old entries not listed here will be left unchanged. ||
|| removeKeystoreSettings[] | **string**

Keystore entries names to remove. ||
|#

## OpenSearchConfig2 {#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2}

OpenSearch server configuration settings.

#|
||Field | Description ||
|| maxClauseCount | **string** (int64)

Defines the maximum product of fields and terms that are queryable simultaneously.

Default value: **1024**.

Change of the setting is applied with restart.

For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/install-and-configure/configuring-opensearch/index-settings/#dynamic-cluster-level-index-settings). ||
|| fielddataCacheSize | **string**

The maximum size of the field data cache.
May be specified as an absolute value (for example, 8GB) or a percentage of the node heap (for example, 50%).
This setting is dynamic. If you don't specify this setting, the maximum size is 35%.
This value should be smaller than the **indices.breaker.fielddata.limit**

Change of the setting is applied with restart.

For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/install-and-configure/configuring-opensearch/index-settings/#dynamic-cluster-level-index-settings). ||
|| searchMaxBuckets | **string** (int64)

The maximum number of aggregation buckets allowed in a single response. Default is 65535

Default value: **65535**.

Change of the setting is applied with restart.

For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/install-and-configure/configuring-opensearch/search-settings). ||
|| reindexRemoteWhitelist | **string**

Allowed remote hosts

Change of the setting is applied with restart.

For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/api-reference/document-apis/reindex/#remote-cluster-allow-list). ||
|| httpMaxInitialLineLength | **string**

Sets the maximum length allowed for HTTP URLs in the initial request line. URLs exceeding this limit will be rejected. Default is **4kb**.

Default value: **4kb**.

Change of the setting is applied with restart.

For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/install-and-configure/configuring-opensearch/network-settings/#advanced-http-settings). ||
|#

## KeystoreSetting {#yandex.cloud.mdb.opensearch.v1.KeystoreSetting}

Single keystore entry.

#|
||Field | Description ||
|| name | **string**

Required field. Keystore entry name. ||
|| value | **string**

Required field. Keystore entry value. ||
|#

## Access {#yandex.cloud.mdb.opensearch.v1.Access}

Access policy for external services.

#|
||Field | Description ||
|| dataTransfer | **boolean**

Determines whether the access to Data Transfer is allowed. ||
|| serverless | **boolean**

Determines whether the access to Serverless is allowed. ||
|#

## SnapshotManagement {#yandex.cloud.mdb.opensearch.v1.SnapshotManagement}

Snapshot management configuration

#|
||Field | Description ||
|| snapshotSchedule | **[SnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.SnapshotSchedule)**

Snapshot creation schedule ||
|| snapshotMaxAgeDays | **string** (int64)

Snapshot max age in days

The minimum value is 7. ||
|#

## SnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.SnapshotSchedule}

Snapshot creation schedule

#|
||Field | Description ||
|| hourlySnapshotSchedule | **[HourlySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.HourlySnapshotSchedule)**

Hourly based snapshot schedule

Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`. ||
|| dailySnapshotSchedule | **[DailySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.DailySnapshotSchedule)**

Daily based snapshot schedule

Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`. ||
|| weeklySnapshotSchedule | **[WeeklySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.WeeklySnapshotSchedule)**

Weekly based snapshot schedule

Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`. ||
|#

## HourlySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.HourlySnapshotSchedule}

Hourly based snapshot schedule

#|
||Field | Description ||
|| minute | **string** (int64)

The minute of the hour at which the backup should be created.

Acceptable values are 0 to 59, inclusive. ||
|#

## DailySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.DailySnapshotSchedule}

Daily based snapshot schedule

#|
||Field | Description ||
|| hour | **string** (int64)

The hour of the day in UTC timezone at which the backup should be created.

Acceptable values are 0 to 23, inclusive. ||
|| minute | **string** (int64)

The minute of the hour at which the backup should be created.

Acceptable values are 0 to 59, inclusive. ||
|#

## WeeklySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.WeeklySnapshotSchedule}

Weekly based snapshot schedule

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week

- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

The hour of the day in UTC timezone at which the backup should be created.

Acceptable values are 0 to 23, inclusive. ||
|| minute | **string** (int64)

The minute of the hour at which the backup should be created.

Acceptable values are 0 to 59, inclusive. ||
|#

## AuditLog {#yandex.cloud.mdb.opensearch.v1.config.AuditLog}

OpenSearch audit logs settings.

#|
||Field | Description ||
|| complianceEnabled | **boolean**

Enables audit logging on changes to a security index, such as changes to roles mappings and role creation or deletion.

For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/security/audit-logs/index/#audit-user-account-manipulation). ||
|| logRequestBody | **boolean**

Includes the body of the request (if available) for both REST and the transport layer.

For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/security/audit-logs/index/#disable-request-body-logging). ||
|| logSearchQueries | **boolean**

Enables indices data read requests logging. ||
|| logDataModifications | **boolean**

Enables indices data write request logging. ||
|| logIndexMetadataAccess | **boolean**

Enables indices metadata requests logging. ||
|| logMonitoringChecks | **boolean**

Enables monitoring data requests logging. ||
|| logIndexMaintenance | **boolean**

Enables indices maintenance requests logging, such as indices refreshes, flushes and merges. ||
|| logBackupOperations | **boolean**

Enables snapshots and repositories requests logging. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow}

An OpenSearch cluster maintenance window. Should be defined by either one of the two options.

#|
||Field | Description ||
|| anytime | **object**

An any-time maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow)**

A weekly maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow}

A weekly maintenance window.

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week.

- `MON`: Monday
- `TUE`: Tuesday
- `WED`: Wednesday
- `THU`: Thursday
- `FRI`: Friday
- `SAT`: Saturday
- `SUN`: Sunday ||
|| hour | **string** (int64)

Hour of the day in the UTC timezone.

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