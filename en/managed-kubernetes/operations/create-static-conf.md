# Creating a configuration file

Static configuration files let you access a {{ k8s }} cluster without using the CLI (for example, from continuous integration systems).

You can also use a static configuration file to configure access to multiple {{ k8s }} clusters. You can quickly switch between {{ k8s }} clusters described in configuration files using the `kubectl config use-context` command. For more information about how to configure access to multiple {{ k8s }} clusters, see the [{{ k8s }} documentation](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/).

To create a configuration file:

- [Prepare a {{ k8s }} cluster certificate](#prepare-cert).
- [Create a ServiceAccount object](#create-sa).
- [Prepare a ServiceAccount token](#prepare-token).
- [Create and populate a configuration file](#create-conf-file).
- [Check the results](#check-result).

To run bash commands, you'll need a JSON parser: [jq](https://stedolan.github.io/jq/download/).

## Get a unique cluster ID {{ k8s }} {#k8s-id}

To access a {{ k8s }} cluster, use its unique ID. Save it to a variable and use it in other commands.

1. Find the unique ID of the {{ k8s }} cluster:

    {% list tabs %}

    - Management console
         1. Go to the folder page and select {{ managed-k8s-name }}.
         1. Click on the name of the {{ k8s }} cluster you need.

         You can see the unique ID of the {{ k8s }} cluster under **General information**.

    - CLI

         ```bash
         yc managed-kubernetes cluster list
         ```

         Result:

         ```
         +----------------------+----------+---------------------+---------+---------+-------------------------+----------------------+
         |          ID          |   NAME   |     CREATED AT      | HEALTH  | STATUS  |    EXTERNAL ENDPOINT    |  INTERNAL ENDPOINT   |
         +----------------------+----------+---------------------+---------+---------+-------------------------+----------------------+
         | catb3ppsdsh7vajr216f | my-k8s   | 2019-09-04 15:17:11 | HEALTHY | RUNNING | https://84.201.148.31/  | https://10.0.0.24/   |
         +----------------------+----------+---------------------+---------+---------+-------------------------+----------------------+
         ```

    {% endlist %}

1. Save the unique ID of the {{ k8s }} cluster to a variable.

    {% list tabs %}

    - Bash

        Run the command:

        ```
        CLUSTER_ID=catb3ppsdsh7vajr216f
        ```

    - PowerShell

        Run the command:

        ```
        $CLUSTER_ID = "catb3ppsdsh7vajr216f"
        ```

    {% endlist %}

## Prepare the cluster certificate {{ k8s }} {#prepare-cert}

Save the {{ k8s }} cluster certificate to a `ca.pem` file. This certificate confirms the authenticity of the {{ k8s }} cluster.

{% list tabs %}

- Bash

    Run a command that:
    - Retrieves cluster information in JSON format.
    - Leaves only certificate information and removes extra quotation marks from the certificate contents.
    - Removes unnecessary characters from the certificate contents.
    - Saves the certificate to the `ca.pem` file.

    ```
    yc managed-kubernetes cluster get --id $CLUSTER_ID --format json | \
        jq -r .master.master_auth.cluster_ca_certificate | \
        awk '{gsub(/\\n/,"\n")}1' > ca.pem
    ```

- PowerShell

    1. Get detailed information about the {{ k8s }} cluster in JSON format and save it to the `$CLUSTER` variable:

        ```
        $CLUSTER = yc managed-kubernetes cluster get --id $CLUSTER_ID --format json | ConvertFrom-Json   
        ```

    1. Get the {{ k8s }} cluster certificate and save it to the `ca.pem` file:

        ```
        $CLUSTER.master.master_auth.cluster_ca_certificate | Set-Content ca.pem
        ```

{% endlist %}

## Create a ServiceAccount object {#create-sa}

Create a `ServiceAccount` object to interact with the {{ k8s }} API inside the {{ k8s}} cluster.

1. Save the following specification for `ServiceAccount` creation in a YAML file named `sa.yaml`.

    See the detailed specification of the `ServiceAccount` object in the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/authentication-resources/service-account-v1/).

    ```
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

1. Create a `ServiceAccount` object:

    ```
    kubectl create -f sa.yaml
    ```

## Prepare a ServiceAccount token {#prepare-token}

The token is required for `ServiceAccount` authentication in the {{ k8s }} cluster.

{% list tabs %}

- Bash

    Run a command that:
    - Retrieves information about the `admin-user` service account in JSON format.
    - Leaves only certificate information and removes extra quotation marks from the token contents.
    - Decodes the token from Base64.
    - Saves the token contents to the `SA_TOKEN` variable.

    ```
    SA_TOKEN=$(kubectl -n kube-system get secret $(kubectl -n kube-system get secret | \
        grep admin-user | \
        awk '{print $1}') -o json | \
        jq -r .data.token | \
        base64 --d)
    ```

- PowerShell

    1. Get the `ServiceAccount` token. Quotation marks in its contents will be removed automatically:

        ```
        $SECRET = kubectl -n kube-system get secret -o json | `
            ConvertFrom-Json | `
            Select-Object -ExpandProperty items | `
            Where-Object { $_.metadata.name -like "*admin-user*" }
        ```

    1. Decode the token from Base64:

        ```
        $SA_TOKEN = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($SECRET.data.token))
        ```

{% endlist %}

## Get the cluster's IP address. {{ k8s }} {#get-cluster-ip}

Get the {{ k8s }} cluster IP and add it to the `MASTER_ENDPOINT` variable for further use.

{% list tabs %}

- Bash

    Run a command that:
    - Retrieves information about the {{ k8s }} cluster with the unique ID `c497ipckbqppifcvrnrk` in JSON format.
    - Leaves only the {{ k8s }} cluster IP address.
    - Removes extra quotation marks from its contents.
    - Saves the IP address to the `MASTER_ENDPOINT` variable.

    ```
    MASTER_ENDPOINT=$(yc managed-kubernetes cluster get --id $CLUSTER_ID \
        --format json | \
        jq -r .master.endpoints.external_v4_endpoint)
    ```

- PowerShell

    Run the command:

    ```
    $MASTER_ENDPOINT = $CLUSTER.master.endpoints.external_v4_endpoint
    ```

{% endlist %}

## Create and populate a configuration file {#create-conf-file}

1. Add information about the {{ k8s }} cluster to the configuration file.

    {% list tabs %}

    - Bash

        Run the command:

        ```
        kubectl config set-cluster sa-test2 \
                       --certificate-authority=ca.pem \
                       --server=$MASTER_ENDPOINT \
                       --kubeconfig=test.kubeconfig
        ```

    - PowerShell

        ```
        kubectl config set-cluster sa-test2 `
                       --certificate-authority=ca.pem `
                       --server=$MASTER_ENDPOINT `
                       --kubeconfig=test.kubeconfig
        ```

    {% endlist %}

1. Add token information for `admin-user` to the configuration file.

    {% list tabs %}

    - Bash

        Run the command:

        ```
        kubectl config set-credentials admin-user \
                        --token=$SA_TOKEN \
                        --kubeconfig=test.kubeconfig
        ```

    - PowerShell

        Run the command:

        ```
        kubectl config set-credentials admin-user `
                        --token=$SA_TOKEN `
                        --kubeconfig=test.kubeconfig
        ```

    {% endlist %}

1. Add context information to the configuration file.

    {% list tabs %}

    - Bash

        Run the command:

        ```
        kubectl config set-context default \
                       --cluster=sa-test2 \
                       --user=admin-user \
                       --kubeconfig=test.kubeconfig
        ```

    - PowerShell

        Run the command:

        ```
        kubectl config set-context default `
                       --cluster=sa-test2 `
                       --user=admin-user `
                       --kubeconfig=test.kubeconfig
        ```

    {% endlist %}

1. Use the created configuration for further work.

    {% list tabs %}

    - Bash

        Run the command:

        ```
        kubectl config use-context default \
                       --kubeconfig=test.kubeconfig
        ```

    - PowerShell

        Run the command:

        ```
        kubectl config use-context default `
                       --kubeconfig=test.kubeconfig
        ```

    {% endlist %}

## Check the results {#check-result}

Make sure that the configuration is correct by running the command:

```
kubectl get namespace --kubeconfig=test.kubeconfig

NAME          STATUS   AGE
default       Active   9d
```

