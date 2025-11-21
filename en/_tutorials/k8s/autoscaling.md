# Horizontal scaling of an application in a cluster


{{ managed-k8s-name }} supports several types of [autoscaling](../../managed-kubernetes/concepts/autoscale.md). In this tutorial, you will learn to configure [cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) autoscaling using a combination of {{ k8s-ca }} and {{ k8s-hpa }}.

* [Scaling based on CPU utilization](#cpu-autoscaling).
* [Scaling based on the number of application requests](#rps-autoscaling).

If you no longer need the resources you created, [delete them](#clear-out).

{% note warning %}

While running, the total number of [group nodes](../../managed-kubernetes/concepts/index.md#node-group) may increase to six. Make sure you have enough [folder resources](../../managed-kubernetes/concepts/limits.md) to follow the steps provided in this tutorial.

{% endnote %}


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* Fee for using the master and outgoing traffic in a {{ managed-k8s-name }} cluster (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for using computing resources, OS, and storage in cluster nodes (VMs) (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for a public IP address for cluster nodes (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).
* {{ kms-name }} fee for the number of active key versions (with `Active` or `Scheduled For Destruction` for status) and completed cryptographic operations (see [{{ kms-name }} pricing](../../kms/pricing.md)).


## Getting started {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Install Helm](https://helm.sh/docs/intro/install/).
1. [Create these service accounts](../../iam/operations/sa/create.md) for the [master](../../managed-kubernetes/concepts/index.md#master) and node groups, and [assign them the listed roles](../../iam/operations/sa/assign-role-for-sa.md):
   * `sa-k8s-master` for cluster management:
     * `k8s.clusters.agent`: To manage a {{ k8s }} cluster.
     * `load-balancer.admin`: To manage a [network load balancer](../../network-load-balancer/).
   * `sa-k8s-nodes` for node group management:
     * `container-registry.images.puller`: To pull images from [{{ container-registry-full-name }}](../../container-registry/).
1. [Create a network](../../vpc/quickstart.md) named `k8s-network` to host your cluster. Select **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** when creating it.

1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. [Create an encryption key](../../kms/operations/key.md#create):
   * **{{ ui-key.yacloud.common.name }}**: `k8s-symetric-key`.
   * **{{ ui-key.yacloud.kms.symmetric-key.form.field_algorithm }}**: `AES-128`.
   * **{{ ui-key.yacloud.kms.symmetric-key.form.field_rotation }}**: `365 days`.
1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) with the following settings:
   * **{{ ui-key.yacloud.k8s.clusters.create.field_service-account }}**: `sa-k8s-master`.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_node-service-account }}**: `sa-k8s-nodes`.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_kms-key }}**: `k8s-symetric-key`.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_release-channel }}**: `RAPID`.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_address-type }}**: `{{ ui-key.yacloud.k8s.clusters.create.switch_auto }}`.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_master-type }}**: `{{ ui-key.yacloud.k8s.clusters.create.option_master-type-highly-available }}`.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_network }}**: `k8s-network`.
   * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: Select the previously created security groups containing the rules for service traffic and {{ k8s }} API access.
   * **{{ ui-key.yacloud.k8s.clusters.create.field_tunnel-mode }}**: `{{ ui-key.yacloud.common.enabled }}`.
1. [Create two node groups](../../managed-kubernetes/operations/node-group/node-group-create.md) with the following settings in the `{{ region-id }}-a` and `{{ region-id }}-b` availability zones:
   * Under **{{ ui-key.yacloud.k8s.node-groups.create.section_scale }}**:
     * **{{ ui-key.yacloud.k8s.node-groups.create.field_scale-type }}**: `{{ ui-key.yacloud.k8s.node-groups.create.value_scale-auto }}`.
     * **{{ ui-key.yacloud.k8s.node-groups.create.field_min-size }}**: `1`.
     * **{{ ui-key.yacloud.k8s.node-groups.create.field_max-size }}**: `3`.
     * **{{ ui-key.yacloud.k8s.node-groups.create.field_initial-size }}**: `1`.
   * Under **{{ ui-key.yacloud.k8s.node-groups.create.section_network }}**:
     * **{{ ui-key.yacloud.k8s.node-groups.create.field_address-type }}**: `{{ ui-key.yacloud.k8s.node-groups.create.switch_auto }}`.
     * **{{ ui-key.yacloud.compute.instances.create.field_security-groups }}**: Select the previously created security groups containing the rules for service traffic, internet access to services, and SSH access to nodes.
     * **{{ ui-key.yacloud.k8s.node-groups.create.field_locations }}**: `{{ region-id }}-a` or `{{ region-id }}-b`.

