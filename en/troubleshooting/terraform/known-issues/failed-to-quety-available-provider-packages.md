# Resolving the 'failed to query available provider packages' error when using Terraform


## Issue description {#issue-description}

When you attempt to use Terraform for creating, modifying, or deleting cloud resources, you see this error message:

```text
│ Error: Failed to query available provider packages
│
│ Could not retrieve the list of available versions for provider yandex-cloud/yandex: could not connect to registry.terraform.io:
│ Failed to request discovery document: 403 Forbidden
```

## Solution {#issue-resolution}

Hashicorp has blocked Russian IP addresses from accessing their repositories.
Use the Hashicorp registry mirror in Yandex Cloud. For this, you need to [configure Terraform following this guide](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider):

Then, navigate to the folder with the Terraform manifest code and run `terraform init -upgrade`.

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:

1. The content of the `~/.terraformrc` file (on Linux or MacOS computers) or `%APPDATA%/terraform.rc` (on Windows computers).
2. Error output when trying to apply manifest code with the `terraform plan` or `terraform apply` command.
3. The output of the `curl -vk registry.terraform.io` and `curl -vk https://terraform-mirror.yandexcloud.net` command
