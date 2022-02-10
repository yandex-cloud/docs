# Creating a {{ k8s }} cluster

Create a {{ k8s }} cluster and then [create a node group](../node-group/node-group-create.md).

## Before you start {#before-you-begin}

To create a {{ k8s }} cluster:
1. Log in to the [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.
1. [On the billing page]({{ link-console-billing }}) make sure that you have enabled a [billing account](../../../billing/concepts/billing-account.md) and that it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../../../billing/quickstart/index.md#create_billing_account).
1. If you don't have a folder, [create one](../../../resource-manager/operations/folder/create.md).
1. Install the [{{ k8s }} CLI (kubectl)](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
1. Make sure you have enough [resources available in the cloud](../../concepts/limits.md).
1. If you don't have a network, [create one](../../../vpc/operations/network-create.md).
1. If you don't have any subnets, [create them](../../../vpc/operations/subnet-create.md) in the availability zones where you will create a {{ k8s }} cluster and node group.
1. Create [service accounts](../../../iam/operations/sa/create.md):
   * A service account with the [{{ roles-editor }}](../../../resource-manager/security/index.md#roles-list) role for the folder where the {{ k8s }} cluster will be created. The resources that the {{ k8s }} cluster needs will be created on behalf of this account.
   * A service account with the [{{ roles-cr-puller }}](../../../container-registry/security/index.md#required-roles) role for the folder containing the Docker image registry. Nodes will download the Docker images they require from the registry on behalf of this account.

   You can use the same service account for both operations.
1. Create the necessary [security groups](../security-groups.md).
1. Review the [recommendations for using {{ managed-k8s-name }}](../../concepts/usage-recommendations.md).

## Create a {{ k8s }} cluster {#kubernetes-cluster-create}

{% list tabs %}

- Management console

  {% include [create-cluster](../../../_includes/managed-kubernetes/cluster-create.md) %}

- CLI

  1. {% include [cli-install](../../../_includes/cli-install.md) %}

  1. {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Specify the {{ k8s }} cluster parameters in the create command (only some of the supported parameters are given in the example):

     ```bash
     {{ yc-k8s }} cluster create \
       --name test-k8s \
       --network-name default \
       --zone ru-central1-a \
       --subnet-name default-a \
       --public-ip \
       --release-channel regular \
       --version 1.13 \
       --cluster-ipv4-range 10.1.0.0/16 \
       --service-ipv4-range 10.2.0.0/16 \
       --security-group-ids enpe5sdn7vs5mu6udl7i,enpj6c5ifh755o6evmu4 \
       --service-account-name default-sa \
       --node-service-account-name default-sa \
       --daily-maintenance-window start=22:00,duration=10h
     ```

     Where:
     * `--name`: The {{ k8s }} cluster name.
     * `--network-name`: Name of the network.
     * `--zone`: Availability zone.
     * `--subnet-name`: Name of the subnet.
     * `--public-ip`: Flag indicating that the {{ k8s }} cluster needs a public IP address.
     * `--release-channel`: [Release channel](../../concepts/release-channels-and-updates.md#release-channels).
     * `--version`: {{ k8s }} version.
     * `--cluster-ipv4-range`: Range of IP addresses for allocating addresses for [pods](../../concepts/index.md#pod).
     * `--service-ipv4-range`: Range of IP addresses for allocating service addresses.
     * `--security-group-ids`: List of cluster security group IDs.

       {% include [security-groups-alert](../../../_includes/managed-kubernetes/security-groups-alert.md) %}

     * `--service-account-id`: The unique ID of the service account for the resources. The resources that the {{ k8s }} cluster needs will be created on behalf of this account.
     * `--node-service-account-id`: The unique ID of the service account for the nodes. Nodes will download the Docker images they require from the registry on behalf of this account.
     * `--daily-maintenance-window`: The maintenance window settings.

     Command output:

     ```bash
     done (5m47s)
     id: cathn0s6qobfa61p3u6k
     folder_id: b1g66jflru0ek1omtsu0
     ...
       service_account_id: aje3932acd0c5ur7gatp
       node_service_account_id: aje3932acd0c5hg8dagp
       release_channel: REGULAR
     ```

  1. To enable the Calico [network policy controller](../../concepts/network-policy.md), pass the `--enable-network-policy` parameter in the cluster create command:

     ```bash
     {{ yc-k8s }} cluster create \
     ...
       --enable-network-policy
     ```

  1. To use the [encryption key](../../concepts/encryption.md) to protect confidential information, pass its name or ID in the cluster creation command:

     ```bash
     {{ yc-k8s }} cluster create \
     ...
       --kms-key-name <encryption key name> \
       --kms-key-id <encryption key ID> \
     ...
     ```

     {% include [write-once-setting.md](../../../_includes/managed-kubernetes/write-once-setting.md) %}

- Terraform

  If you don't have Terraform, [install it and configure the {{ yandex-cloud }} provider](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. In the configuration file, describe the parameters of resources that you want to create. You can add multiple records at the same time:
     * `name`: The {{ k8s }} cluster name.
     * `description`: {{ k8s }} cluster description.
     * `network_id`: Network ID.
     * `version`: The {{ k8s }} version.
     * (Optional) `kms_provider`: [Encryption key](../../concepts/encryption.md) for {{ kms-full-name }} that will be used to protect secrets.

        {% include [write-once-setting.md](../../../_includes/managed-kubernetes/write-once-setting.md) %}

     * `zonal`: Zonal wizard parameters:
       * `zone`: Availability zone.
       * `subnet_id`: The subnet ID. If it is not specified and there is only one subnet in the specified zone, an address in this subnet will be allocated.
     * `public_ip`: Flag indicating that the {{ k8s }} cluster needs a public IP address.
     * `service_account_id`: ID of the service account for the resources. The resources that the {{ k8s }} cluster needs will be created on behalf of this account. The specified service account should have an editing role in the folder where the cluster will be located.
     * `node_service_account_id`: Unique ID of the service account for the nodes. Nodes will download the Docker images they require from the registry on behalf of this account.
     * `release_channel`: [Release channel](../../concepts/release-channels-and-updates.md#release-channels).

     {% note info %}

     If the access rights for `service_account_id` or `node_service_account_id` are granted using Terraform resources, you need to add dependency to these access resources to the cluster configuration in the `depends_on` section.

     The rights are granted with some delay, so you need to add `sleep_after = 30s` to the appropriate resources (`yandex_resourcemanager_folder_iam_member` in the example).

     ```
     depends_on = [
       "yandex_resourcemanager_folder_iam_member.ServiceAccountResourceName",
       "yandex_resourcemanager_folder_iam_member.NodeServiceAccountResourceName"
     ]
     ```

     Otherwise, when you delete resources, Terraform also deletes the cluster and access rights for service accounts. This can cause problems when deleting a cluster and associated node groups.

     {% endnote %}

     ```
     provider "yandex" {
       token     = "key.json"
       cloud_id  = "<cloud ID>"
       folder_id = var.folder-id
       zone      = "ru-central1-a"
     }

     variable "folder-id" {
       default = "<folder id>"
     }

     resource "yandex_kubernetes_cluster" "zonal_cluster_resource_name" {
       name        = "MyCluster"
       description = "MyCluster description"
       network_id  = "${yandex_vpc_network.this.id}"

       master {
         version = "1.17"
         zonal {
           zone      = "${yandex_vpc_subnet.subnet_resource_name.zone}"
           subnet_id = "${yandex_vpc_subnet.subnet_resource_name.id}"
         }
         public_ip = true
       }

       service_account_id      = "${yandex_iam_service_account.this.id}"
       node_service_account_id = "${yandex_iam_service_account.this.id}"
       release_channel         = "STABLE"
       depends_on              = ["yandex_resourcemanager_folder_iam_member.this"]
       kms_provider {
         key_id = "<encryption key ID>"
       }
     }

     resource "yandex_vpc_network" "this" {}

     resource "yandex_vpc_subnet" "subnet_resource_name" {
       network_id     = yandex_vpc_network.this.id
       zone           = "ru-central1-a"
       v4_cidr_blocks = ["192.168.20.0/24"]
     }

     resource "yandex_iam_service_account" "this" {
       name = "k8-sa"
     }

     resource "yandex_resourcemanager_folder_iam_member" "this" {
       folder_id = var.folder-id

       member = "serviceAccount:${yandex_iam_service_account.this.id}"
       role   = "editor"
     }

     locals {
       kubeconfig = <<KUBECONFIG
     apiVersion: v1
     clusters:
     - cluster:
         server: ${yandex_kubernetes_cluster.zonal_cluster_resource_name.master[0].external_v4_endpoint}
         certificate-authority-data: ${base64encode(yandex_kubernetes_cluster.zonal_cluster_resource_name.master[0].cluster_ca_certificate)}
       name: kubernetes
     contexts:
     - context:
         cluster: kubernetes
         user: yc
       name: ycmk8s
     current-context: ycmk8s
     users:
     - name: yc
       user:
         exec:
           apiVersion: client.authentication.k8s.io/v1beta1
           command: yc
           args:
           - k8s
           - create-token
     KUBECONFIG
     }
     output "kubeconfig" {
       value = "${local.kubeconfig}"
     }
     ```

     For more information about the resources you can create using Terraform, see the [provider documentation](https://www.terraform.io/docs/providers/yandex/index.html).

  1. Run the check using the command:

     ```bash
     terraform plan
     ```

     Command output:

     ```
     Refreshing Terraform state in-memory prior to plan...
     The refreshed state will be used to calculate this plan, but will not be
     persisted to local or remote state storage.
     ...
     Note: You didn't specify an "-out" parameter to save this plan, so Terraform
     can't guarantee that exactly these actions will be performed if
     "terraform apply" is subsequently run.
     ```

     The terminal will display a list of resources with parameters. This is a test step. No resources are created. If there are errors in the configuration, Terraform points them out.

     {% note alert %}

     You're charged for all resources created using Terraform. Check the plan carefully.

     {% endnote %}

  1. To create resources, run the command:

     ```bash
     terraform apply
     ```

     Command output:

     ```
     An execution plan has been generated and is shown below.
     Resource actions are indicated with the following symbols:
     + create
     ...
     Terraform will perform the actions described above.
     Only 'yes' will be accepted to approve.

     Enter a value:
     ```

  1. Confirm resource creation: type `yes` in the terminal and press **Enter**.

     ```bash
     Enter a value: yes
     ```

     Terraform creates all the required resources. As a result of executing the command, the console displays the contents of the `kubeconfig` configuration file, which can be used with [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

     {% note info %}

     The [CLI](../../../cli/quickstart.md#install), which is used for getting a token, must be installed and initialized in the system.

     {% endnote %}

     ```yaml
     apiVersion: v1
     clusters:
     - cluster:
         server: https://178.154.202.231
         certificate-authority-data: ...JKdkI0dE1ra0RzRVRSOWIzcFJ1NjNHRFRJRj==...
       name: kubernetes
     contexts:
     - context:
         cluster: kubernetes
         user: yc
       name: ycmk8s
     current-context: ycmk8s
     users:
     - name: yc
       user:
         exec:
           apiVersion: client.authentication.k8s.io/v1beta1
           command: yc
           args:
           - k8s
           - create-token
     ```

  1. Check the resources and their settings in the [management console]({{ link-console-main }}).

- API

  To create a {{ k8s }} cluster, use the [create](../../api-ref/Cluster/create.md) method for the [Cluster](../../api-ref/Cluster) resource.

  To use a [{{ kms-name }} encryption key](../../concepts/encryption.md) to protect secrets, pass its ID in the `kmsProvider.keyId` parameter.

{% endlist %}