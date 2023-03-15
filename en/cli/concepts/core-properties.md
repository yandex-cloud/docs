# CLI configuration

You can [set the parameters](../operations/profile/manage-properties.md) in the profile to quickly switch the command execution context. Use global flags for a single run of a command with a specific parameter value.

{% note warning %}

Note that some parameters cannot be used simultaneously. The value of one of the parameters is reset to zero after the other is set.

{% endnote %}

{% if product == "yandex-cloud" %}

| Global flag | Profile parameter | Description |
|----|----|----|
| `--debug` | — | Output the debug log when executing the command. |
| `--debug-grpc` | — | Output the gRPC debug log when executing the command. This is a very detailed log that is useful for debugging connection issues. |
| `--cloud-id` | `cloud-id` | {% if audience != "internal" %}[ID of the cloud](../../resource-manager/operations/cloud/get-id.md){% else %}ID of the cloud{% endif %} to use when executing the command. |
| `--folder-id` | `folder-id` | ID of the folder to use when executing the command. When this profile parameter is set, the `folder-name` parameter is reset to zero. |
| `--folder-name` | `folder-name` | Name of the folder to use when executing the command. When this profile parameter is set, the `folder-id` parameter is reset to zero. |
| `--format` | `format` | Format for the output: `text` (by default), `yaml`, `json`, `json-rest`. |
| `-h`, `--help` | — | Output the command help. |
| `--no-user-output` | — | Exclude the output intended for the user from the `stderr` error output stream. |
| `--profile` | — | The name of the profile whose parameters will be used when executing the command. |
| — | `service-account-key` | The authorized key of a {% if audience != "internal" %}[service account](../../iam/concepts/users/service-accounts.md){% else %}service account{% endif %} in {{ yandex-cloud }}. It is set from the file where the key is stored. When this profile parameter is set, the `token` parameter is reset to zero. |
| `--token` | `token` | The OAuth token that is used for authentication in {{ yandex-cloud }}. When this profile parameter is set, the `service-account-key` parameter is reset to zero. |

{% endif %}

{% if product == "cloud-il" %}

| Global flag | Profile parameter | Description |
|----|----|----|
| `--debug` | — | Output the debug log when executing the command. |
| `--debug-grpc` | — | Output the gRPC debug log when executing the command. This is a very detailed log that is useful for debugging connection issues. |
| `--cloud-id` | `cloud-id` | [ID of the cloud](../../resource-manager/operations/cloud/get-id.md) to use when executing the command. |
| `--folder-id` | `folder-id` | ID of the folder to use when executing the command. When this profile parameter is set, the `folder-name` parameter is reset to zero. |
| `--folder-name` | `folder-name` | Name of the folder to use when executing the command. When this profile parameter is set, the `folder-id` parameter is reset to zero. |
| `--format` | `format` | Format for the output: `text` (by default), `yaml`, `json`, `json-rest`. |
| `-h`, `--help` | — | Output the command help. |
| `--no-user-output` | — | Exclude the output intended for the user from the `stderr` error output stream. |
| `--profile` | — | The name of the profile whose parameters will be used when executing the command. |
| `--endpoint` | `endpoint` | The domain name and port to which the CLI will send requests. For the CLI to work correctly with {{ yandex-cloud }}, use the `{{ api-host }}:443` value either in the profile parameter (see [this guide](../operations/profile/profile-create.md#create)) or in the global flag at each run. |
| — | `service-account-key` | The authorized key of a [service account](../../iam/concepts/users/service-accounts.md) in {{ yandex-cloud }}. It is set from the file where the key is stored. |

{% endif %}
