# Creating a self-managed {{ k8s }} cluster using the {{ yandex-cloud }} provider for the {{ k8s }} Cluster API

[Cluster-api-provider-yandex](https://github.com/yandex-cloud/cluster-api-provider-yandex) is a provider for deploying a self-managed {{ k8s }} cluster in {{ yandex-cloud }} infrastructure using the [{{ k8s }} Cluster API](https://cluster-api.sigs.k8s.io/).

The cluster is deployed based on {{ compute-full-name }} [virtual machines](../../compute/concepts/vm.md) and an [L7](../../application-load-balancer/concepts/application-load-balancer.md) {{ alb-full-name }}.

**Advantages of using a {{ yandex-cloud }} provider for creating clusters:** {#advantages}

* Integration with the [{{ yandex-cloud }} API](../../api-design-guide/concepts/general.md).
* Declarative approach to cluster creation and management.
* Describing the cluster as a custom resource [CustomResourceDefinition](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/).
* Wide range of parameters for configuring cluster compute resources.
* [Custom OS images](#prepare-os-image) for master and nodes.
* Custom Control Plane.
* Alternative to [{{ TF }}](https://www.terraform.io/) for CI processes.

**Provider compatibility with the {{ k8s }} Cluster API** {#compatibility}

| Provider version | Cluster API version |
| :---: | :---: |
| v1alpha1 | v1beta1 (v1.x) |

To deploy a {{ k8s }} cluster in {{ yandex-cloud }} using the Cluster API:

1. [Get your cloud ready](#before-you-begin).
1. [Set up your environment](#prepare-environment).
1. [Prepare an OS image for cluster nodes](#prepare-os-image).
1. [Get a Docker image with the {{ yandex-cloud }} provider](#get-docker-image).
1. [Install the {{ yandex-cloud }} provider and the {{ k8s }} Cluster API provider](#install-providers).
1. [Generate cluster manifests](#prepare-manifests).
1. [Deploy a cluster](#create-cluster).
1. [Connect to the cluster](#connect-to-cluster).
1. [Install the CCM](#install-ccm).
1. [Install the CNI](#install-cni).
1. [Check the connection between the managing cluster and the new cluster](#check-connection).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support costs include:
* Fee for computing resources and disks of VMs used for {{ k8s }} cluster deployment, auxiliary VM, and {{ managed-k8s-name }} managing cluster nodes (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for using the computing resources of the L7 load balancer (see [{{ alb-full-name }} pricing](../../application-load-balancer/pricing.md)).
* Fee for using {{ managed-k8s-name }} managing cluster master and outbound traffic (see [{{ managed-k8s-full-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for [public IP addresses](../../vpc/concepts/address.md#public-addresses) for auxiliary VMs and {{ managed-k8s-name }} managing cluster (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for using the [NAT gateway](../../vpc/concepts/gateways.md) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md#nat-gateways)).

#### Optional costs {#optional-expenses}

* If intending to use a custom image for the new {{ k8s }} cluster nodes:
  * Fee for storing the image in the bucket and data operations (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).
  * Fee for storing the image in {{ compute-name }} (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* If intending to use a custom Docker image to deploy the {{ yandex-cloud }} provider in the managing cluster, fee for storing a Docker image in the registry and outgoing traffic (see [{{ container-registry-full-name }} pricing](../../container-registry/pricing.md)).

### Set up your infrastructure {#infra}

1. Prepare a {{ yandex-cloud }} [service account](../../iam/concepts/users/service-accounts.md):
    1. [Create](../../iam/operations/sa/create.md) a service account you will use to create resources for the cluster.
    1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the [compute.editor](../../compute/security/index.md#compute-editor) and [alb.editor](../../application-load-balancer/security/index.md#alb-editor) roles for the folder to the service account.
    1. [Create](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) an authorized key for a service account in JSON format.
1. If your folder does not have a {{ vpc-name }} [network](../../vpc/concepts/network.md#network) yet, [create](../../vpc/operations/network-create.md) it. Also [create](../../vpc/operations/subnet-create.md) a subnet.
1. The new cluster infrastructure will automatically be assigned the default [security group](../../vpc/concepts/security-groups.md) which is created together with the network. [Add](../../vpc/operations/security-group-add-rule.md) the following rules for _incoming_ traffic to this group:

    {{ ui-key.yacloud.vpc.network.security-groups.column_sg-rules-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.column_sg-rules-ports }} | {{ ui-key.yacloud.vpc.network.security-groups.column_sg-rules-source-type }} | {{ ui-key.yacloud.vpc.network.security-groups.column_sg-rules-source-target }} | {{ ui-key.yacloud.vpc.network.security-groups.column_sg-rules-description }}
    --- | --- | --- | --- | ---
    `{{ ui-key.yacloud.common.label_tcp }}` | `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-security-group }}` | `Balancer` | `Health checks by an L7 load balancer`
    `Any` | `8443` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | `Access to the {{ k8s }} API`

1. The created cluster will be accessible within the cloud network via an [internal IP address](../../vpc/concepts/address.md#internal-addresses). To enable remote access to the cluster:
    1. [Create](../../compute/operations/vm-create/create-linux-vm.md) an auxiliary VM with a public IP address and the default security group in the same network where your cluster will be deployed.
    1. Install [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) on the auxiliary VM.
1. Create a {{ managed-k8s-name }} _managing_ [cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) with a public IP address and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md). You will need this cluster to deploy the new cluster using the Cluster API and to manage the cluster infrastructure.

    {% note tip %}

    You can also deploy the managing cluster locally, for example, using the [`kind` utility](https://kind.sigs.k8s.io/).

    {% endnote %}

1. For the new cluster to have internet access and be able to push Docker images, [configure](../../vpc/operations/create-nat-gateway.md) a NAT gateway for the subnet the new cluster will be located in.

## Set up your environment {#prepare-environment}

The environment is configured on the local computer.

1. Install the following tools:
    * [Go](https://go.dev/doc/install) 1.22.0 or higher.
    * [Docker](https://www.docker.com/) 17.03 or higher.
    * [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) 1.11.3 or higher.
    * [clusterctl](https://cluster-api.sigs.k8s.io/user/quick-start#install-clusterctl) 1.5.0 or higher.

1. [Configure](../../managed-kubernetes/operations/connect/index.md#kubectl-connect) `kubectl` access to the {{ managed-k8s-name }} managing cluster.

    If the managing cluster is deployed locally with the help of `kind`, configure access to it as per [this guide](https://kind.sigs.k8s.io/docs/user/quick-start/#interacting-with-your-cluster).

1. Clone the [cluster-api-provider-yandex](https://github.com/yandex-cloud/cluster-api-provider-yandex) repository and navigate to the project directory.

    ```bash
    git clone https://github.com/yandex-cloud/cluster-api-provider-yandex.git
    cd cluster-api-provider-yandex
    ```
    
## Prepare an OS image for cluster nodes {#prepare-os-image}

The OS [image](../../compute/concepts/image.md) deployed on the nodes of the new cluster must be ready to work with the {{ k8s }} Cluster API and compatible with {{ compute-name }}.

You can use a ready-made test image or build a custom one:

{% list tabs %}

- Ready-made image

  To use a Ubuntu 24.04 test OS image ready for {{ k8s }} 1.31.4, specify the image ID `fd8a3kknu25826s8hbq3` in the `YANDEX_CONTROL_PLANE_MACHINE_IMAGE_ID` variable when [generating the cluster manifest](#prepare-manifests).

  {% note warning %}

  This image is created for informational purposes only, do not use it in production.

  {% endnote %}

- Custom image

  1. [Build](https://image-builder.sigs.k8s.io/capi/capi) your OS image using the [Image Builder](https://github.com/kubernetes-sigs/image-builder) utility.

      See also: [Prepare a disk image for {{ compute-name }}](../../compute/operations/image-create/custom-image.md).
  1. [Upload](../../compute/operations/image-create/upload.md) the image to {{ compute-name }} and save its ID.

{% endlist %}

## Get a Docker image with the {{ yandex-cloud }} provider {#get-docker-image}

You can use a ready-made Docker image with the {{ yandex-cloud }} provider from a public [{{ container-registry-full-name }}](../../container-registry/concepts/registry.md) or build your own image from the source code.

{% list tabs %}

- Ready-made image

  1. [Authenticate](../../container-registry/operations/authentication.md#cred-helper) in your {{ container-registry-name }} using the [Docker credential helper](https://docs.docker.com/engine/reference/commandline/login/#credential-helpers).
  1. Add to the `IMG` environment variable the path to the Docker image with the {{ yandex-cloud }} provider in the public registry:

      ```bash
      export IMG={{ registry }}/crpsjg1coh47p81vh2lc/capy/cluster-api-provider-yandex:latest
      ```

- Image built from source code

  1. [Create](../../container-registry/operations/registry/registry-create.md) a {{ container-registry-name }} and save its ID.
  1. [Authenticate](../../container-registry/operations/authentication.md#cred-helper) in your {{ container-registry-name }} using the [Docker credential helper](https://docs.docker.com/engine/reference/commandline/login/#credential-helpers).
  1. Add to the `IMG` environment variable the path the new Docker image will be stored at in the registry:

      ```bash
      export IMG={{ registry }}/<registry_ID>/cluster-api-provider-yandex:<tag>
      ```

  1. If you are building your Docker image on a non-[AMD64](https://ru.wikipedia.org/wiki/X86-64) computer, edit the `docker-build` section in the [Makefile](https://github.com/yandex-cloud/cluster-api-provider-yandex/blob/master/Makefile):

      ```text
      docker build --platform linux/amd64 -t ${IMG} .
      ```

  1. Run the Docker daemon.
  1. Build a Docker image and push it to the registry:

      ```bash
      make docker-build docker-push
      ```

{% endlist %}

## Install the {{ yandex-cloud }} provider and the {{ k8s }} Cluster API provider {#install-providers}

1. Initialize the managing cluster:

    ```bash
    clusterctl init
    ```

    The managing cluster will have the core components of the {{ k8s }} Cluster API and [cert-manager](https://cert-manager.io/).

1. Create a custom resource definition ([CustomResourceDefinitions](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/), CRD) for the new cluster:

    ```bash
    make install
    ```

1. Retrieve a list of installed CRDs:

    ```bash
    kubectl get crd | grep cluster.x-k8s.io
    ```

    To get a manifest for a specific CRD, run the following command:

    ```bash
    kubectl get crd <CRD_name> \
      --output yaml
    ```

1. Create a namespace for the {{ yandex-cloud }} provider:

    ```bash
    kubectl create namespace capy-system
    ```

1. Create a secret with the {{ yandex-cloud }} service account's authorized key:

    ```bash
    kubectl create secret generic yc-sa-key \
      --from-file=key=<path_to_file_with_authorized_key> \
      --namespace capy-system
    ```

1. Install the {{ yandex-cloud }} provider:

    ```bash
    make deploy
    ```

## Generate cluster manifests {#prepare-manifests}

1. Get the IDs of {{ yandex-cloud }} resources to deploy a cluster:
    * [OS image](../../compute/operations/image-control/image-control-get-info.md)
    * [Folder](../../resource-manager/operations/folder/get-id.md)
    * [Availability zone](../../overview/concepts/geo-scope.md)
    * [Network](../../vpc/operations/network-get-info.md)
    * [Subnet](../../vpc/operations/subnet-get-info.md) in the selected availability zone.

1. Provide the IDs to these environment variables:

    ```bash
    export YANDEX_CONTROL_PLANE_MACHINE_IMAGE_ID=<image_ID>
    export YANDEX_FOLDER_ID=<folder_ID>
    export YANDEX_NETWORK_ID=<network_ID>
    export YANDEX_SUBNET_ID=<subnet_ID>
    export YANDEX_ZONE_ID=<availability_zone_ID>
    ```

    If you [did not build a custom OS image](#prepare-os-image), set the `YANDEX_CONTROL_PLANE_MACHINE_IMAGE_ID` variable to `fd8a3kknu25826s8hbq3`. This is the ID of a test Ubuntu 24.04 image compatible with {{ k8s }} 1.31.4.

1. Generate cluster manifests:

    ```bash
    clusterctl generate cluster <name_of_new_cluster> \
      --from templates/cluster-template.yaml > /tmp/capy-cluster.yaml
    ```

    The `capy-cluster.yaml` manifest will describe the following:
    * L7 {{ alb-name }} with a dynamic internal IP address. You can [give it a fixed IP address](#configure-endpoint).

        {% note warning %}

        Once the cluster is created, you will not be able to assign a fixed IP address to the L7 load balancer.

        {% endnote %}

    * Three Control Plane nodes for the cluster.

1. Optionally, to deploy workload cluster nodes right away, add their description to the manifest.

    ```bash
    clusterctl generate cluster <name_of_new_cluster> \
        --worker-machine-count <number_of_workload_nodes> \
        --from templates/cluster-template.yaml > /tmp/capy-cluster.yaml
    ```

### Optionally, configure the API server endpoint {#configure-endpoint}

Specify the parameters for the L7 load balancer in the `capy-cluster.yaml` manifest:

```yaml
  loadBalancer:
    listener:
      address: <fixed_IP_address_from_subnet_range>
      subnet:
        id: <subnet_ID>
```

## Deploy a cluster {#create-cluster}

Run this command:

```bash
kubectl apply -f /tmp/capy-cluster.yaml
```

You can monitor cluster creation progress from the {{ yandex-cloud }} [management console]({{ link-console-main }}) and the `capy-controller-manager` pod logs:

```bash
kubectl logs <capy-controller-manager_pod_name> \
  --namespace capy-system \
  --follow
```

## Connect to the cluster {#connect-to-cluster}

The details for connection to the new cluster will be stored in the `<name_of_new_cluster>-kubeconfig` secret in the managing cluster.

1. Get the data from the secret:

    ```bash
    kubectl get secret <name_of_new_cluster>-kubeconfig \
      --output yaml | yq -r '.data.value' | base64 \
      --decode > capy-cluster-config
    ```

1. [Provide](../../compute/operations/vm-connect/scp-sftp.md) the `kubectl` configuration file to the auxiliary VM:

    ```bash
    scp <path_to_capy-cluster-config_file_on_local_computer> \
    <username>@<VM_public_IP_address>:/home/<username>/.kube/config
    ```

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the auxiliary VM over SSH.
1. Make sure the new cluster is accessible:

    ```bash
    kubectl cluster-info
    ```

## Install a CCM to the new cluster {#install-ccm}

For connection between the cluster resources and {{ yandex-cloud }} resources, install a [cloud controller manager](https://kubernetes.io/docs/concepts/architecture/cloud-controller/) to the new cluster, e.g., the [Kubernetes Cloud Controller Manager for {{ yandex-cloud }}](https://github.com/deckhouse/yandex-cloud-controller-manager/tree/master).

{% note info %}

If you want to use the Kubernetes Cloud Controller Manager for {{ yandex-cloud }}, add the current version of the Docker image and the `YANDEX_CLUSTER_NAME` environment variable with the new cluster's name to the [yandex-cloud-controller-manager.yaml](https://github.com/deckhouse/yandex-cloud-controller-manager/blob/master/manifests/yandex-cloud-controller-manager.yaml) manifest example for `DaemonSet`.

{% endnote %}

## Install a CNI to the new cluster {#install-cni}

To provide network functionality for pods in the new cluster, install to it a [container network interface](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/), e.g., [Cilium](https://github.com/cilium/cilium) or [Calico](https://github.com/projectcalico/calico).

To learn more, see this documentation:
* [Cilium Quick Installation](https://docs.cilium.io/en/stable/gettingstarted/k8s-install-default/).
* [Quickstart for Calico on Kubernetes](https://docs.tigera.io/calico/latest/getting-started/kubernetes/quickstart).

## Check the connection between the managing cluster and the new cluster {#check-connection}

1. Connect to the auxiliary VM and make sure that all the pods with the necessary system components have been deployed in the cluster:

    ```bash
    kubectl get pods --all-namespaces
    ```

    Output example:

    ```bash
    NAMESPACE     NAME                                                       READY   STATUS    RESTARTS   AGE
    kube-system   calico-kube-controllers-695bcfd99c-rcc42                   1/1     Running   0          3h55m
    kube-system   calico-node-9qhxj                                          1/1     Running   0          3h55m
    kube-system   coredns-7c65d6cfc9-52tvn                                   1/1     Running   0          4h50m
    kube-system   coredns-7c65d6cfc9-dpgvg                                   1/1     Running   0          4h50m
    kube-system   etcd-capy-cluster-control-plane-p646q                      1/1     Running   0          4h50m
    kube-system   kube-apiserver-capy-cluster-control-plane-p646q            1/1     Running   0          4h50m
    kube-system   kube-controller-manager-capy-cluster-control-plane-p646q   1/1     Running   0          4h50m
    kube-system   kube-proxy-wb7jr                                           1/1     Running   0          4h50m
    kube-system   kube-scheduler-capy-cluster-control-plane-p646q            1/1     Running   0          4h50m
    kube-system   yandex-cloud-controller-manager-nwhwv                      1/1     Running   0          26s
    ```

1. Use your local computer to check the connection between the managing cluster and the new cluster:

    ```bash
    clusterctl describe cluster <name_of_new_cluster>
    ```

    Result:

    ```bash
    NAME                                                             READY  SEVERITY  REASON  SINCE  MESSAGE                                  
    Cluster/capy-cluster                                             True                     10s
    ├─ClusterInfrastructure - YandexCluster/capy-cluster                                   
    └─ControlPlane - KubeadmControlPlane/capy-cluster-control-plane  True                     10s                                                                                       
      └─3 Machines...                                                True                     3m9s   See capy-cluster-control-plane-cf72l, capy-cluster-control-plane-g9jw7, ...
    ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. Delete the {{ k8s }} cluster created using the Cluster API:

    ```bash
    kubectl delete -f /tmp/capy-cluster.yaml
    ```

1. Delete CRD from the {{ managed-k8s-name }} managing cluster:

    ```bash
    make uninstall
    ```

1. Delete the {{ yandex-cloud }} provider controller from the managing cluster:

    ```bash
    make undeploy
    ```

1. Delete the auxiliary {{ yandex-cloud }} resources if you had created them:
    * [Node group](../../managed-kubernetes/operations/node-group/node-group-delete.md) of the {{ managed-k8s-name }} managing cluster
    * {{ managed-k8s-name }} [managing cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md)
    * [Auxiliary VM](../../compute/operations/vm-control/vm-delete.md)
    * [NAT gateway](../../vpc/operations/delete-nat-gateway.md)
    * [OS image](../../compute/operations/image-control/delete.md) in {{ compute-name }}
    * [OS image](../../storage/operations/objects/delete.md) in {{ objstorage-name }}
    * [Bucket](../../storage/operations/buckets/delete.md)
    * [Docker image](../../container-registry/operations/docker-image/docker-image-delete.md)
    * [Registry](../../container-registry/operations/registry/registry-delete.md)