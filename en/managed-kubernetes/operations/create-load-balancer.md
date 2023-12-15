---
title: "Granting access to an app running in a {{ k8s }} cluster"
---

# Granting access to an app running in a {{ k8s }} cluster

To grant access to an app running in a {{ k8s }} cluster, you can use [various types of public and internal services](../concepts/service.md).

To publish an app, use a `LoadBalancer` service. The following options are supported:
* Public access by IP address with a [network load balancer](../../network-load-balancer/concepts/index.md).
* Access from internal networks by IP address with an [internal network load balancer](../../network-load-balancer/concepts/nlb-types.md).

  The application will be available:
  * From {{ vpc-full-name }} [subnets](../../vpc/concepts/network.md#subnet).
    * From the company's internal subnets connected to {{ yandex-cloud }} via [{{ interconnect-full-name }}](../../interconnect/index.yaml).
  * Via VPN.


To use DDoS protection, [reserve](../../vpc/operations/enable-ddos-protection.md) a public IP address and [specify](#advanced) it using the `loadBalancerIP` option.


{% note info %}

Unlike the IP address of a pod or node, which may change if the resources in a node group are updated, the IP address of `LoadBalancer` type services don't change.

{% endnote %}

Prepare and run the application to be granted access to using a `LoadBalancer` service in the {{ k8s }} cluster. As an example, use a simple application that responds to HTTP requests on port 8080.
* [Create a simple app](#simple-app).
* [Create a LoadBalancer service with a public IP address](#lb-create).
* [Create a LoadBalancer service with an internal IP address](#lb-int-create).
* [LoadBalancerIP and externalTrafficPolicy parameters](#advanced).
* (Optional) [{#T}](#network-policy).

## Create a simple app {#simple-app}

1. Save the following app creation specification to a YAML file named `hello.yaml`.

   [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) is the {{ k8s }} API object that manages the replicated application.

   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: hello
   spec:
     replicas: 2
     selector:
       matchLabels:
         app: hello
     template:
       metadata:
         labels:
           app: hello
       spec:
         containers:
         - name: hello-app
           image: {{ registry }}/crpjd37scfv6********/hello:1.1
   ```

1. Create an application:

   {% list tabs %}

   - CLI

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     ```bash
     kubectl apply -f hello.yaml
     ```

     Result:

     ```bash
     deployment.apps/hello created
     ```

   {% endlist %}

1. View information about the created app:

   {% list tabs %}

   - CLI

     ```bash
     kubectl describe deployment hello
     ```

     Result:

     ```text
     Name:                   hello
     Namespace:              default
     CreationTimestamp:      Wed, 28 Oct 2020 23:15:25 +0300
     Labels:                 <none>
     Annotations:            deployment.kubernetes.io/revision: 1
     Selector:               app=hello
     Replicas:               2 desired | 2 updated | 2 total | 1 available | 1 unavailable
     StrategyType:           RollingUpdate
     MinReadySeconds:        0
     RollingUpdateStrategy:  25% max unavailable, 25% max surge
     Pod Template:
       Labels:  app=hello
       Containers:
        hello-app:
         Image:        {{ registry }}/crpab12cdef3********/hello:1.1
         Port:         <none>
         Host Port:    <none>
         Environment:  <none>
         Mounts:       <none>
       Volumes:        <none>
     Conditions:
       Type           Status  Reason
       ----           ------  ------
       Available      False   MinimumReplicasUnavailable
       Progressing    True    ReplicaSetUpdated
     OldReplicaSets:  <none>
     NewReplicaSet:   hello-74******** (2/2 replicas created)
     Events:
       Type    Reason             Age   From                   Message
       ----    ------             ----  ----                   -------
       Normal  ScalingReplicaSet  10s   deployment-controller  Scaled up replica set hello-74******** to 2
     ```

   {% endlist %}

## Create a LoadBalancer service with a public IP address {#lb-create}

When you create a service with the `LoadBalancer` type, {{ yandex-cloud }} controller creates and configures a [network load balancer](../../network-load-balancer/concepts/index.md) in your folder with a public IP address.

{% note warning %}

* You will be charged for the network load balancer you created based on the [pricing rules](../../network-load-balancer/pricing.md).
* Don't modify or delete the network load balancer or target groups that are automatically created in your folder after creating a `LoadBalancer` service.

{% endnote %}

1. Save the following specification for creating a `LoadBalancer` service to a YAML file named `load-balancer.yaml`:

   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: hello
   spec:
     ports:
     # Port is the network load balancer port to handle user requests.
     - port: 80
       name: plaintext
       # Container port the application listens on.
       targetPort: 8080
     # Selector {{ k8s }} labels used in a pod template when creating a Deployment object.
     selector:
       app: hello
     type: LoadBalancer
   ```

1. Create a network load balancer:

   {% list tabs %}

   - CLI

     ```bash
     kubectl apply -f load-balancer.yaml
     ```

     Result:

     ```bash
     service/hello created
     ```

   {% endlist %}

1. View information about the network load balancer created:

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), select your default folder.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
     1. The **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_list }}** tab shows the network load balancer with the `k8s` prefix in the name and the unique ID of your {{ k8s }} cluster in the description.

   - CLI

     ```bash
     kubectl describe service hello
     ```

     Result:

     ```text
     Name:                     hello
     Namespace:                default
     Labels:                   <none>
     Annotations:              Selector: app=hello
     Type:                     LoadBalancer
     IP:                       172.20.169.7
     LoadBalancer Ingress:     130.193.50.111
     Port:                     plaintext 80/TCP
     TargetPort:               8080/TCP
     NodePort:                 plaintext 32302/TCP
     Endpoints:                10.1.130.4:8080
     Session Affinity:         None
     External Traffic Policy:  Cluster
     Events:
       Type    Reason                Age    From                Message
       ----    ------                ----   ----                -------
       Normal  EnsuringLoadBalancer  2m43s  service-controller  Ensuring load balancer
       Normal  EnsuredLoadBalancer   2m17s  service-controller  Ensured load balancer
     ```

   {% endlist %}

1. Make sure the application is available from the internet:

   {% list tabs %}

   - CLI

     ```bash
     curl http://130.193.50.111
     ```

     Where `130.193.50.111` is the public IP address from the `LoadBalancer Ingress` field.

     Result:

     ```text
     Hello, world!
     Running in 'hello-74********-c1rpa'
     ```

   {% endlist %}

## Create a LoadBalancer service with an internal IP address {#lb-int-create}

To create an internal network load balancer, specify the `yandex.cloud/load-balancer-type` and `yandex.cloud/subnet-id` parameters in the YAML specification for the service under `annotations`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: hello
  annotations:
    # Load balancer type: Internal.
    yandex.cloud/load-balancer-type: internal
    # ID of the subnet where an IP address for the internal network load balancer should be allocated.
    yandex.cloud/subnet-id: e1b23q26ab1c********
spec:
  type: LoadBalancer
  ports:
  # The internal network load balancer port to handle user requests.
  - port: 80
    name: plaintext
    # Container port the application listens on.
    targetPort: 8080
  # Selector {{ k8s }} labels used in a pod template when creating a Deployment object.
  selector:
    app: hello
```

## loadBalancerIP and externalTrafficPolicy parameters {#advanced}

In {{ managed-k8s-name }}, the following advanced settings are available for a service with the `LoadBalancer` type:
* Assign a [pre-allocated public IP address](../../vpc/operations/get-static-ip.md) using the `loadBalancerIP` parameter.

  
  When reserving a static IP address, you can activate [DDoS protection](../../vpc/ddos-protection/index.md).


* Manage traffic using the [externalTrafficPolicy](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/service-v1/#ServiceSpec) parameter:
  * `Cluster`: Traffic goes to any of the {{ k8s }} cluster nodes. In which case:
    * If pods are missing from the node, [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy) forwards traffic to another node.
  * `Local`: Traffic goes directly to the nodes where the application containers are running. In which case:
    * The originating IP address of the user query is saved.
    * Horizontal traffic exchanged by VMs is lower.

The `loadBalancerIP` and `externalTrafficPolicy` parameters are optional. If you omit them, a load balancer is created with a dynamic IP address and the `externalTrafficPolicy: Cluster` parameter.

Example of a `LoadBalancer` service YAML specification with these parameters:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: hello
spec:
  ports:
  - port: 80
    name: plaintext
    targetPort: 8080
  selector:
    app: hello
  loadBalancerIP: <IP_address>
  type: LoadBalancer
  externalTrafficPolicy: <traffic_management>
```

Where:

* `loadBalancerIP`: Pre-allocated IP address.
* `externalTrafficPolicy`: Traffic management (`Local` or `Cluster`).

## Parameters for checking node status {#healthcheck}

Services like `LoadBalancer` in {{ managed-k8s-name }} can run status check requests against a {{ k8s }} [target node group](../../network-load-balancer/concepts/target-resources.md). Based on the resulting metrics, {{ managed-k8s-name }} decides if the nodes are available.

To enable node health check mode, specify a set of parameters `yandex.cloud/load-balancer-healthcheck` in the service specification, such as:

```yaml
apiVersion: v1
...
  annotations:
    yandex.cloud/load-balancer-healthcheck-healthy-threshold: "2"
    yandex.cloud/load-balancer-healthcheck-interval: "2s"
    yandex.cloud/load-balancer-healthcheck-timeout: "1s"
    yandex.cloud/load-balancer-healthcheck-unhealthy-threshold: "2"
...
```

Where:
* `yandex.cloud/load-balancer-healthcheck-healthy-threshold` is the number of consecutive successful checks required to consider the node available.

  The minimum value is `2` and the maximum is `10`.
* `yandex.cloud/load-balancer-healthcheck-interval` is the interval (in seconds) for running health checks.

  The minimum value is `2s` and the maximum is `300s`.
* `yandex.cloud/load-balancer-healthcheck-timeout` is the health check timeout (in seconds). A node is considered unavailable if it has not responded within the specified time.

  The minimum value is `1s` and the maximum is `60s`.
* `yandex.cloud/load-balancer-healthcheck-unhealthy-threshold` is the number of consecutive failed checks that would make the node unavailable.

  The minimum value is `2` and the maximum is `10`.

For more information, see the [{{ network-load-balancer-full-name }} documentation](../../network-load-balancer/concepts/health-check.md).

## Create a NetworkPolicy object {#network-policy}

To connect to services published via {{ network-load-balancer-name }} from certain IP addresses, enable [network policies](../concepts/network-policy.md) in the cluster. To set up access via the load balancer, create a [NetworkPolicy]({{ k8s-api-link }}#netowrkpolicy-v1-networking-k8s-io) object with the `Ingress` policy type:

```yaml
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: <policy_name>
  namespace: <namespace>
spec:
  podSelector:
    <pod_filtering_rules>
  policyTypes:
  - Ingress
  ingress:
  - from:
    - ipBlock:
        cidr: 198.18.235.0/24
    - ipBlock:
        cidr: 198.18.248.0/24
    - ipBlock:
        cidr: <range_of_IPs_allowed_to_access_the_load_balancer>
    ...
    - ipBlock:
        cidr: <range_of_IPs_allowed_to_access_the_load_balancer>
```

Where:
* `metadata.name`: Policy name.
* `metadata.namespace`: [Namespace](../concepts/index.md#namespace).
* `spec.podSelector`: Filtering rules for [pods](../concepts/index.md#pod).
* `spec.policyTypes`: Policy type. Enter `Ingress`.
* `spec.ingress.from.ipBlock.cidr`: IP ranges allowed to access the load balancer.

  The `198.18.235.0/24` and `198.18.248.0/24` ranges are [reserved by {{ network-load-balancer-name }}](../../network-load-balancer/concepts/health-check.md) for node health checks. They are required in the NetworkPolicy object settings.

{% cut "NetworkPolicy object configuration example" %}

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: whitelist-netpol
  namespace: ns-example
spec:
  podSelector:
    matchLabels:
      role: db
  policyTypes:
  - Ingress
  ingress:
  - from:
    # IP ranges used by the load balancer to check the health of nodes.
    - ipBlock:
        cidr: 198.18.235.0/24
    - ipBlock:
        cidr: 198.18.248.0/24
    # Ranges of pod IPs.
    - ipBlock:
        cidr: 172.16.1.0/12
    - ipBlock:
        cidr: 172.16.2.0/12
```

{% endcut %}