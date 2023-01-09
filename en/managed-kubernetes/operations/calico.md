# Configuring the Calico network policy controller

[Calico](https://www.projectcalico.org/) is an open-source plugin for {{ k8s }} that can be used to manage {{ k8s }} network policies. Calico extends the standard features of {{ k8s }} network policies, which enables you to:
* Apply policies to any object: pod, container, virtual machine, or interface.
* Specify a particular action in the policy rules: prohibit, allow, or log.
* Specify as a target or a source: port, port range, protocols, HTTP and ICMP attributes, IP address or subnet, and other objects.
* Regulate traffic using DNAT settings and traffic forwarding policies.

To configure the Calico network policy controller:
1. [{#T}](#create-pod).
1. [{#T}](#enable-isolation).
1. [{#T}](#create-policy).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

1. Create an infrastructure:

   {% list tabs %}

   - Manually

     1. Create a [cloud network](../../vpc/operations/network-create.md) and [subnet](../../vpc/operations/subnet-create.md).
     1. [Create a {{ managed-k8s-name }} cluster](kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](node-group/node-group-create.md) in any suitable configuration. When creating a {{ managed-k8s-name }} cluster, activate the Calico network policy controller:
        * In the management console, select **Enable network policies**.
        * Using the CLI, set the `--enable-network-policy` flag.
        * Using the [create](../api-ref/Cluster/create.md) method for the [Cluster](../api-ref/Cluster) resource.

   - Using {{ TF }}

     1. If you don't have {{ TF }}, [install it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
     1. Download the [k8s-calico.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-calico.tf) cluster configuration file to the same working directory. The file describes:
        * Network.
        * Subnet.
        * Security group and rules needed to run the cluster:
          * Rules for service traffic.
          * Rules for accessing the {{ k8s }} API and managing the cluster with `kubectl` through ports 443 and 6443.
        * {{ managed-k8s-name }} cluster.
        * Service account required to use the {{ managed-k8s-name }} cluster and node group.
     1. Specify the following in the configuration file:
        * [Folder ID](../../resource-manager/operations/folder/get-id.md).
        * {{ k8s }} version for the {{ managed-k8s-name }} cluster and node groups.
        * {{ managed-k8s-name }} cluster CIDR.
        * Name of the cluster service account.
     1. Run the `terraform init` command in the directory with the configuration files. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
     1. Make sure the {{ TF }} configuration files are correct using the command:

        ```bash
        terraform validate
        ```

        If there are errors in the configuration files, {{ TF }} will point to them.
     1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. [Create a `policy-test` namespace](kubernetes-cluster/kubernetes-cluster-namespace-create.md) in the {{ managed-k8s-name }} cluster.

## Create an nginx service {#create-pod}

1. Create a pod with the nginx web server in the `policy-test` namespace. Use the {{ k8s }} [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) API object:

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

1. Make sure the nginx web server is available. To do this, create a pod named `access`:

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
networkpolicy.networking.k8s.io/default-deny created
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

Allow access to the nginx web server using network policies. Network policies will only allow the `access` pod to connect to it.

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
     ingress:
       - from:
         - podSelector:
             matchLabels:
               run: access
   EOF
   ```

   {% note info %}

   Network policies will allow traffic from pods labeled `run: access` to pods labeled `app: nginx`. Labels are automatically added by kubectl based on the resource name.

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

The created `access-nginx` network policies allow connections for pods with the `run: access` label.
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

   Command result:

   ```text
   namespace "policy-test" deleted
   ```

## Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:

{% list tabs %}

- Manually

  1. [Delete the {{ managed-k8s-name }} cluster](kubernetes-cluster/kubernetes-cluster-delete.md).
  1. If you reserved a public static IP address for the cluster, [delete it](../../vpc/operations/address-delete.md).

- Using {{ TF }}

  1. In the command line, go to the directory with the current {{ TF }} configuration file with an infrastructure plan.
  1. Delete the `k8s-calico.tf` configuration file.
  1. Make sure the {{ TF }} configuration files are correct using the command:

     ```bash
     terraform validate
     ```

     If there are errors in the configuration files, {{ TF }} will point to them.
  1. Confirm the update of resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     All the resources described in the `k8s-calico.tf` configuration file will be deleted.

{% endlist %}