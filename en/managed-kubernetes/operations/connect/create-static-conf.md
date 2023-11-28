# Creating a static configuration file

Static configuration files allow you to access a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) without using the CLI, e.g., from continuous integration systems.

You can also use a static configuration file to configure access to multiple {{ managed-k8s-name }} clusters. You can quickly switch between {{ managed-k8s-name }} clusters described in configuration files using the `kubectl config use-context` command. For more information about how to configure access to multiple {{ managed-k8s-name }} clusters, see the [{{ k8s }} documentation](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/).

To create a configuration file:
* [Prepare a {{ managed-k8s-name }} cluster certificate](#prepare-cert).
* [Create a ServiceAccount object](#create-sa).
* [Prepare a ServiceAccount token](#prepare-token).
* [Create and populate a configuration file](#create-conf-file).
* [Check the result](#check-result).

To run bash commands, you will need a JSON parser: [jq](https://stedolan.github.io/jq/download/).

## Get a unique cluster ID {#k8s-id}

To access a {{ managed-k8s-name }} cluster, use its unique ID. Save it to a variable and use it in other commands.
1. Find the unique ID of the {{ managed-k8s-name }} cluster:

   {% list tabs %}

   - Management console

     1. Go to the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
     1. Click the name of the {{ managed-k8s-name }} cluster.

    The unique ID of the {{ managed-k8s-name }} cluster will appear in the **{{ ui-key.yacloud.k8s.cluster.overview.label_id }}** field.

   - CLI

     ```bash
     yc managed-kubernetes cluster list
     ```

     Result:

     ```bash
     +----------------------+--------+---------------------+---------+---------+------------------------+--------------------+
     |          ID          |  NAME  |     CREATED AT      | HEALTH  | STATUS  |    EXTERNAL ENDPOINT   |  INTERNAL ENDPOINT |
     +----------------------+--------+---------------------+---------+---------+------------------------+--------------------+
     | catb3ppsdsh7******** | my-k8s | 2019-09-04 15:17:11 | HEALTHY | RUNNING | https://84.201.148.31/ | https://10.0.0.24/ |
     +----------------------+--------+---------------------+---------+---------+------------------------+--------------------+
     ```

   {% endlist %}

1. Save the unique ID of the {{ managed-k8s-name }} cluster to a variable.

   {% list tabs %}

   - Bash

     ```bash
     CLUSTER_ID=catb3ppsdsh7********
     ```

   - PowerShell

     ```shell script
     $CLUSTER_ID = "catb3ppsdsh7********"
     ```

   {% endlist %}

## Prepare a cluster certificate {#prepare-cert}

Save the {{ managed-k8s-name }} cluster certificate to a file named `ca.pem`. This certificate confirms the authenticity of the {{ managed-k8s-name }} cluster.

{% list tabs %}

- Bash

  Run a command that:
  * Retrieves {{ managed-k8s-name }} cluster information in JSON format.
  * Leaves only certificate information and removes extra quotes from the certificate contents.
  * Removes unnecessary characters from the certificate contents.
  * Saves the certificate to the `ca.pem` file.

  ```bash
  yc managed-kubernetes cluster get --id $CLUSTER_ID --format json | \
    jq -r .master.master_auth.cluster_ca_certificate | \
    awk '{gsub(/\\n/,"\n")}1' > ca.pem
  ```

- PowerShell

  1. Get detailed information about the {{ managed-k8s-name }} cluster in JSON format and save it to the `$CLUSTER` variable:

     ```shell script
     $CLUSTER = yc managed-kubernetes cluster get --id $CLUSTER_ID --format json | ConvertFrom-Json
     ```

  1. Get the {{ managed-k8s-name }} cluster certificate and save it to the `ca.pem` file:

     ```shell script
     $CLUSTER.master.master_auth.cluster_ca_certificate | Set-Content ca.pem
     ```

{% endlist %}

## Create a ServiceAccount object {#create-sa}

Create a `ServiceAccount` object to interact with the {{ k8s }} API inside the {{ managed-k8s-name }} cluster.
1. Save the following specification for creating a `ServiceAccount` object and its secret in a YAML file named `sa.yaml`.

   See the detailed specification of the `ServiceAccount` object in the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/authentication-resources/service-account-v1/).

   {% list tabs %}

   - {{ managed-k8s-name }} cluster version: 1.24 and higher

      ```yaml
      apiVersion: v1
      kind: ServiceAccount
      metadata:
        name: admin-user
        namespace: kube-system
      ---
      apiVersion: rbac.authorization.k8s.io/v1
      kind: ClusterRoleBinding
      metadata:
        name: admin-user
      roleRef:
        apiGroup: rbac.authorization.k8s.io
        kind: ClusterRole
        name: cluster-admin
      subjects:
      - kind: ServiceAccount
        name: admin-user
        namespace: kube-system
      ---
      apiVersion: v1
      kind: Secret
      type: kubernetes.io/service-account-token
      metadata:
        name: admin-user-token
        namespace: kube-system
        annotations:
          kubernetes.io/service-account.name: "admin-user"
      ```

   - {{ managed-k8s-name }} cluster version: 1.23 and lower

      ```yaml
      apiVersion: v1
      kind: ServiceAccount
      metadata:
        name: admin-user
        namespace: kube-system
      ---
      apiVersion: rbac.authorization.k8s.io/v1
      kind: ClusterRoleBinding
      metadata:
        name: admin-user
      roleRef:
        apiGroup: rbac.authorization.k8s.io
        kind: ClusterRole
        name: cluster-admin
      subjects:
      - kind: ServiceAccount
        name: admin-user
        namespace: kube-system
      ```

   {% endlist %}

1. Create a `ServiceAccount` object and a secret for it:

   ```bash
   kubectl create -f sa.yaml
   ```

## Prepare a ServiceAccount token {#prepare-token}

The token is required for `ServiceAccount` authentication in the {{ managed-k8s-name }} cluster.

{% list tabs %}

- Bash

  Run a command that:
  * Retrieves information about the previously created `admin-user` [service account](../../../iam/concepts/users/service-accounts.md) in JSON format.
  * Leaves only token information and removes extra quotes from the token contents.
  * Decodes the token from Base64.
  * Saves the token contents to the `SA_TOKEN` variable.

  ```bash
  SA_TOKEN=$(kubectl -n kube-system get secret $(kubectl -n kube-system get secret | \
    grep admin-user-token | \
    awk '{print $1}') -o json | \
    jq -r .data.token | \
    base64 --d)
  ```

- PowerShell

  1. Get the `ServiceAccount` token. Quotation marks in its contents will be removed automatically:

     ```shell script
     $SECRET = kubectl -n kube-system get secret -o json | `
       ConvertFrom-Json | `
       Select-Object -ExpandProperty items | `
       Where-Object { $_.metadata.name -like "*admin-user*" }
     ```

  1. Decode the token from Base64:

     ```shell script
     $SA_TOKEN = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($SECRET.data.token))
     ```

{% endlist %}

## Get the cluster IP {#get-cluster-ip}

Get the {{ managed-k8s-name }} cluster [IP](../../../vpc/concepts/address.md) and add it to the `MASTER_ENDPOINT` variable for further use.

{% list tabs %}

- Bash

  Run a command that:
  * Retrieves {{ managed-k8s-name }} cluster details in JSON format based on its unique ID.
  * Leaves only the {{ managed-k8s-name }} cluster IP address.
  * Removes extra quotation marks from its contents.
  * Saves the IP address to the `MASTER_ENDPOINT` variable.

  To connect to the {{ managed-k8s-name }} cluster API from the internet (outside {{ yandex-cloud }}).

  ```bash
  MASTER_ENDPOINT=$(yc managed-kubernetes cluster get --id $CLUSTER_ID \
    --format json | \
    jq -r .master.endpoints.external_v4_endpoint)
  ```

  To use the {{ managed-k8s-name }} cluster API for connecting to the [master](../../concepts/index.md#master) from [cloud networks](../../../vpc/concepts/network.md#network).

   ```bash
   MASTER_ENDPOINT=$(yc managed-kubernetes cluster get --id $CLUSTER_ID \
     --format json | \
     jq -r .master.endpoints.internal_v4_endpoint)
   ```

- PowerShell

  Run the command below to connect to the {{ managed-k8s-name }} cluster API from the internet (outside {{ yandex-cloud }}):

  ```shell script
  $MASTER_ENDPOINT = $CLUSTER.master.endpoints.external_v4_endpoint
  ```

  Run the command below to connect to the {{ managed-k8s-name }} cluster API from cloud networks:

  ```shell script
  $MASTER_ENDPOINT = $CLUSTER.master.endpoints.internal_v4_endpoint
  ```

{% endlist %}

## Create and populate a configuration file {#create-conf-file}

1. Add information about the {{ managed-k8s-name }} cluster to the configuration file.

   {% list tabs %}

   - Bash

     Run this command:

     ```bash
     kubectl config set-cluster sa-test2 \
       --certificate-authority=ca.pem \
       --server=$MASTER_ENDPOINT \
       --kubeconfig=test.kubeconfig
     ```

   - PowerShell

     ```bash
     kubectl config set-cluster sa-test2 `
       --certificate-authority=ca.pem `
       --server=$MASTER_ENDPOINT `
       --kubeconfig=test.kubeconfig
     ```

   {% endlist %}

1. Add token information for `admin-user` to the configuration file.

   {% list tabs %}

   - Bash

     Run this command:

     ```bash
     kubectl config set-credentials admin-user \
       --token=$SA_TOKEN \
       --kubeconfig=test.kubeconfig
     ```

   - PowerShell

     Run this command:

     ```shell script
     kubectl config set-credentials admin-user `
       --token=$SA_TOKEN `
       --kubeconfig=test.kubeconfig
     ```

   {% endlist %}

1. Add context information to the configuration file.

   {% list tabs %}

   - Bash

     Run this command:

     ```bash
     kubectl config set-context default \
       --cluster=sa-test2 \
       --user=admin-user \
       --kubeconfig=test.kubeconfig
     ```

   - PowerShell

     Run this command:

     ```shell script
     kubectl config set-context default `
       --cluster=sa-test2 `
       --user=admin-user `
       --kubeconfig=test.kubeconfig
     ```

   {% endlist %}

1. Use the created configuration for further work.

   {% list tabs %}

   - Bash

     Run this command:

     ```bash
     kubectl config use-context default \
       --kubeconfig=test.kubeconfig
     ```

   - PowerShell

     Run this command:

     ```shell script
     kubectl config use-context default `
       --kubeconfig=test.kubeconfig
     ```

   {% endlist %}

## Check the result {#check-result}

Make sure that the configuration is correct by running the following command:

```bash
kubectl get namespace --kubeconfig=test.kubeconfig
```

Result:

```bash
NAME     STATUS  AGE
default  Active  9d
```
