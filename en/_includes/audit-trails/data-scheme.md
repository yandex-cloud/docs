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
    "token_info": {
      "masked_iam_token": string,
      "iam_token_id": string,
      "impersonator_id": string,
      "impersonator_type": string,
      "impersonator_name": string,
      "impersonator_federation_id": string,
      "impersonator_federation_name": string,
      "impersonator_federation_type": string
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
  },
  "request_parameters": {
    object
  },
  "response": {
    object
  }
}
```

| Field | Description |
--- | ---
| `event_id` | **string**<br>Event ID |
| `event_source` | **string**<br>Name of the event source service |
| `event_type` | **string**<br>Event type, which is determined by the event source service. For more information, see [{#T}](../../audit-trails/concepts/events-data-plane.md). |
| `event_time` | **string**<br>Time when the event occurred |
| `authentication` ^1^ | **object**<br>Authentication data of the event subject |
| `authentication.authenticated` | **boolean**<br>Authentication result. The possible values include:<ul><li>`true`: Authentication is successful.</li><li>`false`: Authentication failed.</li> |
| `authentication.subject_type` | **string**<br>Subject type. The possible values include:<ul><li>`YANDEX_PASSPORT_USER_ACCOUNT`: Yandex account</li><li>`SERVICE_ACCOUNT`: Service account</li><li>`FEDERATED_USER_ACCOUNT`: Federated account</li> |
| `authentication.subject_id` | **string**<br>Subject ID |
| `authentication.subject_name` | **string**<br>Subject name |
| `authentication.federation_id` ^2^ | **string**<br>ID of the federation the federated user belongs to |
| `authentication.federation_name` ^2^ | **string**<br>Name of the federation the federated user belongs to |
| `authentication.federation_type` ^2^ | **string**<br>Federation type. The possible value is:<ul><li>`PRIVATE_FEDERATION`: Federation managed by {{ yandex-cloud }} clients.</li></ul> |
| `authentication.token_info` ^1^ | **object**<br>Authentication data of the event subject |
| `authentication.token_info.masked_iam_token` | **string**<br>Encrypted value of the IAM token the subject used to execute the request |
| `authentication.token_info.iam_token_id` | **string**<br>ID of the encrypted IAM token |
| `authentication.token_info.impersonator_id` | **string**<br>Subject ID when using [impersonation](../../iam/concepts/access-control/index.md#impersonation) |
| `authentication.token_info.impersonator_type` | **string**<br>Impersonator subject type. The possible values include:<ul><li>`YANDEX_PASSPORT_USER_ACCOUNT`: Yandex account</li><li>`SERVICE_ACCOUNT`: Service account</li><li>`FEDERATED_USER_ACCOUNT`: Federated account</li> |
| `authentication.token_info.impersonator_name` | **string**<br>Impersonator subject name |
| `authentication.token_info.impersonator_federation_id` ^2^ | **string**<br>ID of the federation the impersonated federated user belongs to |
| `authentication.token_info.impersonator_federation_name`&nbsp;^2^ | **string**<br>Name of the federation the impersonated federated user belongs to |
| `authentication.token_info.impersonator_federation_type`&nbsp;^2^ | **string**<br>Federation type. The possible value is:<ul><li>`PRIVATE_FEDERATION`: Federation managed by {{ yandex-cloud }} clients.</li></ul> |
| `authorization` ^1^ | **object**<br>Authorization data of the event subject |
| `authorization.authorized` | **boolean**<br>Authorization result. The possible values include:<ul><li>`true`: Authorization is successful.</li><li>`false`: Authorization failed.</li> |
| `resource_metadata` ^1^ | **object**<br>Metadata of the event object |
| `resource_metadata.path[]` | **array**<br>Path to the resource where the event occurred |
| `resource_metadata.path[].resource_type` | **string**<br>Resource type |
| `resource_metadata.path[].resource_id` | **string**<br>Resource ID |
| `resource_metadata.path[].resource_name` | **string**<br>Resource name |
| `request_metadata` | **object**<br>Details of a query triggering the event |
| `request_metadata.remote_address` | **string**<br>IP address of an event subject |
| `request_metadata.user_agent` | **string**<br>User-agent of an event subject |
| `request_metadata.request_id` | **string**<br>Query ID |
| `event_status` | **string**<br>Event status, which is determined by the source service and the event type. The possible values include:<ul><li>`STARTED`: Operation started.</li><li>`ERROR`: Operation failed.</li><li>`DONE`: Operation completed successfully.</li><li>`CANCELLED`: Operation canceled.</li></ul> |
| `error` | **object**<br>Status error. [google.rpc.Status](https://github.com/googleapis/googleapis/blob/master/google/rpc/status.proto) object:<ul><li>`code`: [Error code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto)</li><li>`message`: Error description</li><li>`details`: [Error details](https://github.com/googleapis/googleapis/blob/master/google/rpc/error_details.proto)</li></ul>to fill out only in case of an error |
| `details` | **object**<br>Event details, which are determined by the source service and the event type |
| `request_parameters` ^1^ | **object**<br>Request parameters |
| `response` ^1^ | **object**<br>Obtained data |

<small>^1^ The field section is used for certain types of events.</small>
<small>^2^ This field is available when `subject_type` = `FEDERATED_USER_ACCOUNT`.</small>

{% note info %}

If the action was run by a {{ yandex-cloud }} infrastructure service or a support team member, the `remote address` field will be set to `cloud.yandex` and the `user agent` field, to `Yandex Cloud`.

{% endnote %}