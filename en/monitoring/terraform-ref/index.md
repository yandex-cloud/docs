# Monitoring Terraform

With [Terraform](https://www.terraform.io/), you can create {{ monitoring-short-name }} resources and manage them using configuration files. They store resource descriptions in HashiCorp Configuration Language (HCL).

For more information about the provider resources, see the [documentation](https://storage.cloud-preprod.yandex.net/terraform/docs/index.html) or its [source code](https://bb.yandexcloud.net/projects/CLOUD/repos/cloud-go/browse/devtools/terraform-provider-ycp/docs/resources).

When you apply the configuration files, Terraform automatically determines which part of your configuration is already deployed and what should be added, updated, or removed.

{{ monitoring-short-name }} resources are provided by [Terraform YCP](https://bb.yandexcloud.net/projects/CLOUD/repos/cloud-go/browse/devtools/terraform-provider-ycp).

## Concepts {#concepts}

* {{ monitoring-short-name }} resources can be managed through Terraform configurations.
* For {{ monitoring-short-name }} resources managed by Terraform, the primary source is Terraform configurations. Any changes made via the API, CLI, or GUI are lost when applying a Terraform configuration if it does not contain these changes.
* A {{ monitoring-short-name }} project may contain both resources that are managed by Terraform and those that are not. For example, if you create an alert in the GUI, it will not change when Terraform configurations are applied.
* {{ monitoring-short-name }} resources have no `managed-by-iac` flag, so you can update them not only using Terraform configurations. In this case, any changes missing from the Terraform configuration are lost.
* No resources are provided for data-plane. For instance, you cannot move metrics across shards.

## Getting started with {#use}

1. [Install Terraform](../../tutorials/infrastructure-management/terraform-quickstart#install-terraform).
1. [Configure a Terraform mirror](https://clubs.at.yandex-team.ru/ycp/4790/4792).

   Sample configuration:

   ```bash
   alextrushkin$ cat ~/.terraformrc
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

1. Add a configuration file named `version.tf` that describes your Terraform provider:
   ```
   terraform {
     required_providers {
       ycp = {
         source = "terraform.storage.cloud-preprod.yandex.net/yandex-cloud/ycp"
         # version = "0.20.0" # optional
       }
     }
     required_version = ">= 0.13"
   }
   ```
1. Initialize the provider. To do this, run this command in the folder that has your configuration:
   ```terraform init```

1. Configure the provider by specifying the endpoint for {{ monitoring-short-name }}:
   ```
   provider ycp {
     monitoring {
       endpoint     = "https://solomon-pre.yandex-team.ru"
       grpc_address = "solomon.yandex.net:443"
     }
   }
   ```

   You can find a list of endpoints for different installations [here](../overview/clusters.md).

1. Write the appropriate configuration and apply it by running this command:
   ```
   terraform apply
   ```

## How do I use a local build? {#use-developer-version}

Since it takes time to release a provider and the latest release does not always contain the required fixes and resources, you can use a local build. To do this:
1. Clone the [repository](https://bb.yandexcloud.net/projects/CLOUD/repos/cloud-go/browse).
1. [Configure the repository](https://bb.yandexcloud.net/projects/CLOUD/repos/cloud-go/browse/README.md).
1. Run a [provider](https://bb.yandexcloud.net/projects/CLOUD/repos/cloud-go/browse/devtools/terraform-provider-ycp) build:
   ```
   make local-build
   ```
1. Add `~/.terraformrc` to the file at the beginning of the ```provider_installation``` section:
   ```
     filesystem_mirror {
       path    = "/Users/not_var{{LOGIN_HERE}}/.terraform.d/plugins"
       include = ["terraform.storage.cloud-preprod.yandex.net/*/*"]
     }
   ```

You can learn more about the local build [here](https://wiki.yandex-team.ru/cloud/devel/terraform-ycp/#sborkaizisxodnyxkodov).

After the provider build is complete, [configure terraform](#use) and write a configuration.

If you need to replace the local build, delete the `.terraform.lock.hcl` file and run ```terraform init -upgrade```.

## Authentication and authorization {#auth}

Terraform configurations are applied on behalf of the user running the ```terraform apply``` command. You can learn more about authentication mechanisms [here](../api-ref/authentication.md).

### In {{ yandex-cloud }} {#cloud},

Specify the IAM token in the `YC_TOKEN` environment variable or configuration:
```
provider ycp {
 token = "TOKEN HERE"
}
```

You can also configure `YCP`:
1. Install [YCP](https://wiki.yandex-team.ru/cloud/devel/platform-team/dev/ycp/#install).
1. Run the ```ycp components update && ycp init``` command.
1. In the Terraform configuration, specify the YCP profile for getting a token:
   ```
   provider ycp {
    ycp_profile = "prod"
   }
   ```

### In Big Yandex {#yandex}

Specify the OAuth token in the `YC_TOKEN` environment variable or configuration:
```
provider ycp {
 token = "TOKEN HERE"
}
```

## Storing states {#s3-store}

Terraform stores the state of applied configuration next to the configuration in `terraform.tfstate` files. You can edit or delete the `terraform.tfstate` file. In this case, Terraform considers it has no resources to manage.

The states of applied configurations can be stored in S3. Example for `solomon-cloud`:
1. Check whether you have the `S3 writer` role in the [YC Solomon](https://abc.yandex-team.ru/services/solomon-cloud?scope=manage_store_systems) ABC service. If you do not, get one.
1. Create a bucket for storing states. [Read more](https://wiki.yandex-team.ru/mds/s3-api/authorization/).
1. Get a key to access the bucket in [S3](https://s3-idm.mds.yandex.net/stats/buckets/yc-solomon):
   1. Get an [OAuth token](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=6797456f343042aabba07f49b478c49b).
   1. Create a new access key:
      ```bash
      curl -qs -X POST -H "Authorization: OAuth $S3_OAUTH_TOKEN" "https://s3-idm.mds.yandex.net/credentials/create-access-key" --data "service_id=3047" --data "role=writer"
      ```

      View the current access keys:
      ```bash
      curl -qs -X POST -H "Authorization: OAuth $S3_OAUTH_TOKEN" "https://s3-idm.mds.yandex.net/credentials/list-access-keys" --data "service_id=3047" | json_pp
      ```
      Delete an access key:
      ```bash
      curl -qs -X POST -H "Authorization: OAuth $S3_OAUTH_TOKEN" "https://s3-idm.mds.yandex.net/credentials/delete-access-key" --data "service_id=3047" --data "access_key_id=$ACCESS_KEY_ID"
      ```
1. Configure a bucket provider:
   ```
   terraform {
       backend "s3" {
           endpoint = "s3.mds.yandex.net"
           bucket = "yc-solomon"
           key = "terraform/israel/solomon.tfstate"
           region = "us-east-1"
           access_key = "XXX"
           secret_key = "XXX"
           skip_credentials_validation = true
           skip_metadata_api_check = true
       }
   }
   ```

## Resources {#resources}

With Terraform configurations, you can manage the following {{ monitoring-short-name }} resources:

| Resource | Description |
------|--------
| [Projects](./project.md) | Managing projects. |
| [Project roles](./project-roles.md) | Managing project roles. |
| [Threshold alerts](./alert-threshold.md) | Managing threshold alerts. |
| [Expression alerts](./alert-expression.md) | Managing expression alerts. |
| [Template alerts](./alert-from-template.md) | Managing alerts from templates. |
| [Service provider alerts](./service-provider-alerts.md) | Managing service provider alerts. |
| [Service provider resources](./service-provider-resources.md) | Managing service provider resources. |
| [Email channels](./channel-email.md) | Managing email channels. |
| [Juggler channels](./channel-juggler.md) | Managing Juggler channels. |
| [Phone channels](./channel-phone.md) | Managing phone channels. |
| [SMS channels](./channel-sms.md) | Managing SMS channels. |
| [Telegram channels](./channel-telegram.md) | Managing Telegram channels. |
| [Webhook channels](./channel-webhook.md) | Managing Webhook channels. |
| [YaChat channels](./channel-yachat.md) | Managing YaChat channels. |
| [Escalations](./escalations.md) | Managing escalations. |
| [Dashboards](./dashboards.md) | Managing dashboards. |
| [Clusters](./clusters.md) | Managing clusters. |
| [Pull services](./services-pull.md) | Managing Pull services. |
| [Push services](./services-push.md) | Managing Push services. |
| [Shards](./shards.md) | Managing shards. |
| [Quick links](./quick-links.md) | Managing quick links in a project. |
