# Fixing the `Invalid provider registry host` error



## Issue description {#issue-description}

When trying to run `terraform init`, you see this error:
```
Initializing the backend...

Initializing provider plugins...
- Finding latest version of yandex-cloud/yandex...
╷
│ Error: Invalid provider registry host
│ 
│ The host "registry.terraform.io" given in in provider source address "registry.terraform.io/yandex-cloud/yandex" does not
│ offer a Terraform provider registry.
```

## Solution {#issue-resolution}

Make sure the provider is set up correctly in the {{ TF }} configuration file. For more info on this setting, see [this guide](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider) that explains how to get started with {{ TF }}.

The way to resolve the issue depends on the OS you are using:

{% list tabs %}

- Microsoft Windows®

  Make sure the file named `terraform.rc` is located in the `%APPDATA%` folder for the user under which `terraform init` is running. If you have already downloaded `.terraformrc`, rename it, and then move it to the correct folder. To identify its actual location in your system, use the `$env:APPDATA` environment variable in PowerShell.

- Linux

  Move the `.terraformrc` file from the `~/.terraform` folder to the root of your home folder, and then run `terraform init` again.

{% endlist %}
