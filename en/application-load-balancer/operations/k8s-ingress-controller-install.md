# Installing a {{ alb-name }} Ingress controller for {{ managed-k8s-name }}

The [{{ alb-name }} Ingress controller for {{ managed-k8s-full-name }}](../tools/k8s-ingress-controller/index.md) is provided via [Helm]{% if lang == "ru" %}(https://helm.sh/ru/){% else %}(https://helm.sh/){% endif %}, a {{ k8s }} package manager.

## Before you begin {#prerequisites}

1. {% include [cli-install](../../_includes/cli-install.md) %}

1. {% include [helm-install](../../_includes/managed-kubernetes/helm-install.md) %}

1. [Create a service account](../../iam/operations/sa/create.md) to enable Ingress controller operation.
1. Using the CLI, [generate an authorized service account key](../../iam/operations/sa/create-access-key.md) and save it to `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name <service account name> \
     --output sa-key.json
   ```

1. {% include [k8s-ingress-controller-create-cluster](../../_includes/application-load-balancer/k8s-ingress-controller-create-cluster.md) %}

1. {% include [k8s-ingress-controller-create-node-group](../../_includes/application-load-balancer/k8s-ingress-controller-create-node-group.md) %}

1. [Create a namespace](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-namespace-create.md) in your cluster.

## Installation {#install}

1. Enable [experimental OCI support](https://helm.sh/docs/topics/registries/) (Open Container Initiative) for Helm:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1
   ```

1. Authenticate the Helm client to the {{ container-registry-full-name }} registry using the authorized service account key:

   ```bash
   cat sa-key.json | helm registry login {{ registry }} --username 'json_key' --password-stdin
   ```

1. Download the Ingress controller chart from the registry and unpack:

   ```bash
   helm pull \
     --version v{{ alb-ingress-version }} \
     oci://{{ registry }}/yc/yc-alb-ingress-controller-chart
   ```

   {% note info %}

   If the command returns an error saying `manifest does not contain a layer with mediatype application/tar+gzip`, make sure you [installed the Helm package manager](https://helm.sh/ru/docs/intro/install/) with version {{ alb-ingress-helm-version }} or higher. To find out the version of the installed manager, [run the command](https://helm.sh/docs/helm/helm_version/): `helm version`.

   {% endnote %}

1. Install the chart in the cluster:

   ```bash
   helm install \
     --namespace <namespace name> \
     --set folderId=<folder ID> \
     --set clusterId=<cluster ID> \
     --set-file saKeySecretKey=sa-key.json \
     yc-alb-ingress-controller ./yc-alb-ingress-controller-chart-v{{ alb-ingress-version }}.tgz
   ```

   Where:
   * `--namespace`: name of namespace created prior to installation.
   * `--set` and `--set-file` set [values for the chart](https://helm.sh/docs/topics/charts/#templates-and-values) either directly or from a file:
      * `folderId`: ID of {{ yandex-cloud }} folder where a {{ managed-k8s-name }} cluster is created. You can retrieve the ID by following [instructions](../../resource-manager/operations/folder/get-id.md) in the {{ resmgr-full-name }} documentation.
      * `clusterId`: Cluster ID. You can retrieve the ID by following [instructions](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md).
      * `saKeySecretKey`: Authorized service account key created prior to the installation.
   * The first argument (`yc-alb-ingress-controller`) is the name of the chart to install.
   * The second argument (`./yc-alb-ingress-controller-chart-v{{ alb-ingress-version }}.tgz`) is the path to the downloaded chart (`./` points to the current directory).