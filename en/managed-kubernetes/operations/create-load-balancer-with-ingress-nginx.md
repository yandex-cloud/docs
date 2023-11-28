# Creating a network load balancer using an NGINX Ingress controller

When installing an [NGINX Ingress controller](https://kubernetes.github.io/ingress-nginx/), you can create both [external](../../network-load-balancer/concepts/index.md) and [internal network load balancers](../../network-load-balancer/concepts/nlb-types.md).

## Getting started {#before-you-begin}

1. [Create a service account](../../iam/operations/sa/create.md) with the `editor`, `container-registry.images.puller`, and `load-balancer.admin` [roles](../../iam/concepts/access-control/roles.md) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). The `load-balancer.admin` role is required to create a [network load balancer](../../network-load-balancer/concepts/index.md).
1. [Create a {{ managed-k8s-name }} cluster](kubernetes-cluster/kubernetes-cluster-create.md). In the cluster settings, specify the service account you created earlier.
1. {% include [Install Helm](../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}
1. Add a repository for NGINX to Helm:

   ```bash
   helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
   ```

   Result:

   ```text
   "ingress-nginx" has been added to your repositories
   ```

1. Update the dataset to create an application instance in the [{{ managed-k8s-name }} cluster](../concepts/index.md#kubernetes-cluster):

   ```bash
   helm repo update
   ```

   Result:

   ```text
   Hang tight while we grab the latest from your chart repositories...
   ...Successfully got an update from the "ingress-nginx" chart repository
   Update Complete. ⎈Happy Helming!⎈
   ```

## External network load balancer {#external}

An external network load balancer is created when installing an NGINX Ingress controller in a standard configuration:

```bash
helm install ingress-nginx ingress-nginx/ingress-nginx
```

Result:

```text
NAME: ingress-nginx
LAST DEPLOYED: Sun Jul 18 22:35:37 2022
NAMESPACE: default
...
The ingress-nginx controller has been installed.
It may take a few minutes for the LoadBalancer IP to be available.
You can watch the status by running 'kubectl --namespace default get services -o wide -w ingress-nginx-controller'
...
```

## Internal network load balancer {#internal}

To install an internal network load balancer:
1. [Configure the controller](https://github.com/kubernetes/ingress-nginx/blob/main/charts/ingress-nginx/values.yaml). To do this, create a `values.yaml` configuration file and specify there the ID of the [subnet](../../vpc/concepts/network.md#subnet) the network load balancer should run in:

   ```yaml
   controller:
     service:
       external:
         enabled: false
       internal:
         enabled: true
         annotations:
           yandex.cloud/load-balancer-type: internal
           yandex.cloud/subnet-id: <subnet_ID>
   ```

1. Install the NGINX Ingress controller using the `values.yaml` configuration file:

   ```bash
   helm install ingress-nginx -f values.yaml ingress-nginx/ingress-nginx
   ```

   Result:

   ```text
   NAME: ingress-nginx
   LAST DEPLOYED: Sun Jul 18 22:55:37 2022
   NAMESPACE: default
   ...
   The ingress-nginx controller has been installed.
   It may take a few minutes for the LoadBalancer IP to be available.
   You can watch the status by running 'kubectl --namespace default get services -o wide -w ingress-nginx-controller'
   ...
   ```

## Check the result {#check-result}

To make sure the required network load balancer is created, get a [list of network load balancers in the folder](../../network-load-balancer/operations/load-balancer-list.md#list).