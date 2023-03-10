# Standard fields

This section lists standard fields that can be found in {{ yandex-cloud }} resource views. These fields are unified for all services.

| Field name | Description |
| ----- | ----- |
| `cloud_id`* | <b>string</b> <br/> ID of the cloud where the folder is located. The field is present in the <q>folder</q> resource view.<br/><br/>The `cloud_id` and `folder_id` fields are mutually exclusive. |
| `folder_id`* | <b>string</b> <br/> ID of the folder where the resource is located. This field is only present in the views of cloud resources (disks, VMs, and so on).<br/><br/>The `cloud_id` and `folder_id` fields are mutually exclusive. |
| `id`* | <b>string</b> <br/> Resource ID. Generated on the service side. Maximum ID length is 50 characters. |
| `created_at`* | [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto)<br/> Time of resource creation specified in [RFC3339 (Timestamps)](https://www.ietf.org/rfc/rfc3339.txt) format. |
| `name` | <b>string</b> <br/>Resource name. Specified by the user. Maximum name length is 64 characters. |
| `description` | <b>string</b> <br/> Resource description. Specified by the user. Maximum description length is 256 characters. |
| `zone_id` | <b>string</b> <br/> ID of the availability zone the resource lives in.<br/>This field is omitted if the resource does not belong to any zone. |
| `status` | <b>enum</b> <br/> Resource state. For example: READY or CREATING.<br/>This field is used for resources that take a long time to modify. For example, VMs or disks. |
| `labels` | <b>map<string, string></b> <br/> Resource labels in the `` key:value `` format. Specified by the user. Metadata or other arbitrary data can be used as resource labels. |

\* Required field which is always present in the views of all resources.


