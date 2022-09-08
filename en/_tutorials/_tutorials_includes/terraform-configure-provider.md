1. At the beginning of the configuration file, specify the provider settings.

   {% note info %}

   The provider settings were tested on {{ TF }} `0.14`.

   {% endnote %}

   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }
   }

   provider "yandex" {
     token     = "<OAuth>"
     cloud_id  = "<cloud ID>"
     folder_id = "<folder ID>"
     zone      = "{{ region-id }}-a"
   }
   ```
   
   Where:

   * `provider`: The provider name.
   * `token`: [OAuth token](../iam/concepts/authorization/oauth-token.md) to access {{ yandex-cloud }}.
   * `cloud_id`: ID of the cloud where {{ TF }} will create resources.
   * `folder_id`: [ID of the folder](../resource-manager/operations/folder/get-id.md) where resources will be created by default.
   * `zone`: The availability zone where all cloud resources will be created by default.

1. Execute the command `terraform init` in the folder with the configuration file. This command initializes the providers specified in the configuration files and allows you to work with the provider resources and data sources.

