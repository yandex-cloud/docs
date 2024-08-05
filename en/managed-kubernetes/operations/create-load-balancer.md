---
title: "Granting access to an app running in a {{ k8s }} cluster"
---

# Granting access to an app running in a {{ k8s }} cluster

To grant access to an app running in a {{ k8s }} cluster, you can use [various types of public and internal services](../concepts/service.md).

To publish an app, use a`LoadBalancer` service. The following options are supported:

* Public access by IP address with a [network load balancer](../../network-load-balancer/concepts/index.md).
* Access from internal networks by IP address with an [internal network load balancer](../../network-load-balancer/concepts/nlb-types.md).

  The application will be available:
  * From {{ vpc-full-name }} [subnets](../../vpc/concepts/network.md#subnet).
    * From the company's internal subnets connected to {{ yandex-cloud }} via [{{ interconnect-full-name }}](../../interconnect/index.yaml).
  * Via VPN.

When using an external load balancer, [you can specify](#advanced) a static [public IP address](../../vpc/concepts/address.md#public-addresses) in the `loadBalancerIP` field. You need to [reserve such an address in advance](../../vpc/operations/get-static-ip.md). When reserving a public IP address, you can enable [DDoS protection](../../vpc/ddos-protection/index.md).


If you do not specify a static IP address, the network load balancer will get a dynamic IP address.

{% note info %}

Unlike the IP address of a pod or node, which may change if the resources in a node group are updated, the static IP address of a `LoadBalancer`-type service does not change.

{% endnote %}

Prepare and run the application to be granted access to using a `LoadBalancer` service in the {{ k8s }} cluster. As an example, use an application that responds to HTTP requests on port 8080.

1. [Create a simple app](#simple-app).
1. [Create a LoadBalancer service with a public IP address](#lb-create).
1. [Create a LoadBalancer service with an internal IP address](#lb-int-create).
1. [Specify the advanced settings](#advanced).
1. [Specify node health check parameters](#healthcheck).
1. (Optional) [{#T}](#network-policy).

{% cut "How to ensure access to an app via HTTPS?" %}

See the documentation:

* [{#T}](../tutorials/new-kubernetes-project.md)
* [{#T}](../tutorials/alb-ingress-controller.md)
* [{#T}](../tutorials/ingress-cert-manager.md)
* [Installing an NGINX Ingress controller with a {{ certificate-manager-full-name }} certificate](../tutorials/nginx-ingress-certificate-manager.md#check-service-availability)

{% endcut %}

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

Prepare the required infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

   1. Create a [cloud network](../../vpc/operations/network-create.md) and [subnet](../../vpc/operations/subnet-create.md).
   1. Create a [service account](../../iam/operations/sa/create.md) with the `editor` [role](../../iam/concepts/access-control/roles.md).
   1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

      {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

   1. [Create a {{ managed-k8s-name }} cluster](kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](node-group/node-group-create.md) with public internet access and the security groups prepared earlier.

- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

   1. Download the [k8s-load-balancer.tf](https://github.com/yandex-cloud-examples/yc-mk8s-load-balancer/blob/main/k8s-load-balancer.tf) {{ managed-k8s-name }} cluster configuration file to the same working directory. The file describes:
      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * {{ managed-k8s-name }} cluster.
      * [Service account](../../iam/concepts/users/service-accounts.md) required for the cluster and [{{ managed-k8s-name }} node group](../concepts/index.md#node-group) to operate.
      * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

         {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

   1. Specify the following in the configuration file:
      * [Folder ID](../../resource-manager/operations/folder/get-id.md).
      * [{{ k8s }} version](../concepts/release-channels-and-updates.md) for the {{ managed-k8s-name }} cluster and node groups.
      * Name of the {{ managed-k8s-name }} cluster service account.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.
   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

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
           image: {{ registry }}/crpjd37scfv653nl11i9/hello:1.1
   ```

1. Create an app:

   {% list tabs group=instructions %}

   - CLI {#cli}

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

   {% list tabs group=instructions %}

   - CLI {#cli}

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
          Image:        {{ registry }}/crpjd37scfv653nl11i9/hello:1.1
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
      NewReplicaSet:   hello-******** (2/2 replicas created)
      Events:
        Type    Reason             Age   From                   Message
        ----    ------             ----  ----                   -------
        Normal  ScalingReplicaSet  10s   deployment-controller  Scaled up replica set hello-******** to 2
      ```

   {% endlist %}

## Create a LoadBalancer service with a public IP address {#lb-create}

When you create a service of the `LoadBalancer` type, the {{ yandex-cloud }} controller creates and configures for you in your folder a [network load balancer](../../network-load-balancer/concepts/index.md) with a public IP address.

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
     type: LoadBalancer
     ports:
     - port: 80
       name: plaintext
       targetPort: 8080
     # Selector {{ k8s }} labels used in the pod template when creating the Deployment object.
     selector:
       app: hello
   ```

   For more information, see the `Service` resource [reference](../nlb-ref/service.md) for {{ network-load-balancer-full-name }}.

1. Create a network load balancer:

   {% list tabs group=instructions %}

   - CLI {#cli}

      ```bash
      kubectl apply -f load-balancer.yaml
      ```

      Result:

      ```bash
      service/hello created
      ```

   {% endlist %}

1. View information about the network load balancer created:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select your default folder.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
     1. The **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_list }}** tab shows the network load balancer with the `k8s` prefix in the name and the unique ID of your {{ k8s }} cluster in the description.

   - CLI {#cli}

      ```bash
      kubectl describe service hello
      ```

      Result:

      ```text
      Name:                     hello
      Namespace:                default
      Labels:                   <none>
      Annotations:              <none>
      Selector:                 app=hello
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

   {% list tabs group=instructions %}

   - CLI {#cli}

      ```bash
      curl http://130.193.50.111
      ```

      Where `130.193.50.111` is the public IP address from the `LoadBalancer Ingress` field.

      Result:

      ```text
      Hello, world!
      Running in 'hello-********'
      ```

   {% endlist %}

   {% include [Configuring security groups if resource is unavailable](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

## Create a LoadBalancer service with an internal IP address {#lb-int-create}

1. Edit the specification in the `load-balancer.yaml` file:

   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: hello
     annotations:
       # Load balancer type.
       yandex.cloud/load-balancer-type: internal
       # ID of the subnet for the internal network load balancer.
       yandex.cloud/subnet-id: e1b23q26ab1c********
   spec:
     type: LoadBalancer
     ports:
     - port: 80
       name: plaintext
       targetPort: 8080
     # Selector {{ k8s }} labels used in the pod template when creating the Deployment object.
     selector:
       app: hello
   ```

   For more information, see the `Service` resource [reference](../nlb-ref/service.md#annotations) for {{ network-load-balancer-full-name }}.

1. Delete the network load balancer you created earlier:

   {% list tabs %}

   - CLI

      ```bash
      kubectl delete service hello
      ```

      Result:

      ```bash
      service "hello" deleted
      ```

   {% endlist %}

1. Create an internal network load balancer:

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

## Configure the advanced settings {#advanced}

In {{ managed-k8s-name }}, you can specify the following advanced settings for your `LoadBalancer` type service:

* `loadBalancerIP`: [Public](../../vpc/concepts/address.md#public-addresses) (static) IP address you reserved in advance.
* `externalTrafficPolicy`: [Traffic management policy]({{ k8s-api-link }}#servicespec-v1-core).

{% cut "Example" %}

```yaml
apiVersion: v1
kind: Service
metadata:
  name: hello
spec:
  type: LoadBalancer
  ports:
  - port: 80
    name: plaintext
    targetPort: 8080
  selector:
    app: hello
  loadBalancerIP: 159.161.32.22
  externalTrafficPolicy: Cluster
```

{% endcut %}

For more information, see the `Service` resource [reference](../nlb-ref/service.md#servicespec) for {{ network-load-balancer-full-name }}.

## Specify node health check parameters {#healthcheck}

Such services as `LoadBalancer` in {{ managed-k8s-name }} can run status check requests against a {{ k8s }} [target node group](../../network-load-balancer/concepts/target-resources.md). Based on the metrics delivered to the service, {{ managed-k8s-name }} decides if the nodes are available.

To enable node health check mode, specify the `yandex.cloud/load-balancer-healthcheck-*` annotations in the service specification, such as the following:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: hello
  annotations:
    # Node health check parameters
    yandex.cloud/load-balancer-healthcheck-healthy-threshold: "2"
    yandex.cloud/load-balancer-healthcheck-interval: "2s"
```

For more information, see the `Service` resource [reference](../nlb-ref/service.md#annotations) for {{ network-load-balancer-full-name }}.

## Create a NetworkPolicy object {#network-policy}

To connect to services published via {{ network-load-balancer-name }} from particular IP addresses, enable [network policies](../concepts/network-policy.md) in the cluster. To set up access via the load balancer, create a [NetworkPolicy]({{ k8s-api-link }}#networkpolicy-v1-networking-k8s-io) object with a policy of the `Ingress` type.

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
    # IP ranges used by the load balancer to health check nodes.
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

For more information, see the [NetworkPolicy](../nlb-ref/networkpolicy.md) resource `reference` for {{ network-load-balancer-full-name }}.

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Delete the {{ managed-k8s-name }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).
   1. If you used static [public](../../vpc/concepts/address.md#public-addresses) IP addresses to access a {{ managed-k8s-name }} cluster or nodes, release and delete them.

- {{ TF }} {#tf}

   1. In the command line, go to the directory with the current {{ TF }} configuration file with an infrastructure plan.
   1. Delete the `k8s-load-balancer.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `k8s-load-balancer.tf` configuration file will be deleted.

   1. If you used static [public](../../vpc/concepts/address.md#public-addresses) IP addresses to access a {{ managed-k8s-name }} cluster or nodes, release and delete them.

{% endlist %}
