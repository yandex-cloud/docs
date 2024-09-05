---
editable: false
sourcePath: en/_api-ref/backup/v1/backup/api-ref/Resource/index.md
---

# Cloud Backup API, REST: Resource methods
A set of methods for managing backup resources: [Compute Cloud instances](/docs/backup/concepts/vm-connection#os).
## JSON Representation {#representation}
```json 
{
  "computeInstanceId": "string",
  "createdAt": "string",
  "updatedAt": "string",
  "online": true,
  "enabled": true,
  "status": "string",
  "statusDetails": "string",
  "statusProgress": "string",
  "lastBackupTime": "string",
  "nextBackupTime": "string",
  "resourceId": "string",
  "isActive": true,
  "initStatus": "string",
  "metadata": "string",
  "type": "string"
}
```
 
Field | Description
--- | ---
computeInstanceId | **string**<br><p>Compute Cloud instance ID.</p> 
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
updatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
online | **boolean** (boolean)<br><p>If this field is true, it means that instance is online.</p> 
enabled | **boolean** (boolean)<br><p>If this field is true, it means that backup is enabled to instance.</p> 
status | **string**<br><ul> <li>IDLE: Compute Cloud instance is doing nothing right now.</li> <li>BACKUPING: Compute Cloud instance is currently backing up itself.</li> <li>RECOVERING: Compute Cloud instance is currently recovering itself.</li> <li>FAILED: Compute Cloud instance is in failure state, check content of ``status_details`` field for more information.</li> <li>OTHER: Unspecified state, check ``status_details`` field for more information.</li> </ul> 
statusDetails | **string**<br><p>If status value is one of ``OTHER`` or ``FAILED``, detailed info might be stored here.</p> 
statusProgress | **string** (int64)<br><p>In case status is one of ``BACKUPING`` or ``RECOVERING``, progress value might be found here.</p> 
lastBackupTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
nextBackupTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
resourceId | **string**<br><p>Resource ID is used to identify Compute Cloud instance in backup service.</p> 
isActive | **boolean** (boolean)<br><p>Status ``is_active`` shows whether current Compute Cloud instance controls Cloud Backup resource. If status ``is_active`` is false it means Compute Cloud instance is not able to manipulate Cloud Backup resource.</p> 
initStatus | **string**<br><p>Status of resource initialization in cloud backup service.</p> <ul> <li>REGISTERING: Registration of instance in cloud backups have started.</li> <li>REGISTRED: Instance is registered in cloud backups.</li> <li>FAILED_REGISTRATION: Instance registration failed.</li> <li>DELETED: Instance is deleted from cloud backup service.</li> </ul> 
metadata | **string**<br><p>Metadata to provide details about instance registration process if status is FAILED_REGISTRATION or REGISTERING</p> 
type | **string**<br><p>Type of resource. Could be compute VM or baremetal server.</p> <ul> <li>COMPUTE: Resource is Compute Cloud VM</li> <li>BMS: Resource is baremetal server</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[delete](delete.md) | Delete specific Compute Cloud instance from Cloud Backup. It does not delete instance from Cloud Compute service.
[get](get.md) | Get specific Compute Cloud instance.
[list](list.md) | List resources: Compute Cloud instances.
[listTasks](listTasks.md) | List tasks of resources.