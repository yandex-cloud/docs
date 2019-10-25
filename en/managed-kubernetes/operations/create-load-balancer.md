# Granting access to an app running in a cluster {{ k8s }}

To grant access to an app running in a {{ k8s }} cluster, you can use [various types of services](../concepts/service.md). To grant public access, use `LoadBalancer` service.

Prepare and run the application to be granted access to using a `LoadBalancer` service in the {{ k8s }} cluster. As an example, use a simple application that responds to HTTP requests on port 8080.

- [Create a simple application](#simple-app)
- [Create a LoadBalancer service](#lb-create)
- [Check the result](#check-result)
- [Advanced LoadBalancer service settings](#advanced)

## Create a simple app {#simple-app}

1. Save the following app creation specification to a YAML file named `hello.yaml`:

    [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) is a Kubernetes API object that manages the replicated application.

    ```
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
              image: cr.yandex/crpjd37scfv653nl11i9/hello:1.1
    ```

1. Run the command:

    ```
    $ kubectl apply -f hello.yaml
    deployment.apps/hello created
    ```

1. View information about the created app:

    ```
    $ kubectl describe deployment hello
    Name:                   hello
    Namespace:              default
    CreationTimestamp:      Mon, 23 Sep 2019 12:13:28 +0300
    Labels:                 <none>
    Annotations:            deployment.kubernetes.io/revision: 1
                            kubectl.kubernetes.io/last-applied-configuration:
                              {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"name":"hello","namespace":"default"},"spec":{"replicas":2,"selec...
    Selector:               app=hello
    Replicas:               2 desired | 2 updated | 2 total | 2 available | 0 unavailable
    StrategyType:           RollingUpdate
    MinReadySeconds:        0
    RollingUpdateStrategy:  25% max unavailable, 25% max surge
    Pod Template:
      Labels:  app=hello
      Containers:
       hello-app:
        Image:        cr.yandex/crpjd37scfv653nl11i9/hello:1.1
        Port:         <none>
        Host Port:    <none>
        Environment:  <none>
        Mounts:       <none>
      Volumes:        <none>
    Conditions:
      Type           Status  Reason
      ----           ------  ------
      Available      True    MinimumReplicasAvailable
      Progressing    True    NewReplicaSetAvailable
    OldReplicaSets:  <none>
    NewReplicaSet:   hello-9ffd9ff9b (2/2 replicas created)
    Events:
      Type    Reason             Age   From                   Message
      ----    ------             ----  ----                   -------
      Normal  ScalingReplicaSet  24s   deployment-controller  Scaled up replica set hello-9ffd9ff9b to 2
    ```

## Create a LoadBalancer service {#lb-create}

When you create a service with the `LoadBalancer` type, Yandex.Cloud controller creates and configures a [network load balancer](../../load-balancer/concepts/index.md) in your folder with a public IP address.

{% note important %}

Don't modify or delete the network load balancer or target groups that are automatically created in your folder after creating a `LoadBalancer` service.

{% endnote %}

1. Save the following specification for creating a `LoadBalancer` service to a YAML file named `load-balancer.yaml`.
    - The `targetPort` field specifies the container port where the app is available.
    - The `port` field specifies the network load balancer port to handle user requests.
    - The `selector` field specifies the selector labels used in the pod template when creating the `Deployment` object.

    ```
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
      type: LoadBalancer
    ```

1. Run the command:

    ```
    $ kubectl apply -f load-balancer.yaml
    service/hello configured
    ```

1. View information about the load balancer:

    ```
    $ kubectl describe service hello
    Name:                     hello
    Namespace:                default
    Labels:                   <none>
    Annotations:              kubectl.kubernetes.io/last-applied-configuration:
                                {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"name":"hello","namespace":"default"},"spec":{"ports":[{"name":"plaintext...
    Selector:                 app=hello
    Type:                     LoadBalancer
    IP:                       10.15.165.125
    LoadBalancer Ingress:     84.201.145.125
    Port:                     plaintext  80/TCP
    TargetPort:               8080/TCP
    NodePort:                 plaintext  31050/TCP
    Endpoints:                10.16.129.6:8080,10.16.130.6:8080
    Session Affinity:         None
    External Traffic Policy:  Cluster
    Events:
      Type    Reason                Age   From                Message
      ----    ------                ----  ----                -------
      Normal  EnsuringLoadBalancer  39s   service-controller  Ensuring load balancer
      Normal  EnsuredLoadBalancer   4s    service-controller  Ensured load balancer
    ```

1.  In the [management console]({{ link-console-main }}), open **{{ load-balancer-name }}**. Make sure you find the load balancer with the `k8s` name prefix and unique ID of your {{ k8s }} cluster in the description.

## Check the results {#check-result}

To check the results, run:

```
$ curl http://<IP address from LoadBalancer Ingress field> 
Hello, world!
Running in 'hello-9ffd9ff9b-4jnxs'
```

## Advanced LoadBalancer service settings {#advanced}

In {{ managed-k8s-short-name }}, the following advanced settings are available for a service with the `LoadBalancer` type:

- Assign a [pre-allocated IP address](../../vpc/operations/get-static-ip.md) using the `loadBalancerIP` parameter.
- Manage traffic using the [externalTrafficPolicy](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.15/#service-v1-core) parameter:
    - `Local`: Traffic goes directly to the nodes where the application containers are running. In this case:
        - The originating IP address of the user query is saved.
        - Horizontal traffic exchanged by VMs is lower.
    - `Cluster`: Traffic goes to any of the {{ k8s }} cluster nodes. In this case:
        - If pods are missing from the node, [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/) forwards traffic to another node.

The `loadBalancerIP` and `externalTrafficPolicy` parameters are optional. If you omit them, a load balancer is created with a dynamic IP address and the `externalTrafficPolicy: Cluster` parameter.

Example of a `LoadBalancer` service specification:

```
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
  loadBalancerIP: <pre-allocated IP address>
  type: LoadBalancer
  externalTrafficPolicy: <Local or Cluster>
```

