{% note info %}

The settings apply to Terraform `0.13` and higher.

{% endnote %}


1. Specify the source the provider will be installed from.

   {% list tabs %}

   - Linux and MacOS

      Open the Terraform CLI configuration file:

      ```
      nano ~/.terraformrc
      ```

   - Windows

      Open the Terraform CLI `terraform.rc` configuration file located in your user's `%APPDATA%` folder.

   {% endlist %}

   Add the following section to the file:


   ```
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
     token     = "<OAuth>"
     cloud_id  = "<cloud ID>"
     folder_id = "<folder ID>"
     zone      = "<default availability zone>"
   }
   ```




   * `source`: Provider's global [source address](https://www.terraform.io/docs/language/providers/requirements.html#source-addresses).
   * `version`: The minimum provider version that the module is compatible with. You can find the version number on the [provider's page]({{ tf-provider-link }})(click **USE PROVIDER** in the top right corner).
   * `provider`: The provider name.

   * `token`: [OAuth token](../iam/concepts/authorization/oauth-token.md) for {{ yandex-cloud }} access.
   * `cloud_id`: ID of the cloud where Terraform will create resources.
   * `folder_id`: [ID of the folder](../resource-manager/operations/folder/get-id.md) where resources will be created by default.
   * `zone`: [The availability zone](../overview/concepts/geo-scope.md) where all cloud resources will be created by default.

1. If you previously had a provider from the Hashicorp registry configured, delete its settings:

   ```
   rm -rf .terraform*
   ```

1. Execute the `terraform init` command in the folder containing the `.tf` configuration file. This command initializes the providers specified in the configuration files and lets you work with the provider resources and data sources.

If the provider installation failed, create a [support]({{ link-console-support }}?section=contact) request indicating the provider name and version.

If you used the `.terraform.lock.hcl` file, run the `terraform providers lock` command before initializing, specifying the URL of the mirror that the provider will be uploaded from and the platforms that the configuration will be used on:

```
terraform providers lock -net-mirror=https://terraform-mirror.yandexcloud.net -platform=linux_amd64 -platform=darwin_arm64 yandex-cloud/yandex
```

If you used modules, first run `terraform init`, then delete the lock file. After that, run the `terraform providers lock` command.

