# Creating a {{ managed-k8s-name }} cluster

Create a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) and then [create a node group](../node-group/node-group-create.md).

## Getting started {#before-you-begin}

To create a {{ managed-k8s-name }} cluster:

{% list tabs %}

- Management console

  1. Log in to the [management console]({{ link-console-main }}). If you do not have an account yet, go to the management console and follow the guide.

  
  1. On the [**{{ ui-key.yacloud.billing.label_service }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../../../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account yet, [create one](../../../billing/quickstart/index.md#create_billing_account).


  1. If you do not have a [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) yet, [create one](../../../resource-manager/operations/folder/create.md).
  1. Make sure that the [account](../../../iam/concepts/index.md#accounts) you are using to create the {{ managed-k8s-name }} cluster has all the [relevant roles](../../concepts/index.md#required-roles).
  1. Make sure you have enough [resources available in the cloud](../../concepts/limits.md).
  1. If you do not have a [network](../../../vpc/concepts/network.md#network) yet, [create one](../../../vpc/operations/network-create.md).
  1. If you do not have any [subnets](../../../vpc/concepts/network.md#subnet) yet, [create them](../../../vpc/operations/subnet-create.md) in the [availability zones](../../../overview/concepts/geo-scope.md) where your {{ managed-k8s-name }} cluster and [node group](../../concepts/index.md#node-group) will be created.
  1. Create the following [service accounts](../../../iam/operations/sa/create.md):
     * [Service account](../../../iam/concepts/users/service-accounts.md) with the [{{ roles-editor }}](../../../resource-manager/security/index.md#roles-list) [role](../../../iam/concepts/access-control/roles.md) for the folder where your {{ managed-k8s-name }} cluster will reside. The resources the {{ managed-k8s-name }} cluster needs will be created on behalf of this account.
     * Service account with the [{{ roles-cr-puller }}](../../../container-registry/security/index.md#choosing-roles) role for the folder containing the [Docker image](../../../container-registry/concepts/docker-image.md) [registry](../../../container-registry/concepts/registry.md). Nodes will download the Docker images they require from the registry on behalf of this account.

     You can use the same service account for both operations.

     {% include [k8s.tunnelClusters.agent role](../../../_includes/managed-kubernetes/note-tunnelClusters-agent.md) %}

  1. Create the required [security groups](../connect/security-groups.md).

  1. Review the [recommendations for using {{ managed-k8s-name }}](../../concepts/usage-recommendations.md).

{% endlist %}

## Create a {{ managed-k8s-name }} cluster {#kubernetes-cluster-create}

{% list tabs %}

- Management console

  {% include [create-cluster](../../../_includes/managed-kubernetes/cluster-create.md) %}

- CLI

   1. {% include [cli-install](../../../_includes/cli-install.md) %}

   1. {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Specify the {{ managed-k8s-name }} cluster parameters in the create command (the example shows only some of the parameters):

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
        --security-group-ids enpe5sdn7vs5********,enpj6c5ifh75******** \
        --service-account-name default-sa \
        --node-service-account-name default-sa \
        --daily-maintenance-window start=22:00,duration=10h
      ```

      Where:
      * `--name`: {{ managed-k8s-name }} cluster name.
      * `--network-name`: Name of the [network](../../../vpc/concepts/network.md#network).

         {% include [note-another-catalog-network](../../../_includes/managed-kubernetes/note-another-catalog-network.md) %}

      * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md).
      * `--subnet-name`: Name of the [subnet](../../../vpc/concepts/network.md#subnet).
      * `--public-ip`: Flag indicating that the {{ managed-k8s-name }} cluster needs a [public IP address](../../../vpc/concepts/address.md#public-addresses).
      * `--release-channel`: [Release channel](../../concepts/release-channels-and-updates.md#release-channels).
      * `--version`: {{ k8s }} version.
      * `--cluster-ipv4-range`: Range of [IP addresses](../../../vpc/concepts/address.md) for allocating [pod](../../concepts/index.md#pod) addresses.
      * `--service-ipv4-range`: Range of IP addresses for allocating [service](../../concepts/index.md#service) addresses.
      * `--security-group-ids`: List of {{ managed-k8s-name }} cluster [security group](../../../vpc/concepts/security-groups.md) IDs.

         {% include [security-groups-alert](../../../_includes/managed-kubernetes/security-groups-alert.md) %}

      * `--service-account-id`: Unique ID of the [service account](../../../iam/concepts/users/service-accounts.md) for the resources. The resources the {{ managed-k8s-name }} cluster needs will be created on behalf of this account.
      * `--node-service-account-id`: Unique ID of the service account for the [nodes](../../concepts/index.md#node-group). Nodes will pull the required [Docker images](../../../container-registry/concepts/docker-image.md) from the [registry](../../../container-registry/concepts/registry.md) on behalf of this account.
      * `--daily-maintenance-window`: [Maintenance](../../concepts/release-channels-and-updates.md#updates) window settings.

      Result:

      ```bash
      done (5m47s)
      id: cathn0s6qobf********
      folder_id: b1g66jflru0e********
      ...
        service_account_id: aje3932acd0c********
        node_service_account_id: aje3932acd0c********
        release_channel: REGULAR
      ```

   1. To activate the Calico [network policy controller](../../concepts/network-policy.md), set the `--enable-network-policy` flag in the {{ managed-k8s-name }} cluster create command:

      ```bash
      {{ yc-k8s }} cluster create \
      ...
        --enable-network-policy
      ```

   1. To use a [{{ kms-full-name }} encryption key](../../concepts/encryption.md) to protect confidential information, provide its name or ID in the {{ managed-k8s-name }} cluster create command:

      ```bash
      {{ yc-k8s }} cluster create \
      ...
        --kms-key-name <encryption_key_name> \
        --kms-key-id <encryption_key_ID>
      ```

      {% include [write-once-setting.md](../../../_includes/managed-kubernetes/write-once-setting.md) %}

  1. To enable sending logs to [{{ cloud-logging-full-name }}](../../../logging/), provide the logging settings in the `--master-logging` parameter of the {{ managed-k8s-name }} cluster create command:

      ```bash
      {{ yc-k8s }} cluster create \
      ...
        --master-logging enabled=<log_sending>,`
          `log-group-id=<log_group_ID>,`
          `folder-id=<folder_ID>,`
          `kube-apiserver-enabled=<kube-apiserver_log_sending>,`
          `cluster-autoscaler-enabled=<cluster-autoscaler_log_sending>,`
          `events-enabled=<{{ k8s }}_event_sending>
      ```

      Where:

      {% include [master-logging-cli-description.md](../../../_includes/managed-kubernetes/master-logging-cli-description.md) %}

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To create a {{ managed-k8s-name }} cluster:
   1. In the configuration file, describe the parameters of the resources you want to create:
      * {{ managed-k8s-name }} cluster: Cluster description.
      * [Network](../../../vpc/concepts/network.md#network): Description of the cloud network to host the {{ managed-k8s-name }} cluster. If you already have a suitable network, you do not need to describe it again.

         {% include [note-another-catalog-network](../../../_includes/managed-kubernetes/note-another-catalog-network.md) %}

      * [Subnets](../../../vpc/concepts/network.md#subnet): Description of the subnets to connect the {{ managed-k8s-name }} cluster hosts to. If you already have suitable subnets, you do not need to describe them again.
      * [Service account](#before-you-begin) for the {{ managed-k8s-name }} cluster and [nodes](../../concepts/index.md#node-group), as well as [role settings]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member) for the account. Create separate [service accounts](../../../iam/concepts/users/service-accounts.md) for the {{ managed-k8s-name }} cluster and nodes, as required. If you already have a suitable service account, you do not need to describe it again.

      > Here is an example of the configuration file structure:
      >
      > ```hcl
      > resource "yandex_kubernetes_cluster" "<{{ managed-k8s-name }}_cluster_name>" {
      >  network_id = yandex_vpc_network.<network_name>.id
      >  master {
      >    zonal {
      >      zone      = yandex_vpc_subnet.<subnet_name>.zone
      >      subnet_id = yandex_vpc_subnet.<subnet_name>.id
      >    }
      >  }
      >  service_account_id      = yandex_iam_service_account.<service_account_name>.id
      >  node_service_account_id = yandex_iam_service_account.<service_account_name>.id
      >    depends_on = [
      >      yandex_resourcemanager_folder_iam_member.editor,
      >      yandex_resourcemanager_folder_iam_member.images-puller
      >    ]
      > }
      >
      > resource "yandex_vpc_network" "<network_name>" { name = "<network_name>" }
      >
      > resource "yandex_vpc_subnet" "<subnet_name>" {
      >  v4_cidr_blocks = ["<subnet_address_range>"]
      >  zone           = "<availability_zone>"
      >  network_id     = yandex_vpc_network.<network_name>.id
      > }
      >
      > resource "yandex_iam_service_account" "<service_account_name>" {
      >  name        = "<service_account_name>"
      >  description = "<service_account_description>"
      > }
      >
      > resource "yandex_resourcemanager_folder_iam_member" "editor" {
      >  # The service account is assigned the editor role.
      >  folder_id = "<folder_ID>"
      >  role      = "editor"
      >  member    = "serviceAccount:${yandex_iam_service_account.<service_account_name> id}"
      > }
      >
      > resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
      >  # The service account is assigned the container-registry.images.puller role.
      >  folder_id = "<folder_ID>"
      >  role      = "container-registry.images.puller"
      >  member    = "serviceAccount:${yandex_iam_service_account.<service_account_name>.id}"
      > }
      > ```

      To enable sending logs to [{{ cloud-logging-full-name }}](../../../logging/), add the `master_logging` section to the {{ managed-k8s-name }} cluster description:

      {% include [master-logging-tf.md](../../../_includes/managed-kubernetes/master-logging-tf.md) %}

      Where:

      {% include [master-logging-tf-description.md](../../../_includes/managed-kubernetes/master-logging-tf-description.md) %}

      For more information, see the [{{ TF }} provider documentation]({{ tf-provider-k8s-cluster }}).
   1. Make sure the configuration files are valid.

      {% include [terraform-create-cluster-step-2](../../../_includes/mdb/terraform-create-cluster-step-2.md) %}

   1. Create a {{ managed-k8s-name }} cluster.

      {% include [terraform-create-cluster-step-3](../../../_includes/mdb/terraform-create-cluster-step-3.md) %}

- API

   To create a {{ managed-k8s-name }} cluster, use the [create](../../api-ref/Cluster/create.md) method for the [Cluster](../../api-ref/Cluster) resource.

   {% include [note-another-catalog-network](../../../_includes/managed-kubernetes/note-another-catalog-network.md) %}

   To use a [{{ kms-full-name }} encryption key](../../concepts/encryption.md) to protect secrets, provide its ID in the `kmsProvider.keyId` parameter.

   To enable sending logs to [{{ cloud-logging-full-name }}](../../../logging/), provide the logging settings in the `masterSpec.masterLogging` parameter.

{% endlist %}

## Examples {#examples}

### Creating a zonal {{ managed-k8s-name }} cluster {#example-zonal-cluster}

{% list tabs %}

- {{ TF }}

    Let's assume we need to create a {{ managed-k8s-name }} cluster and a network for it with the following specifications:
    * Name: `k8s-zonal`.
    * Version: `1.22`.
    * [Cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud) ID: `{{ tf-cloud-id }}`.
    * [Folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) ID: `{{ tf-folder-id }}`.
    * New network: `mynet`.
    * New subnet: `mysubnet`; [availability zone](../../../overview/concepts/geo-scope.md): `{{ region-id }}-a`. The `mysubnet` subnet has the `10.1.0.0/16` range.
    * New service account: `myaccount` with the `k8s.clusters.agent`, `vpc.publicAdmin`, `container-registry.images.puller`, and `kms.viewer` role permissions.
    * [{{ kms-full-name }} encryption key](../../concepts/encryption.md): `kms-key`.
    * New [security group](../../../vpc/concepts/security-groups.md): `k8s-public-services`, allowing [connections to services from the internet](../connect/security-groups.md#rules-nodes).

    To do this, install {{ TF }} (unless you already have it), configure the provider according to [this guide](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), and apply the configuration file:

    {% cut "Configuration file for the {{ managed-k8s-name }} cluster:" %}

    
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

    resource "yandex_resourcemanager_folder_iam_member" "viewer" {
      folder_id = local.folder_id
      role      = "viewer"
      member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
    }

    resource "yandex_vpc_security_group" "k8s-public-services" {
      name        = "k8s-public-services"
      description = "Group rules allow connections to services from the internet. Apply the rules only for node groups."
      network_id  = yandex_vpc_network.mynet.id
      ingress {
        protocol          = "TCP"
        description       = "The rule allows availability checks from the load balancer address range. It is required for the operation of a fault-tolerant {{ managed-k8s-name }} cluster and load balancer services."
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
        description       = "The rule allows pod-to-pod and service-to-service communication. Specify the subnets of your {{ managed-k8s-name }} cluster and services."
        v4_cidr_blocks    = concat(yandex_vpc_subnet.mysubnet.v4_cidr_blocks)
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
        description       = "The rule allows incoming traffic from the internet to the NodePort port range. Add ports or change existing ones to the required ports."
        v4_cidr_blocks    = ["0.0.0.0/0"]
        from_port         = 30000
        to_port           = 32767
      }
      egress {
        protocol          = "ANY"
        description       = "The rule allows all outgoing traffic. Nodes can connect to {{ container-registry-full-name }}, {{ objstorage-full-name }}, Docker Hub, and so on."
        v4_cidr_blocks    = ["0.0.0.0/0"]
        from_port         = 0
        to_port           = 65535
      }
    }
    ```



   {% endcut %}

{% endlist %}

### Creating a regional {{ managed-k8s-name }} cluster {#example-regional-cluster}

{% list tabs %}

- {{ TF }}

   Let's assume we need to create a {{ managed-k8s-name }} cluster and a network for it with the following specifications:
   * Name: `k8s-regional`.
   * Version: `1.22`.
   * Cloud ID: `{{ tf-cloud-id }}`.
   * Folder ID: `{{ tf-folder-id }}`.
   * In the new `mynet` network with new subnets:
      * `mysubnet-a` in the {{ region-id }}-a availability zone with a range of `10.5.0.0/16`.
      * `mysubnet-b` in the {{ region-id }}-b availability zone with a range of `10.6.0.0/16`.
      * `mysubnet-c` in the {{ region-id }}-c availability zone with a range of `10.7.0.0/16`.
   * With the new `myaccount` service account that has the `k8s.clusters.agent`, `vpc.publicAdmin`, `container-registry.images.puller`, and `kms.viewer` role permissions.
   * {{ kms-name }} encryption key: `kms-key`.
   * New security group: `k8s-main-sg` containing [rules for service traffic](../connect/security-groups.md#rules-internal).

   To do this, install {{ TF }} (unless you already have it), configure the provider according to [this guide](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), and apply the configuration file:

   {% cut "Configuration file for the {{ managed-k8s-name }} cluster:" %}

   
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

   resource "yandex_resourcemanager_folder_iam_member" "viewer" {
     folder_id = local.folder_id
     role      = "viewer"
     member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
   }

   resource "yandex_vpc_security_group" "k8s-main-sg" {
     name        = "k8s-main-sg"
     description = "Group rules ensure the basic performance of the {{ managed-k8s-name }} cluster. Apply it to the {{ managed-k8s-name }} cluster and node groups."
     network_id  = yandex_vpc_network.mynet.id
     ingress {
       protocol          = "TCP"
       description       = "The rule allows availability checks from the load balancer address range. It is required for the operation of a fault-tolerant {{ managed-k8s-name }} cluster and load balancer services."
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
       description       = "The rule allows pod-to-pod and service-to-service communication. Specify the subnets of your {{ managed-k8s-name }} cluster and services."
       v4_cidr_blocks    = concat(yandex_vpc_subnet.mysubnet-a.v4_cidr_blocks, yandex_vpc_subnet.mysubnet-b.v4_cidr_blocks, yandex_vpc_subnet.mysubnet-c.v4_cidr_blocks)
       from_port         = 0
       to_port           = 65535
     }
     ingress {
       protocol          = "ICMP"
       description       = "The rule allows debugging ICMP packets from internal subnets."
       v4_cidr_blocks    = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
     }
     ingress {
       protocol          = "TCP"
       description       = "The rule allows incoming traffic from the internet to the NodePort port range. Add ports or change existing ones to the required ports."
       v4_cidr_blocks    = ["0.0.0.0/0"]
       from_port         = 30000
       to_port           = 32767
     }
     egress {
       protocol          = "ANY"
       description       = "The rule allows all outgoing traffic. Nodes can connect to {{ container-registry-full-name }}, {{ objstorage-full-name }}, Docker Hub, and so on."
       v4_cidr_blocks    = ["0.0.0.0/0"]
       from_port         = 0
       to_port           = 65535
     }
   }
   ```



   {% endcut %}

{% endlist %}