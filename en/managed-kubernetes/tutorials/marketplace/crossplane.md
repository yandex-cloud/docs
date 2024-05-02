# Integration with Crossplane


[Crossplane](https://crossplane.io/) is an open-source {{ k8s }} add-on that helps you bring solutions from different providers into a single infrastructure and provide application developers access to this infrastructure through high-level APIs. With Crossplane, users can manage third-party services in the same way they manage {{ k8s }} resources.

To create a {{ compute-full-name }} [VM](../../../compute/concepts/vm.md) using the [Crossplane application](/marketplace/products/yc/crossplane) installed in a [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster):
1. [{#T}](#k8s-create)
1. [{#T}](#create-crossplane-res)

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Install the [`jq` JSON stream processor](https://stedolan.github.io/jq/).

## Create {{ managed-k8s-name }} resources {#k8s-create}

1. Create a {{ k8s }} cluster and a [group of nodes](../../../managed-kubernetes/concepts/index.md#node-group).

   {% list tabs group=instructions %}

   - Manually {#manual}

      1. If you do not have a [network](../../../vpc/concepts/network.md#network) yet, [create one](../../../vpc/operations/network-create.md).
      1. If you do not have any [subnets](../../../vpc/concepts/network.md#subnet) yet, [create them](../../../vpc/operations/subnet-create.md) in the [availability zones](../../../overview/concepts/geo-scope.md) where your {{ k8s }} cluster and node group will be created.
      1. [Create service accounts](../../../iam/operations/sa/create.md):
         * Service account with the `k8s.clusters.agent` and `vpc.publicAdmin` [roles](../../security/index.md#yc-api) for the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ k8s }} cluster is created. This service account will be used to create the resources required for the {{ k8s }} cluster.
         * Service account with the [{{ roles-cr-puller }}](../../../container-registry/security/index.md#container-registry-images-puller) [role](../../../iam/concepts/access-control/roles.md). Nodes will pull the required [Docker images](../../../container-registry/concepts/docker-image.md) from the [registry](../../../container-registry/concepts/registry.md) on behalf of this account.

         {% note tip %}

         You can use the same [service account](../../../iam/concepts/users/service-accounts.md) to manage your {{ k8s }} cluster and its node groups.

         {% endnote %}

      1. [Create a {{ k8s }} cluster](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration.

      1. {% include [configure-sg-manual](../../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

         {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

   - {{ TF }} {#tf}

      1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
      1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
      1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
      1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

      1. Download the [k8s-cluster.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-cluster.tf) cluster configuration file to the same working directory. The file describes:
         * [Network](../../../vpc/concepts/network.md#network).
         * [Subnet](../../../vpc/concepts/network.md#subnet).
         * {{ k8s }} cluster.
         * [Service account](../../../iam/concepts/users/service-accounts.md) required to use the {{ managed-k8s-name }} cluster and node group.
         * {% include [configure-sg-terraform](../../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

            {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

      1. Specify the following in the configuration file:
         * [Folder ID](../../../resource-manager/operations/folder/get-id.md).
         * {{ k8s }} version for the {{ k8s }} cluster and node groups.
         * {{ k8s }} cluster CIDR.
         * Name of the {{ managed-k8s-name }} cluster service account.
      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point them out.
      1. Create the required infrastructure:

         {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

         {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. {% include [kubectl-install-links](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Install Crossplane in the {{ k8s }} cluster](../../operations/applications/crossplane.md).
1. [Set up a NAT gateway for the {{ k8s }} cluster node subnet](../../../vpc/operations/create-nat-gateway.md).

## Create resources using Crossplane {#create-crossplane-res}

1. Create a Crossplane `providerconfig.yml` manifest:

   ```yaml
   apiVersion: yandex-cloud.jet.crossplane.io/v1alpha1
   kind: ProviderConfig
   metadata:
     name: yc-config
   spec:
     credentials:
       source: Secret
       secretRef:
         name: yc-creds
         namespace: <namespace_for_Crossplane>
         key: credentials
   ```

1. Create a template manifest `vm-instance-template.yml` with a description of the network, subnet, and `crossplane-vm` instance created using Crossplane:

   ```yaml
   apiVersion: vpc.yandex-cloud.jet.crossplane.io/v1alpha1
   kind: Network
   metadata:
     name: <NET_NAME>
     annotations:
       crossplane.io/external-name: <NET_ID>
   spec:
     deletionPolicy: Orphan
     forProvider:
       name: <NET_NAME>
       folderId: <FOLDER_ID>
   ---
   apiVersion: vpc.yandex-cloud.jet.crossplane.io/v1alpha1
   kind: Subnet
   metadata:
     name: <SUBNET_NAME>
     annotations:
       crossplane.io/external-name: <SUBNET_ID>
   spec:
     deletionPolicy: Orphan
     forProvider:
       name: <SUBNET_NAME>
       networkIdRef:
         name: <NET_NAME>
       v4CidrBlocks:
         - <SUBNET_PREFIX>
       zone: <ZONE_ID>
       folderId: <FOLDER_ID>
   ---
   apiVersion: compute.yandex-cloud.jet.crossplane.io/v1alpha1
   kind: Instance
   metadata:
     name: <VM_NAME>
   spec:
     forProvider:
       name: <VM_NAME>
       platformId: standard-v2
       zone: <ZONE_ID>
       resources:
         - cores: 2
           memory: 4
       bootDisk:
         - initializeParams:
             # LEMP stack
             # yc compute image get --folder-id standard-images --name=lemp-v20220606 --format=json | jq -r .id
             - imageId: <IMAGE_ID>
       networkInterface:
         - subnetIdRef:
             name: <SUBNET_NAME>
       folderId: <FOLDER_ID>
   ```

   Where:
   * `ZONE_ID`: [Availability zone](../../../overview/concepts/geo-scope.md).
   * `VM_NAME`: Name of the VM to be created using Crossplane tools.
   * `NET_NAME`: Name of the {{ k8s }} cluster cloud network.
   * `SUBNET_NAME`: Name of the {{ k8s }} cluster node subnet.
   * `SUBNET_ID`: Subnet ID.
   * `NET_ID`: Network ID.
   * `SUBNET_PREFIX`: Subnet CIDR.
   * `FOLDER_ID`: Folder ID.
   * `IMAGE_ID`: ID of the VM's boot image. You can fetch it with a [list of images](../../../compute/operations/image-control/get-list.md). This example uses the [LEMP](/marketplace/products/yc/lemp) image.
1. Apply the `providerconfig.yml` manifest:

   ```bash
   kubectl apply -f providerconfig.yml
   ```

1. Apply the `vm-instance.yml` manifest:

   ```bash
   kubectl apply -f vm-instance.yml
   ```

1. Check the state of the created resources:

   ```bash
   kubectl get network
   kubectl get subnet
   kubectl get instance
   ```

1. Make sure the created `crossplane-vm` instance is now in the folder:

   ```bash
   yc compute instance list
   ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. Delete the `crossplane-vm` instance:

   ```bash
   kubectl delete instance crossplane-vm
   ```

1. Delete the other resources:

   {% list tabs group=instructions %}

   - Manually {#manual}

      1. [Delete the {{ k8s }} cluster](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
      1. [Delete the created subnets](../../../vpc/operations/subnet-delete.md) and [networks](../../../vpc/operations/network-delete.md).
      1. [Delete the created service accounts](../../../iam/operations/sa/delete.md).

   - {{ TF }} {#tf}

      1. In the command line, go to the directory with the current {{ TF }} configuration file with an infrastructure plan.
      1. Delete the `k8s-cluster.tf` configuration file.
      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point them out.
      1. Confirm updating the resources.

         {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

         All the resources described in the `k8s-cluster.tf` configuration file will be deleted.

   {% endlist %}
