---
title: Granting access to an application running in a {{ k8s }} cluster
---

# Granting access to an application running in a {{ k8s }} cluster

The example below uses a {{ k8s }} application that responds to HTTP requests on port 8080. To provide access to the application, use public or internal [services](../concepts/service.md). Their IP addresses do not change, unlike the addresses of pods and cluster nodes.

To publish an application, use a `LoadBalancer` type service. You can set up two types of access:

* Public IP access with an external [{{ network-load-balancer-full-name }}](../../network-load-balancer/concepts/index.md).
* Access from internal networks by IP address with an [internal network load balancer](../../network-load-balancer/concepts/nlb-types.md).

  The application will be available:
  * From {{ vpc-full-name }} [subnets](../../vpc/concepts/network.md#subnet).
  * From your corporate internal subnets connected to {{ yandex-cloud }} via [{{ interconnect-full-name }}](../../interconnect/index.yaml).
  * Via VPN.

When using an external load balancer, [you can specify](#advanced) a static [public IP address](../../vpc/concepts/address.md#public-addresses) in the `loadBalancerIP` field. You need to [reserve such an address in advance](../../vpc/operations/get-static-ip.md). When reserving a public IP address, you can enable [DDoS protection](../../vpc/ddos-protection/index.md). If you do not specify a static public IP address, the network load balancer will get a dynamic public IP address.

{% note info %}

Unlike an IP address of a pod or node, which may change if node group resources are updated, the static public IP address of a `LoadBalancer` type service does not change.

{% endnote %}

When using an internal load balancer, you can specify an [internal IP address](../../vpc/concepts/address.md#internal-addresses). Make sure the specified internal IP address is not assigned to some other resource in the same cloud network.

{% note warning %}

Once removed from the specification, the internal IP address may be automatically assigned to a different resource in the same cloud network. We recommend selecting the address closer to the upper bound of your subnet's IP address range.

{% endnote %}

To ensure access to the {{ k8s }} application:
1. [Get ready](#before-you-begin).
1. [{#T}](#create-application).
1. [{#T}](#create-lb).
1. [{#T}](#check-result).
1. [{#T}](#network-policy).

{% cut "How to ensure access to an application via HTTPS" %}

See these guides:

* [{#T}](../tutorials/new-kubernetes-project.md)
* [{#T}](../tutorials/alb-ingress-controller.md)

{% endcut %}

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Set up your infrastructure:

    {% list tabs group=instructions %}

    - Manually {#manual}

      1. Create a [cloud network](../../vpc/operations/network-create.md) and [subnet](../../vpc/operations/subnet-create.md).
      1. Create a [service account](../../iam/operations/sa/create.md) with the `k8s.clusters.agent`, `vpc.publicAdmin`, and `load-balancer.admin` [role](../../iam/concepts/access-control/roles.md). It needs the `load-balancer.admin` role to create a [network load balancer](../../network-load-balancer/concepts/index.md).
      1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

          {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

      1. [Create a {{ managed-k8s-name }} cluster](kubernetes-cluster/kubernetes-cluster-create.md) and [node group](node-group/node-group-create.md) with public internet access and preconfigured security groups.

    - {{ TF }} {#tf}

      1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
      1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
      1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
      1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

      1. Download the [k8s-load-balancer.tf](https://github.com/yandex-cloud-examples/yc-mk8s-load-balancer/blob/main/k8s-load-balancer.tf) {{ managed-k8s-name }} cluster configuration file to the same working directory. This file describes:
          * [Network](../../vpc/concepts/network.md#network).
          * [Subnet](../../vpc/concepts/network.md#subnet).
          * {{ managed-k8s-name }} cluster.
          * [Service account](../../iam/concepts/users/service-accounts.md) for the {{ managed-k8s-name }} cluster and [node group](../concepts/index.md#node-group).
          * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

            {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

      1. Specify the following in the configuration file:
          * [Folder ID](../../resource-manager/operations/folder/get-id.md).
          * [{{ k8s }} version](../concepts/release-channels-and-updates.md) for the {{ managed-k8s-name }} cluster and node groups.
          * Name of the {{ managed-k8s-name }} cluster service account.
      1. Validate your {{ TF }} configuration files using this command:

          ```bash
          terraform validate
          ```

          {{ TF }} will display any configuration errors detected in your files.
      1. Create the required infrastructure:

          {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

          {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

          {% include [Terraform timeouts](../../_includes/managed-kubernetes/terraform-timeout-both.md) %}

    {% endlist %}

## Create a {{ k8s }} app {#create-application}

1. Create a file named `hello.yaml` and add the [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) resource specification to it to create the application:

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

1. Create an application:

   ```bash
   kubectl apply -f hello.yaml
   ```

1. Make sure the application was created:

   ```bash
   kubectl get deployment 
   ```

   Result:

   ```text
   NAME    READY   UP-TO-DATE   AVAILABLE   AGE
   hello   2/2     2            2           17h
   ```

## Create a LoadBalancer type service {#create-lb}

When you create a `LoadBalancer` type service, the {{ yandex-cloud }} controller installs a network load balancer in your folder. It is charged based on the {{ network-load-balancer-name }} [pricing policy](../../network-load-balancer/pricing.md).

{% include [note-nlb](../../_includes/managed-kubernetes/note-nlb.md) %}

To create a `LoadBalancer` type service:

1. Select and prepare the service specification based on the required load balancer type:

   {% list tabs group=instructions %}

   * External load balancer {#external-balancer}

      1. Create a file named `load-balancer.yaml` and add the following service specification to it:

         ```yaml
         apiVersion: v1
         kind: Service
         metadata:
           name: hello
         spec:
           type: LoadBalancer
           ports:
           - port: <application_port>
             name: plaintext
             targetPort: 8080
           selector:
             <{{ k8s }}_labels>
         ```

         In the specification, indicate:

         * `spec.ports.port`: Application port.

            The example assumes the {{ k8s }} application is available over HTTP, so specify `80` as the value. If you need to access the application over HTTPS, set the value to `443`.

         * `spec.selector`: {{ k8s }} labels specified in the `spec.selector.matchLabels` field of the `Deployment` resource.

            Specify the `app: hello` label as it is used in the `Deployment` resource you created previously.

         For details on the specification, see [this reference](../nlb-ref/service.md).

      1. Optionally, [reserve a static public IP address](../../vpc/operations/get-static-ip.md) and add it to the specification:

         ```yaml
         ...
         spec:
           loadBalancerIP: <static_IP_address>
           ...
         ```

         {% note info %}

         If you do not specify a static IP address, the network load balancer will get a dynamic IP address.

         {% endnote %}

   * Internal load balancer {#internal-balancer}

      1. Create a file named `load-balancer.yaml` and add the following service specification to it:

         ```yaml
         apiVersion: v1
         kind: Service
         metadata:
           name: hello
           annotations:
             yandex.cloud/load-balancer-type: internal
             yandex.cloud/subnet-id: <cluster_subnet_ID>
         spec:
           type: LoadBalancer
           ports:
           - port: <application_port>
             name: plaintext
             targetPort: 8080
           selector:
             <{{ k8s }}_labels>
         ```

         In the specification, indicate:

         * `yandex.cloud/subnet-id`: ID of the subnet hosting the cluster. You can [get the ID together with the subnet information](../../vpc/operations/subnet-get-info.md).
         * `spec.ports.port`: Application port.

            The example assumes the {{ k8s }} application is available over HTTP, so specify `80` as the value. If you need to access the application over HTTPS, set the value to `443`.

         * `spec.selector`: {{ k8s }} labels specified in the `spec.selector.matchLabels` field of the `Deployment` resource.

            Specify the `app: hello` label as it is used in the `Deployment` resource you created previously.

         For details on the specification, see [this reference](../nlb-ref/service.md).

      1. Optionally, [reserve a static private IP address](../../vpc/operations/private-ip-reserve.md) and add it to the specification:

         ```yaml
         ...
         spec:
           loadBalancerIP: <static_IP_address>
           ...
         ```

         {% note info %}

         If you do not specify a static IP address, the network load balancer will get a dynamic IP address.

         {% endnote %}

   {% endlist %}

1. Optionally, add a traffic management policy:

   ```yaml
   ...
   spec:
     externalTrafficPolicy: <Cluster_or_Local>
     ...
   ```

   The possible values are:

   {% include [externalTrafficPolicy-description](../../_includes/managed-kubernetes/externalTrafficPolicy.md) %}

1. Optionally, enable [node health checks](../../network-load-balancer/concepts/health-check.md).

   `LoadBalancer` type services in {{ managed-k8s-name }} can run health check requests for a [target group](../../network-load-balancer/concepts/target-resources.md). Based on the received metrics, {{ managed-k8s-name }} decides if the nodes are available.

   To enable node availability checks, specify the following annotations in the service specification:

   ```yaml
   ...
   metadata:
     ...
     annotations:
       yandex.cloud/load-balancer-healthcheck-healthy-threshold: "2"
       yandex.cloud/load-balancer-healthcheck-interval: "2s"
   ```

   Annotations used:

   * `yandex.cloud/load-balancer-healthcheck-healthy-threshold`: Number of consecutive successful checks to consider a cluster node available.
   * `yandex.cloud/load-balancer-healthcheck-interval`: Check interval in seconds.

1. Create a network load balancer:

   ```bash
   kubectl apply -f load-balancer.yaml
   ```

## Check application availability {#check-result}

1. View information about the network load balancer you created and get its IP address:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select your default folder.
     1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
     1. The **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_list }}** tab shows the network load balancer with the `k8s` prefix in the name and the unique ID of your {{ k8s }} cluster in the description.

        Copy the balancer address in the **{{ ui-key.yacloud.load-balancer.network-load-balancer.column_ip-address }}** column.

   - kubectl {#kubectl}

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

     Copy the balancer address from the `LoadBalancer Ingress` field.

   {% endlist %}

1. Make sure the application is available. The verification steps depend on your load balancer type:

   {% list tabs group=instructions %}

   * External load balancer {#external-balancer}

      Run this command:

      ```bash
      curl http://<load_balancer_IP_address>
      ```

      Result:

      ```text
      Hello, world!
      Running in 'hello-********'
      ```

   * Internal load balancer {#internal-balancer}

      1. In the {{ managed-k8s-name }} cluster subnet, [create a Linux VM](../../compute/operations/vm-create/create-linux-vm.md).

         Since you have deployed an internal network load balancer, you can only test access to the {{ k8s }} application from the cluster subnet.

      1. [Connect to the VM over SSH](../../compute/operations/vm-connect/ssh.md).
      1. Check availability of the {{ k8s }} application:

         ```bash
         curl http://<load_balancer_IP_address>
         ```

         Result:

         ```text
         Hello, world!
         Running in 'hello-********'
         ```

   {% endlist %}

   {% include [Configuring security groups if resource is unavailable](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

## Optionally, create a NetworkPolicy object {#network-policy}

To connect to services published via {{ network-load-balancer-name }} from specific IP addresses, enable [network policies](../concepts/network-policy.md) in the cluster. To set up access via the load balancer, create a [NetworkPolicy](https://kubernetes.io/docs/concepts/services-networking/network-policies/#networkpolicy-resource) object with an `Ingress` type policy.

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
    # Address ranges used by the load balancer to health check nodes.
    - ipBlock:
        cidr: 198.18.235.0/24
    - ipBlock:
        cidr: 198.18.248.0/24
    # Pod address ranges.
    - ipBlock:
        cidr: 172.16.1.0/12
    - ipBlock:
        cidr: 172.16.2.0/12
```

{% endcut %}

For more information, see the `NetworkPolicy` resource [reference](../nlb-ref/networkpolicy.md).

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

1. Delete the resources depending on how you created them:

    {% list tabs group=instructions %}

    - Manually {#manual}

        [Delete the {{ managed-k8s-name }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}

1. If you used static [public](../../vpc/concepts/address.md#public-addresses) IP addresses to access your {{ managed-k8s-name }} cluster or nodes, release and delete them.