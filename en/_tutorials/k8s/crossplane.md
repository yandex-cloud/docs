# Integration with Crossplane

[Crossplane](https://crossplane.io/) is an open-source {{ k8s }} add-on that helps you bring solutions from different providers into a single infrastructure and provide application developers access to this infrastructure through high-level APIs. With Crossplane, users can manage third-party services in the same way they manage {{ k8s }} resources.

To create a {{ compute-full-name }} [VM](../../compute/concepts/vm.md) using the [Crossplane application](/marketplace/products/yc/crossplane) installed in a [{{ k8s }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster):

1. [Get your cloud ready](#before-you-begin).
1. [Create the {{ managed-k8s-name }} resources](#k8s-create).
1. [Create {{ yandex-cloud }} resources using Crossplane](#create-crossplane-res).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* Fee for the {{ managed-k8s-name }} cluster: using the master and outgoing traffic (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Cluster nodes (VM) fee: using computing resources, operating system, and storage (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for a public IP address assigned to cluster nodes (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).
* Fee for using the NAT gateway (see [{{ vpc-name }} pricing](../../vpc/pricing.md#nat-gateways)).


## Get your cloud ready {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. Install the [`jq`](https://stedolan.github.io/jq/) JSON stream processor.

## Create the {{ managed-k8s-name }} resources {#k8s-create}

1. Create a {{ k8s }} cluster and [node group](../../managed-kubernetes/concepts/index.md#node-group).

   {% list tabs group=instructions %}

   - Manually {#manual}

     1. If you do not have a [network](../../vpc/concepts/network.md#network) yet, [create one](../../vpc/operations/network-create.md).
     1. If you do not have any [subnets](../../vpc/concepts/network.md#subnet) yet, [create them](../../vpc/operations/subnet-create.md) in the [availability zones](../../overview/concepts/geo-scope.md) where your {{ k8s }} cluster and node group will be created.
     1. [Create service accounts](../../iam/operations/sa/create.md):
        * Service account with the `k8s.clusters.agent` and `vpc.publicAdmin` [roles](../../resource-manager/concepts/resources-hierarchy.md#folder) for the [folder](../../managed-kubernetes/security/index.md#yc-api) where the {{ k8s }} cluster is created. This service account will be used to create the resources required for the {{ k8s }} cluster.
        * Service account with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#container-registry-images-puller) [role](../../iam/concepts/access-control/roles.md). Nodes will pull the required [Docker images](../../container-registry/concepts/registry.md) from the [registry](../../container-registry/concepts/docker-image.md) on behalf of this account.

        {% note tip %}

        You can use the same [service account](../../iam/concepts/users/service-accounts.md) to manage your {{ k8s }} cluster and its node groups.

        {% endnote %}

     1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. [Create a {{ k8s }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration. When creating them, specify the security groups prepared earlier.

   - {{ TF }} {#tf}

     1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
     1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
     1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
     1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

     1. Download the [k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-infrastructure/blob/main/k8s-cluster.tf) cluster configuration file to the same working directory. This file describes:
        * [Network](../../vpc/concepts/network.md#network).
        * [Subnet](../../vpc/concepts/network.md#subnet).
        * {{ k8s }} cluster.
        * [Service account](../../iam/concepts/users/service-accounts.md) required for the {{ managed-k8s-name }} cluster and node group.
        * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

            {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. Specify the following in the configuration file:
        * [Folder ID](../../resource-manager/operations/folder/get-id.md).
        * {{ k8s }} version for the {{ k8s }} cluster and node groups.
        * {{ k8s }} cluster CIDR.
        * Name of the {{ managed-k8s-name }} cluster service account.
     1. Check that the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.
     1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. {% include [kubectl-install-links](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Install Crossplane in the {{ k8s }} cluster](../../managed-kubernetes/operations/applications/crossplane.md).
1. [Set up a NAT gateway for the {{ k8s }} cluster node subnet](../../vpc/operations/create-nat-gateway.md).

## Create {{ yandex-cloud }} resources using Crossplane {#create-crossplane-res}

1. Decide what resources you want to create using Crossplane. To get a list of available resources, run the following command:

   ```bash
   kubectl get crd | grep yandex-cloud.jet.crossplane.io
   ```

1. Decide the resources' parameters. To see what parameters are available for a particular resource, run this command:

   ```bash
   kubectl describe crd <resource_name>
   ```

1. Create the `vm-instance-template.yml` manifest template describing the network and subnet existing in the folder as well as the new `crossplane-vm` VM you are going to create with Crossplane:

    ```yaml
    # Adding an existing network to the configuration
    apiVersion: vpc.yandex-cloud.jet.crossplane.io/v1alpha1
    kind: Network
    metadata:
      name: <name_of_existing_network>
      annotations:
        # Point out an existing network to the provider
        crossplane.io/external-name: <ID_of_existing_network>
    spec:
      # Prohibit deletion of an existing network
      deletionPolicy: Orphan
      forProvider:
        name: <name_of_existing_network>
      providerConfigRef:
        name: default
    ---
    # Adding an existing subnet to the configuration
    apiVersion: vpc.yandex-cloud.jet.crossplane.io/v1alpha1
    kind: Subnet
    metadata:
      name: <name_of_existing_subnet>
      annotations:
        # Point out an existing subnet to the provider
        crossplane.io/external-name: <ID_of_existing_subnet>
    spec:
      # Prohibit deletion of an existing subnet
      deletionPolicy: Orphan
      forProvider:
        name: <name_of_existing_subnet>
        networkIdRef:
          name: <name_of_existing_network>
        v4CidrBlocks:
          - <IPv4_CIDR_of_existing_subnet>
      providerConfigRef:
        name: default
    ---
    # Creating a VM instance
    apiVersion: compute.yandex-cloud.jet.crossplane.io/v1alpha1
    kind: Instance
    metadata:
      name: crossplane-vm
    spec:
      forProvider:
        name: crossplane-vm
        platformId: standard-v1
        zone: {{ region-id }}-a
        resources:
          - cores: 2
            memory: 4
        bootDisk:
          - initializeParams:
              - imageId: fd80bm0rh4rkepi5ksdi
        networkInterface:
          - subnetIdRef:
              name: <name_of_existing_subnet>
            # Automatically provide a public IP address to the VM
            nat: true
        metadata:
          ssh-keys: "<public_SSH_key>"
      providerConfigRef:
        name: default
      # Write the credentials for connection to the VM into a secret
      writeConnectionSecretToRef:
        name: instance-conn
        namespace: default
      ```

   In the VM configuration section:
   * `zone: {{ region-id }}-a`: [Availability zone](../../overview/concepts/geo-scope.md) to deploy the VM in.
   * `name: crossplane-vm`: Name of the VM that will be created with Crossplane.
   * `imageId: fd80bm0rh4rkepi5ksdi`: ID of the VM's boot image. You can get it with the [list of images](../../compute/operations/image-control/get-list.md). This example uses a [Ubuntu 22.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-22-04-lts) image.

   For examples of how to configure {{ yandex-cloud }} resources, see the [provider's GitHub repo](https://github.com/yandex-cloud/crossplane-provider-yc/tree/main/examples).

1. Apply the `vm-instance-template.yml` manifest:

   ```bash
   kubectl apply -f vm-instance-template.yml
   ```

1. Check the state of the new resources:

   ```bash
   kubectl get network
   kubectl get subnet
   kubectl get instance
   ```

1. Make sure the new `crossplane-vm` VM has appeared in the folder:

   ```bash
   yc compute instance list
   ```

1. To retrieve the data needed to connect to the VM from the secret, run this command:
   
   ```bash
   kubectl get secret instance-conn -o json | jq -r '.data | map_values(@base64d)'
   ```

   Expected result:
   
   ```json
   {
     "external_ip": "<public_IP_address>",
     "fqdn": "<full_domain_name>",
     "internal_ip": "<internal_IP_address>"
   }
   ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. Delete the `crossplane-vm` VM:

   ```bash
   kubectl delete instance crossplane-vm
   ```

1. Delete the other resources:

   {% list tabs group=instructions %}

   - Manually {#manual}

     1. [Delete the {{ k8s }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
     1. [Delete the subnets you created](../../vpc/operations/subnet-delete.md).
     1. [Delete the route table](../../vpc/operations/delete-route-table.md).
     1. [Delete the NAT gateway](../../vpc/operations/delete-nat-gateway.md).
     1. [Delete the networks](../../vpc/operations/network-delete.md).
     1. [Delete service accounts you created](../../iam/operations/sa/delete.md).

   - {{ TF }} {#tf}

     {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

   {% endlist %}
