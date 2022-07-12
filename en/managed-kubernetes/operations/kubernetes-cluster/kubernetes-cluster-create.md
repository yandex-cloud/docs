# Creating a {{ k8s }} cluster

Create a [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster) and then [create a node group](../node-group/node-group-create.md).

## Before you start {#before-you-begin}

To create a {{ k8s }} cluster:
1. Log in to the [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.


1. [On the billing page]({{ link-console-billing }}), make sure you linked a [billing account](../../../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../../../billing/quickstart/index.md#create_billing_account).


1. If you don't have a [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder), [create one](../../../resource-manager/operations/folder/create.md).
1. Install [{{ k8s }} CLI (kubectl)]({{ k8s-docs }}/tasks/tools/install-kubectl).
1. Make sure you have enough [resources available in the cloud](../../concepts/limits.md).
1. If you don't have a [network](../../../vpc/concepts/network.md#network), [create one](../../../vpc/operations/network-create.md).
1. If you don't have any [subnets](../../../vpc/concepts/network.md#subnet), [create them](../../../vpc/operations/subnet-create.md) in the [availability zones](../../../overview/concepts/geo-scope.md) where your {{ k8s }} cluster and [node group](../../concepts/index.md#node-group) will be created.
1. Create [service accounts](../../../iam/operations/sa/create.md):
   * A service account with the [{{ roles-editor }}](../../../resource-manager/security/index.md#roles-list) role to the folder where a {{ k8s }} cluster is being created. The resources that the {{ k8s }} cluster needs will be created on behalf of this account.
   * A service account with the [{{ roles-cr-puller }}](../../../container-registry/security/index.md#required-roles) role to the folder containing a [Docker image](../../../container-registry/concepts/docker-image.md) [registry](../../../container-registry/concepts/registry.md). Nodes will download the Docker images they require from the registry on behalf of this account.

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

  1. Specify the cluster parameters in the create command (only some of the supported parameters are given in the example):

     ```bash
     {{ yc-k8s }} cluster create \
       --name test-k8s \
       --network-name default \
       --zone {{ region-id }}-a \
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
     * `--network-name`: The name of the network.
     * `--zone`: availability zone.
     * `--subnet-name`: Name of the subnet.
     * `--public-ip`: Flag indicating that the {{ k8s }} cluster needs a public IP address.
     * `--release-channel`: [The release channel](../../concepts/release-channels-and-updates.md#release-channels).
     * `--version`: The {{ k8s }} version.
     * `--cluster-ipv4-range`: The range of IP addresses for allocating [pod](../../concepts/index.md#pod) addresses.
     * `--service-ipv4-range`: The range of IP addresses for allocating [service](../../concepts/index.md#service) addresses.
     * `--security-group-ids`: List of cluster security group IDs.

       {% include [security-groups-alert](../../../_includes/managed-kubernetes/security-groups-alert.md) %}

     * `--service-account-id`: The unique ID of the service account for the resources. The resources that the {{ k8s }} cluster needs will be created on behalf of this account.
     * `--node-service-account-id`: The unique ID of the service account for the nodes. Nodes will download the Docker images they require from the registry on behalf of this account.
     * `--daily-maintenance-window`: [Maintenance](../../concepts/release-channels-and-updates.md#updates) window settings.

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

  1. To activate the Calico [network policy controller](../../concepts/network-policy.md), pass the `--enable-network-policy` flag in the cluster create command:

     ```bash
     {{ yc-k8s }} cluster create \
     ...
       --enable-network-policy
     ```

  1. To use a [{{ kms-full-name }} encryption key](../../concepts/encryption.md) to protect confidential information, pass its name or ID in to the cluster create command:

     ```bash
     {{ yc-k8s }} cluster create \
     ...
       --kms-key-name <encryption key name> \
       --kms-key-id <encryption key ID> \
     ...
     ```

     {% include [write-once-setitng.md](../../../_includes/managed-kubernetes/write-once-setting.md) %}

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  If you don't have Terraform, [install it and configure the provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  To create a cluster:
  1. In the configuration file, describe the parameters of resources that you want to create:
     * {{ k8s }} cluster: Cluster description.
     * Network: A description of the [cloud network](../../../vpc/concepts/network.md#network) where the cluster will reside. If you already have a suitable network, you don't need to describe it again.
     * Subnets: The [subnets](../../../vpc/concepts/network.md#subnet) to connect the cluster hosts to. If you already have suitable subnets, you don't need to describe them again.
     * A [service account](#before-you-begin) for the cluster and nodes and [role settings]({{ tf-provider-link }}/resourcemanager_folder_iam_binding) for the account. Create separate service accounts for the cluster and the nodes, as required. If you have a suitable service account already, you do not need to describe it again.

     > Example configuration file structure:
     >
     > ```hcl
     > resource "yandex_kubernetes_cluster" "<cluster name>" {
     >  network_id = yandex_vpc_network.<network name>.id
     >  master {
     >    zonal {
     >      zone      = yandex_vpc_subnet.<subnet name>.zone
     >      subnet_id = yandex_vpc_subnet.<subnet name>.id
     >    }
     >  }
     >  service_account_id      = yandex_iam_service_account.<service account name>.id
     >  node_service_account_id = yandex_iam_service_account.<service account name>.id
     >    depends_on = [
     >      yandex_resourcemanager_folder_iam_binding.editor,
     >      yandex_resourcemanager_folder_iam_binding.images-puller
     >    ]
     > }
     >
     > resource "yandex_vpc_network" "<network name>" { name = "<network name>" }
     >
     > resource "yandex_vpc_subnet" "<subnet name>" {
     >  v4_cidr_blocks = ["<subnet address range>"]
     >  zone           = "<availability zone>"
     >  network_id     = yandex_vpc_network.<network name>.id
     > }
     >
     > resource "yandex_iam_service_account" "<service account name>" {
     >  name        = "<service account name>"
     >  description = "<service account description>"
     > }
     >
     > resource "yandex_resourcemanager_folder_iam_binding" "editor" {
     >  # Service account to be assigned "editor" role.
     >  folder_id = "<folder ID>"
     >  role      = "editor"
     >  members   = [
     >    "serviceAccount:${yandex_iam_service_account.<service account name>.id}"
     >  ]
     > }
     >
     > resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
     >  # Service account to be assigned "container-registry.images.puller" role.
     >  folder_id = "<folder ID>"
     >  role      = "container-registry.images.puller"
     >  members   = [
     >    "serviceAccount:${yandex_iam_service_account.<service account name>.id}"
     >  ]
     > }
     > ```

     For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-cluster }}).

  1. Make sure that the configuration files are correct.

     {% include [terraform-create-cluster-step-2](../../../_includes/mdb/terraform-create-cluster-step-2.md) %}

  1. Create a cluster.

     {% include [terraform-create-cluster-step-3](../../../_includes/mdb/terraform-create-cluster-step-3.md) %}

- API

  To create a {{ k8s }} cluster, use the [create](../../api-ref/Cluster/create.md) method for the [Cluster](../../api-ref/Cluster) resource.

  To use a [{{ kms-name }} encryption key](../../concepts/encryption.md) to protect secrets, pass its ID in in the `kmsProvider.keyId` parameter.

{% endlist %}