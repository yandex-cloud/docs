1. At the beginning of the configuration file, specify the provider settings.

   ```
   provider "yandex" {
     token = "<OAuth or static key of service account>"
     folder_id = "<folder ID>"
     zone      = "ru-central1-a"
   }
   ```
   * `provider`: The provider name.
   * `token`: [OAuth token](../../iam/concepts/authorization/oauth-token.md) to access Yandex.Cloud.
   * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id) where Terraform will create cloud resources.
   * `zone`: The availability zone where all cloud resources will be created by default.

1. Execute the command `terraform init` in the folder with the configuration file. This command initializes the providers specified in the configuration files and allows you to work with the provider resources and data sources.

