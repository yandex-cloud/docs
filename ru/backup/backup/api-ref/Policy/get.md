---
editable: false
sourcePath: en/_api-ref/backup/v1/backup/api-ref/Policy/get.md
---

# Cloud Backup API, REST: Policy.get
Get specific policy.
 

 
## HTTP request {#https-request}
```
GET https://backup.{{ api-host }}/backup/v1/policies/{policyId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
policyId | <p>Required. Policy ID.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "name": "string",
  "createdAt": "string",
  "updatedAt": "string",
  "enabled": true,
  "settings": {
    "compression": "string",
    "format": "string",
    "multiVolumeSnapshottingEnabled": true,
    "preserveFileSecuritySettings": true,
    "reattempts": {
      "enabled": true,
      "interval": {
        "type": "string",
        "count": "string"
      },
      "maxAttempts": "string"
    },
    "silentModeEnabled": true,
    "splitting": {
      "size": "string"
    },
    "vmSnapshotReattempts": {
      "enabled": true,
      "interval": {
        "type": "string",
        "count": "string"
      },
      "maxAttempts": "string"
    },
    "vss": {
      "enabled": true,
      "provider": "string"
    },
    "archive": {
      "name": "string"
    },
    "performanceWindow": {
      "enabled": true
    },
    "retention": {
      "rules": [
        {
          "backupSet": [
            "string"
          ],

          // `settings.retention.rules[]` includes only one of the fields `maxAge`, `maxCount`
          "maxAge": {
            "type": "string",
            "count": "string"
          },
          "maxCount": "string",
          // end of the list of possible fields`settings.retention.rules[]`

        }
      ],
      "beforeBackup": true
    },
    "scheduling": {
      "backupSets": [
        {
          "type": "string",

          // `settings.scheduling.backupSets[]` includes only one of the fields `time`, `sinceLastExecTime`
          "time": {
            "weekdays": [
              "string"
            ],
            "repeatAt": [
              {
                "hour": "string",
                "minute": "string"
              }
            ],
            "repeatEvery": {
              "type": "string",
              "count": "string"
            },
            "timeFrom": {
              "hour": "string",
              "minute": "string"
            },
            "timeTo": {
              "hour": "string",
              "minute": "string"
            },
            "monthdays": [
              "string"
            ],
            "includeLastDayOfMonth": true,
            "months": [
              "string"
            ],
            "type": "string"
          },
          "sinceLastExecTime": {
            "delay": {
              "type": "string",
              "count": "string"
            }
          },
          // end of the list of possible fields`settings.scheduling.backupSets[]`

        }
      ],
      "enabled": true,
      "maxParallelBackups": "string",
      "randMaxDelay": {
        "type": "string",
        "count": "string"
      },
      "scheme": "string",
      "weeklyBackupDay": "string"
    },
    "cbt": "string",
    "fastBackupEnabled": true,
    "quiesceSnapshottingEnabled": true
  },
  "folderId": "string"
}
```

 
Field | Description
--- | ---
id | **string**<br><p>Required. Policy ID.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Required. Policy name.</p> <p>The maximum string length in characters is 50.</p> 
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
updatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
enabled | **boolean** (boolean)<br><p>If this field is true, it means that the policy is enabled.</p> 
settings | **object**<br><p>Set of policy settings</p> <p>Set of policy settings</p> 
settings.<br>compression | **string**<br><p>Required. Archive compression level.</p> <p>Compression rate of the backups.</p> 
settings.<br>format | **string**<br><p>Required. Format of the Acronis backup archive.</p> <p>Format of the backup in policy. For backup locations that can be browsed with a file manager, the backup format determines the number of files and their extension.</p> <ul> <li>VERSION_11: A legacy backup format used in older versions. It's not recommended to use.</li> <li>VERSION_12: A new format recommended in most cases for fast backup and recovery.</li> <li>AUTO: Automatic version selection. Will be used version 12 unless the protection plan (policy) appends backups to the ones created by earlier product versions.</li> </ul> 
settings.<br>multiVolumeSnapshottingEnabled | **boolean** (boolean)<br><p>If true, snapshots of multiple volumes will be taken simultaneously.</p> 
settings.<br>preserveFileSecuritySettings | **boolean** (boolean)<br><p>If true, the file security settings will be preserved.</p> 
settings.<br>reattempts | **object**<br><p>Required. Configuration of retries on recoverable errors during the backup operations like reconnection to destination. No attempts to fix recoverable errors will be made if retry configuration is not set.</p> 
settings.<br>reattempts.<br>enabled | **boolean** (boolean)<br><p>If true, enables retry on errors.</p> 
settings.<br>reattempts.<br>interval | **object**<br><p>Required. An interval between retry attempts.</p> 
settings.<br>reattempts.<br>interval.<br>type | **string**<br><p>Required. A type of the interval.</p> 
settings.<br>reattempts.<br>interval.<br>count | **string** (int64)<br><p>The amount of value specified in ``Interval.Type``.</p> <p>Value must be greater than 0.</p> 
settings.<br>reattempts.<br>maxAttempts | **string** (int64)<br><p>Max number of retry attempts. Operation will be considered as failed when max number of retry attempts is reached.</p> <p>Value must be greater than 0.</p> 
settings.<br>silentModeEnabled | **boolean** (boolean)<br><p>If true, a user interaction will be avoided when possible. Equals to false if value is not specified.</p> 
settings.<br>splitting | **object**<br><p>Required. Determines the size to split backups on. Splitting is not performed if value is not specified.</p> 
settings.<br>splitting.<br>size | **string** (int64)<br><p>The size of split backup file in bytes.</p> 
settings.<br>vmSnapshotReattempts | **object**<br><p>Required. Configuration of retries on errors during the creation of the virtual machine snapshot. No attempts to fix recoverable errors will be made if retry configuration is not set.</p> 
settings.<br>vmSnapshotReattempts.<br>enabled | **boolean** (boolean)<br><p>If true, enables retry on errors.</p> 
settings.<br>vmSnapshotReattempts.<br>interval | **object**<br><p>Required. An interval between retry attempts.</p> 
settings.<br>vmSnapshotReattempts.<br>interval.<br>type | **string**<br><p>Required. A type of the interval.</p> 
settings.<br>vmSnapshotReattempts.<br>interval.<br>count | **string** (int64)<br><p>The amount of value specified in ``Interval.Type``.</p> <p>Value must be greater than 0.</p> 
settings.<br>vmSnapshotReattempts.<br>maxAttempts | **string** (int64)<br><p>Max number of retry attempts. Operation will be considered as failed when max number of retry attempts is reached.</p> <p>Value must be greater than 0.</p> 
settings.<br>vss | **object**<br><p>Required. Settings for the Volume Shadow Copy Service (VSS) provider. If not set, no VSS provider is used.</p> <p>Settings for Volume Shadow Copy Services which allows to notify VSS-aware applications that backup is about to start. This will ensure the consistent state of all data used by the applications.</p> 
settings.<br>vss.<br>enabled | **boolean** (boolean)<br><p>If true, the VSS will be enabled.</p> 
settings.<br>vss.<br>provider | **string**<br><p>Required. A type of VSS provider to use in backup.</p> 
settings.<br>archive | **object**<br><p>The archive properties.</p> 
settings.<br>archive.<br>name | **string**<br><p>The name of the generated archive. The name may use the following variables: ``[Machine Name]``, ``[Plan ID]``, ``[Plan Name]``, ``[Unique ID]``, ``[Virtualization Server Type]``. Default value: ``[Machine Name]-[Plan ID]-[Unique ID]A``.</p> 
settings.<br>performanceWindow | **object**<br><p>Required. Time windows for performance limitations of backup and storage maintenance operations.</p> 
settings.<br>performanceWindow.<br>enabled | **boolean** (boolean)<br><p>If true, the time windows will be enabled.</p> 
settings.<br>retention | **object**<br><p>Required. Configuration of backup retention rules.</p> 
settings.<br>retention.<br>rules[] | **object**<br><p>A list of retention rules.</p> 
settings.<br>retention.<br>rules[].<br>backupSet[] | **string**<br><p>A list of backup sets where rules are effective.</p> 
settings.<br>retention.<br>rules[].<br>maxAge | **object** <br>`settings.retention.rules[]` includes only one of the fields `maxAge`, `maxCount`<br>
settings.<br>retention.<br>rules[].<br>maxAge.<br>type | **string**<br><p>Required. A type of the interval.</p> 
settings.<br>retention.<br>rules[].<br>maxAge.<br>count | **string** (int64)<br><p>The amount of value specified in ``Interval.Type``.</p> <p>Value must be greater than 0.</p> 
settings.<br>retention.<br>rules[].<br>maxCount | **string** (int64) <br>`settings.retention.rules[]` includes only one of the fields `maxAge`, `maxCount`<br>
settings.<br>retention.<br>beforeBackup | **boolean** (boolean)<br><p>If true, retention rules will be applied before backup is finished.</p> 
settings.<br>scheduling | **object**<br><p>Required. Configuration of the backup schedule.</p> 
settings.<br>scheduling.<br>backupSets[] | **object**<br><p>Required. A list of schedules with backup sets that compose the whole scheme.</p> <p>Must contain at least one element.</p> 
settings.<br>scheduling.<br>backupSets[].<br>type | **string**<br>BackupSet type -- one of incr, full, differential or auto. if custom scheme is used the BackupSet type should be specified
settings.<br>scheduling.<br>backupSets[].<br>time | **object** <br>`settings.scheduling.backupSets[]` includes only one of the fields `time`, `sinceLastExecTime`<br>
settings.<br>scheduling.<br>backupSets[].<br>time.<br>weekdays[] | **string**<br><p>Days in a week to perform a backup.</p> 
settings.<br>scheduling.<br>backupSets[].<br>time.<br>repeatAt[] | **object**<br><p>Time to repeat the backup.</p> 
settings.<br>scheduling.<br>backupSets[].<br>time.<br>repeatAt[].<br>hour | **string** (int64)<br><p>Hours.</p> 
settings.<br>scheduling.<br>backupSets[].<br>time.<br>repeatAt[].<br>minute | **string** (int64)<br><p>Minutes.</p> 
settings.<br>scheduling.<br>backupSets[].<br>time.<br>repeatEvery | **object**<br><p>Frequency of backup repetition.</p> 
settings.<br>scheduling.<br>backupSets[].<br>time.<br>repeatEvery.<br>type | **string**<br><p>Required. A type of the interval.</p> 
settings.<br>scheduling.<br>backupSets[].<br>time.<br>repeatEvery.<br>count | **string** (int64)<br><p>The amount of value specified in ``Interval.Type``.</p> <p>Value must be greater than 0.</p> 
settings.<br>scheduling.<br>backupSets[].<br>time.<br>timeFrom | **object**<br><p>The start time of the backup time interval.</p> 
settings.<br>scheduling.<br>backupSets[].<br>time.<br>timeFrom.<br>hour | **string** (int64)<br><p>Hours.</p> 
settings.<br>scheduling.<br>backupSets[].<br>time.<br>timeFrom.<br>minute | **string** (int64)<br><p>Minutes.</p> 
settings.<br>scheduling.<br>backupSets[].<br>time.<br>timeTo | **object**<br><p>The end time of the backup time interval.</p> 
settings.<br>scheduling.<br>backupSets[].<br>time.<br>timeTo.<br>hour | **string** (int64)<br><p>Hours.</p> 
settings.<br>scheduling.<br>backupSets[].<br>time.<br>timeTo.<br>minute | **string** (int64)<br><p>Minutes.</p> 
settings.<br>scheduling.<br>backupSets[].<br>time.<br>monthdays[] | **string** (int64)<br><p>Days in a month to perform a backup. Allowed values are from 1 to 31.</p> 
settings.<br>scheduling.<br>backupSets[].<br>time.<br>includeLastDayOfMonth | **boolean** (boolean)<br><p>If set to true, last day of month will activate the policy.</p> 
settings.<br>scheduling.<br>backupSets[].<br>time.<br>months[] | **string** (int64)<br><p>Set of values. Allowed values form 1 to 12.</p> 
settings.<br>scheduling.<br>backupSets[].<br>time.<br>type | **string**<br><p>Required. Possible types: ``REPEATE_PERIOD_UNSPECIFIED``, ``HOURLY``, ``DAILY``, ``WEEKLY``, ``MONTHLY``.</p> 
settings.<br>scheduling.<br>backupSets[].<br>sinceLastExecTime | **object** <br>`settings.scheduling.backupSets[]` includes only one of the fields `time`, `sinceLastExecTime`<br>
settings.<br>scheduling.<br>backupSets[].<br>sinceLastExecTime.<br>delay | **object**<br><p>Required. The interval between backups.</p> 
settings.<br>scheduling.<br>backupSets[].<br>sinceLastExecTime.<br>delay.<br>type | **string**<br><p>Required. A type of the interval.</p> 
settings.<br>scheduling.<br>backupSets[].<br>sinceLastExecTime.<br>delay.<br>count | **string** (int64)<br><p>The amount of value specified in ``Interval.Type``.</p> <p>Value must be greater than 0.</p> 
settings.<br>scheduling.<br>enabled | **boolean** (boolean)<br><p>If true, the backup schedule will be enabled.</p> 
settings.<br>scheduling.<br>maxParallelBackups | **string** (int64)<br><p>Max number of backup processes allowed to run in parallel. Unlimited if not set.</p> 
settings.<br>scheduling.<br>randMaxDelay | **object**<br><p>Required. Configuration of the random delay between the execution of parallel tasks.</p> 
settings.<br>scheduling.<br>randMaxDelay.<br>type | **string**<br><p>Required. A type of the interval.</p> 
settings.<br>scheduling.<br>randMaxDelay.<br>count | **string** (int64)<br><p>The amount of value specified in ``Interval.Type``.</p> <p>Value must be greater than 0.</p> 
settings.<br>scheduling.<br>scheme | **string**<br><p>Required. A backup scheme. Available values: ``simple``, ``always_full``, ``always_incremental``, ``weekly_incremental``, ``weekly_full_daily_incremental``, ``custom``, ``cdp``.</p> <p>Scheme of backups.</p> <ul> <li>CUSTOM: Custom will require to specify schedules for full, differential and incremental backups additionally.</li> </ul> 
settings.<br>scheduling.<br>weeklyBackupDay | **string**<br><p>Required. A day of week to start weekly backups.</p> 
settings.<br>cbt | **string**<br><p>Required. A configuration of Changed Block Tracking (CBT).</p> 
settings.<br>fastBackupEnabled | **boolean** (boolean)<br><p>If true, determines whether a file has changed by the file size and timestamp. Otherwise, the entire file contents are compared to those stored in the backup.</p> 
settings.<br>quiesceSnapshottingEnabled | **boolean** (boolean)<br><p>If true, a quiesced snapshot of the virtual machine will be taken.</p> 
folderId | **string**<br><p>ID of the folder that the policy belongs to.</p> 