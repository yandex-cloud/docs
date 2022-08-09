---
editable: false
---

# Method update
Modifies the specified SQL Server cluster.
 

 
## HTTP request {#https-request}
```
PATCH https://mdb.{{ api-host }}/mdb/sqlserver/v1/clusters/{clusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the SQL Server cluster to update.</p> <p>To get the SQL Server cluster ID, use a <a href="/docs/managed-sqlserver/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "description": "string",
  "labels": "object",
  "configSpec": {
    "version": "string",
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "string",
      "diskTypeId": "string"
    },
    "backupWindowStart": {
      "hours": "integer",
      "minutes": "integer",
      "seconds": "integer",
      "nanos": "integer"
    },
    "access": {
      "dataLens": true,
      "webSql": true
    },
    "secondaryConnections": "string",

    // `configSpec` includes only one of the fields `sqlserverConfig_2016Sp2Std`, `sqlserverConfig_2016Sp2Ent`, `sqlserverConfig_2017Std`, `sqlserverConfig_2017Ent`, `sqlserverConfig_2019Std`, `sqlserverConfig_2019Ent`
    "sqlserverConfig_2016Sp2Std": {
      "maxDegreeOfParallelism": "integer",
      "costThresholdForParallelism": "integer",
      "auditLevel": "integer",
      "fillFactorPercent": "integer",
      "optimizeForAdHocWorkloads": true
    },
    "sqlserverConfig_2016Sp2Ent": {
      "maxDegreeOfParallelism": "integer",
      "costThresholdForParallelism": "integer",
      "auditLevel": "integer",
      "fillFactorPercent": "integer",
      "optimizeForAdHocWorkloads": true
    },
    "sqlserverConfig_2017Std": {
      "maxDegreeOfParallelism": "integer",
      "costThresholdForParallelism": "integer",
      "auditLevel": "integer",
      "fillFactorPercent": "integer",
      "optimizeForAdHocWorkloads": true
    },
    "sqlserverConfig_2017Ent": {
      "maxDegreeOfParallelism": "integer",
      "costThresholdForParallelism": "integer",
      "auditLevel": "integer",
      "fillFactorPercent": "integer",
      "optimizeForAdHocWorkloads": true
    },
    "sqlserverConfig_2019Std": {
      "maxDegreeOfParallelism": "integer",
      "costThresholdForParallelism": "integer",
      "auditLevel": "integer",
      "fillFactorPercent": "integer",
      "optimizeForAdHocWorkloads": true
    },
    "sqlserverConfig_2019Ent": {
      "maxDegreeOfParallelism": "integer",
      "costThresholdForParallelism": "integer",
      "auditLevel": "integer",
      "fillFactorPercent": "integer",
      "optimizeForAdHocWorkloads": true
    },
    // end of the list of possible fields`configSpec`

  },
  "name": "string",
  "securityGroupIds": [
    "string"
  ],
  "deletionProtection": true,
  "serviceAccountId": "string"
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>Field mask that specifies which fields of the SQL Server cluster should be updated.</p> <p>A comma-separated names off ALL fields to be updated. Only the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
description | **string**<br><p>New description of the SQL Server cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the SQL Server cluster as ``key:value`` pairs.</p> <p>For example, ``"project":"mvp"`` or ``"source":"dictionary"``.</p> <p>The new set of labels completely replaces the old one.</p> <p>To add a label, request the current set with the <a href="/docs/managed-sqlserver/api-ref/Cluster/get">get</a> method, then send an <a href="/docs/managed-sqlserver/api-ref/Cluster/update">update</a> request with the new label added to the set.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
configSpec | **object**<br><p>New configuration and resources for hosts in the SQL Server cluster.</p> 
configSpec.<br>version | **string**<br><p>Version of SQL Server used in the cluster.</p> <p>Possible values:</p> <ul> <li>2016sp2std,</li> <li>2016sp2ent,</li> <li>2017std,</li> <li>2017ent,</li> <li>2019std,</li> <li>2019ent.</li> </ul> 
configSpec.<br>resources | **object**<br>Resources allocated to SQL Server hosts.
configSpec.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory, etc.).</p> <p>All available presets are listed in the <a href="/docs/managed-sqlserver/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host.</p> 
configSpec.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> <p>Possible values:</p> <ul> <li>``network-hdd`` - network HDD drive;</li> <li>``network-ssd`` - network SSD drive;</li> <li>``local-ssd`` - local SSD storage.</li> </ul> 
configSpec.<br>backupWindowStart | **object**<br>Start time for the daily backup in UTC timezone.
configSpec.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
configSpec.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
configSpec.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
configSpec.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
configSpec.<br>access | **object**<br>Database access policy.
configSpec.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Allows access for DataLens.</p> 
configSpec.<br>access.<br>webSql | **boolean** (boolean)<br><p>Allows access for Web SQL.</p> 
configSpec.<br>secondaryConnections | **string**<br>Secondary replicas connection mode<br><ul> <li>SECONDARY_CONNECTIONS_OFF: Connections to secondary replicas are prohibited</li> <li>SECONDARY_CONNECTIONS_READ_ONLY: Secondary replicas are read-only</li> </ul> 
configSpec.<br>sqlserverConfig_2016Sp2Std | **object**<br>Configuration for an SQL Server 2016 SP2 Standard edition cluster. <br>`configSpec` includes only one of the fields `sqlserverConfig_2016Sp2Std`, `sqlserverConfig_2016Sp2Ent`, `sqlserverConfig_2017Std`, `sqlserverConfig_2017Ent`, `sqlserverConfig_2019Std`, `sqlserverConfig_2019Ent`<br>
configSpec.<br>sqlserverConfig_2016Sp2Std.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Limits the number of processors to use in parallel plan execution per task.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2Std.<br>costThresholdForParallelism | **integer** (int64)<br><p>Specifies the threshold at which SQL Server creates and runs parallel plans for queries.</p> <p>SQL Server creates and runs a parallel plan for a query only when the estimated cost to run a serial plan for the same query is higher than the value of the option.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 5 to 32767, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2Std.<br>auditLevel | **integer** (int64)<br><p>Describes how to configure login auditing to monitor SQL Server Database Engine login activity.</p> <p>Possible values:</p> <ul> <li>0 - do not log login attempts;</li> <li>1 - log only failed login attempts;</li> <li>2 - log only successful login attempts (not recommended);</li> <li>3 - log all login attempts (not recommended).</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2Std.<br>fillFactorPercent | **integer** (int64)<br><p>Manages the fill factor server configuration option.</p> <p>When an index is created or rebuilt, the fill factor determines the percentage of space on each index leaf-level page to be filled with data, reserving the rest as free space for future growth.</p> <p>Values 0 and 100 mean full page usage (no space reserved).</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2Std.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Determines whether plans should be cached only after second execution.</p> <p>Allows to avoid SQL cache bloat because of single-use plans.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> 
configSpec.<br>sqlserverConfig_2016Sp2Ent | **object**<br>Configuration for an SQL Server 2016 SP2 Enterprise edition cluster. <br>`configSpec` includes only one of the fields `sqlserverConfig_2016Sp2Std`, `sqlserverConfig_2016Sp2Ent`, `sqlserverConfig_2017Std`, `sqlserverConfig_2017Ent`, `sqlserverConfig_2019Std`, `sqlserverConfig_2019Ent`<br>
configSpec.<br>sqlserverConfig_2016Sp2Ent.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Limits the number of processors to use in parallel plan execution per task.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2Ent.<br>costThresholdForParallelism | **integer** (int64)<br><p>Specifies the threshold at which SQL Server creates and runs parallel plans for queries.</p> <p>SQL Server creates and runs a parallel plan for a query only when the estimated cost to run a serial plan for the same query is higher than the value of the option.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 5 to 32767, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2Ent.<br>auditLevel | **integer** (int64)<br><p>Describes how to configure login auditing to monitor SQL Server Database Engine login activity.</p> <p>Possible values:</p> <ul> <li>0 - do not log login attempts;</li> <li>1 - log only failed login attempts;</li> <li>2 - log only successful login attempts (not recommended);</li> <li>3 - log all login attempts (not recommended).</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2Ent.<br>fillFactorPercent | **integer** (int64)<br><p>Manages the fill factor server configuration option. When an index is created or rebuilt, the fill factor determines the percentage of space on each index leaf-level page to be filled with data, reserving the rest as free space for future growth.</p> <p>Values 0 and 100 mean full page usage (no space reserved).</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2Ent.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Determines whether plans should be cached only after second execution.</p> <p>Allows to avoid SQL cache bloat because of single-use plans.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> 
configSpec.<br>sqlserverConfig_2017Std | **object**<br>Configuration for an SQL Server 2017 Standard edition cluster. <br>`configSpec` includes only one of the fields `sqlserverConfig_2016Sp2Std`, `sqlserverConfig_2016Sp2Ent`, `sqlserverConfig_2017Std`, `sqlserverConfig_2017Ent`, `sqlserverConfig_2019Std`, `sqlserverConfig_2019Ent`<br>
configSpec.<br>sqlserverConfig_2017Std.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Limits the number of processors to use in parallel plan execution per task.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2017">SQL Server documentation</a>.</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
configSpec.<br>sqlserverConfig_2017Std.<br>costThresholdForParallelism | **integer** (int64)<br><p>Specifies the threshold at which SQL Server creates and runs parallel plans for queries.</p> <p>SQL Server creates and runs a parallel plan for a query only when the estimated cost to run a serial plan for the same query is higher than the value of the option.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2017">SQL Server documentation</a>.</p> <p>Acceptable values are 5 to 32767, inclusive.</p> 
configSpec.<br>sqlserverConfig_2017Std.<br>auditLevel | **integer** (int64)<br><p>Describes how to configure login auditing to monitor SQL Server Database Engine login activity.</p> <p>Possible values:</p> <ul> <li>0 - do not log login attempts;</li> <li>1 - log only failed login attempts;</li> <li>2 - log only successful login attempts (not recommended);</li> <li>3 - log all login attempts (not recommended).</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2017">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
configSpec.<br>sqlserverConfig_2017Std.<br>fillFactorPercent | **integer** (int64)<br><p>Manages the fill factor server configuration option.</p> <p>When an index is created or rebuilt, the fill factor determines the percentage of space on each index leaf-level page to be filled with data, reserving the rest as free space for future growth.</p> <p>Values 0 and 100 mean full page usage (no space reserved).</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2017">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
configSpec.<br>sqlserverConfig_2017Std.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Determines whether plans should be cached only after second execution.</p> <p>Allows to avoid SQL cache bloat because of single-use plans.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2017">SQL Server documentation</a>.</p> 
configSpec.<br>sqlserverConfig_2017Ent | **object**<br>Configuration for an SQL Server 2017 Enterprise edition cluster. <br>`configSpec` includes only one of the fields `sqlserverConfig_2016Sp2Std`, `sqlserverConfig_2016Sp2Ent`, `sqlserverConfig_2017Std`, `sqlserverConfig_2017Ent`, `sqlserverConfig_2019Std`, `sqlserverConfig_2019Ent`<br>
configSpec.<br>sqlserverConfig_2017Ent.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Limits the number of processors to use in parallel plan execution per task.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2017">SQL Server documentation</a>.</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
configSpec.<br>sqlserverConfig_2017Ent.<br>costThresholdForParallelism | **integer** (int64)<br><p>Specifies the threshold at which SQL Server creates and runs parallel plans for queries.</p> <p>SQL Server creates and runs a parallel plan for a query only when the estimated cost to run a serial plan for the same query is higher than the value of the option.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2017">SQL Server documentation</a>.</p> <p>Acceptable values are 5 to 32767, inclusive.</p> 
configSpec.<br>sqlserverConfig_2017Ent.<br>auditLevel | **integer** (int64)<br><p>Describes how to configure login auditing to monitor SQL Server Database Engine login activity.</p> <p>Possible values:</p> <ul> <li>0 - do not log login attempts;</li> <li>1 - log only failed login attempts;</li> <li>2 - log only successful login attempts (not recommended);</li> <li>3 - log all login attempts (not recommended).</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2017">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
configSpec.<br>sqlserverConfig_2017Ent.<br>fillFactorPercent | **integer** (int64)<br><p>Manages the fill factor server configuration option. When an index is created or rebuilt, the fill factor determines the percentage of space on each index leaf-level page to be filled with data, reserving the rest as free space for future growth.</p> <p>Values 0 and 100 mean full page usage (no space reserved).</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2017">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
configSpec.<br>sqlserverConfig_2017Ent.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Determines whether plans should be cached only after second execution.</p> <p>Allows to avoid SQL cache bloat because of single-use plans.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2017">SQL Server documentation</a>.</p> 
configSpec.<br>sqlserverConfig_2019Std | **object**<br>Configuration for an SQL Server 2019 Standard edition cluster. <br>`configSpec` includes only one of the fields `sqlserverConfig_2016Sp2Std`, `sqlserverConfig_2016Sp2Ent`, `sqlserverConfig_2017Std`, `sqlserverConfig_2017Ent`, `sqlserverConfig_2019Std`, `sqlserverConfig_2019Ent`<br>
configSpec.<br>sqlserverConfig_2019Std.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Limits the number of processors to use in parallel plan execution per task.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2019">SQL Server documentation</a>.</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
configSpec.<br>sqlserverConfig_2019Std.<br>costThresholdForParallelism | **integer** (int64)<br><p>Specifies the threshold at which SQL Server creates and runs parallel plans for queries.</p> <p>SQL Server creates and runs a parallel plan for a query only when the estimated cost to run a serial plan for the same query is higher than the value of the option.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2019">SQL Server documentation</a>.</p> <p>Acceptable values are 5 to 32767, inclusive.</p> 
configSpec.<br>sqlserverConfig_2019Std.<br>auditLevel | **integer** (int64)<br><p>Describes how to configure login auditing to monitor SQL Server Database Engine login activity.</p> <p>Possible values:</p> <ul> <li>0 - do not log login attempts;</li> <li>1 - log only failed login attempts;</li> <li>2 - log only successful login attempts (not recommended);</li> <li>3 - log all login attempts (not recommended).</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2019">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
configSpec.<br>sqlserverConfig_2019Std.<br>fillFactorPercent | **integer** (int64)<br><p>Manages the fill factor server configuration option.</p> <p>When an index is created or rebuilt, the fill factor determines the percentage of space on each index leaf-level page to be filled with data, reserving the rest as free space for future growth.</p> <p>Values 0 and 100 mean full page usage (no space reserved).</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2019">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
configSpec.<br>sqlserverConfig_2019Std.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Determines whether plans should be cached only after second execution.</p> <p>Allows to avoid SQL cache bloat because of single-use plans.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2019">SQL Server documentation</a>.</p> 
configSpec.<br>sqlserverConfig_2019Ent | **object**<br>Configuration for an SQL Server 2019 Enterprise edition cluster. <br>`configSpec` includes only one of the fields `sqlserverConfig_2016Sp2Std`, `sqlserverConfig_2016Sp2Ent`, `sqlserverConfig_2017Std`, `sqlserverConfig_2017Ent`, `sqlserverConfig_2019Std`, `sqlserverConfig_2019Ent`<br>
configSpec.<br>sqlserverConfig_2019Ent.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Limits the number of processors to use in parallel plan execution per task.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2019">SQL Server documentation</a>.</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
configSpec.<br>sqlserverConfig_2019Ent.<br>costThresholdForParallelism | **integer** (int64)<br><p>Specifies the threshold at which SQL Server creates and runs parallel plans for queries.</p> <p>SQL Server creates and runs a parallel plan for a query only when the estimated cost to run a serial plan for the same query is higher than the value of the option.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2019">SQL Server documentation</a>.</p> <p>Acceptable values are 5 to 32767, inclusive.</p> 
configSpec.<br>sqlserverConfig_2019Ent.<br>auditLevel | **integer** (int64)<br><p>Describes how to configure login auditing to monitor SQL Server Database Engine login activity.</p> <p>Possible values:</p> <ul> <li>0 - do not log login attempts;</li> <li>1 - log only failed login attempts;</li> <li>2 - log only successful login attempts (not recommended);</li> <li>3 - log all login attempts (not recommended).</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2019">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
configSpec.<br>sqlserverConfig_2019Ent.<br>fillFactorPercent | **integer** (int64)<br><p>Manages the fill factor server configuration option. When an index is created or rebuilt, the fill factor determines the percentage of space on each index leaf-level page to be filled with data, reserving the rest as free space for future growth.</p> <p>Values 0 and 100 mean full page usage (no space reserved).</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2019">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
configSpec.<br>sqlserverConfig_2019Ent.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Determines whether plans should be cached only after second execution.</p> <p>Allows to avoid SQL cache bloat because of single-use plans.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2019">SQL Server documentation</a>.</p> 
name | **string**<br><p>New name for the SQL Server cluster.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
securityGroupIds[] | **string**<br><p>User security groups.</p> 
deletionProtection | **boolean** (boolean)<br><p>Determines whether the cluster is protected from being deleted.</p> 
serviceAccountId | **string**<br><p>ID of the service account used for access to Object Storage.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 