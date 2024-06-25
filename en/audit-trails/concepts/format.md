# Management event audit log

A [management event](events.md) audit log is a JSON object with a record of events that occurred to {{ yandex-cloud }} resources.

{% include [format-and-object](../../_includes/audit-trails/format-and-object.md) %}

{% cut "Sample management audit log generated when creating a VM" %}

If a federated user creates a VM in {{ compute-full-name }}, the following entry is written in the audit log:

```json
{
    "event_id": "<event_ID>",
    "event_source": "compute",
    "event_type": "yandex.cloud.audit.compute.CreateInstance",
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
        "instance_id": "<VM_ID>",
        "instance_name": "<VM_name>",
        "zone_id": "<VM_availability_zone>",
        "platform_id": "standard-v3",
        "metadata_keys": [
            "ssh-keys",
            "user-data",
            "install-unified-agent"
        ],
        "network_settings": {
            "type": "STANDARD"
        },
        "placement_policy": {
        },
        "os": {
            "type": "LINUX"
        },
        "product_ids": [
            "<image_ID>"
        ],
        "resources": {
            "memory": "2147483648",
            "cores": "2",
            "core_fraction": "100"
        },
        "boot_disk": {
            "mode": "READ_WRITE",
            "device_name": "<disk_name>",
            "auto_delete": true,
            "disk_id": "<disk_ID>"
        },
        "network_interfaces": [
            {
                "index": "0",
                "mac_address": "<VM_MAC_address>",
                "subnet_id": "<subnet_ID>",
                "primary_v4_address": {
                    "address": "<VM_internal_address>",
                    "one_to_one_nat": {
                        "address": "<VM_external_address>",
                        "ip_version": "IPV4"
                    }
                }
            }
        ],
        "fqdn": "VM_internal_FQDN"
    }
}
```
{% endcut %}

{% include [data-scheme](../../_includes/audit-trails/data-scheme.md) %}

{% include [audit-log-format](../../_includes/audit-trails/audit-log-format.md) %}