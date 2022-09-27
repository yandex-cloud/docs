# Horizontal application scaling in a cluster

{{ managed-k8s-name }} supports several types of [autoscaling](../concepts/autoscale.md). In this article, you will learn to configure [cluster](../concepts/index.md#kubernetes-cluster) autoscaling using a combination of {{ k8s-ca }} and {{ k8s-hpa }}.
* [{#T}](#cpu-autoscaling).
* [{#T}](#rps-autoscaling).

{% note warning %}

While running, the total number of [group nodes](../concepts/index.md#node-group) may increase to 6. Make sure you have sufficient [folder resources](../concepts/limits.md) to perform the instructions in this tutorial.

{% endnote %}

## Before you begin {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Install the Helm package manager](https://helm.sh/docs/intro/install/).

1. [Create service accounts](../../iam/operations/sa/create.md) for the [master](../concepts/index.md#master) and node groups and [assign them roles](../../iam/operations/sa/assign-role-for-sa.md).
   * The `sa-k8s-master` service account for managing clusters:
     * `k8s.clusters.agent`: For managing {{ k8s }} clusters.
     * `load-balancer.admin`: For managing the [network load balancer](../../network-load-balancer/).
   * The `sa-k8s-nodes` service account to manage a group of nodes:
     * `container-registry.images.puller`: For pulling images from [{{ container-registry-full-name }}](../../container-registry/).
1. [Create a network](../../vpc/quickstart.md) named `k8s-network` to host your cluster. When creating your network, select the **Create subnets** option.
1. [Create security groups](../operations/connect/security-groups.md) for the master and the nodes:
   * `sg-k8s`: For [master and node group](../operations/connect/security-groups.md#rules-internal).
   * `k8s-public-services`: For providing [public access to services from the Internet](../operations/connect/security-groups.md#rules-nodes).
   * `k8s-master-whitelist`: For [accessing the {{ k8s }} API](../operations/connect/security-groups.md#rules-master).
1. [Create an encryption key](../../kms/operations/key.md#create):
   * **Key name**: `k8s-symetric-key`.
   * **Encryption algorithm**: `AES-128`.
   * **Rotation period**: 365 days.
1. [Create a {{ managed-k8s-name }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md) with the following settings:
   * **Resource service account**: `sa-k8s-master`.
   * **Node service account**: `sa-k8s-nodes`.
   * **Encryption key**: `k8s-symetric-key`.
   * **Release channel**: `RAPID`.
   * **{{ k8s }} version**: `1.20`.
   * **Public address**: `Auto`.
   * **Master type**: `Regional`.
   * **Cloud network**: `k8s-network`.
   * **Security groups**: `sg-k8s`, `k8s-master-whitelist`.
   * **Enable tunneling mode**: Enabled.
1. [Create two groups of nodes](../operations/node-group/node-group-create.md) with the following settings in the `{{ region-id }}-a` and the `{{ region-id }}-b` availability zones:
   * **{{ k8s }} version**: `1.20`.
   * In the **Scalability** section:
     * **Type**: `Automatic`.
     * **Minimum nodes**: `1`.
     * **Maximum nodes**: `3`.
     * **Initial nodes**: `1`.
   * Under **Network settings**:
     * **Public address**: `Auto`.
     * **Security groups**: `sg-k8s`, `k8s-public-services`.
     * **Location**: `{{ region-id }}-a` or `{{ region-id }}-b`.
1. {% include [install kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Scaling based on CPU utilization {#cpu-autoscaling}

In this section, you will learn to configure cluster autoscaling based on CPU load.
1. Create a file named `k8s-autoscale-CPU.yaml` containing the settings for a test application, a load balancer, and [{{ k8s-hpa }}](../concepts/autoscale.md#hpa):

   {% cut "k8s-autoscale-CPU.yaml" %}

   ```yaml
   ---
   ### Deployment
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: nginx
     labels:
       app: nginx
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: nginx
     template:
       metadata:
         name: nginx
         labels:
           app: nginx
       spec:
         containers:
           - name: nginx
             image: k8s.gcr.io/hpa-example
             resources:
               requests:
                 memory: "256Mi"
                 cpu: "500m"
               limits:
                 memory: "500Mi"
                 cpu: "1"
   ---
   ### Service
   apiVersion: v1
   kind: Service
   metadata:
     name: nginx
   spec:
     selector:
       app: nginx
     ports:
       - protocol: TCP
         port: 80
         targetPort: 80
     type: LoadBalancer
   ---
   ### HPA
   apiVersion: autoscaling/v1
   kind: HorizontalPodAutoscaler
   metadata:
     name: nginx
   spec:
     scaleTargetRef:
       apiVersion: apps/v1
       kind: Deployment
       name: nginx
     minReplicas: 1
     maxReplicas: 10
     targetCPUUtilizationPercentage: 20
   ```

   {% endcut %}

1. Create objects:

   ```bash
   kubectl apply -f k8s-autoscale-CPU.yaml
   ```

1. In a separate window, launch {{ k8s }} component load tracking:

   ```bash
   watch kubectl get pod,svc,hpa,nodes -o wide
   ```

1. Run a process to simulate a workload:

   ```bash
   URL=$(kubectl get service nginx -o json \
     | jq -r '.status.loadBalancer.ingress[0].ip') && \
     while true; do wget -q -O- http://$URL; done
   ```

{% note tip %}

To increase load and accelerate scenario progress, run several processes in separate windows.

{% endnote %}

In the span of several minutes, {{ k8s-hpa }} will increase the number of pods on the nodes as a result of CPU usage. When existing cluster resources become insufficient to satisfy the `requests` value, {{ k8s-ca}} will increase the number of nodes in the groups.
1. Stop simulating the workload. Over the next few minutes, the number of nodes and pods will drop back to the initial state.

## Scaling based on application requests {#rps-autoscaling}

In this section, you will learn to configure cluster autoscaling based on the number of application requests (_Requests Per Second, RPS_).

### Runtime algorithm {#how-it-works}

1. An Ingress controller transmits information on the number of application requests to the [Prometheus monitoring system](https://prometheus.io/).
1. Prometheus generates and publishes the `nginx_ingress_controller_requests_per_second` metric for the number of application requests per second.

   To create this metric, the following rule has been added to the Prometheus configuration file called `values-prom.yaml`:

   ```yaml
   rules:
     groups:
       - name: Ingress
         rules:
           - record: nginx_ingress_controller_requests_per_second
             expr: rate(nginx_ingress_controller_requests[2m])
   ```

1. Based on this metric, the [autoscaling tools](../concepts/autoscale.md) update the number of pods and nodes.

### Installing objects {#create-objects}

1. Clone the GitHub repository containing the up-to-date configuration files:

   ```bash
   git clone https://github.com/yandex-cloud/yc-architect-solution-library.git && \
     cd yc-architect-solution-library/demos/yc-k8s-autoscaling
   ```

1. Add the Helm repositories with the Ingress controller and the Prometheus monitoring system:

   ```bash
   helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx && \
     helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && \
     helm repo update
   ```

1. Install the Ingress controller:

   ```bash
   helm upgrade \
     --install rps ingress-nginx/ingress-nginx \
     --values values-ingr.yaml
   ```

1. Install Prometheus:

   ```bash
   helm upgrade \
     --install prometheus prometheus-community/prometheus \
     --values values-prom.yaml
   ```

1. Install a [Prometheus adapter](https://github.com/kubernetes-sigs/prometheus-adapter) that will deliver Prometheus metrics to the autoscaling tools:

   ```bash
   helm upgrade \
     --install prometheus-adapter prometheus-community/prometheus-adapter \
     --values values-prom-ad.yaml
   ```

1. Create a test application, an Ingress rule, and [{{ k8s-hpa }}](../concepts/autoscale.md#hpa):

   ```bash
   kubectl apply -f k8s_autoscale-RPS.yaml
   ```

   Once objects are created, Prometheus will add a new metric called `nginx_ingress_controller_requests_per_second`. Prometheus will not start computing this metric until after traffic passes through the Ingress controller.
1. Make a few test requests against the Ingress controller:

   ```bash
   URL=$(kubectl get service rps-ingress-nginx-controller -o json \
     | jq -r '.status.loadBalancer.ingress[0].ip') && \
     curl -H "Host: nginx.example.com" http://$URL
   ```

1. Make sure that the `nginx_ingress_controller_requests_per_second` metric is available:

   ```bash
   kubectl get --raw /apis/custom.metrics.k8s.io/v1beta1 | jq . | \
     grep ingresses.networking.k8s.io/nginx_ingress_controller_requests_per_second
   ```

   Result:

   ```text
   "name": "ingresses.networking.k8s.io/nginx_ingress_controller_requests_per_second",
   ```

### Testing autoscaling {#test-rps-autoscaling}

1. In a separate window, launch {{ k8s }} component load tracking:

   ```bash
   watch kubectl get pod,svc,hpa,nodes -o wide
   ```

1. Run a process to simulate workload:

   ```bash
   URL=$(kubectl get service rps-ingress-nginx-controller -o json \
     | jq -r '.status.loadBalancer.ingress[0].ip') && \
     while true; do curl -H "Host: nginx.example.com" http://$URL; done
   ```

   Over the next several minutes, {{ k8s-hpa }} will increase the number of pods on the nodes as a result of an increased number of application requests. When existing cluster resources become insufficient to satisfy the `requests` value, {{ k8s-ca }} will increase the number of nodes in the groups.
1. Stop simulating the workload. Over the next few minutes, the number of nodes and pods will drop back to the initial state.

## Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:
1. [Delete a {{ k8s }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. If static public IP addresses were used for cluster and node access, release and [delete](../../vpc/operations/address-delete.md) them.