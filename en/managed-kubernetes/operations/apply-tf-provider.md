# Activating the {{ k8s }} {{ TF }} provider

You can use {{ TF }} manifests to create {{ k8s }} resources. To do this, activate the `kubernetes` {{ TF }} provider. It supports {{ TF }} resources that are mapped to YAML configuration files for various {{ k8s }} resources.

For more information about the provider resources, see the relevant provider reference on the [{{ TF }}](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs) website.

## Getting started {#before-you-begin}

To connect the `kubernetes` provider, [create](kubernetes-cluster/kubernetes-cluster-create.md) a {{ k8s }} cluster using {{ TF }}.

{% note warning %}

Do not delete {{ TF }} configuration files after creating the cluster as you will need them to activate the provider.

{% endnote %}

The `kubernetes` provider is initialized only after creating and setting up a {{ k8s }} cluster for the following reasons:

* The provider requires the cluster data.
* The provider is used to create {{ k8s }} resources. You can only create them when the cluster is ready.

## Activating the provider {#configure-provider}

1. Navigate to the working directory with {{ TF }} files.

1. Open the `.tf` file with `yandex` provider settings you used when creating the {{ k8s }} cluster. It must have the following structure:

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
      token     = "<IAM_token>"
      cloud_id  = "<cloud_ID>"
      folder_id = "<folder_ID>"
      zone      = "<default_availability_zone>"
    }
    ```

1. In the file, specify the parameters required for the `kubernetes` provider to operate:

    1. Under `required_providers`, add:

        ```hcl
        kubernetes = {
          source = "hashicorp/kubernetes"
        }
        ```

    1. Under `required_providers`, change `required_version` to `">= 0.14.8"`.

    1. Add a new section at the end of the file:

        ```hcl
        data "yandex_client_config" "client" {}

        provider "kubernetes" {
          host                   = yandex_kubernetes_cluster.<{{ k8s }}>_cluster_name.master[0].external_v4_endpoint
          cluster_ca_certificate = yandex_kubernetes_cluster.<{{ k8s }}>_cluster_name.master[0].cluster_ca_certificate
          token                  = data.yandex_client_config.client.iam_token
        }
        ```

1. Make sure the resulting file looks like this:

    ```hcl
    terraform {
      required_providers {
          yandex = {
              source = "yandex-cloud/yandex"
          }
          kubernetes = {
              source = "hashicorp/kubernetes"
          }
      }
      required_version = ">= 0.14.8"
    }

    provider "yandex" {
      token     = "<IAM_token>"
      cloud_id  = "<cloud_ID>"
      folder_id = "<folder_ID>"
      zone      = "<default_availability_zone>"
    }

    data "yandex_client_config" "client" {}

    provider "kubernetes" {
      host                   = yandex_kubernetes_cluster.<{{ k8s }}>_cluster_name.master[0].external_v4_endpoint
      cluster_ca_certificate = yandex_kubernetes_cluster.<{{ k8s }}>_cluster_name.master[0].cluster_ca_certificate
      token                  = data.yandex_client_config.client.iam_token
    }
    ```

1. Initialize the `kubernetes` provider:

   ```bash
   terraform init
   ```

## See also {see-also}

[Managing {{ k8s }} resources via the {{ TF }} provider](../../managed-kubernetes/tutorials/kubernetes-terraform-provider.md).