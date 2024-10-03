---
title: How to integrate a {{ managed-k8s-full-name }} cluster into a private corporate DNS zone
description: Follow this guide to integrate a {{ managed-k8s-full-name }} cluster into a private corporate DNS zone.
---

# Integrating into a corporate DNS zone


To integrate a [{{ managed-k8s-name }} cluster](../concepts/index.md#kubernetes-cluster) into a private corporate DNS [zone](../../dns/concepts/dns-zone.md):
1. [{#T}](#setup-zone).
1. [{#T}](#create-pod).
1. [{#T}](#verify-dns).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. Create {{ managed-k8s-name }} resources:

   {% list tabs group=instructions %}

   - Manually {#manual}

      1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

         {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

      1. {% include [k8s-ingress-controller-create-cluster](../../_includes/application-load-balancer/k8s-ingress-controller-create-cluster.md) %}

      1. {% include [k8s-ingress-controller-create-node-group](../../_includes/application-load-balancer/k8s-ingress-controller-create-node-group.md) %}

   - {{ TF }} {#tf}

      1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
      1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
      1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
      1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

      1. Download the [k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-infrastructure/blob/main/k8s-cluster.tf) configuration file of the {{ managed-k8s-name }} cluster to the same working directory. The file describes:
         * [Network](../../vpc/concepts/network.md#network).
         * [Subnet](../../vpc/concepts/network.md#subnet).
         * {{ managed-k8s-name }} cluster.
         * {{ managed-k8s-name }} node group.
         * [Service account](../../iam/concepts/users/service-accounts.md) required to create the {{ managed-k8s-name }} cluster and node group.
         * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

            {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

      1. Specify the [folder ID](../../resource-manager/operations/folder/get-id.md) in the configuration file:
      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point them out.
      1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

   {% include [kubectl info](../../_includes/managed-kubernetes/kubectl-info.md) %}

## Configure the DNS server {#setup-dns}

When configuring, it is important to achieve IP connectivity between the {{ managed-k8s-name }} cluster nodes and the DNS servers. The DNS servers themselves can either reside in [{{ vpc-full-name }}](../../vpc/) or be accessible via VPN or [{{ interconnect-full-name }}](../../interconnect/index.yaml). In the example below, a DNS server with the address `10.129.0.3` and name `ns.example.com` serves the `example.com` zone.

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

{% note info %}

If the corporate DNS zone is unavailable, [make sure](../operations/connect/security-groups.md) that the security groups for the {{ managed-k8s-name }} cluster and its node groups are configured correctly. If any rule is missing, [add it](../../vpc/operations/security-group-add-rule.md). The rules must allow access to resources from the cluster.

{% endnote %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:
1. Delete the {{ managed-k8s-name }} cluster:

   {% list tabs group=instructions %}

   - Manually {#manual}

      [Delete the {{ managed-k8s-name }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).

   - {{ TF }} {#tf}

      1. In the command line, go to the directory with the current {{ TF }} configuration file with an infrastructure plan.
      1. Delete the resources using this command:

         ```bash
         terraform destroy
         ```

         {% note alert %}

         {{ TF }} will delete all the resources you created using it, such as {{ managed-k8s-name }} clusters, networks, subnets, and [VMs](../../compute/concepts/vm.md).

         {% endnote %}

      1. Confirm the deletion of resources.

   {% endlist %}

1. [Delete the VM](../../compute/operations/vm-control/vm-delete.md) with the DNS server.
1. [Delete the DNS zone](../../dns/operations/zone-delete.md).
