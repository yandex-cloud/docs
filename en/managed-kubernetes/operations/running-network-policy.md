# Using cluster network policies in {{ k8s }}

To check how {{ k8s }} network policies run, follow these steps.

## Create a cluster {{ k8s }} {#create-cluster}

When creating a {{ k8s }} cluster, enable network policies to use the [Calico](https://www.projectcalico.org/) network policy controller:
* In the management console, select **Enable network policies**.
* Using the CLI, set the `--enable-network-policy` flag.
* Using the [create](../api-ref/Cluster/create.md) method for the [Cluster](../api-ref/Cluster) resource.

{% cut "How to create a {{ k8s }} cluster" %}

{% list tabs %}

- Management console

   1. In [management console]({{ link-console-main }}), select the folder where you want to create your {{ k8s }} cluster.
   1. In the list of services, select **{{ managed-k8s-name }}**.
   1. Click **Create cluster**.
   1. Enter the {{ k8s }} cluster name.
   1. Specify a **service account for the resources**. This is used to create the resources.
   1. Specify a **service account for nodes**. The nodes use this service account to access the Docker image registry.
   1. Specify a [release channel](../concepts/release-channels-and-updates.md).
   1. Under **Master configuration**:
      * In the **{{ k8s }} version** field, select the {{ k8s }} version to be installed on the master.
      * In the **Public IP** field, choose a method for assigning an IP address:
        * **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
        * **No address**: Don't assign a public IP address.
      * In the **Master type** field, select the type of master:
        * **Zonal**: A master created in a subnet in one availability zone.
        * **Regional**: A master created and distributed in three subnets in each availability zone.
      * Select the [availability zone](../../overview/concepts/geo-scope.md) to create a [master](../concepts/index.md#master) in.

        This step is only available for the zonal master.

      * In the **Cloud network** field, select the network to create the master in.

      * In the **Subnet** field, select the subnet to create the master in.

        For the regional master, specify three subnets in each availability zone.
   1. Under **Maintenance window settings**:
      * In the **Maintenance frequency / Disable** field, configure the maintenance window:
        * **Disabled**: Automatic updates are disabled.
        * **Anytime**: Maintenance is allowed at any time.
        * **Daily**: Maintenance is performed in the time interval specified in the **Time (UTC) and duration** field.
        * **On selected days**: Maintenance is performed in the time interval specified in the **Weekly schedule** field.
   1. Under **Cluster network settings**:
      * Select the **Enable network policies** option for the {{ k8s }} cluster to use the Calico network policy controller.
   1. Click **Create cluster**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Create a {{ k8s }} cluster:

   ```bash
   yc managed-kubernetes cluster create
     --name cluster-np \
     --service-account-name k8s \
     --node-service-account-name docker \
     --zone ru-central1-a \
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
   created_at: "2020-09-14T15:56:31Z"
   name: k8s-np
   status: RUNNING
   health: HEALTHY
   network_id: cdefghig01klmnopqrs1
   master:
     zonal_master:
       zone_id: ru-central1-a
       internal_v4_address: 10.130.0.24
     version: "1.17"
     endpoints:
       internal_v4_endpoint: https://10.130.0.24
     master_auth:
       cluster_ca_certificate: |
         -----BEGIN CERTIFICATE-----
         MIICyDCCAbCgAwIBAgIBADANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDEwprdWJl
         ...
         IyO849nznkMKNHzxvQKnXSNNTmbPu9DmPx8MsdI2vcklBbtkiHtc6U3y25I=
         -----END CERTIFICATE-----
     version_info:
       current_version: "1.17"
     maintenance_policy:
       auto_upgrade: true
       maintenance_window:
         anytime: {}
   ip_allocation_policy:
     cluster_ipv4_cidr_block: 10.112.0.0/16
     node_ipv4_cidr_mask_size: "24"
     service_ipv4_cidr_block: 10.96.0.0/16
   service_account_id: ajedclfluactb5868n99
   node_service_account_id: ajeo8f063dmnicot7t7j
   release_channel: REGULAR
   network_policy:
     provider: CALICO
   ```

- API

   To create a {{ k8s }} cluster, use the [create](../api-ref/Cluster/create.md) method for the [Cluster](../api-ref/Cluster) resource.

{% endlist %}

{% endcut %}

## Create a namespace {{ k8s }} {#сonfigure-namespace}

Create a namespace using the {{ k8s }} [Namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) API object:

```bash
kubectl create ns policy-test
```

Command execution result:

```bash
namespace/policy-test created
```

## Create an nginx service {#create-pod}

To create a pod, use the {{ k8s }} [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) API object.

1. Create a pod with the nginx web server in the `policy-test` namespace:

   ```bash
   kubectl create deployment --namespace=policy-test nginx --image=nginx
   ```

   Command execution result:

   ```bash
   deployment.apps/nginx created
   ```

1. Run the pod with nginx as a {{ k8s }} service:

   ```bash
   kubectl expose --namespace=policy-test deployment nginx --port=80
   ```

   Execution result:

   ```bash
   service/nginx exposed
   ```

1. Make sure the nginx web server is available. To do this, create a pod named `access`:

   ```bash
   kubectl run --namespace=policy-test access --rm -ti --image busybox /bin/sh
   ```

   A shell session opens on the `access` pod:

   ```bash
   If you don't see a command prompt, try pressing enter.
   / #
   ```

1. Connect to the nginx web server via the session on the `access` pod:

   ```bash
   wget -q nginx -O -
   ```

   The nginx web server is available:

   ```bash
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

   ```bash
   / # exit
   ```

   The pod is deleted:

   ```
   Session ended, resume using 'kubectl attach access -c access -i -t' command when the pod is running
   pod "access" deleted
   ```

## Isolate pods using network policies {#enable-isolation}

Isolate the `policy-test` namespace. As a result, the Calico network policy controller prevents connections to pods in this namespace:

```bash
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

```bash
networkpolicy.networking.k8s.io/default-deny created
```

### Test how isolation works {#test-isolation}

1. Network policies isolated the nginx web server. To check this, create a pod named `access`:

   ```bash
   kubectl run --namespace=policy-test access --rm -ti --image busybox /bin/sh
   ```

   A shell session opens on the `access` pod:

   ```bash
   If you don't see a command prompt, try pressing enter.
   / #
   ```

1. Check if the `access` pod can access the nginx web server:

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

   ```bash
   Session ended, resume using 'kubectl attach access -c access -i -t' command when the pod is running
   pod "access" deleted
   ```

## Create network policies that allow access to the service {#create-policy}

Allow access to the nginx web server using network policies. Network policies will only allow the `access` pod to connect to it.

1. Create `access-nginx` network policies:

   ```bash
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

   ```bash
   networkpolicy.networking.k8s.io/access-nginx created
   ```

1. Create a pod named `access`:

   ```bash
   kubectl run --namespace=policy-test access --rm -ti --image busybox /bin/sh
   ```

   A shell session opens on the `access` pod:

   ```bash
   If you don't see a command prompt, try pressing enter.
   / #
   ```

1. Check if the `access` pod can access the nginx web server:

   ```bash
   wget -q --timeout=5 nginx -O -
   ```

   The connection is established:

   ```bash
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

   ```bash
   Session ended, resume using 'kubectl attach access -c access -i -t' command when the pod is running
   pod "access" deleted
   ```

### Check that network isolation is available for other pods {#сheck-isolation}

The created `access-nginx` network policies allow connections for pods with the `run: access` label.

1. Create a pod with no `run: access` label:

   ```bash
   kubectl run --namespace=policy-test cant-access --rm -ti --image busybox /bin/sh
   ```

   A shell session opens on the `cant-access` pod:

   ```bash
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

   ```bash
   Session ended, resume using 'kubectl attach access -c access -i -t' command when the pod is running
   pod "cant-access" deleted
   ```

1. To delete the sample data, delete the namespace:

   ```bash
   kubectl delete ns policy-test
   ```

   Command execution result:

   ```bash
   namespace "policy-test" deleted
   ```