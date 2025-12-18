# Fixing the `Permission denied to create UDP listener in folder` error when using {{ TF }}



## Issue description {#issue-description}

When trying to use {{ TF }} for creating, modifying, or deleting cloud resources, you get this error message:

```text
│ Error: Failed to query available provider packages
│
│ Could not retrieve the list of available versions for provider yandex-cloud/yandex: could not connect to registry.terraform.io:
│ Failed to request discovery document: 403 Forbidden
```

## Solution {#issue-resolution}

HashiCorp has blocked Russian IP addresses from accessing their repositories. Use the HashiCorp registry mirror in {{ yandex-cloud }}. To do this, follow these steps:

1. Configure {{ TF }} using [this guide](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
1. Go to the folder containing the {{ TF }} manifest code.
1. Run `terraform init -upgrade`.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Contents of the `~/.terraformrc` file for Linux or MacOS devices, or `%APPDATA%/terraform.rc` for Microsoft Windows® devices. For macOS and Linux, `~` is shorthand for the user’s home directory.
1. Error output when trying to apply the manifest code with the `terraform plan` or `terraform apply` command.
1. `curl -vk registry.terraform.io` and `curl -vk https://terraform-mirror.yandexcloud.net` command output.
