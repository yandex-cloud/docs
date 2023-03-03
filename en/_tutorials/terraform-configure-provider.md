{% note info %}

These settings apply to {{ TF }} `0.13` and higher. It's recommended to use the latest stable version of {{ TF }}.

{% endnote %}

{% if product == "yandex-cloud" %}
1. If you previously had a provider from the Hashicorp registry configured, save its settings:

   {% list tabs %}

   - Linux and macOS

      ```bash
      mv ~/.terraformrc ~/.terraformrc.old
      ```

   - Windows

      ```powershell
      mv $env:APPDATA/terraform.rc $env:APPDATA/terraform.rc.old
      ```

   {% endlist %}

1. Specify the source the provider will be installed from.

   {% list tabs %}

   - Linux and macOS

      Open the {{ TF }} CLI configuration file:

      ```
      nano ~/.terraformrc
      ```

   - Windows

      Open the {{ TF }} CLI configuration file named `terraform.rc` in your user's `%APPDATA%` folder.

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
   * `required_version`: The minimum version of {{ TF }} the provider is compatible with.
   * `provider`: The provider name.
   {% if product == "cloud-il" %}* `endpoint`: Domain name and port for requests to the {{ yandex-cloud }} API: `{{ api-host }}:443`.{% endif %}
   * `zone`: The [availability zone](../overview/concepts/geo-scope.md) where all cloud resources will be created by default.

1. Execute the `terraform init` command in the folder containing the `.tf` configuration file. This command initializes the providers specified in the configuration files and lets you work with the provider resources and data sources.

If the provider installation failed, create a [support]({{ link-console-support }}?section=contact) request indicating the provider name and version.

{% if product == "yandex-cloud" %}

If you used the `.terraform.lock.hcl` file, run the `terraform providers lock` command before initializing, specifying the URL of the mirror that the provider will be uploaded from and the platforms that the configuration will be used on:

```
terraform providers lock -net-mirror=https://terraform-mirror.yandexcloud.net -platform=linux_amd64 -platform=darwin_arm64 yandex-cloud/yandex
```

If you used modules, first run `terraform init`, then delete the lock file. After that, run the `terraform providers lock` command.

{% endif %}
