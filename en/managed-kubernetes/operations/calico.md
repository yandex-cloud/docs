---
title: How to set up the Calico network policy controller in {{ managed-k8s-full-name }}
description: Follow this guide to set up the Calico network policy controller.
---

# Configuring the Calico network policy controller

[Calico](https://www.projectcalico.org/) is an open-source plugin for {{ k8s }} that can be used to manage {{ k8s }} network policies. Calico extends the standard features of {{ k8s }} [network policies](../concepts/network-policy.md), which enables you to:
* Apply policies to any object: [pod](../concepts/index.md#pod), container, [virtual machine](../../compute/concepts/vm.md), or interface.
* Specify a particular action in the policy rules: prohibit, allow, or log.
* Specify as a target or a source: port, port range, protocols, HTTP and ICMP attributes, [IP address](../../vpc/concepts/address.md) or [subnet](../../vpc/concepts/network.md#subnet), and other objects.
* Regulate traffic using DNAT settings and traffic forwarding policies.

To configure the Calico network policy controller:
1. [Create an nginx service](#create-pod).
1. [Isolate pods using network policies](#enable-isolation).
1. [Create network policies enabling service access](#create-policy).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. Create an infrastructure:

   {% list tabs group=instructions %}

   - Manually {#manual}

     1. [Create a cloud network](../../vpc/operations/network-create.md) and [subnet](../../vpc/operations/subnet-create.md).
     1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. [Create a {{ managed-k8s-name }} cluster](kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](node-group/node-group-create.md) in any suitable configuration. When creating it, specify the network, subnet, and security groups prepared earlier. Also, enable the Calico network policy controller in the cluster:
        * In the management console, by selecting **{{ ui-key.yacloud.k8s.clusters.create.field_network-policy }}**.
        * Using the CLI, by setting the `--enable-network-policy` flag.
        * Using the [create](../managed-kubernetes/api-ref/Cluster/create.md) method for the [Cluster](../managed-kubernetes/api-ref/Cluster) resource.

   - {{ TF }} {#tf}

     1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
     1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
     1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
     1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

     1. Download the [k8s-calico.tf](https://github.com/yandex-cloud-examples/yc-mk8s-calico/blob/main/k8s-calico.tf) configuration file of the [{{ managed-k8s-name }} cluster](../concepts/index.md#kubernetes-cluster) to the same working directory. The file describes:
        * [Network](../../vpc/operations/network-create.md).
        * Subnet.
        * {{ managed-k8s-name }} cluster.
        * [Service account](../../iam/concepts/users/service-accounts.md) required for the {{ managed-k8s-name }} cluster and [node group](../concepts/index.md#node-group).
        * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

            {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. Specify the following in the configuration file:
        * [Folder ID](../../resource-manager/operations/folder/get-id.md).
        * [{{ k8s }} version](../concepts/release-channels-and-updates.md) for the {{ managed-k8s-name }} cluster and node groups.
        * {{ managed-k8s-name }} cluster CIDR.
        * Name of the {{ managed-k8s-name }} cluster service account.
     1. Run the `terraform init` command in the directory with the configuration files. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
     1. Check that the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.
     1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Create the `policy-test` namespace](kubernetes-cluster/kubernetes-cluster-namespace-create.md) in your {{ managed-k8s-name }} cluster.

## Create an nginx service {#create-pod}

1. Create a pod with the nginx web server in the `policy-test` [namespace](../concepts/index.md#namespace). Use the {{ k8s }} [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) API object:

   ```bash
   kubectl create deployment --namespace=policy-test nginx --image=nginx
   ```

   Result:

   ```text
   deployment.apps/nginx created
   ```

1. Run the pod with nginx as a {{ k8s }} service:

   ```bash
   kubectl expose --namespace=policy-test deployment nginx --port=80
   ```

   Result:

   ```text
   service/nginx exposed
   ```

1. Make sure the nginx web server is available. Create a pod named `access`:

   ```bash
   kubectl run --namespace=policy-test access --rm -ti --image busybox /bin/sh
   ```

   A shell session opens on the `access` pod:

   ```text
   If you don't see a command prompt, try pressing enter.
   / #
   ```

1. Connect to the nginx web server via the session on the `access` pod:

   ```bash
   wget -q nginx -O -
   ```

   The nginx web server is available:

   ```html
   <!DOCTYPE html>
   <html>
   <head>
   ...
   <p><em>Thank you for using nginx.</em></p>
   </body>
   </html>
   ```

1. Exit the pod:

   ```bash
   / # exit
   ```

   The pod is deleted:

   ```text
   Session ended, resume using 'kubectl attach access -c access -i -t' command when the pod is running
   pod "access" deleted
   ```

## Isolate pods using network policies {#enable-isolation}

Isolate the `policy-test` namespace. As a result, the Calico network policy controller prevents connections to pods in this namespace:

```yaml
kubectl create -f - <<EOF
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: deny
  namespace: policy-test
spec:
  podSelector:
    matchLabels: {}
EOF
```

Network policies are created:

```text
networkpolicy.networking.k8s.io/deny created
```

### Test whether isolation works {#test-isolation}

1. Network policies isolated the nginx web server. To check this, create a pod named `access`:

   ```bash
   kubectl run --namespace=policy-test access --rm -ti --image busybox /bin/sh
   ```

   A shell session opens on the `access` pod:

   ```text
   If you don't see a command prompt, try pressing enter.
   / #
   ```

1. Check if the `access` pod can access the nginx web server:

   ```bash
   wget -q --timeout=5 nginx -O -
   ```

   No connection is established:

   ```text
   wget: download timed out
   / #
   ```

1. Exit the pod:

   ```bash
   / # exit
   ```

   The pod is deleted:

   ```text
   Session ended, resume using 'kubectl attach access -c access -i -t' command when the pod is running
   pod "access" deleted
   ```

## Create network policies enabling service access {#create-policy}

Allow access to the nginx web server using network policies. Only the `access` pod will be allowed to connect by the network policies.
1. Create `access-nginx` network policies:

   ```yaml
   kubectl create -f - <<EOF
   kind: NetworkPolicy
   apiVersion: networking.k8s.io/v1
   metadata:
     name: access-nginx
     namespace: policy-test
   spec:
     podSelector:
       matchLabels:
         app: nginx
     policyTypes:
     - Ingress
     - Egress
     ingress:
       - from:
         - podSelector:
             matchLabels:
               run: access
     egress:
       - to:
         - podSelector:
             matchLabels:
               app: nginx
   EOF
   ```

   {% note info %}

   Network policies will allow traffic from pods with the `run: access` [{{ k8s }} label](../concepts/index.md#node-labels) to pods with the `app: nginx` {{ k8s }} label. Labels are automatically added by kubectl based on the resource name.

   {% endnote %}

   Network policies are created:

   ```text
   networkpolicy.networking.k8s.io/access-nginx created
   ```

1. Create a pod named `access`:

   ```bash
   kubectl run --namespace=policy-test access --rm -ti --image busybox /bin/sh
   ```

   A shell session opens on the `access` pod:

   ```text
   If you don't see a command prompt, try pressing enter.
   / #
   ```

1. Check if the `access` pod can access the nginx web server:

   ```bash
   wget -q --timeout=5 nginx -O -
   ```

   The connection is established:

   ```html
   <!DOCTYPE html>
   <html>
   <head>
   <title>Welcome to nginx!</title>
   ...
   ```

1. Exit the pod:

   ```bash
   / # exit
   ```

   The pod is deleted:

   ```text
   Session ended, resume using 'kubectl attach access -c access -i -t' command when the pod is running
   pod "access" deleted
   ```

### Check the network isolation functionality for other pods {#check-isolation}

The created `access-nginx` network policies allow connections for pods with the `run: access` {{ k8s }} label.
1. Create a pod with no `run: access` label:

   ```bash
   kubectl run --namespace=policy-test cant-access --rm -ti --image busybox /bin/sh
   ```

   A shell session opens on the `cant-access` pod:

   ```text
   If you don't see a command prompt, try pressing enter.
   / #
   ```

1. Check if the `cant-access` pod can access the nginx web server:

   ```bash
   wget -q --timeout=5 nginx -O -
   ```

   No connection is established:

   ```bash
   wget: download timed out
   / #
   ```

1. Exit the pod:

   ```bash
   / # exit
   ```

   The pod is deleted:

   ```text
   Session ended, resume using 'kubectl attach access -c access -i -t' command when the pod is running
   pod "cant-access" deleted
   ```

1. To delete the sample data, delete the namespace:

   ```bash
   kubectl delete ns policy-test
   ```

   The result will be as follows:

   ```text
   namespace "policy-test" deleted
   ```

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

  1. [Delete the {{ managed-k8s-name }} cluster](kubernetes-cluster/kubernetes-cluster-delete.md).
  1. If you reserved a public static IP address for your {{ managed-k8s-name }} cluster, [delete it](../../vpc/operations/address-delete.md).

- {{ TF }} {#tf}

  1. In the command line, go to the directory with the current {{ TF }} configuration file with an infrastructure plan.
  1. Delete the `k8s-calico.tf` configuration file.
  1. Check that the {{ TF }} configuration files are correct using this command:

     ```bash
     terraform validate
     ```

     If there are any errors in the configuration files, {{ TF }} will point them out.
  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     All the resources described in the `k8s-calico.tf` configuration file will be deleted.

{% endlist %}
