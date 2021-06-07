# Audit event log

The format of entries in the audit log is universal for all operations. The values of some fields are determined by the source service and the event type.

An event object is the service resource that the operation is performed with. An event subject is an account on behalf of which the operation is performed.

## Data schema {#scheme}

```json
[{
  "event_id": string,
  "event_source": string,
  "event_type": string,
  "event_time": string,
  "authentication": {
    "authenticated": boolean,
    "subject_type": string,
    "subject_id": string,
    "subject_name": string
  },
  "authorization": {
    "authorized": boolean
  },
  "resource_metadata": {
    "cloud_id": string,
    "cloud_name": string,
    "folder_id": string,
    "folder_name": string
  },
  "request_metadata": {
    "remote_address": string,
    "user_agent": string,
    "request_id": string
  },
  "event_status": string,
  "details": {
    object
  }
}]
```

| Field | Description |
| --- | --- |
| `event_id` | **string**<br/>Event ID. |
| `event_source` | **string**<br/>Name of the event source service. |
| `event_type` | **string**<br/>Event type. Determined by the event source service. For more information, see [{#T}](events.md). |
| `event_time` | **string**<br/>The time the event occurred. |
| `authentication` | **object**<br/>Authentication data of the event subject. |
| `authentication.authenticated` | **boolean**<br/>Authentication result. Possible values:<ul><li>`true`: Authentication successful.</li><li>`false`: Authentication failed.</li> |
| `authentication.subject_type` | **string**<br/>Subject type. Possible values:<ul><li>`YANDEX_PASSPORT_USER_ACCOUNT`: A Yandex account.</li><li>`SERVICE_ACCOUNT`: A service account.</li><li>`FEDERATED_USER_ACCOUNT`: A federated account.</li> |
| `authentication.subject_id` | **string**<br/>Subject ID. |
| `authentication.subject_name` | **string**<br/>Subject name. |
| `Authorization` | **object**<br/>Authorization data of the event subject. |
| `authorization.authorized` | **boolean**<br/>Authorization result. Possible values:<ul><li>`true`: Authorization successful.</li><li>`false`: Authorization failed.</li> |
| `resource_metadata` | **object**<br/>Metadata of the event object. |
| `resource_metadata.cloud_id` | **string**<br/>Cloud ID. |
| `resource_metadata.cloud_name` | **string**<br/>Cloud name. |
| `resource_metadata.folder_id` | **string**<br/>Folder ID. |
| `resource_metadata.folder_name` | **string**<br/>Folder name. |
| `request_metadata` | **object**<br/>Details of a query triggering the event. |
| `request_metadata.remote_address` | **string**<br/>IP address of an event subject. |
| `request_metadata.user_agent` | **string**<br/>User-agent of an event subject. |
| `request_metadata.request_id` | **string**<br/>Query ID. |
| `event_status` | **string**<br/>Event status. Determined by the source service and the event type.  Possible values:<ul><li>`STARTED`: Operation started.</li><li>`ERROR`: Operation failed.</li><li>`DONE`: Operation successful.</li><li>`CANCELLED`: Operation canceled.</li> |
| `details` | **object**<br/>Event details. Determined by the source service and the event type. |

