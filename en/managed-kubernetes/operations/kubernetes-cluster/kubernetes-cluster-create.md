---
title: Creating a {{ managed-k8s-full-name }} cluster
description: Follow this guide to create a {{ managed-k8s-name }} cluster.
---

# Creating a {{ managed-k8s-name }} cluster


Create a [{{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) cluster and then [create a node group](../node-group/node-group-create.md).

To create a cluster with no internet access, see [{#T}](../../tutorials/k8s-cluster-with-no-internet.md).

## Getting started {#before-you-begin}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [management console]({{ link-console-main }}). If not signed up yet, navigate to the management console and follow the on-screen instructions.
  1. On the [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) page, make sure you have a linked [billing account](../../../billing/concepts/billing-account.md) and its status is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../../../billing/quickstart/index.md#create_billing_account).
  1. If you do not have a [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) yet, [create one](../../../resource-manager/operations/folder/create.md).
  1. Make sure that the [account](../../../iam/concepts/users/accounts.md) you are using to create the {{ managed-k8s-name }} cluster has all the [relevant roles](../../security/index.md#required-roles).
  1. Make sure you have enough [resources available in the cloud](../../concepts/limits.md).
  1. If you do not have a [network](../../../vpc/concepts/network.md#network) yet, [create one](../../../vpc/operations/network-create.md).
  1. If you do not have any [subnets](../../../vpc/concepts/network.md#subnet) yet, [create them](../../../vpc/operations/subnet-create.md) in the [availability zones](../../../overview/concepts/geo-scope.md) where your {{ managed-k8s-name }} cluster and [node group](../../concepts/index.md#node-group) will be created.
  1. Create [service accounts](../../../iam/operations/sa/create.md):
     * Service account with the `k8s.clusters.agent` and `vpc.publicAdmin` [roles for the folder](../../security/index.md#yc-api) where the {{ managed-k8s-name }} cluster is created. This service account will be used to create the resources required for the {{ managed-k8s-name }} cluster.
     * Service account with the [{{ roles-cr-puller }}](../../../container-registry/security/index.md#choosing-roles) role for the folder containing the [Docker image](../../../container-registry/concepts/registry.md) [registry](../../../container-registry/concepts/docker-image.md). Nodes will pull the required Docker images from the registry on behalf of this account.

     You can use the same service account for both operations.

     {% include [k8s.tunnelClusters.agent role](../../../_includes/managed-kubernetes/note-tunnelClusters-agent.md) %}

  1. [Create and configure the security groups](../connect/security-groups.md).

  1. Review the [recommendations for using {{ managed-k8s-name }}](../../concepts/usage-recommendations.md).

{% endlist %}

## Create a {{ managed-k8s-name }} cluster {#kubernetes-cluster-create}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [create-cluster](../../../_includes/managed-kubernetes/cluster-create.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To create a {{ managed-k8s-name }} cluster:

  1. Specify the {{ managed-k8s-name }} cluster parameters in the create command (not all parameters are given in the example):

     ```bash
     {{ yc-k8s }} cluster create \
       --name test-k8s \
       --network-name default \
       --public-ip \
       --release-channel regular \
       --version 1.27 \
       --cluster-ipv4-range 10.1.0.0/16 \
       --service-ipv4-range 10.2.0.0/16 \
       --security-group-ids enpe5sdn7vs5********,enpj6c5ifh75******** \
       --service-account-name default-sa \
       --node-service-account-name default-sa \
       --master-location zone={{ region-id }}-a,subnet-id=mysubnet \
       --daily-maintenance-window start=22:00,duration=10h
       --labels <cloud_label_name=cloud_label_value>
     ```

     Where:

     * `--name`: {{ managed-k8s-name }} cluster name.
     * `--network-name`: [Network name](../../../vpc/concepts/network.md#network).

        {% include [note-another-catalog-network](../../../_includes/managed-kubernetes/note-another-catalog-network.md) %}

     * `--public-ip`: Flag indicating that the {{ managed-k8s-name }} cluster needs a [public IP address](../../../vpc/concepts/address.md#public-addresses).

       {% include [nat-instance-restriction](../../../_includes/managed-kubernetes/nat-instance-restriction.md) %}

       {% include [write-once-setting](../../../_includes/managed-kubernetes/write-once-setting.md) %}

     * `--release-channel`: [Release channel](../../concepts/release-channels-and-updates.md#release-channels).

       {% include [write-once-setting](../../../_includes/managed-kubernetes/write-once-setting.md) %}

     * `--version`: {{ k8s }} version. Specify a version available for the selected release channel.
     * `--cluster-ipv4-range`: Range of [IP addresses](../../../vpc/concepts/address.md) for allocating [pod](../../concepts/index.md#pod) addresses.
     * `--service-ipv4-range`: Range of IP addresses for allocating [service](../../concepts/index.md#service) addresses.
     * `--security-group-ids`: List of {{ managed-k8s-name }} cluster [security group](../../../vpc/concepts/security-groups.md) IDs.

       {% include [security-groups-alert](../../../_includes/managed-kubernetes/security-groups-alert.md) %}

     * `--service-account-id`: Unique ID of the [service account](../../../iam/concepts/users/service-accounts.md) for the resources. This service account will be used to create the resources required for the {{ managed-k8s-name }} cluster.
     * `--node-service-account-id`: Unique ID of the service account for the [nodes](../../concepts/index.md#node-group). Nodes will pull the required [Docker images](../../../container-registry/concepts/registry.md) from the [registry](../../../container-registry/concepts/docker-image.md) on behalf of this account.
     * `--master-location`: [Master](../../concepts/index.md#master) configuration. Specify in the parameter the availability zone and subnet where the master will be located.

        The number of `--master-location` parameters depends on the type of master:

        * For the basic master, provide one `--master-location` parameter.
        * For a highly available master hosted across three availability zones, provide three `--master-location` parameters. In each one, specify different availability zones and subnets.
        * For a highly available master hosted in a single availability zone, provide three `--master-location` parameters. In each one, specify the same availability zone and subnet.

     * `--daily-maintenance-window`: [Maintenance](../../concepts/release-channels-and-updates.md#updates) window settings.
     * `--labels`: [Cloud labels](../../concepts/index.md#cluster-labels) for the cluster.

     Result:

     ```text
     done (5m47s)
     id: cathn0s6qobf********
     folder_id: b1g66jflru0e********
     ...
       service_account_id: aje3932acd0c********
       node_service_account_id: aje3932acd0c********
       release_channel: REGULAR
     ```
  
  1. Configure the cluster’s [Container Network Interface](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/):

      {% include [write-once-setting](../../../_includes/managed-kubernetes/write-once-setting.md) %}

      {% include [calico-cilium-mutual-exclusion](../../../_includes/managed-kubernetes/calico-cilium-mutual-exclusion.md) %}

      * To enable the Calico [network policy controller](../../concepts/network-policy.md#calico), set the `--enable-network-policy` flag in the {{ managed-k8s-name }} cluster create command:

        ```bash
        {{ yc-k8s }} cluster create \
        ...
          --enable-network-policy
        ```

      * To enable the Cilium [tunnel mode](../../concepts/network-policy.md#cilium), provide the `--cilium` flag in the {{ managed-k8s-name }} cluster create command:

        ```bash
        {{ yc-k8s }} cluster create \
        ...
          --cilium
        ```

  1. To use the [{{ kms-full-name }}](../../concepts/encryption.md) encryption key for protecting sensitive data, provide the key name or ID in the {{ managed-k8s-name }} cluster creation command:

     ```bash
     {{ yc-k8s }} cluster create \
     ...
       --kms-key-name <encryption_key_name> \
       --kms-key-id <encryption_key_ID>
     ```

     {% include [write-once-setting](../../../_includes/managed-kubernetes/write-once-setting.md) %}

  1. To enable sending logs to [{{ cloud-logging-full-name }}](../../../logging/), provide the logging settings in the `--master-logging` property of the {{ managed-k8s-name }} cluster create command:

     ```bash
     {{ yc-k8s }} cluster create \
     ...
       --master-logging enabled=<send_logs>,`
         `log-group-id=<log_group_ID>,`
         `folder-id=<folder_ID>,`
         `kube-apiserver-enabled=<send_kube-apiserver_logs>,`
         `cluster-autoscaler-enabled=<send_cluster-autoscaler_logs>,`
         `events-enabled=<send_{{ k8s }}_events>`
         `audit-enabled=<send_audit_events>
     ```

     Where:

     {% include [master-logging-cli-description.md](../../../_includes/managed-kubernetes/master-logging-cli-description.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To create a {{ managed-k8s-name }} cluster:
  1. In the configuration file, define the parameters of the resources you want to create:
     * {{ managed-k8s-name }} cluster: Cluster description.
     * [Network](../../../vpc/concepts/network.md#network): Description of the cloud network to host the {{ managed-k8s-name }} cluster. If you already have a suitable network, you do not need to describe it again.

        {% include [note-another-catalog-network](../../../_includes/managed-kubernetes/note-another-catalog-network.md) %}

     * [Subnets](../../../vpc/concepts/network.md#subnet): Description of the subnets to connect the {{ managed-k8s-name }} cluster hosts to. If you already have suitable subnets, you do not need to describe them again.
     * [Service account](#before-you-begin) for the {{ managed-k8s-name }} cluster and [nodes](../../concepts/index.md#node-group) and [role settings]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member) for this account. Create separate [service accounts](../../../iam/concepts/users/service-accounts.md) for the {{ managed-k8s-name }} cluster and nodes, as required. If you already have a suitable service account, you do not need to describe it again.

     >Here is the configuration file example:
     >
     >```hcl
     >resource "yandex_kubernetes_cluster" "<Managed_Service_for_Kubernetes_cluster_name>" {
     >  network_id = yandex_vpc_network.<network_name>.id
     >  master {
     >    master_location {
     >      zone      = yandex_vpc_subnet.<subnet_name>.zone
     >      subnet_id = yandex_vpc_subnet.<subnet_name>.id
     >    }
     >  }
     >  service_account_id      = yandex_iam_service_account.<service_account_name>.id
     >  node_service_account_id = yandex_iam_service_account.<service_account_name>.id
     >    depends_on = [
     >      yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
     >      yandex_resourcemanager_folder_iam_member.vpc-public-admin,
     >      yandex_resourcemanager_folder_iam_member.images-puller
     >    ]
     > }
     >  labels {
     >    "<cloud_label_name>"="<cloud_label_value>"
     >  }
     >resource "yandex_vpc_network" "<network_name>" { name = "<network_name>" }
     >
     >resource "yandex_vpc_subnet" "<subnet_name>" {
     >  v4_cidr_blocks = ["<subnet_IP_address_range>"]
     >  zone           = "<availability_zone>"
     >  network_id     = yandex_vpc_network.<network_name>.id
     >}
     >
     >resource "yandex_iam_service_account" "<service_account_name>" {
     >  name        = "<service_account_name>"
     >  description = "<service_account_description>"
     >}
     >
     >resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
     >  # The service account gets the "k8s.clusters.agent" role.
     >  folder_id = "<folder_ID>"
     >  role      = "k8s.clusters.agent"
     >  member    = "serviceAccount:${yandex_iam_service_account.<service_account_name>.id}"
     >}
     >
     >resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
     >  # The service account gets the "vpc.publicAdmin" role.
     >  folder_id = "<folder_ID>"
     >  role      = "vpc.publicAdmin"
     >  member    = "serviceAccount:${yandex_iam_service_account.<service_account_name>.id}"
     >}
     >
     >resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
     >  # The service account gets the "container-registry.images.puller" role.
     >  folder_id = "<folder_ID>"
     >  role      = "container-registry.images.puller"
     >  member    = "serviceAccount:${yandex_iam_service_account.<service_account_name>.id}"
     >}
     >```

     {% note info %}
     
      Cloud labels for a {{ k8s }} cluster are composed according to certain [rules](../../concepts/index.md#cluster-labels).

     {% endnote %}

     To enable sending logs to [{{ cloud-logging-full-name }}](../../../logging/), add the `master_logging` section to the {{ managed-k8s-name }} cluster description:

     {% include [master-logging-tf.md](../../../_includes/managed-kubernetes/master-logging-tf.md) %}

     Where:

     {% include [master-logging-tf-description.md](../../../_includes/managed-kubernetes/master-logging-tf-description.md) %}

     For more information, see the [{{ TF }}]({{ tf-provider-k8s-cluster }}) provider documentation.
  1. Make sure the configuration files are correct.

     {% include [terraform-create-cluster-step-2](../../../_includes/mdb/terraform-create-cluster-step-2.md) %}

  1. Create a {{ managed-k8s-name }} cluster.

     {% include [terraform-create-cluster-step-3](../../../_includes/mdb/terraform-create-cluster-step-3.md) %}

- API {#api}

  To create a {{ managed-k8s-name }} cluster, use the [create](../../managed-kubernetes/api-ref/Cluster/create.md) method for the [Cluster](../../managed-kubernetes/api-ref/Cluster) resource.

  The request body depends on the [master type](../../concepts/index.md#master):

  * For the basic master, provide one `masterSpec.locations` parameter in the request.
  * For a highly available master hosted across three availability zones, provide three `masterSpec.locations` parameters in the request. In each one, specify different availability zones and subnets.
  * For a highly available master hosted in a single availability zone, provide three `masterSpec.locations` parameters in the request. In each one, specify the same availability zone and subnet.

  When providing the `masterSpec.locations` parameter, you do not need to specify `masterSpec.zonalMasterSpec` or `masterSpec.regionalMasterSpec`.

  {% include [note-another-catalog-network](../../../_includes/managed-kubernetes/note-another-catalog-network.md) %}

  To use a [{{ kms-full-name }}](../../concepts/encryption.md) encryption key to protect secrets, provide its ID in the `kmsProvider.keyId` parameter.

  To enable sending logs to [{{ cloud-logging-full-name }}](../../../logging/), provide the logging settings in the `masterSpec.masterLogging` parameter.

  To add a [cloud label](../../concepts/index.md#cluster-labels), provide its name and value in the `labels` parameter.

{% endlist %}

## Examples {#examples}

### Creating a {{ managed-k8s-name }} cluster with a basic master {#example-single-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  Create a {{ managed-k8s-name }} cluster with the following test specifications:

  * Name: `k8s-single`.
  * Network: `mynet`.
  * Availability zone: `{{ region-id }}-a`.
  * Subnet: `mysubnet`.
  * Service account: `myaccount`.
  * Security group ID: `{{ security-group }}`.

  To create a {{ managed-k8s-name }} cluster with a basic master, run this command:

  ```bash
  {{ yc-k8s }} cluster create \
     --name k8s-single \
     --network-name mynet \
     --master-location zone={{ region-id }}-a,subnet-name=mysubnet \
     --service-account-name myaccount \
     --node-service-account-name myaccount \
     --security-group-ids {{ security-group }}
  ```

- {{ TF }} {#tf}

  Create a {{ managed-k8s-name }} cluster and a network for it with the following test specifications:

  * Name: `k8s-single`.
  * [Folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) ID: `{{ tf-folder-id }}`.
  * Network: `mynet`.
  * Subnet: `mysubnet`. Its network settings are as follows:

    * Availability zone: `{{ region-id }}-a`.
    * Range: `10.1.0.0/16`.

  * Service account: `myaccount`.
  * Service account [roles](../../../iam/concepts/access-control/roles.md): `k8s.clusters.agent`, `vpc.publicAdmin`, `container-registry.images.puller`, and `kms.keys.encrypterDecrypter`.
  * {{ kms-full-name }} [encryption key](../../concepts/encryption.md): `kms-key`.
  * Security group: `k8s-public-services`. It contains [rules for connecting to services from the internet](../connect/security-groups.md#rules-nodes).

  Install {{ TF }} (unless you already have it), configure the provider according to [this guide](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), and apply the configuration file:

  ```hcl
  locals {
    folder_id   = "{{ tf-folder-id }}"
  }

  resource "yandex_kubernetes_cluster" "k8s-single" {
    name = "k8s-single"
    network_id = yandex_vpc_network.mynet.id
    master {
      master_location {
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
      yandex_resourcemanager_folder_iam_member.images-puller,
      yandex_resourcemanager_folder_iam_member.encrypterDecrypter
    ]
    kms_provider {
      key_id = yandex_kms_symmetric_key.kms-key.id
    }
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_subnet" "mysubnet" {
    name = "mysubnet"
    v4_cidr_blocks = ["10.1.0.0/16"]
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
  }

  resource "yandex_iam_service_account" "myaccount" {
    name        = "myaccount"
    description = "Service account for the single Kubernetes cluster"
  }

  resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
    # The service account gets the "k8s.clusters.agent" role.
    folder_id = local.folder_id
    role      = "k8s.clusters.agent"
    member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
    # The service account gets the "vpc.publicAdmin" role.
    folder_id = local.folder_id
    role      = "vpc.publicAdmin"
    member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
    # The service account gets the "container-registry.images.puller" role.
    folder_id = local.folder_id
    role      = "container-registry.images.puller"
    member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "encrypterDecrypter" {
    # The service account gets the "kms.keys.encrypterDecrypter" role.
    folder_id = local.folder_id
    role      = "kms.keys.encrypterDecrypter"
    member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  }

  resource "yandex_kms_symmetric_key" "kms-key" {
    # A {{ kms-full-name }} key for encrypting critical information, including passwords, OAuth tokens, and SSH keys.
    name              = "kms-key"
    default_algorithm = "AES_128"
    rotation_period   = "8760h" # 1 year.
  }

  resource "yandex_vpc_security_group" "k8s-public-services" {
    name        = "k8s-public-services"
    description = "Group rules allow connections to services from the internet. Apply the rules for node groups only."
    network_id  = yandex_vpc_network.mynet.id
    ingress {
      protocol          = "TCP"
      description       = "The rule allows availability checks from the load balancer's range of addresses. It is required for the operation of a fault-tolerant {{ managed-k8s-name }} cluster and load balancer services."
      predefined_target = "loadbalancer_healthchecks"
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ANY"
      description       = "The rule allows master-to-node and node-to-node communication inside a security group."
      predefined_target = "self_security_group"
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ANY"
      description       = "The rule allows sub-sub and service-service interactions. Specify the subnets of your {{ managed-k8s-name }} cluster and services."
      v4_cidr_blocks    = concat(yandex_vpc_subnet.mysubnet.v4_cidr_blocks)
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ICMP"
      description       = "The rule allows debug ICMP packets from internal subnets."
      v4_cidr_blocks    = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
    }
    ingress {
      protocol          = "TCP"
      description       = "The rule allows incoming traffic from the internet to a range of NodePorts. Add ports or change existing ones to the required ports."
      v4_cidr_blocks    = ["0.0.0.0/0"]
      from_port         = 30000
      to_port           = 32767
    }
    egress {
      protocol          = "ANY"
      description       = "The rule allows all outgoing traffic. Nodes can connect to {{ container-registry-full-name }}, {{ objstorage-full-name }}, Docker Hub, etc."
      v4_cidr_blocks    = ["0.0.0.0/0"]
      from_port         = 0
      to_port           = 65535
    }
  }
  ```

{% endlist %}

### Creating a {{ managed-k8s-name }} cluster with a highly available master in three availability zones {#example-ha-cluster-three-zones}

{% list tabs group=instructions %}

- CLI {#cli}

  Create a {{ managed-k8s-name }} cluster with the following test specifications:

  * Name: `k8s-ha-three-zones`.
  * Network: `my-ha-net`.
  * Subnet for the `{{ region-id }}-a` availability zone: `mysubnet-a`.
  * Subnet for the `{{ region-id }}-b` availability zone: `mysubnet-b`.
  * Subnet for the `{{ region-id }}-d` availability zone: `mysubnet-d`.
  * Service account: `ha-k8s-account`.
  * Security group ID: `{{ security-group }}`.

  To create a {{ managed-k8s-name }} cluster with a highly available master in three availability zones, run this command:

  ```bash
  {{ yc-k8s }} cluster create \
     --name k8s-ha-three-zones \
     --network-name my-ha-net \
     --master-location zone={{ region-id }}-a,subnet-name=mysubnet-a \
     --master-location zone={{ region-id }}-b,subnet-name=mysubnet-b \
     --master-location zone={{ region-id }}-d,subnet-name=mysubnet-d \
     --service-account-name ha-k8s-account \
     --node-service-account-name ha-k8s-account \
     --security-group-ids {{ security-group }}
  ```

- {{ TF }} {#tf}

  Create a {{ managed-k8s-name }} cluster and a network for it with the following test specifications:

  * Name: `k8s-ha-three-zones`.
  * Folder ID: `{{ tf-folder-id }}`
  * Network: `my-ha-net`.
  * Subnet: `mysubnet-a`. Its network settings are as follows:

    * Availability zone: `{{ region-id }}-a`.
    * Range: `10.5.0.0/16`.

  * Subnet: `mysubnet-b`. Its network settings are as follows:

    * Availability zone: `{{ region-id }}-b`.
    * Range: `10.6.0.0/16`.

  * Subnet: `mysubnet-d`. Its network settings are as follows:

    * Availability zone: `{{ region-id }}-d`.
    * Range: `10.7.0.0/16`.

  * Service account: `ha-k8s-account`.
  * Service account roles: `k8s.clusters.agent`, `vpc.publicAdmin`, `container-registry.images.puller`, and `kms.keys.encrypterDecrypter`.
  * {{ kms-full-name }} [encryption key](../../concepts/encryption.md): `kms-key`.
  * Security group: `regional-k8s-sg`. It contains [rules for service traffic](../connect/security-groups.md#rules-internal).

  Install {{ TF }} (unless you already have it), configure the provider according to [this guide](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), and apply the configuration file:

  ```hcl
  locals {
    folder_id   = "{{ tf-folder-id }}"
  }

  resource "yandex_kubernetes_cluster" "k8s-ha-three-zones" {
    name = "k8s-ha-three-zones"
    network_id = yandex_vpc_network.my-ha-net.id
    master {
      master_location {
        zone      = yandex_vpc_subnet.mysubnet-a.zone
        subnet_id = yandex_vpc_subnet.mysubnet-a.id
      }
      master_location {
        zone      = yandex_vpc_subnet.mysubnet-b.zone
        subnet_id = yandex_vpc_subnet.mysubnet-b.id
      }
      master_location {
        zone      = yandex_vpc_subnet.mysubnet-d.zone
        subnet_id = yandex_vpc_subnet.mysubnet-d.id
      }
      security_group_ids = [yandex_vpc_security_group.ha-k8s-sg.id]
    }
    service_account_id      = yandex_iam_service_account.ha-k8s-account.id
    node_service_account_id = yandex_iam_service_account.ha-k8s-account.id
    depends_on = [
      yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
      yandex_resourcemanager_folder_iam_member.vpc-public-admin,
      yandex_resourcemanager_folder_iam_member.images-puller,
      yandex_resourcemanager_folder_iam_member.encrypterDecrypter
    ]
    kms_provider {
      key_id = yandex_kms_symmetric_key.kms-key.id
    }
  }

  resource "yandex_vpc_network" "my-ha-net" {
    name = "my-ha-net"
  }

  resource "yandex_vpc_subnet" "mysubnet-a" {
    name = "mysubnet-a"
    v4_cidr_blocks = ["10.5.0.0/16"]
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.my-ha-net.id
  }

  resource "yandex_vpc_subnet" "mysubnet-b" {
    name = "mysubnet-b"
    v4_cidr_blocks = ["10.6.0.0/16"]
    zone           = "{{ region-id }}-b"
    network_id     = yandex_vpc_network.my-ha-net.id
  }

  resource "yandex_vpc_subnet" "mysubnet-d" {
    name = "mysubnet-d"
    v4_cidr_blocks = ["10.7.0.0/16"]
    zone           = "{{ region-id }}-d"
    network_id     = yandex_vpc_network.my-ha-net.id
  }

  resource "yandex_iam_service_account" "ha-k8s-account" {
    name        = "ha-k8s-account"
    description = "Service account for the highly available Kubernetes cluster"
  }

  resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
    # The service account gets the "k8s.clusters.agent" role.
    folder_id = local.folder_id
    role      = "k8s.clusters.agent"
    member    = "serviceAccount:${yandex_iam_service_account.ha-k8s-account.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
    # The service account gets the "vpc.publicAdmin" role.
    folder_id = local.folder_id
    role      = "vpc.publicAdmin"
    member    = "serviceAccount:${yandex_iam_service_account.ha-k8s-account.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
    # The service account gets the "container-registry.images.puller" role.
    folder_id = local.folder_id
    role      = "container-registry.images.puller"
    member    = "serviceAccount:${yandex_iam_service_account.ha-k8s-account.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "encrypterDecrypter" {
    # The service account gets the "kms.keys.encrypterDecrypter" role.
    folder_id = local.folder_id
    role      = "kms.keys.encrypterDecrypter"
    member    = "serviceAccount:${yandex_iam_service_account.ha-k8s-account.id}"
  }

  resource "yandex_kms_symmetric_key" "kms-key" {
    # A {{ kms-full-name }} key for encrypting critical information, including passwords, OAuth tokens, and SSH keys.
    name              = "kms-key"
    default_algorithm = "AES_128"
    rotation_period   = "8760h" # 1 year.
  }

  resource "yandex_vpc_security_group" "ha-k8s-sg" {
    name        = "ha-k8s-sg"
    description = "Group rules ensure the basic performance of the {{ managed-k8s-name }} cluster. Apply it to the cluster and node groups."
    network_id  = yandex_vpc_network.my-ha-net.id
    ingress {
      protocol          = "TCP"
      description       = "The rule allows availability checks from the load balancer's range of addresses. It is required for the operation of a fault-tolerant {{ managed-k8s-name }} cluster and load balancer services."
      predefined_target = "loadbalancer_healthchecks"
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ANY"
      description       = "The rule allows master-to-node and node-to-node communication inside a security group."
      predefined_target = "self_security_group"
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ANY"
      description       = "The rule allows sub-sub and service-service interactions. Specify the subnets of your {{ managed-k8s-name }} cluster and services."
      v4_cidr_blocks    = concat(yandex_vpc_subnet.mysubnet-a.v4_cidr_blocks, yandex_vpc_subnet.mysubnet-b.v4_cidr_blocks, yandex_vpc_subnet.mysubnet-d.v4_cidr_blocks)
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ICMP"
      description       = "The rule allows debug ICMP packets from internal subnets."
      v4_cidr_blocks    = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
    }
    ingress {
      protocol          = "TCP"
      description       = "The rule allows incoming traffic from the internet to a range of NodePorts. Add ports or change existing ones to the required ports."
      v4_cidr_blocks    = ["0.0.0.0/0"]
      from_port         = 30000
      to_port           = 32767
    }
    egress {
      protocol          = "ANY"
      description       = "The rule allows all outgoing traffic. Nodes can connect to {{ container-registry-full-name }}, {{ objstorage-full-name }}, Docker Hub, etc."
      v4_cidr_blocks    = ["0.0.0.0/0"]
      from_port         = 0
      to_port           = 65535
    }
  }
  ```

{% endlist %}

### Creating a {{ managed-k8s-name }} cluster with a highly available master in a single availability zone {#example-ha-cluster-one-zone}

{% list tabs group=instructions %}

- CLI {#cli}

  Create a {{ managed-k8s-name }} cluster with the following test specifications:

  * Name: `k8s-ha-one-zone`.
  * Network: `my-ha-net`.
  * Subnet for the `{{ region-id }}-a` availability zone: `my-ha-subnet`.
  * Number of identical `--master-location` parameters: three. This creates three instances of the master in one availability zone.
  * Availability zone: `{{ region-id }}-a`.
  * Service account: `ha-k8s-account`.
  * Security group ID: `{{ security-group }}`.

  To create a {{ managed-k8s-name }} cluster with a highly available master in a single availability zone , run this command:

  ```bash
  {{ yc-k8s }} cluster create \
     --name k8s-ha-one-zone \
     --network-name my-ha-net \
     --master-location zone={{ region-id }}-a,subnet-name=my-ha-subnet \
     --master-location zone={{ region-id }}-a,subnet-name=my-ha-subnet \
     --master-location zone={{ region-id }}-a,subnet-name=my-ha-subnet \
     --service-account-name ha-k8s-account \
     --node-service-account-name ha-k8s-account \
     --security-group-ids {{ security-group }}
  ```

- {{ TF }} {#tf}

  Create a {{ managed-k8s-name }} cluster and a network for it with the following test specifications:

  * Name: `k8s-ha-one-zone`.
  * Folder ID: `{{ tf-folder-id }}`.
  * Network: `my-ha-net`.
  * Subnet: `my-ha-subnet`. Its network settings are as follows:

    * Availability zone: `{{ region-id }}-a`.
    * Range: `10.5.0.0/16`.

  * Service account: `ha-k8s-account`.
  * Service account roles: `k8s.clusters.agent`, `vpc.publicAdmin`, `container-registry.images.puller`, and `kms.keys.encrypterDecrypter`.
  * {{ kms-full-name }} encryption key: `kms-key`.
  * Security group: `ha-k8s-sg`. It contains [rules for service traffic](../connect/security-groups.md#rules-internal).

  Install {{ TF }} (unless you already have it), configure the provider according to [this guide](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), and apply the configuration file:

  ```hcl
  locals {
    folder_id   = "{{ tf-folder-id }}"
  }

  resource "yandex_kubernetes_cluster" "k8s-ha-one-zone" {
    name = "k8s-ha-one-zone"
    network_id = yandex_vpc_network.my-ha-net.id
    master {
      master_location {
        zone      = yandex_vpc_subnet.my-ha-subnet.zone
        subnet_id = yandex_vpc_subnet.my-ha-subnet.id
      }
      master_location {
        zone      = yandex_vpc_subnet.my-ha-subnet.zone
        subnet_id = yandex_vpc_subnet.my-ha-subnet.id
      }
      master_location {
        zone      = yandex_vpc_subnet.my-ha-subnet.zone
        subnet_id = yandex_vpc_subnet.my-ha-subnet.id
      }
      security_group_ids = [yandex_vpc_security_group.ha-k8s-sg.id]
    }
    service_account_id      = yandex_iam_service_account.ha-k8s-account.id
    node_service_account_id = yandex_iam_service_account.ha-k8s-account.id
    depends_on = [
      yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
      yandex_resourcemanager_folder_iam_member.vpc-public-admin,
      yandex_resourcemanager_folder_iam_member.images-puller,
      yandex_resourcemanager_folder_iam_member.encrypterDecrypter
    ]
    kms_provider {
      key_id = yandex_kms_symmetric_key.kms-key.id
    }
  }

  resource "yandex_vpc_network" "my-ha-net" {
    name = "my-ha-net"
  }

  resource "yandex_vpc_subnet" "my-ha-subnet" {
    name = "my-ha-subnet"
    v4_cidr_blocks = ["10.5.0.0/16"]
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.my-ha-net.id
  }

  resource "yandex_iam_service_account" "ha-k8s-account" {
    name        = "ha-k8s-account"
    description = "Service account for the highly available Kubernetes cluster"
  }

  resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
    # The service account gets the "k8s.clusters.agent" role.
    folder_id = local.folder_id
    role      = "k8s.clusters.agent"
    member    = "serviceAccount:${yandex_iam_service_account.ha-k8s-account.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
    # The service account gets the "vpc.publicAdmin" role.
    folder_id = local.folder_id
    role      = "vpc.publicAdmin"
    member    = "serviceAccount:${yandex_iam_service_account.ha-k8s-account.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
    # The service account gets the "container-registry.images.puller" role.
    folder_id = local.folder_id
    role      = "container-registry.images.puller"
    member    = "serviceAccount:${yandex_iam_service_account.ha-k8s-account.id}"
  }

  resource "yandex_resourcemanager_folder_iam_member" "encrypterDecrypter" {
    # The service account gets the "kms.keys.encrypterDecrypter" role.
    folder_id = local.folder_id
    role      = "kms.keys.encrypterDecrypter"
    member    = "serviceAccount:${yandex_iam_service_account.ha-k8s-account.id}"
  }

  resource "yandex_kms_symmetric_key" "kms-key" {
    # A {{ kms-full-name }} key for encrypting critical information, including passwords, OAuth tokens, and SSH keys.
    name              = "kms-key"
    default_algorithm = "AES_128"
    rotation_period   = "8760h" # 1 year.
  }

  resource "yandex_vpc_security_group" "ha-k8s-sg" {
    name        = "ha-k8s-sg"
    description = "Group rules ensure the basic performance of the {{ managed-k8s-name }} cluster. Apply it to the cluster and node groups."
    network_id  = yandex_vpc_network.my-ha-net.id
    ingress {
      protocol          = "TCP"
      description       = "The rule allows availability checks from the load balancer's range of addresses. It is required for the operation of a fault-tolerant {{ managed-k8s-name }} cluster and load balancer services."
      predefined_target = "loadbalancer_healthchecks"
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ANY"
      description       = "The rule allows master-to-node and node-to-node communication inside a security group."
      predefined_target = "self_security_group"
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ANY"
      description       = "The rule allows sub-sub and service-service interactions. Specify the subnets of your {{ managed-k8s-name }} cluster and services."
      v4_cidr_blocks    = concat(yandex_vpc_subnet.my-ha-subnet.v4_cidr_blocks, yandex_vpc_subnet.my-ha-subnet.v4_cidr_blocks, yandex_vpc_subnet.my-ha-subnet.v4_cidr_blocks)
      from_port         = 0
      to_port           = 65535
    }
    ingress {
      protocol          = "ICMP"
      description       = "The rule allows debug ICMP packets from internal subnets."
      v4_cidr_blocks    = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
    }
    ingress {
      protocol          = "TCP"
      description       = "The rule allows incoming traffic from the internet to a range of NodePorts. Add ports or change existing ones to the required ports."
      v4_cidr_blocks    = ["0.0.0.0/0"]
      from_port         = 30000
      to_port           = 32767
    }
    egress {
      protocol          = "ANY"
      description       = "The rule allows all outgoing traffic. Nodes can connect to {{ container-registry-full-name }}, {{ objstorage-full-name }}, Docker Hub, etc."
      v4_cidr_blocks    = ["0.0.0.0/0"]
      from_port         = 0
      to_port           = 65535
    }
  }
  ```

{% endlist %}

## See also {#see-also}

[Overview of methods for connecting to a cluster](../connect/index.md)
