# Audit log

An audit log stores a JSON object with events that occurred to {{ yandex-cloud }} resources.

Log entry [format](#scheme) is universal for any event. The values of some fields are determined both by the source resource and the event type.

An event object is the service resource that the operation is performed with. An event subject is an account on behalf of which the operation is performed.

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
    "subject_name": string
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
}
```

| Field | Description |
--- | ---
| `event_id` | **string**<br>Event ID. |
| `event_source` | **string**<br>Name of the service that is the event source. |
| `event_type` | **string**<br>Event type. Determined by the event source service. For more information, see [{#T}](events.md). |
| `event_time` | **string**<br>The time the event occurred. |
| `authentication` | **object**<br>Authentication data of the event subject. |
| `authentication.authenticated` | **boolean**<br>Authentication result. Possible values:<ul><li>`true`: Authentication is successful.</li><li>`false`: Authentication failed.</li> |
| `authentication.subject_type` | **string**<br>Subject type. Possible values:<ul>{% if product == "yandex-cloud" %}<li>`YANDEX_PASSPORT_USER_ACCOUNT`: A Yandex account.</li>{% endif %}<li>`SERVICE_ACCOUNT`: A service account.</li><li>`FEDERATED_USER_ACCOUNT`: A federated account.</li> |
| `authentication.subject_id` | **string**<br>Subject ID. |
| `authentication.subject_name` | **string**<br>Subject name. |
| `authorization` | **object**<br>Authorization data of the event subject. |
| `authorization.authorized` | **boolean**<br>Authorization result. Possible values:<ul><li>`true`: Authorization is successful.</li><li>`false`: Authorization failed.</li> |
| `resource_metadata` | **object**<br>Metadata of the event object. |
| `resource_metadata.path[]` | **array**<br>The path to the resource where the event occurred. |
| `resource_metadata.path[].resource_type` | **string**<br>Resource type. |
| `resource_metadata.path[].resource_id` | **string**<br>Resource ID. |
| `resource_metadata.path[].resource_name` | **string**<br>Resource name. |
| `request_metadata` | **object**<br>Details of a query triggering the event. |
| `request_metadata.remote_address` | **string**<br>IP address of an event subject. |
| `request_metadata.user_agent` | **string**<br>User-agent of an event subject. |
| `request_metadata.request_id` | **string**<br>Query ID. |
| `event_status` | **string**<br>Event status. Determined by the source service and the event type. Possible values:<ul><li>`STARTED`: The operation started.</li><li>`ERROR`: The operation failed.</li><li>`DONE`: The operation completed successfully.</li><li>`CANCELLED`: The operation is canceled.</li></ul> |
| `error` | **object**<br>Status error. [google.rpc.Status](https://github.com/googleapis/googleapis/blob/master/google/rpc/status.proto) object:<ul><li>`code`: [Error code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto).</li><li>`message`: Error description.</li><li>`details`: [Error details](https://github.com/googleapis/googleapis/blob/master/google/rpc/error_details.proto).</li></ul> |
| `details` | **object**<br>Event details. Determined by the source service and the event type. |

{% note info %}

If the action was run by a {{ yandex-cloud }} infrastructure service or a support representative, the `remote address` field will include {% if product == "yandex-cloud" %}`cloud.yandex`{% endif %}{% if product == "cloud-il" %}`cloud.il`{% endif %} and the `user agent` field will include {% if product == "yandex-cloud" %}`Yandex Cloud`{% endif %}{% if product == "cloud-il" %}`Cloud IL`{% endif %}.

{% endnote %}

{% if product == "yandex-cloud" %}
## Audit log format {#log-name}

Depending on the [destination object](./trail.md#target) (a bucket or log group), the message used by {{ at-name }} to transmit audit logs has a different structure and content:
* If the destination object is a bucket, the message is a file containing an array of [JSON objects](./format.md#scheme) of the audit log.
* For a log group: A message that only includes one JSON object from an audit log.
{% endif %}
### Audit log file in a bucket {#log-file-name}

Below is the template for the full name of an audit log file in a bucket:

`<object prefix>/<trail ID>/<year>/<month>/<file_name.json>`

{% if product == "yandex-cloud" %}
### Log group entry {#logging-group-name}

Values of log group entries:
* **Time**: The value of `event_time` of the event.
* **JSON**: The JSON object of the event.
* **Level**: Calculated depending on the value of `event_status` of the event:
   * `ERROR`: For the `ERROR` value.
   * `WARN`: For the `CANCELLED` value.
   * `INFO`: For all other cases.
* **Message**: Includes the values of the `event_status`, `event_type`, `subject_name`, `cloud_name`, and `resource_name`.
{% endif %}


