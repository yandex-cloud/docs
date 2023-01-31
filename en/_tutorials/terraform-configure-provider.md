{% note info %}

The settings apply to {{ TF }} `0.13` and higher.

{% endnote %}

{% if product == "yandex-cloud" %}
1. Specify the source the provider will be installed from.

   {% list tabs %}

   - Linux and macOS

      Open the {{ TF }} CLI configuration file:

      ```
      nano ~/.terraformrc
      ```

   - Windows

      Open the {{ TF }} CLI `terraform.rc` configuration file located in your user's `%APPDATA%` folder.

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
{% endif %}

1. Add the following sections at the top of the `.tf` configuration file:

   {% if product == "yandex-cloud" %}

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

   {% endif %}

   {% if product == "cloud-il" %}

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
     endpoint         = "{{ api-host }}:443"
     token            = "<static key of the service account>"
     cloud_id         = "<cloud ID>"
     folder_id        = "<folder ID>"
     zone             = "<default availability zone>"
     storage_endpoint = "{{ s3-storage-host }}"
   }
   ```

   {% endif %}

   Where:

   * `source`: Provider's global [source address](https://www.terraform.io/docs/language/providers/requirements.html#source-addresses).
   * `version`: The minimum provider version that the module is compatible with. You can find the version number on the [provider's page]({{ tf-provider-link }}) (click **USE PROVIDER** in the top right corner).
   * `provider`: The provider name.
   {% if product == "cloud-il" %}* `endpoint`: Domain name and port for {{ yandex-cloud }} API: `{{ api-host }}:443`.{% endif %}
   * `token`: {% if product == "yandex-cloud" %}[OAuth token](../iam/concepts/authorization/oauth-token.md){% endif %}{% if product == "cloud-il" %}static key (`secret`) of the service account{% endif %} for {{ yandex-cloud }} access.
   * `cloud_id`: ID of the cloud where {{ TF }} will create resources.
   * `folder_id`: [ID of the folder](../resource-manager/operations/folder/get-id.md) where resources will be created by default.
   * `zone`: [The availability zone](../overview/concepts/geo-scope.md) where all cloud resources will be created by default.

{% if product == "yandex-cloud" %}
1. If you previously had a provider from the Hashicorp registry configured, delete its settings:

   ```
   rm -rf .terraform*
   ```
{% endif %}

1. Execute the `terraform init` command in the folder containing the `.tf` configuration file. This command initializes the providers specified in the configuration files and lets you work with the provider resources and data sources.

If the provider installation failed, create a [support]({{ link-console-support }}?section=contact) request indicating the provider name and version.

{% if product == "yandex-cloud" %}

If you used the `.terraform.lock.hcl` file, run the `terraform providers lock` command before initializing, specifying the URL of the mirror that the provider will be uploaded from and the platforms that the configuration will be used on:

```
terraform providers lock -net-mirror=https://terraform-mirror.yandexcloud.net -platform=linux_amd64 -platform=darwin_arm64 yandex-cloud/yandex
```

If you used modules, first run `terraform init`, then delete the lock file. After that, run the `terraform providers lock` command.

{% endif %}
