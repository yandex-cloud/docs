# Integrating into a corporate DNS zone

To integrate a [{{ managed-k8s-name }} cluster](../concepts/index.md#kubernetes-cluster) into a private corporate DNS [zone](../../dns/concepts/dns-zone.md):
1. [{#T}](#setup-zone)
1. [{#T}](#create-pod)
1. [{#T}](#verify-dns)

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

In this scenario's examples, the DNS server has the address `10.129.0.3`, the name `ns.example.com`, and serves a zone called `example.com`. Your DNS servers can be part of [{{ vpc-full-name }}](../../vpc/) or be accessible via VPN or [{{ interconnect-full-name }}](../../interconnect/). IP connectivity between the {{ managed-k8s-name }} cluster [nodes](../concepts/index.md#node-group) and the DNS servers is required.
1. Create {{ managed-k8s-name }} resources:

   {% list tabs %}

   - Manually

     1. {% include [k8s-ingress-controller-create-cluster](../../_includes/application-load-balancer/k8s-ingress-controller-create-cluster.md) %}

     1. {% include [k8s-ingress-controller-create-node-group](../../_includes/application-load-balancer/k8s-ingress-controller-create-node-group.md) %}

     1. [Configure {{ managed-k8s-name }} cluster security groups and node groups](../operations/connect/security-groups.md). The [security group](../../vpc/concepts/security-groups.md) of the {{ managed-k8s-name }} cluster must allow incoming connections on ports `443` and `6443`.

   - Using {{ TF }}

     1. If you do not have {{ TF }} yet, [install it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
     1. Download the [k8s-cluster.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-cluster.tf) configuration file of the {{ managed-k8s-name }} cluster to the same working directory. The file describes:
        * [Network](../../vpc/concepts/network.md#network).
        * [Subnet](../../vpc/concepts/network.md#subnet).
        * Default [security group](../../vpc/concepts/security-groups.md) and [rules](../operations/connect/security-groups.md) needed to run the {{ managed-k8s-name }} cluster:
          * Rules for service traffic.
          * Rules for accessing the {{ k8s }} API and managing the {{ managed-k8s-name }} cluster with `kubectl` (through ports 443 and 6443).
        * {{ managed-k8s-name }} cluster.
        * {{ managed-k8s-name }} node group.
        * [Service account](../../iam/concepts/users/service-accounts.md) required to create the {{ managed-k8s-name }} cluster and node group.
     1. Specify the [folder ID](../../resource-manager/operations/folder/get-id.md) in the configuration file:
     1. Run the `terraform init` command in the directory with the configuration files. This command initializes the provider specified in the configuration files and enables you to use the provider's resources and data sources.
     1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point to them.
     1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Configure the DNS server {#setup-dns}

When setting up the configuration, it is important that there is IP connectivity between the {{ managed-k8s-name }} cluster nodes and the DNS servers. The DNS servers can be part of {{ vpc-name }} or be accessible via VPN or {{ interconnect-name }}. The example below assumes that the DNS server has the `10.129.0.3` address and the `ns.example.com` name and serves a zone called `example.com`.

## Specify a corporate DNS zone {#setup-zone}

1. Create a `custom-zone.yaml` file with the following contents:

   ```yaml
   kind: ConfigMap
   apiVersion: v1
   metadata:
     name: coredns-user
     namespace: kube-system
     labels:
       addonmanager.kubernetes.io/mode: EnsureExists
   data:
     Corefile: |
       # User can put their additional configurations here, for example:
       example.com {
         errors
         cache 30
         forward . 10.129.0.3
       }
   ```

1. Run this command:

   ```bash
   kubectl replace -f custom-zone.yaml
   ```

   Result:

   ```text
   configmap/coredns-user replaced
   ```

## Create a dns-utils pod {#create-pod}

1. Create a [pod](../concepts/index.md#pod).

   ```bash
   kubectl run jessie-dnsutils \
     --image=registry.k8s.io/jessie-dnsutils \
     --restart=Never \
     --command sleep infinity
   ```

   Result:

   ```text
   pod/jessie-dnsutils created
   ```

1. View details of the pod created:

   ```bash
   kubectl describe pod jessie-dnsutils
   ```

   Result:

   ```text
   ...
   Status:  Running
   ...
   ```

## Verify DNS integration {#verify-dns}

Run the `nslookup` command in the running cluster:

```bash
kubectl exec jessie-dnsutils -- nslookup ns.example.com
```

Result:

```text
Server:   10.96.128.2
Address:  10.96.128.2#53
Name:     ns.example.com
Address:  10.129.0.3
```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:
1. Delete the {{ managed-k8s-name }} cluster:

   {% list tabs %}

   - Manually

     [Delete the {{ managed-k8s-name }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).

   - Using {{ TF }}

     1. In the command line, go to the directory with the current {{ TF }} configuration file with an infrastructure plan.
     1. Delete the resources using this command:

        ```bash
        terraform destroy
        ```

        {% note alert %}

        {{ TF }} will delete all the resources that you created using it, such as {{ managed-k8s-name }} clusters, networks, subnets, and [VMs](../../compute/concepts/vm.md).

        {% endnote %}

     1. Confirm the deletion of resources.

   {% endlist %}

1. [Delete a VM](../../compute/operations/vm-control/vm-delete.md) with the DNS server.
1. [Delete a DNS zone](../../dns/operations/zone-delete.md).