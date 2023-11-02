# Data event audit log

You can track data (data plane) events to make sure only authorized users can access and update your data. This will help you ensure your cloud infrastructure's compliance with legal regulations and industry standards. For example, you can track granting employees access permissions to sensitive data stored in buckets.

You can analyze data event logs to optimize the use of resources in your infrastructure. Thus, you can determine what resources are used most often and enhance their performance, or identify rarely used resources that can be grouped or removed to cut costs.

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

{% note warning %}

When setting up collection of data events for an {{ objstorage-name }} bucket, we do not recommend using the same bucket as a [destination object](./trail.md#target) for uploading logs. This may cause automatic recursive generation of audit logs and, consequently, an increase in the size of generated logs (by about 16 MB per month for all events per trail saved to the bucket).

{% endnote %}

A data (data plane) audit log is a JSON object with a record of events that occurred to {{ yandex-cloud }} resources.

The log entry [format](#scheme) is universal for any event. The values of some fields are determined both by the source resource and the event type.

An event object is the service resource on which the operation is performed. An event subject is the account under which the operation is performed.

{% cut "Sample data audit log created when requesting the contents of a secret" %}

If a federated user requests the contents of a secret in {{ lockbox-full-name }}, the following entry is written in the audit log:

```json
{
    "event_id": "<event_ID>",
    "event_source": "lockbox",
    "event_type": "yandex.cloud.audit.lockbox.GetPayload",
    "event_time": "<event_date>",
    "authentication": {
        "authenticated": true,
        "subject_type": "FEDERATED_USER_ACCOUNT",
        "subject_id": "<user_ID>",
        "subject_name": "<username>",
        "federation_id": "<federation_ID>",
        "federation_name": "<federation_name>",
        "federation_type": "<federation_type>"
    },
    "authorization": {
        "authorized": true
    },
    "resource_metadata": {
        "path": [
            {
                "resource_type": "organization-manager.organization",
                "resource_id": "<organization_ID>",
                "resource_name": "<organization_name>"
            },
            {
                "resource_type": "resource-manager.cloud",
                "resource_id": "<cloud_ID>",
                "resource_name": "<cloud_name>"
            },
            {
                "resource_type": "resource-manager.folder",
                "resource_id": "<folder_ID>",
                "resource_name": "<folder_name>"
            }
        ]
    },
    "request_metadata": {
        "remote_address": "cloud.yandex",
        "user_agent": "Yandex Cloud",
        "request_id": "<request_ID>"
    },
    "event_status": "DONE",
    "details": {
        "secret_id": "<secret_ID>",
        "secret_name": "<secret_name>",
        "secret_version_id": "<secret_version_ID>",
        "secret_kms_key_id": "<ID_of_secret_encryption_key_in_KMS>",
        "secret_status": "<secret_status>",
        "secret_version_status": "<secret_version_status>",
        "secret_version_payload_entry_keys": [
            "<secret_version_entry_keys>"
        ]
    },
    "request_parameters": {
        "secret_id": "<secret_ID>",
        "version_id": "<secret_version_ID>"
    },
    "response": {
        "version_id": "<version_ID>",
        "entry_keys": [
            "<entry_keys>"
        ]
    }
}
```
{% endcut %}

## Data schema {#scheme}

```json
{
  "event_id": string,
  "event_source": string,
  "event_type": string,
  "event_time": string,
  "authentication": {
    "authenticated": boolean,
    "subject_type": string,
    "subject_id": string,
    "subject_name": string,
    "federation_id": string,
    "federation_name": string,
    "federation_type": string,
    "impersonator_info": {
      "impersonator_id": string,
      "type": string,
      "name": string,
      "federation_id": string,
      "federation_name": string,
      "federation_type": string
    }
  },
  "authorization": {
    "authorized": boolean
  },
  "resource_metadata": {
    "path": [{
      "resource_type": string,
      "resource_id": string,
      "resource_name": string
    }]
  },
  "request_metadata": {
    "remote_address": string,
    "user_agent": string,
    "request_id": string
  },
  "event_status": string,
  "error": {
    "code": number,
    "message": string,
    "details": {
      object
    }
  },
  "details": {
    object
  }
  "request_parameters": {
    object
  }
  "response": {
    object
  }
}
```

| Field | Description |
--- | ---
| `event_id` | **string**<br>Event ID |
| `event_source` | **string**<br>Name of the event source service |
| `event_type` | **string**<br>Event type, which is determined by the event source service. For more information, see [{#T}](events.md). |
| `event_time` | **string**<br>Time when the event occurred. |
| `authentication` | **object**<br>Authentication data of the event subject |
| `authentication.authenticated` | **boolean**<br>Authentication result. The possible values include:<ul><li>`true`: Authentication is successful.</li><li>`false`: Authentication failed.</li> |
| `authentication.subject_type` | **string**<br>Subject type. The possible values include:<ul><li>`YANDEX_PASSPORT_USER_ACCOUNT`: Yandex account</li><li>`SERVICE_ACCOUNT`: Service account</li><li>`FEDERATED_USER_ACCOUNT`: Federated account</li> |
| `authentication.subject_id` | **string**<br>Subject ID |
| `authentication.subject_name` | **string**<br>Subject name |
| `authentication.federation_id`* | **string**<br>ID of the federation the federated user belongs to |
| `authentication.federation_name`* | **string**<br>Name of the federation the federated user belongs to |
| `authentication.federation_type`* | **string**<br>Federation type. The possible value is:<ul><li>`PRIVATE_FEDERATION`: Federation managed by {{ yandex-cloud }} clients</li></ul> |
| `authentication.impersonator_info` | **object**<br>Authentication data of the event subject when [impersonation](../../iam/concepts/access-control/index.md#impersonation) is used. |
| `authentication.impersonator_info.impersonator_id` | **string**<br>Impersonator subject ID |
| `authentication.impersonator_info.type` | **string**<br>Impersonator subject type The possible values include:<ul><li>`YANDEX_PASSPORT_USER_ACCOUNT`: Yandex account</li><li>`SERVICE_ACCOUNT`: Service account</li><li>`FEDERATED_USER_ACCOUNT`: Federated account</li> |
| `authentication.impersonator_info.name` | **string**<br>Impersonator subject name |
| `authentication.impersonator_info.federation_id`* | **string**<br>ID of the federation the impersonated federated user belongs to. |
| `authentication.impersonator_info.federation_name`* | **string**<br>Name of the federation the impersonated federated user belongs to. |
| `authentication.impersonator_info.federation_type`* | **string**<br>Federation type. The possible value is:<ul><li>`PRIVATE_FEDERATION`: Federation managed by {{ yandex-cloud }} clients</li></ul> |
| `authorization` | **object**<br>Authorization data of the event subject |
| `authorization.authorized` | **boolean**<br>Authorization result. The possible values include:<ul><li>`true`: Authorization is successful.</li><li>`false`: Authorization failed.</li> |
| `resource_metadata` | **object**<br>Metadata of the event object |
| `resource_metadata.path[]` | **array**<br>Path to the resource where the event occurred. |
| `resource_metadata.path[].resource_type` | **string**<br>Resource type |
| `resource_metadata.path[].resource_id` | **string**<br>Resource ID |
| `resource_metadata.path[].resource_name` | **string**<br>Resource name |
| `request_metadata` | **object**<br>Details of a query triggering the event |
| `request_metadata.remote_address` | **string**<br>IP address of an event subject |
| `request_metadata.user_agent` | **string**<br>User-agent of an event subject |
| `request_metadata.request_id` | **string**<br>Query ID |
| `event_status` | **string**<br>Event status, which is determined by the source service and the event type. The possible values include:<ul><li>`STARTED`: The operation started.</li><li>`ERROR`: The operation failed.</li><li>`DONE`: The operation completed successfully.</li><li>`CANCELLED`: The operation is canceled.</li></ul> |
| `error` | **object**<br>Status error. [google.rpc.Status](https://github.com/googleapis/googleapis/blob/master/google/rpc/status.proto) object:<ul><li>`code`: [Error code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto)</li><li>`message`: Error description</li><li>`details`: [Error details](https://github.com/googleapis/googleapis/blob/master/google/rpc/error_details.proto)</li></ul> |
| `details` | **object**<br>Event details, which are determined by the source service and the event type. |
| `request_parameters` | **object**<br>Request parameters |
| `response` | **object**<br>Obtained data |

<small>* The field is available when `subject_type` = `FEDERATED_USER_ACCOUNT`</small>.

{% note info %}

If the action was run by a {{ yandex-cloud }} infrastructure service or a support representative, the `remote address` field will include `cloud.yandex` and the `user agent` field will include `Yandex Cloud`.

{% endnote %}

## Audit log format {#log-name}

Depending on the [destination object](./trail.md#target) (a bucket or log group), the message used by {{ at-name }} to transmit audit logs has a different structure and content:
* If the destination object is a bucket, the message is a file containing an array of [JSON objects](./format.md#scheme) of the audit log.
* If the destination object is a log group, the message includes a single JSON object of the audit log.


### Audit log file in a bucket {#log-file-name}

Below is the template for the full name of an audit log file in a bucket:

`<object prefix>/<trail ID>/<year>/<month>/<file_name.json>`


### Log group entry {#logging-group-name}

Log group entries have the following values:
* **{{ ui-key.yacloud.logging.column_header-time }}**: `Event_time` field value of the event
* **JSON**: JSON object of the event
* **{{ ui-key.yacloud.logging.column_header-level }}**: Calculated depending on the `event_status` value:
   * `ERROR`: For the `ERROR` value
   * `WARN`: For the `CANCELLED` value
   * `INFO`: For all other cases
* **{{ ui-key.yacloud.logging.column_header-message }}**: Includes the values of the `event_status`, `event_type`, `subject_name`, `cloud_name`, and `resource_name` fields.
