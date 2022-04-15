{% note info %}

The settings apply to Terraform `0.13` and higher.

{% endnote %}



1. At the beginning of the configuration file, specify the provider settings.

   {% list tabs %}

   - From the Hashicorp registry

      ```hcl
      terraform {
        required_providers {
          yandex = {
            source  = "yandex-cloud/yandex"
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

   - From a {{ yandex-cloud }} registry

      ```hcl
      terraform {
        required_providers {
          yandex = {
            source = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
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

      If you previously had a provider from the Hashicorp registry configured, delete its settings:
      ```
      rm -rf .terraform*
      ```

   {% endlist %}

   * `source`: Provider's global [source address](https://www.terraform.io/docs/language/providers/requirements.html#source-addresses).
   * `version`: The minimum provider version that the module is compatible with. You can find the version number on the [provider's page](https://registry.terraform.io/providers/yandex-cloud/yandex/latest) (click **USE PROVIDER** in the top right corner).
   * `provider`: The provider name.
   * `token`: [OAuth token](../../iam/concepts/authorization/oauth-token.md) for {{ yandex-cloud }} access.
   * `cloud_id`: ID of the cloud where Terraform will create resources.
   * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) where resources will be created by default.
   * `zone`: The [availability zone](../../overview/concepts/geo-scope.md) where all cloud resources will be created by default.

1. Execute the command `terraform init` in the folder with the configuration file. This command initializes the providers specified in the configuration files and lets you work with the provider resources and data sources.