1. {% include [kubectl-install](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Scaling based on CPU utilization {#cpu-autoscaling}

In this section, you will learn how to configure cluster autoscaling based on CPU load.
1. Create a file named `k8s-autoscale-CPU.yaml` that contains the configuration for the test application, load balancer, and [{{ k8s-hpa }}](../../managed-kubernetes/concepts/autoscale.md#hpa):

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
             image: registry.k8s.io/hpa-example
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

1. Create the objects:

   ```bash
   kubectl apply -f k8s-autoscale-CPU.yaml
   ```

1. In a separate window, start {{ k8s }} component load monitoring:

   ```bash
   watch kubectl get pod,svc,hpa,nodes -o wide
   ```

1. Run the following command to simulate a workload:

   ```bash
   URL=$(kubectl get service nginx -o json \
     | jq -r '.status.loadBalancer.ingress[0].ip') && \
     while true; do wget -q -O- http://$URL; done
   ```

   {% note tip %}

   To increase the load and speed up the scenario, run multiple simulations in separate windows.

   {% endnote %}

    {% include [check-sg-if-url-unavailable-lvl3](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

   Within a few minutes, {{ k8s-hpa }} will increase the number of pods on the nodes due to rising CPU usage. As soon as existing cluster resources become inadequate to satisfy the `requests` value, {{ k8s-ca }} will scale up nodes in the groups.
1. Stop simulating the workload. Over the next few minutes, the number of nodes and pods will drop back to the initial value.

## Scaling based on the number of application requests {#rps-autoscaling}

In this section, you will learn how to configure cluster autoscaling based on the number of application requests (_Requests Per Second, RPS_).

### How it works {#how-it-works}

1. The ingress controller sends information on the number of application requests to [Prometheus](https://prometheus.io/).
1. Prometheus generates and publishes the `nginx_ingress_controller_requests_per_second` metric for the number of application requests per second.

   For creating this metric, the `values-prom.yaml` Prometheus configuration file includes the following rule:

   ```yaml
   rules:
     groups:
       - name: Ingress
         rules:
           - record: nginx_ingress_controller_requests_per_second
             expr: rate(nginx_ingress_controller_requests[2m])
   ```

1. Based on this metric, the [autoscaling tools](../../managed-kubernetes/concepts/autoscale.md) adjust the number of pods and nodes.

### Installing objects {#create-objects}

1. Clone the GitHub repository with the up-to-date configuration files:

   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-mk8s-autoscaling-solution.git && \
   cd yc-mk8s-autoscaling-solution
   ```

1. Add the Helm repositories with the ingress controller and Prometheus monitoring system:

   ```bash
   helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx && \
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && \
   helm repo update
   ```

1. Install the ingress controller:

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

1. Install the [Prometheus adapter](https://github.com/kubernetes-sigs/prometheus-adapter) that enables the autoscaling tools to retrieve metrics from Prometheus:

   ```bash
   helm upgrade \
     --install prometheus-adapter prometheus-community/prometheus-adapter \
     --values values-prom-ad.yaml
   ```

1. Create a test application, Ingress rule, and [{{ k8s-hpa }}](../../managed-kubernetes/concepts/autoscale.md#hpa):

   ```bash
   kubectl apply -f k8s_autoscale-RPS.yaml
   ```

   Once these objects are created, Prometheus will add a new metric called `nginx_ingress_controller_requests_per_second`. Prometheus will start monitoring that metric only after traffic goes through the ingress controller.
1. Send several test requests to the ingress controller:

   ```bash
   URL=$(kubectl get service rps-ingress-nginx-controller -o json \
     | jq -r '.status.loadBalancer.ingress[0].ip') && \
     curl --header "Host: nginx.example.com" http://$URL
   ```

    {% include [check-sg-if-url-unavailable-lvl3](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

1. Make sure the `nginx_ingress_controller_requests_per_second` metric is available:

   ```bash
   kubectl get --raw /apis/custom.metrics.k8s.io/v1beta1 | jq . | \
     grep ingresses.networking.k8s.io/nginx_ingress_controller_requests_per_second
   ```

   Result:

   ```text
   "name": "ingresses.networking.k8s.io/nginx_ingress_controller_requests_per_second",
   ```

### Testing autoscaling {#test-rps-autoscaling}

1. In a separate window, start {{ k8s }} component load monitoring:

   ```bash
   watch kubectl get pod,svc,hpa,nodes -o wide
   ```

1. Run the following command to simulate a workload:

   ```bash
   URL=$(kubectl get service rps-ingress-nginx-controller -o json \
     | jq -r '.status.loadBalancer.ingress[0].ip') && \
     while true; do curl --header "Host: nginx.example.com" http://$URL; done
   ```

    {% include [check-sg-if-url-unavailable-lvl3](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

   Within a few minutes, {{ k8s-hpa }} will increase the number of pods on the nodes due to increasing number of application requests. As soon as existing cluster resources become inadequate to satisfy the `requests` value, {{ k8s-ca }} will scale up nodes in the groups.
1. Stop simulating the workload. Over the next few minutes, the number of nodes and pods will drop back to the initial value.

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

1. [Delete the {{ k8s }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. If you used static public IP addresses to access your cluster or nodes, release and [delete](../../vpc/operations/address-delete.md) them.
