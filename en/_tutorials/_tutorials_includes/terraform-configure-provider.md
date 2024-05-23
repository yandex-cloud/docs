{% note info %}

These settings apply to {{ TF }} `0.13` and higher. We recommend using the latest stable version of {{ TF }}.

{% endnote %}

1. If you previously configured a provider from the HashiCorp registry, save its settings:

   {% list tabs group=operating_system %}

   - Linux/macOS {#linux-macos}

      ```bash
      mv ~/.terraformrc ~/.terraformrc.old
      ```

   - Windows {#windows}

      ```powershell
      mv $env:APPDATA/terraform.rc $env:APPDATA/terraform.rc.old
      ```

   {% endlist %}

1. Specify the source the provider will be installed from.

   {% list tabs group=operating_system %}

   - Linux/macOS {#linux-macos}

      Open the {{ TF }} CLI configuration file:

      ```bash
      nano ~/.terraformrc
      ```

      {% include [terraform-configure-provider-directory](../terraform-configure-provider-directory.md) %}

   - Windows {#windows}

      Open the {{ TF }} CLI configuration file named `terraform.rc` in your user's `%APPDATA%` folder.

      To find out the absolute path to the `%APPDATA%` folder, run the `echo %APPDATA%` command for cmd or the `$env:APPDATA` command for PowerShell.

   {% endlist %}

   Add the following section to the file:

   ```hcl
   provider_installation {
     network_mirror {
       url = "https://terraform-mirror.yandexcloud.net/"
       include = ["registry.terraform.io/*/*"]
     }
     direct {
       exclude = ["registry.terraform.io/*/*"]
     }
   }
   ```

   For more information about setting up mirrors, see the [documentation](https://www.terraform.io/cli/config/config-file#explicit-installation-method-configuration).
1. Add the following sections at the top of the `.tf` configuration file:

   
   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }
     required_version = ">= 0.13"
   }

   provider "yandex" {
     zone = "<default_availability_zone>"
   }
   ```



   Where:
   * `source`: Provider's global [source address](https://www.terraform.io/docs/language/providers/requirements.html#source-addresses).
   * `required_version`: Minimum {{ TF }} version the provider is compatible with.
   * `provider`: Provider name.
   * `zone`: [Availability zone](../../overview/concepts/geo-scope.md) where all cloud resources will be created by default.
1. Run the `terraform init` command in the folder containing the `.tf` configuration file. This command initializes the providers specified in the configuration files and allows you to work with the provider resources and data sources.

If the provider installation failed, create a [support request]({{ link-console-support }}) stating provider name and version.

If you used the `.terraform.lock.hcl` file, prior to the initialization, run the `terraform providers lock` command specifying the URL of the mirror to upload the provider from and the platforms the configuration will run on:

```bash
terraform providers lock -net-mirror=https://terraform-mirror.yandexcloud.net -platform=<platform_1_name> -platform=<platform_2_name> yandex-cloud/yandex
```

Where:
* `-net-mirror`: Address of the mirror to upload the provider from.
* `-platform`: Platforms to use the configuration on. The possible values include:
   * `windows_amd64`: 64-bit Windows
   * `linux_amd64`: 64-bit Linux
   * `darwin_arm64`: 64-bit macOS

If you used the [{{ TF }} modules](../../tutorials/infrastructure-management/terraform-modules.md), first run `terraform init`, then delete the lock file. After that, run the `terraform providers lock` command.

For more information about the `terraform providers lock` command, see the [{{ TF }} documentation](https://developer.hashicorp.com/terraform/cli/commands/providers/lock).