# Creating an ACME resolver webhook for responses to DNS01 checks


To pass checks for [domain rights](../../certificate-manager/concepts/challenges.md) automatically using the [cert-manager](https://cert-manager.io/docs/) utility, add a webhook with a DNS01 resolver to the utility configuration.

Below, we have an example of creating a `ClusterIssuer` object with a DNS01 resolver webhook for a domain registered in {{ dns-full-name }}.

To run a webhook in a {{ managed-k8s-name }} cluster:

1. [Set up the {{ managed-k8s-name }} cluster](#before-managed-kubernetes).
1. [Install the latest version of the certificate manager](#install-certs-manager).
1. [Install the Helm package manager](#helm-install).
1. [Install and run a webhook in a {{ managed-k8s-name }} cluster](#yandex-webhook).
1. [Delete the resources you created](#clear-out).

{% note info %}

The certificate manager with the ACME webhook for {{ dns-full-name }} supports [Wildcard certificates](https://en.wikipedia.org/wiki/Public_key_certificate#Wildcard_certificate).

{% endnote %}

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

## Prepare the environment {#prepare-environment}

1. {% include [cli-install](../../_includes/cli-install.md) %}
1. Install [kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl/), which is the command line interface for {{ k8s }}.
1. Make sure you have enough [resources available in the cloud](../../resource-manager/concepts/limits.md).
1. If you do not have a [network](../../vpc/concepts/network.md#network) yet, [create one](../../vpc/operations/network-create.md).
1. If you do not have any [subnets](../../vpc/concepts/network.md#subnet) yet, [create them](../../vpc/operations/subnet-create.md) in the [availability zones](../../overview/concepts/geo-scope.md) where your {{ managed-k8s-name }} cluster and node group will be created.
1. [Create service accounts](../../iam/operations/sa/create.md):

   * `sa-kubernetes` with the following [roles](../../managed-kubernetes/security/index.md#yc-api):
     
     * `{{ roles.k8s.clusters.agent }}` and `{{ roles-vpc-public-admin }}` for the folder where the {{ managed-k8s-name }} is created.
     * `{{ roles-cr-puller }}` for the folder containing a Docker image [registry](../../container-registry/concepts/registry.md).

     On behalf of this service account, resources your cluster needs will be created and {{ managed-k8s-name }} nodes will pull the required [Docker images](../../container-registry/concepts/docker-image.md) from the registry.

   * `sa-dns-editor` with the `dns.editor` role for the folder containing the [public zone](../../dns/concepts/dns-zone.md#public-zones). This service account will be used to create DNS [resource records](../../dns/concepts/resource-record.md).

## Prepare your {{ managed-k8s-name }} cluster {#before-managed-kubernetes}

### Create a {{ managed-k8s-name }} cluster {#kubernetes-cluster-create}

To create a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a {{ managed-k8s-name }} cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Click **{{ ui-key.yacloud.k8s.clusters.button_create }}**.
  1. Enter the name for the cluster: `kubernetes-cluster-wh`.
  1. **{{ ui-key.yacloud.k8s.clusters.create.field_service-account }}**: Specify the `sa-kubernetes` service account that will be used to create resources.
  1. **{{ ui-key.yacloud.k8s.clusters.create.field_node-service-account }}**: Specify the `sa-kubernetes` service account the {{ managed-k8s-name }} nodes will use to access the Docker image registry.
  1. Specify a [release channel](../../managed-kubernetes/concepts/release-channels-and-updates.md). You will not be able to edit this setting once you create a {{ managed-k8s-name }} cluster.
  1. Under **{{ ui-key.yacloud.k8s.clusters.create.section_main-cluster }}**:
     * **{{ ui-key.yacloud.k8s.clusters.create.field_master-version }}**: Select a {{ k8s }} version to install on the [{{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#master) master. It must match the {{ k8s }} command line version.
     * **{{ ui-key.yacloud.k8s.clusters.create.field_address-type }}**: Select the [IP address](../../vpc/concepts/address.md) assignment method:
       * `{{ ui-key.yacloud.k8s.clusters.create.switch_auto }}`: Assign a random IP address from the {{ yandex-cloud }} IP pool.
     * **{{ ui-key.yacloud.k8s.clusters.create.field_master-type }}**: Select the master type:
       * `{{ ui-key.yacloud.k8s.clusters.create.switch_zone }}`: To create a single master host in the selected availability zone. Specify a cloud network and select a subnet for the master host.
       * `{{ ui-key.yacloud.k8s.clusters.create.switch_region }}`: To create a single master host in each availability zone. Specify a cloud network and subnet for each availability zone.
     * Select [security groups](../../managed-kubernetes/operations/connect/security-groups.md) for the {{ managed-k8s-name }} cluster's network traffic.
  1. Under **{{ ui-key.yacloud.k8s.clusters.create.section_allocation }}**:
     * **{{ ui-key.yacloud.k8s.clusters.create.field_cluster-cidr }}**: Specify an IP range to allocate addresses to [pods](../../managed-kubernetes/concepts/index.md#pod) from.
     * **{{ ui-key.yacloud.k8s.clusters.create.field_service-cidr }}**: Specify an IP range to allocate IP addresses to [services](../../managed-kubernetes/concepts/index.md#service) from.
     * Set the {{ managed-k8s-name }} node subnet mask and the maximum number of pods per node.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Wait for the cluster status to change to `Running` and its state to `Healthy`.

{% endlist %}

### Add credentials to the `kubectl` configuration file {#add-conf}

To add {{ managed-k8s-name }} cluster credentials to the `kubectl` configuration file:

{% list tabs group=instructions %}

- CLI {#cli}

  1. Run this command:

     ```bash
     yc managed-kubernetes cluster get-credentials kubernetes-cluster-wh --external
     ```

     By default, credentials are added to the `$HOME/.kube/config` directory. If you need to change the configuration location, use `--kubeconfig <file_path>`.

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

To [create a {{ managed-k8s-name }} node group](../../managed-kubernetes/operations/node-group/node-group-create.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the required {{ managed-k8s-name }} cluster was created.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Select the `kubernetes-cluster-wh` cluster.
  1. On the cluster page, go to the ![nodes-management.svg](../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}** tab.
  1. Click **{{ ui-key.yacloud.k8s.cluster.node-groups.button_create }}**.
  1. Enter a name and description for the {{ managed-k8s-name }} node group.
  1. In the **{{ ui-key.yacloud.k8s.node-groups.create.field_node-version }}** field, select a {{ k8s }} version for {{ managed-k8s-name }} nodes.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_scale }}**, select its type:
     * `{{ ui-key.yacloud.k8s.node-groups.create.value_scale-fixed }}`, to keep the number of nodes in the {{ managed-k8s-name }} group constant. Specify the number of nodes in the {{ managed-k8s-name }} group.
     * `{{ ui-key.yacloud.k8s.node-groups.create.value_scale-auto }}`, to control the number of nodes in the {{ managed-k8s-name }} group via [{{ managed-k8s-name }}](../../managed-kubernetes/concepts/autoscale.md#ca) cluster autoscaling.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_deploy }}**, specify the maximum number of [instances](../../compute/concepts/vm.md) by which you can exceed or reduce the size of the {{ managed-k8s-name }} group.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
     * Select a [platform](../../compute/concepts/vm-platforms.md).
     * Specify the required number of vCPUs, [guaranteed vCPU performance](../../compute/concepts/performance-levels.md), and the amount of RAM.

  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_disk }}**:
     * Specify the **{{ ui-key.yacloud.k8s.node-groups.create.field_disk-type }}** for the {{ managed-k8s-name }} group nodes:
       * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-hdd }}`: Standard network drive; HDD network block storage.
       * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd }}`: Fast network drive; SSD network block storage.
       * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-nonreplicated }}`: Network drive with enhanced performance achieved by eliminating redundancy. You can only change the size of this type of disk in 93 GB increments.
       * `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-io-m3 }}`: Network drive with the same performance characteristics as `{{ ui-key.yacloud.k8s.node-group.overview.label_network-ssd-nonreplicated }}`, plus redundancy. You can only change the size of this type of disk in 93 GB increments.

       For more information about disk types, see the [{{ compute-full-name }}](../../compute/concepts/disk.md#disks_types) documentation.
     * Specify the disk size for the {{ managed-k8s-name }} group nodes.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_network }}**:
     * In the **{{ ui-key.yacloud.k8s.node-groups.create.field_address-type }}** field, select a method for assigning an IP address:
       * `{{ ui-key.yacloud.k8s.node-groups.create.switch_auto }}`: Assign a random IP address from the {{ yandex-cloud }} IP pool.
     * Select [security groups](../../managed-kubernetes/operations/connect/security-groups.md).
     * Select an availability zone and subnet to deploy the {{ managed-k8s-name }} group nodes in.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_access }}**, specify the information required to access the {{ managed-k8s-name }} group nodes over SSH:
     * **{{ ui-key.yacloud.compute.instances.create.field_user }}**: Enter the username.
     * **{{ ui-key.yacloud.compute.instances.create.field_key }}**: Insert the contents of the [public key](../../managed-kubernetes/operations/node-connect-ssh.md#creating-ssh-keys) file.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Wait for the node group status to change to `Running`.

{% endlist %}

## Install the latest version of the certificate manager {#install-certs-manager}

1. Install the [latest version](https://github.com/cert-manager/cert-manager/releases) of the certificate manager configured to issue Let's Encrypt certificates. For example, run the following command for version 1.21.1:

   ```bash
   kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.1/cert-manager.yaml
   ```

1. Make sure that the `cert-manager` [namespace](../../managed-kubernetes/concepts/index.md#namespace) has three [pods](../../managed-kubernetes/concepts/index.md#pod), all of them being `1/1` ready and with the `Running` status:

   ```bash
   kubectl get pods -n cert-manager --watch
   ```

   Result:

   ```text
   NAME                                      READY  STATUS   RESTARTS  AGE
   cert-manager-69********-ghw6s             1/1    Running  0         54s
   cert-manager-cainjector-76********-gnrzz  1/1    Running  0         55s
   cert-manager-webhook-77********-wz9bh     1/1    Running  0         54s
   ```

## Install the Helm package manager {#helm-install}

[Install Helm](https://helm.sh/docs/intro/install/) to manage packages on your {{ k8s }} cluster.

## Install and run a webhook in a {{ managed-k8s-name }} cluster {#yandex-webhook}

### Install a webhook {#install-yandex-webhook}

1. Clone the webhook's repository:

   ```bash
   git clone https://github.com/yandex-cloud/cert-manager-webhook-yandex.git
   ```

1. Install the webhook using Helm:

   ```bash
   helm install -n cert-manager yandex-webhook ./deploy/cert-manager-webhook-yandex
   ```

### Prepare configuration files {#prepare-files}

1. Create an [authorized key](../../iam/concepts/authorization/key.md) for the `sa-dns-editor` service account and save it to the `iamkey.json` file:

   ```bash
   yc iam key create iamkey \
     --service-account-id=<service_account_ID> \
     --format=json \
     --output=iamkey.json
   ```

1. Create a secret with the key of the service account:

   ```bash
   kubectl create secret generic cert-manager-secret --from-file=iamkey.json -n cert-manager
   ```

1. Create the `cluster-issuer.yml` file with the `ClusterIssuer` object manifest:

   ```yml
   apiVersion: cert-manager.io/v1
   kind: ClusterIssuer
   metadata:
    name: clusterissuer
    namespace: default
   spec:
    acme:
     # You must replace this email address with your own.
     # Let's Encrypt will use this to contact you about expiring
     # certificates, and issues related to your account.
     email: your@email.com
     server: https://acme-v02.api.letsencrypt.org/directory
     privateKeySecretRef:
      # Secret resource that will be used to store the account's private key.
      name: secret-ref
     solvers:
      - dns01:
         webhook:
           config:
             # ID of the folder the dns-zone is located in
             folder: <folder_ID>
             # This is the secret used to access the service account
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
    name: your-site-com
    namespace: default
   spec:
    secretName: example-com-secret
    issuerRef:
     # The issuer created previously
     name: clusterissuer
     kind: ClusterIssuer
    dnsNames:
      - your-site.com
   ```

### Run the certificate manager with the webhook {#run-webhook}

1. Create objects in a {{ k8s }} cluster:

   ```bash
   kubectl apply -f cluster-issuer.yml && \
   kubectl apply -f cluster-certificate.yml
   ```

1. Check that the webhook is running:

   ```bash
   kubectl get pods -n cert-manager --watch
   ```

   Make sure the records contain the ACME webhook for {{ dns-full-name }}:

   ```text
   NAME                                                         READY   STATUS    RESTARTS   AGE
   ... 
   yandex-webhook-cert-manager-webhook-yandex-5578cfb98-tw4mq   1/1     Running   1          43h
   ```

## Delete the resources you created {#clear-out}

If you no longer need the resources you created, [delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
