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

     {% include [terraform-configure-provider-directory](terraform-configure-provider-directory.md) %}

   - Windows {#windows}

     Open the {{ TF }} CLI `terraform.rc` configuration file in your user's `%APPDATA%` folder.

     To find out the absolute path to the `%APPDATA%` folder, run the `echo %APPDATA%` command for `cmd` or the `$env:APPDATA` command for PowerShell.

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
1. At the beginning of the `.tf` configuration file, add the following sections:

   
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
   * `zone`: Default [availability zone](../../overview/concepts/geo-scope.md) for all your cloud resources.
1. Run the `terraform init` command in the folder with the `.tf` configuration file. This command initializes the providers specified in the configuration files and allows you to work with the provider resources and data sources.

If the provider installation failed, create a [support]({{ link-console-support }}) request indicating the provider name and version.

If you used the `.terraform.lock.hcl` file, run the `terraform providers lock` command prior to the initialization specifying the URL of the mirror to upload the provider from and the platforms the configuration will run on:

```bash
terraform providers lock -net-mirror=https://terraform-mirror.yandexcloud.net -platform=<platform_name_1> -platform=<platform_name_2> yandex-cloud/yandex
```

Where:
* `-net-mirror`: Address of the mirror to upload the provider from.
* `-platform`: Platforms to use the configuration on. The possible values are:
  * `windows_amd64`: Windows 64-bit.
  * `linux_amd64`: Linux 64-bit.
  * `darwin_arm64`: macOS 64-bit.

If you used the [{{ TF }} modules](../../tutorials/infrastructure-management/terraform-modules.md), first run `terraform init`, then delete the lock file. After that, run the `terraform providers lock` command.

For more information about the `terraform providers lock` command, see [this {{ TF }} article](https://developer.hashicorp.com/terraform/cli/commands/providers/lock).