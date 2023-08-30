# Creating a {{ k8s }} cluster

Create a [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster) and then [create a node group](../node-group/node-group-create.md).

## Before you begin {#before-you-begin}

To create a {{ k8s }} cluster:

{% list tabs %}

- Management console

  1. Log in to the [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.

  
  1. [On the billing page]({{ link-console-billing }}), make sure you linked a [billing account](../../../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../../../billing/quickstart/index.md#create_billing_account).


  1. If you don't have a [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder), [create one](../../../resource-manager/operations/folder/create.md).

  1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

  1. Make sure you have enough [resources available in the cloud](../../concepts/limits.md).
  1. If you don't have a [network](../../../vpc/concepts/network.md#network), [create one](../../../vpc/operations/network-create.md).
  1. If you don't have any [subnets](../../../vpc/concepts/network.md#subnet), [create them](../../../vpc/operations/subnet-create.md) in the [availability zones](../../../overview/concepts/geo-scope.md) where your {{ k8s }} cluster and [node group](../../concepts/index.md#node-group) will be created.
  1. Create [service accounts](../../../iam/operations/sa/create.md):
     * A service account with the [{{ roles-editor }}](../../../resource-manager/security/index.md#roles-list) role to the folder where a {{ k8s }} cluster is being created. The resources that the {{ k8s }} cluster needs will be created on behalf of this account.
     * A service account with the [{{ roles-cr-puller }}](../../../container-registry/security/index.md#choosing-roles) role to the folder containing a [Docker image](../../../container-registry/concepts/docker-image.md) [registry](../../../container-registry/concepts/registry.md). Nodes will download the Docker images they require from the registry on behalf of this account.

     You can use the same service account for both operations.

     {% include [k8s.tunnelClusters.agent role](../../../_includes/managed-kubernetes/note-tunnelClusters-agent.md) %}

  1. Create the necessary [security groups](../connect/security-groups.md).
  1. Review the [recommendations for using {{ managed-k8s-name }}](../../concepts/usage-recommendations.md).

{% endlist %}

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

     Command result:

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
       --kms-key-id <encryption key ID>
     ```

     {% include [write-once-setting.md](../../../_includes/managed-kubernetes/write-once-setting.md) %}

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  If you don't have {{ TF }}, [install it and configure the provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  To create a cluster:
  1. In the configuration file, describe the parameters of resources that you want to create:
     * {{ k8s }} cluster: Cluster description.
     * Network: A description of the [cloud network](../../../vpc/concepts/network.md#network) where the cluster will be hosted. If you already have a suitable network, you don't need to describe it again.
     * Subnets: The [subnets](../../../vpc/concepts/network.md#subnet) to connect the cluster hosts to. If you already have suitable subnets, you don't need to describe them again.
     * A [service account](#before-you-begin) for the cluster and nodes and [role settings]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member) for the account. Create separate service accounts for the cluster and the nodes, as required. If you have a suitable service account already, you do not need to describe it again.

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
     >      yandex_resourcemanager_folder_iam_member.editor,
     >      yandex_resourcemanager_folder_iam_member.images-puller
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
     > resource "yandex_resourcemanager_folder_iam_member" "editor" {
     >  # Service account to be assigned "editor" role.
     >  folder_id = "<folder ID>"
     >  role      = "editor"
     >  member    = "serviceAccount:${yandex_iam_service_account.<service account name>.id}"
     > }
     >
     > resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
     >  # Service account to be assigned "container-registry.images.puller" role.
     >  folder_id = "<folder ID>"
     >  role      = "container-registry.images.puller"
     >  member    = "serviceAccount:${yandex_iam_service_account.<service account name>.id}"
     > }
     > ```

     For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-cluster }}).
  1. Make sure that the configuration files are valid.

     {% include [terraform-create-cluster-step-2](../../../_includes/mdb/terraform-create-cluster-step-2.md) %}

  1. Create a cluster.

     {% include [terraform-create-cluster-step-3](../../../_includes/mdb/terraform-create-cluster-step-3.md) %}

- API

  To create a {{ k8s }} cluster, use the [create](../../api-ref/Cluster/create.md) method for the [Cluster](../../api-ref/Cluster) resource.

  To use a [{{ kms-name }} encryption key](../../concepts/encryption.md) to protect secrets, pass its ID in the `kmsProvider.keyId` parameter.

{% endlist %}

## Examples {#examples}

### Creating a zonal cluster {#example-zonal-cluster}

{% list tabs %}

- {{ TF }}

  Let's say we need to create a {{ k8s }} cluster and a network for it with the following characteristics:
  * Named `k8s-zonal`.
  * Version `1.22`.
  * In the cloud with the ID `{{ tf-cloud-id }}`.
  * In the folder with the ID `{{ tf-folder-id }}`.
  * In the new `mynet` network.
  * In the new subnet `mysubnet` and `{{ region-id }}-a` availability zone. The `mysubnet` subnet will have a range of `10.1.0.0/16`.
  * With the new service account `myaccount` that has the `k8s.clusters.agent`, `vpc.publicAdmin`, `container-registry.images.puller`, and `kms.viewer` role permissions.
  * With the {{ kms-name }} `kms-key` encryption key.
  * In the new security group `k8s-public-services` allowing [connections to services from the internet](../connect/security-groups.md#rules-nodes).

  To do this, install Terraform (if you don't have it yet) and configure the provider by following the [instructions](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Next, apply the configuration file:

  {% cut "Configuration file for the cluster:" %}

  
  ```hcl
  locals {
    cloud_id    = "{{ tf-cloud-id }}"
    folder_id   = "{{ tf-folder-id }}"
    k8s_version = "1.22"
    sa_name     = "myaccount"
  }

  terraform {
    required_providers {
      yandex = {
        source = "yandex-cloud/yandex"
      }
    }
  }

  provider "yandex" {
    folder_id = local.folder_id
  }

  resource "yandex_kubernetes_cluster" "k8s-zonal" {
    network_id = yandex_vpc_network.mynet.id
    master {
      version = local.k8s_version
      zonal {
        zone      = yandex_vpc_subnet.mysubnet.zone
        subnet_id = yandex_vpc_subnet.mysubnet.id
      }
      security_group_ids = [yandex_vpc_security_group.k8s-public-services.id]
    }
    service_account_id      = yandex_iam_service_account.myaccount.id
    node_service_account_id = yandex_iam_service_account.myaccount.id
    depends_on = [
      yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
      yandex_resourcemanager_folder_iam_member.vpc-public-admin,
      yandex_resourcemanager_folder_iam_member.images-puller
    ]
    kms_provider {
      key_id = yandex_kms_symmetric_key.kms-key.id
    }
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_subnet" "mysubnet" {
    v4_cidr_blocks = ["10.1.0.0/16"]
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
  }

  resource "yandex_iam_service_account" "myaccount" {
    name        = local.sa_name
    description = "K8S zonal service account"
  }

  resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
    # The service account is assigned the k8s.clusters.agent role.
    folder_id = local.folder_id
    role      = "k8s.clusters.agent"
    member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
    # The service account is assigned the vpc.publicAdmin role.
    folder_id = local.folder_id
    role      = "vpc.publicAdmin"
    member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
    # The service account is assigned the container-registry.images.puller role.
    folder_id = local.folder_id
    role      = "container-registry.images.puller"
    member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  }

  resource "yandex_kms_symmetric_key" "kms-key" {
    # A key for encrypting critical information, including passwords, OAuth tokens, and SSH keys.
    name              = "kms-key"
    default_algorithm = "AES_128"
    rotation_period   = "8760h" # 1 year.
  }

  resource "yandex_kms_symmetric_key_iam_member" "viewer" {
    symmetric_key_id = yandex_kms_symmetric_key.kms-key.id
    role             = "viewer"
    member           = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  }

  resource "yandex_vpc_security_group" "k8s-public-services" {
    name        = "k8s-public-services"
    description = "Group rules allow connections to services from the internet. Apply the rules only for node groups."
    network_id  = yandex_vpc_network.mynet.id
    ingress {
      protocol          = "TCP"
      description       = "Rule allows availability checks from load balancer's address range. It is required for the operation of a fault-tolerant cluster and load balancer services."
      predefined_target = "loadbalancer_healthchecks"
      from_port         = 0
      to_port           = 65535
     }
    ingress {
      protocol          = "ANY"
      description       = "Rule allows master-node and node-node communication inside a security group."
      predefined_target = "self_security_group"
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ANY"
      description       = "Rule allows pod-pod and service-service communication. Specify the subnets of your cluster and services."
      v4_cidr_blocks    = concat(yandex_vpc_subnet.mysubnet-a.v4_cidr_blocks, yandex_vpc_subnet.mysubnet-b.v4_cidr_blocks, yandex_vpc_subnet.mysubnet-c.v4_cidr_blocks)
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ICMP"
      description       = "Rule allows debugging ICMP packets from internal subnets."
      v4_cidr_blocks    = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
    }
    ingress {
      protocol          = "TCP"
      description       = "Rule allows incoming traffic from the internet to the NodePort port range. Add ports or change existing ones to the required ports."
      v4_cidr_blocks    = ["0.0.0.0/0"]
      from_port         = 30000
      to_port           = 32767
    }
    egress {
      protocol          = "ANY"
      description       = "Rule allows all outgoing traffic. Nodes can connect to Yandex Container Registry, Yandex Object Storage, Docker Hub, and so on."
      v4_cidr_blocks    = ["0.0.0.0/0"]
      from_port         = 0
      to_port           = 65535
    }
  }
  ```



{% endcut %}

{% endlist %}

### Creating a regional cluster {#example-regional-cluster}

{% list tabs %}

- {{ TF }}

  Let's say we need to create a {{ k8s }} cluster and a network for it with the following characteristics:
  * Named `k8s-regional`.
  * Version `1.22`.
  * In the cloud with the ID `{{ tf-cloud-id }}`.
  * In the folder with the ID `{{ tf-folder-id }}`.
  * In the new `mynet` network with new subnets:
    * `mysubnet-a` in the {{ region-id }}-a availability zone with a range of `10.5.0.0/16`.
    * `mysubnet-b` in the {{ region-id }}-b availability zone with a range of `10.6.0.0/16`.
    * `mysubnet-c` in the {{ region-id }}-c availability zone with a range of `10.7.0.0/16`.
  * With the new service account `myaccount` that has the `k8s.clusters.agent`, `vpc.publicAdmin`, `container-registry.images.puller`, and `kms.viewer` role permissions.
  * With the {{ kms-name }} `kms-key` encryption key.
  * In the new security group `k8s-main-sg` containing [rules for service traffic](../connect/security-groups.md#rules-internal).

  To do this, install Terraform (if you don't have it yet) and configure the provider by following the [instructions](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Next, apply the configuration file:

  {% cut "Configuration file for the cluster:" %}

  
  ```hcl
  locals {
    cloud_id    = "{{ tf-cloud-id }}"
    folder_id   = "{{ tf-folder-id }}"
    k8s_version = "1.22"
    sa_name     = "myaccount"
  }

  terraform {
    required_providers {
      yandex = {
        source = "yandex-cloud/yandex"
      }
    }
  }

  provider "yandex" {
    folder_id = local.folder_id
  }

  resource "yandex_kubernetes_cluster" "k8s-regional" {
    network_id = yandex_vpc_network.mynet.id
    master {
      version = local.k8s_version
      regional {
        region = "{{ region-id }}"
        location {
          zone      = yandex_vpc_subnet.mysubnet-a.zone
          subnet_id = yandex_vpc_subnet.mysubnet-a.id
        }
        location {
          zone      = yandex_vpc_subnet.mysubnet-b.zone
          subnet_id = yandex_vpc_subnet.mysubnet-b.id
        }
        location {
          zone      = yandex_vpc_subnet.mysubnet-c.zone
          subnet_id = yandex_vpc_subnet.mysubnet-c.id
        }
      }
      security_group_ids = [yandex_vpc_security_group.k8s-main-sg.id]
    }
    service_account_id      = yandex_iam_service_account.myaccount.id
    node_service_account_id = yandex_iam_service_account.myaccount.id
    depends_on = [
      yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
      yandex_resourcemanager_folder_iam_member.vpc-public-admin,
      yandex_resourcemanager_folder_iam_member.images-puller
    ]
    kms_provider {
      key_id = yandex_kms_symmetric_key.kms-key.id
    }
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_subnet" "mysubnet-a" {
    v4_cidr_blocks = ["10.5.0.0/16"]
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
  }

  resource "yandex_vpc_subnet" "mysubnet-b" {
    v4_cidr_blocks = ["10.6.0.0/16"]
    zone           = "{{ region-id }}-b"
    network_id     = yandex_vpc_network.mynet.id
  }

  resource "yandex_vpc_subnet" "mysubnet-c" {
    v4_cidr_blocks = ["10.7.0.0/16"]
    zone           = "{{ region-id }}-c"
    network_id     = yandex_vpc_network.mynet.id
  }

  resource "yandex_iam_service_account" "myaccount" {
    name        = local.sa_name
    description = "K8S regional service account"
  }

  resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
    # The service account is assigned the k8s.clusters.agent role.
    folder_id = local.folder_id
    role      = "k8s.clusters.agent"
    member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
    # The service account is assigned the vpc.publicAdmin role.
    folder_id = local.folder_id
    role      = "vpc.publicAdmin"
    member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
    # The service account is assigned the container-registry.images.puller role.
    folder_id = local.folder_id
    role      = "container-registry.images.puller"
    member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  }

  resource "yandex_kms_symmetric_key" "kms-key" {
    # A key for encrypting critical information, including passwords, OAuth tokens, and SSH keys.
    name              = "kms-key"
    default_algorithm = "AES_128"
    rotation_period   = "8760h" # 1 year.
  }

  resource "yandex_kms_symmetric_key_iam_member" "viewer" {
    symmetric_key_id = yandex_kms_symmetric_key.kms-key.id
    role             = "viewer"
    member           = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  }

  resource "yandex_vpc_security_group" "k8s-main-sg" {
    name        = "k8s-main-sg"
    description = "Group rules ensure the basic performance of the cluster. Apply it to the cluster and node groups."
    network_id  = yandex_vpc_network.mynet.id
    ingress {
      protocol          = "TCP"
      description       = "Rule allows availability checks from load balancer's address range. It is required for the operation of a fault-tolerant cluster and load balancer services."
      predefined_target = "loadbalancer_healthchecks"
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ANY"
      description       = "Rule allows master-node and node-node communication inside a security group."
      predefined_target = "self_security_group"
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ANY"
      description       = "Rule allows pod-pod and service-service communication. Specify the subnets of your cluster and services."
      v4_cidr_blocks    = concat(yandex_vpc_subnet.mysubnet-a.v4_cidr_blocks, yandex_vpc_subnet.mysubnet-b.v4_cidr_blocks, yandex_vpc_subnet.mysubnet-c.v4_cidr_blocks)
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ICMP"
      description       = "Rule allows debugging ICMP packets from internal subnets."
      v4_cidr_blocks    = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
    }
    ingress {
      protocol          = "TCP"
      description       = "Rule allows incoming traffic from the internet to the NodePort port range. Add ports or change existing ones to the required ports."
      v4_cidr_blocks    = ["0.0.0.0/0"]
      from_port         = 30000
      to_port           = 32767
    }
    egress {
      protocol          = "ANY"
      description       = "Rule allows all outgoing traffic. Nodes can connect to {{ container-registry-full-name }}, {{ objstorage-full-name }}, Docker Hub, and so on."
      v4_cidr_blocks    = ["0.0.0.0/0"]
      from_port         = 0
      to_port           = 65535
    }
  }
  ```



  {% endcut %}

{% endlist %}