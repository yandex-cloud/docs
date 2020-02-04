# Integration with {{ container-registry-name }}

To integrate {{ k8s }} with {{ container-registry-name }}, create the following resources: service accounts for managing resources and respective access permissions, a {{ k8s }} cluster, a node group, and a Docker registry and image. To facilitate authentication, configure the Docker Credential helper and make sure that a pod with an app from {{ container-registry-name }} launches using a service account with no additional authentication.

1. [Create service accounts](#create-sa)
    1. [Create a service account for resources](#res-sa)
    1. [Create a service account for nodes](#node-sa)
1. [Prepare the necessary {{ k8s }} resources](#create-k8s-res)
    1. [Create a {{ k8s }} cluster](#create-cluster)
    1. [Create a node group](#create-node-groups)
1. [Prepare the necessary {{ container-registry-name }} resources](#create-cr-res)
    1. [Create a registry](#registry-create)
    1. [Configure the Credential helper](#config-ch)
    1. [Prepare a Docker image](#docker-image)
1. [Connect to the {{ k8s }} cluster](#cluster-connect)
1. [Run the test app](#test-app)
1. [Delete the created resources](#delete-resources)

{% include [before-you-begin](../../_includes/before-begin.md) %}

## Create service accounts {#create-sa}

Create [service accounts](../../iam/operations/sa/create.md):

- A service account for resources with the [{{ roles-editor }}](../../resource-manager/security/#roles-list) role for the folder where the {{ k8s }} cluster will be created. The resources that the {{ k8s }} cluster needs will be created on behalf of this account.
- A service account for nodes with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#required-roles) role for the folder containing the Docker image registry. Nodes will download the Docker images they require from the registry on behalf of this account.

### Create a service account for resources {#res-sa}

To create a service account for making the resources required by the {{ k8s }} cluster:

1. Write the folder ID from your CLI profile configuration to the variable:

    {% list tabs %}

    - Bash

        ```
        $ FOLDER_ID=$(yc config get folder-id)
        ```

    - PowerShell

        ```
        > $FOLDER_ID = yc config get folder-id
        ```

    {% endlist %}

1. Create a service account:

    {% list tabs %}

    - Bash

        ```
        $ yc iam service-account create --name k8s-res-sa-$FOLDER_ID
        ```

    - PowerShell

        ```
        > yc iam service-account create --name k8s-res-sa-$FOLDER_ID
        ```

    {% endlist %}

1. Write the service account ID to the variable:

    {% list tabs %}

    - Bash

        ```
        $ RES_SA_ID=$(yc iam service-account get --name k8s-res-sa-${FOLDER_ID} --format json | jq .id -r)
        ```

    - PowerShell

        ```
        > $RES_SA_ID = (yc iam service-account get --name k8s-res-sa-$FOLDER_ID --format json | ConvertFrom-Json).id
        ```

    {% endlist %}

1. Assign to the service account the [{{ roles-editor }}](../../resource-manager/security/#roles-list) role for the folder:

    ```
    yc resource-manager folder add-access-binding --id $FOLDER_ID --role editor --subject serviceAccount:$RES_SA_ID
    ```

### Create a service account for nodes {#node-sa}

To create a service account that lets nodes download the necessary Docker images from the registry:

1. Write the folder ID from your CLI profile configuration to the variable:

    {% list tabs %}

    - Bash

        ```
        $ FOLDER_ID=$(yc config get folder-id)
        ```

    - PowerShell

        ```
        > $FOLDER_ID = yc config get folder-id
        ```

    {% endlist %}

1. Create a service account:

    {% list tabs %}

    - Bash

        ```
        $ yc iam service-account create --name k8s-node-sa-$FOLDER_ID
        ```

    - PowerShell

        ```
        > yc iam service-account create --name k8s-node-sa-$FOLDER_ID
        ```

    {% endlist %}

1. Write the service account ID to the variable:

    {% list tabs %}

    - Bash

        ```
        $ NODE_SA_ID=$(yc iam service-account get --name k8s-node-sa-${FOLDER_ID} --format json | jq .id -r)
        ```

    - PowerShell

        ```
        > $NODE_SA_ID = (yc iam service-account get --name k8s-node-sa-$FOLDER_ID --format json | ConvertFrom-Json).id
        ```

    {% endlist %}

1. Assign to the service account the [{{ roles-cr-puller }}](../../container-registry/security/index.md#required-roles) role for the folder:

    ```
    yc resource-manager folder add-access-binding --id $FOLDER_ID --role container-registry.images.puller --subject serviceAccount:$NODE_SA_ID
    ```

{% include [create-k8s-res](../../_includes/managed-kubernetes/create-k8s-res.md) %}

## Prepare {{ container-registry-name }} resources {#create-cr-res}

### Create a registry {#registry-create}

Create a container registry:

```
yc container registry create --name yc-auto-cr
```

### Configure the Docker Credential helper {#config-ch}

To facilitate authentication in {{ container-registry-name }}, configure the [Docker Credential helper](../../container-registry/operations/authentication.md#cred-helper). It lets you use private Yandex.Cloud registries without running the `docker login` command.

To configure the Credential helper, run the following command:

```
yc container registry configure-docker
```

### Prepare a Docker image {#docker-image}

Build a Docker image and push it to the registry:

1. Create a Dockerfile named `hello.dockerfile` and add the following lines to it:

    ```
    FROM ubuntu:latest
    CMD echo "Hi, I'm inside"
    ```

1. Build a Docker image:

    1. Get the ID of the [previously created](#registry-create) registry and write it to the variable:

        {% list tabs %}

        - Bash

            ```
            $ REGISTRY_ID=$(yc container registry get --name yc-auto-cr  --format json | jq .id -r)
            ```

        - PowerShell

            ```
            > $REGISTRY_ID = (yc container registry get --name yc-auto-cr  --format json | ConvertFrom-Json).id
            ```

        {% endlist %}

    1. Build a Docker image:

        ```
        docker build . -f hello.dockerfile -t cr.yandex/$REGISTRY_ID/ubuntu:hello
        ```

    1. Push the Docker image to the registry:

        ```
        docker push cr.yandex/${REGISTRY_ID}/ubuntu:hello
        ```

1. Make sure the Docker image was pushed to the registry:

    ```
    yc container image list
    
    +----------------------+---------------------+-----------------------------+-------+-----------------+
    |          ID          |       CREATED       |            NAME             | TAGS  | COMPRESSED SIZE |
    +----------------------+---------------------+-----------------------------+-------+-----------------+
    | crpa2mf008mpjig73rp6 | 2019-11-20 11:52:17 | crp71hkgiolp6677hg9i/ubuntu | hello | 27.5 MB         |
    +----------------------+---------------------+-----------------------------+-------+-----------------+
    ```

{% include [kubectl-connect](../../_includes/managed-kubernetes/kubectl-connect.md) %}

## Run the test app {#test-app}

Start the pod with the app from the Docker image and make sure that no additional authentication in {{ container-registry-short-name }} was required to push the Docker image.

1. Run the pod with the app from the Docker image:

    ```
    kubectl run --attach hello-ubuntu --image cr.yandex/${REGISTRY_ID}/ubuntu:hello
    ```

1. Find the running pod to see its full name:

    ```
    kubectl get po
    
    NAME                            READY   STATUS      RESTARTS   AGE
    hello-ubuntu-5847fb96b4-54g48   0/1     Completed   3          61s
    ```

1. Check the logs of the container running on this pod:

    ```
    kubectl logs hello-ubuntu-5847fb96b4-54g48
    
    Hi, I'm inside
    ```

    The pod pushed the Docker image with no additional authentication on the {{ container-registry-short-name }} side.

## Delete the created resources {#delete-resources}

1. Delete the {{ k8s }} cluster:

    ```
    yc managed-kubernetes cluster delete --name k8s-demo
    ```

1. Delete the service accounts:

    {% note important %}

    Make sure you don't delete any service accounts before deleting the {{ k8s }} cluster.

    {% endnote %}

    - Delete the service account created for resources:

        ```
        yc iam service-account delete --id $RES_SA_ID
        ```

    - Delete the service account created for nodes:

        ```
        yc iam service-account delete --id $NODE_SA_ID
        ```

1. Delete the {{ container-registry-short-name }} resources:

    1. Find the name of the Docker image pushed to the registry:

        {% list tabs %}

        - Bash

            ```
            $ IMAGE_ID=$(yc container image list --format json | jq .[0].id -r)
            ```

        - PowerShell

            ```
            > $IMAGE_ID = (yc container image list --format json | ConvertFrom-Json).id
            ```

        {% endlist %}

    1. Delete the Docker image:

        ```
        yc container image delete --id $IMAGE_ID
        ```

    1. Delete the registry:

        ```
        yc container registry delete --name yc-auto-cr
        ```

#### See also {#see-also}

* [{#T}](../../container-registry/concepts/docker-image.md)
* [{#T}](../../container-registry/operations/authentication.md)
* [{#T}](../../container-registry/operations/index.md)

