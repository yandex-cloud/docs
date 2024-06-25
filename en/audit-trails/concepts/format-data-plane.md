# Data event audit log

Keep track of [data events](events-data-plane.md) to make sure only authorized users can access and update your data. This will help you ensure your cloud infrastructure's compliance with legal regulations and industry standards. For example, you can keep track of your employees' access permissions to sensitive data stored in buckets.

You can analyze data event logs to optimize the use of resources in your infrastructure. Thus, you can determine what resources are used most often and enhance their performance, or identify rarely used resources that can be grouped or removed to cut costs.

{% note warning %}

When setting up collection of data events for an {{ objstorage-name }} bucket, we do not recommend using the same bucket as a [destination object](./trail.md#target) for uploading logs. This may cause automatic recursive generation of audit logs and, consequently, an increase in the size of generated logs (by about 16 MB per month for all events per trail saved to the bucket).

{% endnote %}

A data event audit log is a JSON object with a record of events that occurred to {{ yandex-cloud }} resources.

{% include [format-and-object](../../_includes/audit-trails/format-and-object.md) %}

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

{% include [data-scheme](../../_includes/audit-trails/data-scheme.md) %}

{% include [audit-log-format](../../_includes/audit-trails/audit-log-format.md) %}