# Creating an ACME resolver webhook for responses to DNS01 challenges


Install the [cert-manager](https://cert-manager.io/docs/) application with the DNS01 webhook resolver to automatically pass [domain ownership](../../certificate-manager/concepts/challenges.md) checks for domains registered in {{ dns-full-name }}.

To run a webhook in a {{ managed-k8s-name }} cluster:

1. [Set up the {{ managed-k8s-name }} cluster](#before-managed-kubernetes).
1. [Install and run a webhook in a {{ managed-k8s-name }} cluster](#yandex-webhook).
1. [Test the webhook](#check-yandex-webhook).
1. [Delete the resources you created](#clear-out).

{% note info %}

The certificate manager with the ACME webhook for {{ dns-full-name }} supports [Wildcard certificates](https://en.wikipedia.org/wiki/Public_key_certificate#Wildcard_certificate).

{% endnote %}

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The support cost for this solution includes:

* Fee for using the master and outgoing traffic in a {{ managed-k8s-name }} cluster (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for using computing resources, OS, and storage in cluster nodes (VMs) (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for a public IP address for the cluster nodes (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).


## Set up your environment {#prepare-environment}

1. {% include [cli-install](../../_includes/cli-install.md) %}
1. Install [kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl/), which is the command line interface for {{ k8s }}.
1. Make sure you have enough [resources available in the cloud](../../resource-manager/concepts/limits.md).
1. If you do not have a [network](../../vpc/concepts/network.md#network) yet, [create one](../../vpc/operations/network-create.md).
1. If you do not have any [subnets](../../vpc/concepts/network.md#subnet) yet, [create them](../../vpc/operations/subnet-create.md) in the [availability zones](../../overview/concepts/geo-scope.md) where the new {{ managed-k8s-name }} cluster and node group will reside.
1. [Create these service accounts](../../iam/operations/sa/create.md):

   * `sa-kubernetes` with the following [roles](../../managed-kubernetes/security/index.md#yc-api):

     * `{{ roles.k8s.clusters.agent }}` and `{{ roles-vpc-public-admin }}` for the folder where you will create the {{ managed-k8s-name }} cluster.
     * `{{ roles-cr-puller }}` for the folder containing a Docker image [registry](../../container-registry/concepts/registry.md).

     This service account will be used to create the resources your cluster needs, and {{ managed-k8s-name }} nodes will pull the required [Docker images](../../container-registry/concepts/docker-image.md) from the registry.

   * `sa-dns-editor` with the `dns.editor` role for the folder containing the [public zone](../../dns/concepts/dns-zone.md#public-zones). This service account will be used to create DNS [resource records](../../dns/concepts/resource-record.md).

1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. {% include [configure-cert-manager](../../_includes/managed-kubernetes/security-groups/configure-cert-manager.md) %}

## Prepare your {{ managed-k8s-name }} cluster {#before-managed-kubernetes}

### Create a {{ managed-k8s-name }} cluster {#kubernetes-cluster-create}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a {{ managed-k8s-name }} cluster.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click **{{ ui-key.yacloud.k8s.clusters.button_create }}**.
  1. Enter the name for the cluster: `kubernetes-cluster-wh`.
  1. **{{ ui-key.yacloud.k8s.clusters.create.field_service-account }}**: Specify the `sa-kubernetes` service account that will be used to create resources.
  1. **{{ ui-key.yacloud.k8s.clusters.create.field_node-service-account }}**: Specify the `sa-kubernetes` service account the {{ managed-k8s-name }} nodes will use to access the Docker image registry.
  1. Specify the [release channel](../../managed-kubernetes/concepts/release-channels-and-updates.md). You will not be able to edit this setting once you create the {{ managed-k8s-name }} cluster.
  1. Under **{{ ui-key.yacloud.k8s.clusters.create.section_main-cluster }}**:
     * **{{ ui-key.yacloud.k8s.clusters.create.field_master-version }}**: Select the {{ k8s }} version to install on the [{{ managed-k8s-name }} master](../../managed-kubernetes/concepts/index.md#master). It must match the {{ k8s }} command line version.
     * **{{ ui-key.yacloud.k8s.clusters.create.field_address-type }}**: Select the [IP address](../../vpc/concepts/address.md) assignment method:
       * `{{ ui-key.yacloud.k8s.clusters.create.switch_auto }}`: Assign a random IP address from the {{ yandex-cloud }} IP address pool.
     * **{{ ui-key.yacloud.k8s.clusters.create.field_master-type }}**: Select the master type:
       * `{{ ui-key.yacloud.k8s.clusters.create.option_master-type-basic }}`: To create a single master host in the selected availability zone. Specify the cloud network and select the subnet for the master host.
       * `{{ ui-key.yacloud.k8s.clusters.create.option_master-type-highly-available }}`: To create a single master host in each availability zone. Specify the cloud network and subnet for each availability zone.
     * Select [security groups](../../managed-kubernetes/operations/connect/security-groups.md) for the {{ managed-k8s-name }} cluster's network traffic.
  1. Under **{{ ui-key.yacloud.k8s.clusters.create.section_allocation }}**:
     * **{{ ui-key.yacloud.k8s.clusters.create.field_cluster-cidr }}**: Specify the IP address range to allocate addresses to [pods](../../managed-kubernetes/concepts/index.md#pod) from.
     * **{{ ui-key.yacloud.k8s.clusters.create.field_service-cidr }}**: Specify the IP address range to allocate IP addresses to [services](../../managed-kubernetes/concepts/index.md#service) from.
     * Set the subnet mask for the {{ managed-k8s-name }} nodes and the maximum number of pods per node.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Wait until the cluster status switches to `Running` and its state, to `Healthy`.

{% endlist %}

### Add credentials to the kubectl configuration file {#add-conf}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Run this command:

     ```bash
     yc managed-kubernetes cluster get-credentials kubernetes-cluster-wh --external
     ```

     By default, credentials are added to the `$HOME/.kube/config` directory. If you need to change the configuration location, use the `--kubeconfig <file_path>` parameter.

  1. Check the `kubectl` configuration after adding the credentials:

     ```bash
     kubectl config view
     ```

     Result:

     ```yml
     apiVersion: v1
     clusters:
       - cluster:
         certificate-authority-data: DATA+OMITTED
     ...
     ```

{% endlist %}

### Create a node group {#node-group-create}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you created the required {{ managed-k8s-name }} cluster.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select `kubernetes-cluster-wh`.
  1. On the cluster page, navigate to the ![nodes-management.svg](../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
  1. Click **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create }}**.
  1. Enter a name and description for the {{ managed-k8s-name }} node group.
  1. In the **{{ ui-key.yacloud.k8s.node-groups.create.field_node-version }}** field, select the {{ k8s }} version for the {{ managed-k8s-name }} nodes.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_scale }}**, select its type:
     * `{{ ui-key.yacloud.k8s.node-groups.create.value_scale-fixed }}`, to keep a fixed number of nodes in the {{ managed-k8s-name }} group. Specify the number of nodes in the {{ managed-k8s-name }} group.
     * `{{ ui-key.yacloud.k8s.node-groups.create.value_scale-auto }}`, to manage the number of nodes in the {{ managed-k8s-name }} group using [{{ managed-k8s-name }} cluster autoscaling](../../managed-kubernetes/concepts/autoscale.md#ca).
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_deploy }}**, specify the maximum number of [VMs](../../compute/concepts/vm.md) by which you can exceed or reduce the {{ managed-k8s-name }} group size.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
     * Select a [platform](../../compute/concepts/vm-platforms.md).
     * Specify the required number of vCPUs, [guaranteed vCPU performance](../../compute/concepts/performance-levels.md), and the amount of RAM.

  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_disk }}**:
     * Specify the **{{ ui-key.yacloud.k8s.node-groups.create.field_disk-type }}** for the {{ managed-k8s-name }} group nodes:
       * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-hdd }}`: Standard network drive; HDD network block storage.
       * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd }}`: Fast network drive; SSD network block storage.
       * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-nonreplicated }}`: Network drive with enhanced performance achieved by eliminating redundancy. You can only change the size of this disk type in 93 GB increments.
       * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-io-m3 }}`: Network drive with the same performance specifications as `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-nonreplicated }}`, plus redundancy. You can only change the size of this disk type in 93 GB increments.

       For more information about disk types, see [this {{ compute-full-name }} guide](../../compute/concepts/disk.md#disks_types).
     * Specify the disk size for the {{ managed-k8s-name }} group nodes.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_network }}**:
     * In the **{{ ui-key.yacloud.k8s.node-groups.create.field_address-type }}** field, select an IP address assignment method:
       * `{{ ui-key.yacloud.k8s.node-groups.create.switch_auto }}`: Assign a random IP address from the {{ yandex-cloud }} IP address pool.
     * Select [security groups](../../managed-kubernetes/operations/connect/security-groups.md).
     * Select the availability zone and subnet to place the {{ managed-k8s-name }} group nodes in.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_access }}**, specify the access credentials for the {{ managed-k8s-name }} group nodes over SSH:
     * **{{ ui-key.yacloud.compute.instances.create.field_user }}**: Enter the username.
     * **{{ ui-key.yacloud.compute.instances.create.field_key }}**: Paste the contents of the [public key](../../managed-kubernetes/operations/node-connect-ssh.md#creating-ssh-keys) file.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Wait until the node group status switches to `Running`.

{% endlist %}

## Install and run a webhook in a {{ managed-k8s-name }} cluster {#yandex-webhook}

1. Clone the webhook repository with the certificate manager configured to issue Let's Encrypt certificates:

   ```bash
   git clone https://github.com/yandex-cloud/cert-manager-webhook-yandex.git
   ```

1. [Install Helm](https://helm.sh/docs/intro/install/) to manage packages in your {{ k8s }} cluster.
1. Install the webhook using Helm:

   ```bash
   helm install \
     --namespace cert-manager \
     --create-namespace \
     yandex-webhook ./cert-manager-webhook-yandex/deploy/cert-manager-webhook-yandex
   ```

1. Make sure the webhook is running:

   ```bash
   kubectl get pods -n cert-manager --watch
   ```

   Make sure the records contain the ACME webhook for {{ dns-full-name }}:

   ```text
   NAME                                                          READY   STATUS    RESTARTS   AGE
   ... 
   yandex-webhook-cert-manager-webhook-yandex-55********-tw4mq   1/1     Running   1          43m
   ```

## Test the webhook {#check-yandex-webhook}

### Prepare configuration files {#prepare-files}

1. Create an [authorized key](../../iam/concepts/authorization/key.md) for the `sa-dns-editor` service account and save it to the `iamkey.json` file:

   ```bash
   yc iam key create iamkey \
     --service-account-id=<service_account_ID> \
     --format=json \
     --output=iamkey.json
   ```

1. Create a secret with the service account key:

   ```bash
   kubectl create secret generic cert-manager-secret --from-file=iamkey.json -n cert-manager
   ```

1. Create the `cluster-issuer.yml` file with the `ClusterIssuer` object manifest that uses the DNS01 webhook resolver for the {{ dns-name }} domain:

   ```yml
   apiVersion: cert-manager.io/v1
   kind: ClusterIssuer
   metadata:
    name: clusterissuer
    namespace: default
   spec:
    acme:
     email: <email_address_for_notifications_from_Lets_Encrypt>
     server: https://acme-v02.api.letsencrypt.org/directory
     privateKeySecretRef:
      name: secret-ref
     solvers:
      - dns01:
         webhook:
           config:
             folder: <ID_of_folder_with_public_zone>
             serviceAccountSecretRef:
               name: cert-manager-secret
               key: iamkey.json
           groupName: acme.cloud.yandex.com
           solverName: yandex-cloud-dns
   ```

1. Create the `cluster-certificate.yml` file with the `Certificate` object manifest:

   ```yml
   apiVersion: cert-manager.io/v1
   kind: Certificate
   metadata:
    name: your-site
    namespace: default
   spec:
    secretName: your-site-secret
    issuerRef:
     name: clusterissuer
     kind: ClusterIssuer
    dnsNames:
      - <domain_name>
   ```

### Issue a certificate using the webhook {#run-webhook}

1. Create the objects in the {{ k8s }} cluster:

   ```bash
   kubectl apply -f cluster-issuer.yml && \
   kubectl apply -f cluster-certificate.yml
   ```

1. Check the certificate status:

   ```bash
   kubectl get certificate
   ```

   Result:

   ```text
   NAME        READY  SECRET            AGE
   your-site   True   your-site-secret  45m
   ```

    The `True` status in the `READY` column means that the certificate was issued successfully.

## Delete the resources you created {#clear-out}

If you no longer need the resources you created, [delete](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) the {{ managed-k8s-name }} cluster.
