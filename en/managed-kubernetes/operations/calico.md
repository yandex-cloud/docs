# Configuring the Calico network policy controller

To configure the [Calico network policy controller](https://www.projectcalico.org/), follow these steps.

## Create a {{ k8s }} cluster with Calico support {#create-cluster}

When creating a {{ k8s }} cluster, activate the Calico network policy controller:
* In the management console, select **Enable network policies**.
* Using the CLI, set the `--enable-network-policy` flag.
* Using the [create](../api-ref/Cluster/create.md) method for the [Cluster](../api-ref/Cluster) resource.

{% cut "How to create a {{ k8s }} cluster" %}

{% list tabs %}

- Management console

  {% include [create-cluster](../../_includes/managed-kubernetes/cluster-create.md) %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Create a {{ k8s }} cluster:

  ```bash
  yc managed-kubernetes cluster create
    --name cluster-np \
    --service-account-name k8s \
    --node-service-account-name docker \
    --zone {{ region-id }}-a \
    --network-name network \
    --enable-network-policy
  ```

  Where:
  * `--name`: The {{ k8s }} cluster name.
  * `--service-account-id`: The unique ID of the service account for the resources. The resources that the {{ k8s }} cluster needs will be created on behalf of this account.
  * `--node-service-account-id`: The unique ID of the service account for the nodes. Nodes will download the Docker images they require from the registry on behalf of this account.
  * `--zone`: Availability zone.
  * `--network-name`: Name of the network.
  * `--enable-network-policy`: Option that enables network policies.

  Command execution result:

  ```bash
  done (8m52s)
  id: abcdef1ghi23jklmno4
  folder_id: p5q67rs89tuv1wxyzab
  ...
  release_channel: REGULAR
  network_policy:
    provider: CALICO
  ```

- API

  To create a {{ k8s }} cluster, use the [create](../api-ref/Cluster/create.md) method for the [Cluster](../api-ref/Cluster) resource.

{% endlist %}

{% endcut %}

## Create a {{ k8s }} namespace {#configure-namespace}

Create a namespace using the {{ k8s }} [Namespace]({{ k8s-docs }}/concepts/overview/working-with-objects/namespaces/) API object:

```
kubectl create ns policy-test
```

Command execution result:

```
namespace/policy-test created
```

## Create an nginx service {#create-pod}

To create a pod, use the {{ k8s }} [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) API object.

1. Create a pod with the nginx web server in the `policy-test` namespace:

   ```
   kubectl create deployment --namespace=policy-test nginx --image=nginx
   ```

   Command execution result:

   ```
   deployment.apps/nginx created
   ```

1. Run the pod with nginx as a {{ k8s }} service:

   ```
   kubectl expose --namespace=policy-test deployment nginx --port=80
   ```

   Execution result:

   ```
   service/nginx exposed
   ```

1. Make sure the nginx web server is available. To do this, create a pod named `access`:

   ```
   kubectl run --namespace=policy-test access --rm -ti --image busybox /bin/sh
   ```

   A shell session opens on the `access` pod:

   ```
   If you don't see a command prompt, try pressing enter.
   / #
   ```

1. Connect to the nginx web server via the session on the `access` pod:

   ```
   wget -q nginx -O -
   ```

   The nginx web server is available:

   ```
   <!DOCTYPE html>
   <html>
   <head>
   <title>Welcome to nginx!</title>
   <style>
     body {
       width: 35em;
       margin: 0 auto;
       font-family: Tahoma, Verdana, Arial, sans-serif;
     }
   </style>
   </head>
   <body>
   <h1>Welcome to nginx!</h1>
   <p>If you see this page, the nginx web server is successfully installed and
   working. Further configuration is required.</p>

   <p>For online documentation and support please refer to
   <a href="http://nginx.org/">nginx.org</a>.<br/>
   Commercial support is available at
   <a href="http://nginx.com/">nginx.com</a>.</p>

   <p><em>Thank you for using nginx.</em></p>
   </body>
   </html>
   ```

1. Exit the pod:

   ```
   / # exit
   ```

   The pod is deleted:

   ```
   Session ended, resume using 'kubectl attach access -c access -i -t' command when the pod is running
   pod "access" deleted
   ```

## Isolate pods using network policies {#enable-isolation}

Isolate the `policy-test` namespace. As a result, the Calico network policy controller prevents connections to pods in this namespace:

```
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

```
networkpolicy.networking.k8s.io/default-deny created
```

### Test whether isolation works {#test-isolation}

1. Network policies isolated the nginx web server. To check this, create a pod named `access`:

   ```
   kubectl run --namespace=policy-test access --rm -ti --image busybox /bin/sh
   ```

   A shell session opens on the `access` pod:

   ```
   If you don't see a command prompt, try pressing enter.
   / #
   ```

1. Check if the `access` pod can access the nginx web server:

   ```
   wget -q --timeout=5 nginx -O -
   ```

   No connection is established:

   ```
   wget: download timed out
   / #
   ```

1. Exit the pod:

   ```
   / # exit
   ```

   The pod is deleted:

   ```
   Session ended, resume using 'kubectl attach access -c access -i -t' command when the pod is running
   pod "access" deleted
   ```

## Create network policies enabling service access {#create-policy}

Allow access to the nginx web server using network policies. Network policies will only allow the `access` pod to connect to it.

1. Create `access-nginx` network policies:

   ```
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

   ```
   networkpolicy.networking.k8s.io/access-nginx created
   ```

1. Create a pod named `access`:

   ```
   kubectl run --namespace=policy-test access --rm -ti --image busybox /bin/sh
   ```

   A shell session opens on the `access` pod:

   ```
   If you don't see a command prompt, try pressing enter.
   / #
   ```

1. Check if the `access` pod can access the nginx web server:

   ```
   wget -q --timeout=5 nginx -O -
   ```

   The connection is established:

   ```
   <!DOCTYPE html>
   <html>
   <head>
   <title>Welcome to nginx!</title>
   ...
   ```

1. Exit the pod:

   ```
   / # exit
   ```

   The pod is deleted:

   ```
   Session ended, resume using 'kubectl attach access -c access -i -t' command when the pod is running
   pod "access" deleted
   ```

### Check the network isolation functionality for other pods {#check-isolation}

The created `access-nginx` network policies allow connections for pods with the `run: access` label.

1. Create a pod with no `run: access` label:

   ```
   kubectl run --namespace=policy-test cant-access --rm -ti --image busybox /bin/sh
   ```

   A shell session opens on the `cant-access` pod:

   ```
   If you don't see a command prompt, try pressing enter.
   / #
   ```

1. Check if the `cant-access` pod can access the nginx web server:

   ```
   wget -q --timeout=5 nginx -O -
   ```

   No connection is established:

   ```
   wget: download timed out
   / #
   ```

1. Exit the pod:

   ```
   / # exit
   ```

   The pod is deleted:

   ```
   Session ended, resume using 'kubectl attach access -c access -i -t' command when the pod is running
   pod "cant-access" deleted
   ```

1. To delete the sample data, delete the namespace:

   ```
   kubectl delete ns policy-test
   ```

   Command execution result:

   ```
   namespace "policy-test" deleted
   ```