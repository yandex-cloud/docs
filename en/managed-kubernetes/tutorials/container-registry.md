# Integration with {{ container-registry-name }}

To integrate {{ k8s }} with {{ container-registry-full-name }}, create the following resources: [service accounts](../../iam/concepts/users/service-accounts.md) for managing resources and respective access permissions, a [{{ k8s }} cluster](../concepts/index.md#kubernetes-cluster), a [node group](../concepts/index.md#node-group), a Docker registry, and a [Docker image](../../container-registry/concepts/docker-image.md). To facilitate authentication, configure Docker Credential Helper and make sure that a [pod](../concepts/index.md#pod) with an application from {{ container-registry-name }} launches using a service account with no additional authentication required.
1. [Create service accounts](#create-sa)
   1. [Create a service account for resources](#res-sa)
   1. [Create a service account for nodes](#node-sa)
1. [Prepare the necessary {{ k8s }} resources](#create-k8s-res)
   1. [Create a {{ k8s }} cluster](#create-cluster)
   1. [Create a node group](#create-node-groups)
1. [Prepare the necessary {{ container-registry-name }} resources](#create-cr-res)
   1. [Create a registry](#registry-create)
   1. [Configure Credential helper](#config-ch)
   1. [Prepare a Docker image](#docker-image)
1. [Connect to the {{ k8s }} cluster](#cluster-connect)
1. [Run the test app](#test-app)
1. [Delete the created resources](#delete-resources)

{% include [requirements](backup.md#requirements) %}

{% include [before-you-begin](../../_includes/before-begin.md) %}

## Create service accounts {#create-sa}

Create [service accounts](../../iam/operations/sa/create.md):
* A service account for the resources with the [{{ roles-editor }}](../../resource-manager/security/#roles-list) role to the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ k8s }} cluster is being created. The resources that the {{ k8s }} cluster needs will be created on behalf of this account.
* A service account for nodes with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#required-roles) role for the folder with the Docker image registry. Nodes will download the Docker images they require from the registry on behalf of this account.

### Create a service account for resources {#res-sa}

To create a service account for making the resources required by the {{ k8s }} cluster.
1. Write the folder ID from your CLI profile configuration to the variable:

   {% list tabs %}

   - Bash

      ```bash
      FOLDER_ID=$(yc config get folder-id)
      ```

   - PowerShell

      ```shell script
      $FOLDER_ID = yc config get folder-id
      ```

   {% endlist %}

1. Create a service account:

   {% list tabs %}

   - Bash

      ```bash
      yc iam service-account create --name k8s-res-sa-$FOLDER_ID
      ```

   - PowerShell

      ```shell script
      yc iam service-account create --name k8s-res-sa-$FOLDER_ID
      ```

   {% endlist %}

1. Write the service account ID to the variable:

   {% list tabs %}

   - Bash

      ```bash
      RES_SA_ID=$(yc iam service-account get --name k8s-res-sa-${FOLDER_ID} --format json | jq .id -r)
      ```

   - PowerShell

      ```shell script
      $RES_SA_ID = (yc iam service-account get --name k8s-res-sa-$FOLDER_ID --format json | ConvertFrom-Json).id
      ```

   {% endlist %}

1. Assign the service account the [{{ roles-editor }}](../../resource-manager/security/#roles-list) role for the folder:

   ```bash
   yc resource-manager folder add-access-binding \
     --id $FOLDER_ID \
     --role editor \
     --subject serviceAccount:$RES_SA_ID
   ```

### Create a service account for nodes {#node-sa}

To create a service account that lets nodes download the necessary Docker images from the registry.
1. Write the folder ID from your CLI profile configuration to the variable:

   {% list tabs %}

   - Bash

      ```bash
      FOLDER_ID=$(yc config get folder-id)
      ```

   - PowerShell

      ```shell script
      $FOLDER_ID = yc config get folder-id
      ```

   {% endlist %}

1. Create a service account:

   {% list tabs %}

   - Bash

      ```bash
      yc iam service-account create --name k8s-node-sa-$FOLDER_ID
      ```

   - PowerShell

      ```shell script
      yc iam service-account create --name k8s-node-sa-$FOLDER_ID
      ```

   {% endlist %}

1. Write the service account ID to the variable:

   {% list tabs %}

   - Bash

      ```bash
      NODE_SA_ID=$(yc iam service-account get --name k8s-node-sa-${FOLDER_ID} --format json | jq .id -r)
      ```

   - PowerShell

      ```shell script
      $NODE_SA_ID = (yc iam service-account get --name k8s-node-sa-$FOLDER_ID --format json | ConvertFrom-Json).id
      ```

   {% endlist %}

1. Assign the service account the [{{ roles-cr-puller }}](../../container-registry/security/index.md#required-roles) role for the folder:

   ```bash
   yc resource-manager folder add-access-binding \
     --id $FOLDER_ID \
     --role container-registry.images.puller \
     --subject serviceAccount:$NODE_SA_ID
   ```

{% include [create-k8s-res](../../_includes/managed-kubernetes/create-k8s-res.md) %}

## Prepare {{ container-registry-name }} resources {#create-cr-res}

### Create a registry {#registry-create}

Create a container registry:

```bash
yc container registry create --name yc-auto-cr
```

### Configure Docker Credential helper {#config-ch}

To facilitate authentication in {{ container-registry-name }}, configure [Docker Credential helper](../../container-registry/operations/authentication.md#cred-helper). It lets you use private {{ yandex-cloud }} registries without running the `docker login` command.

To configure the Credential helper, run the following command:

{% if product == "yandex-cloud" %}

```bash
yc container registry configure-docker
```

{% endif %}

{% if product == "cloud-il" %}

```bash
yc container registry configure-docker --hostname http://{{ registry }}/
```

{% endif %}

### Prepare a Docker image {#docker-image}

Build a Docker image and push it to the registry.
1. Create a Dockerfile named `hello.dockerfile` and add the following lines to it:

   ```bash
   FROM ubuntu:latest
   CMD echo "Hi, I'm inside"
   ```

1. Assemble the Docker image.
   1. Get the ID of the [previously created](#registry-create) registry and write it to the variable:

      {% list tabs %}

      - Bash

         ```bash
         REGISTRY_ID=$(yc container registry get --name yc-auto-cr --format json | jq .id -r)
         ```

      - PowerShell

         ```shell script
         $REGISTRY_ID = (yc container registry get --name yc-auto-cr --format json | ConvertFrom-Json).id
         ```

      {% endlist %}

   1. Build a Docker image:

      ```
      docker build . -f hello.dockerfile -t {{ registry }}/$REGISTRY_ID/ubuntu:hello
      ```

   1. Push the Docker image to the registry:

      ```
      docker push {{ registry }}/${REGISTRY_ID}/ubuntu:hello
      ```

1. Make sure the Docker image was pushed to the registry:

   ```bash
   yc container image list
   ```

   Result:

   ```bash
   +----------------------+---------------------+-----------------------------+-------+-----------------+
   |          ID          |       CREATED       |            NAME             | TAGS  | COMPRESSED SIZE |
   +----------------------+---------------------+-----------------------------+-------+-----------------+
   | crpa2mf008mpjig73rp6 | 2019-11-20 11:52:17 | crp71hkgiolp6677hg9i/ubuntu | hello | 27.5 MB         |
   +----------------------+---------------------+-----------------------------+-------+-----------------+
   ```

{% include [kubectl-connect](../../_includes/managed-kubernetes/kubectl-connect.md) %}

## Run the test app {#test-app}

Start the pod with the app from the Docker image and make sure that no additional authentication in {{ container-registry-name }} was required to push the Docker image.
1. Run the pod with the app from the Docker image:

   ```
   kubectl run --attach hello-ubuntu --image {{ registry }}/${REGISTRY_ID}/ubuntu:hello
   ```

1. Find the running pod to see its full name:

   ```
   kubectl get po
   ```

   Result:

   ```
   NAME                           READY  STATUS     RESTARTS  AGE
   hello-ubuntu-5847fb96b4-54g48  0/1    Completed  3         61s
   ```

1. Check the logs of the container running on this pod:

   ```
   kubectl logs hello-ubuntu-5847fb96b4-54g48
   ```

   Result:

   ```
   Hi, I'm inside
   ```

   The pod pushed the Docker image with no additional authentication on the {{ container-registry-name }} side.

## Delete the resources you created {#delete-resources}

1. Delete a {{ k8s }} cluster:

   ```bash
   yc managed-kubernetes cluster delete --name k8s-demo
   ```

1. Delete the service accounts:

   {% note warning %}

   Make sure you don't delete any service accounts before deleting the {{ k8s }} cluster.

   {% endnote %}

   - Delete the service account created for resources:

      ```bash
      yc iam service-account delete --id $RES_SA_ID
      ```

   - Delete the service account created for nodes:

      ```bash
      yc iam service-account delete --id $NODE_SA_ID
      ```

1. Delete resources {{ container-registry-name }}.
   1. Find the name of the Docker image pushed to the registry:

      {% list tabs %}

      - Bash

         ```bash
         IMAGE_ID=$(yc container image list --format json | jq .[0].id -r)
         ```

      - PowerShell

         ```shell script
         $IMAGE_ID = (yc container image list --format json | ConvertFrom-Json).id
         ```

      {% endlist %}

   1. Delete the Docker image:

      ```bash
      yc container image delete --id $IMAGE_ID
      ```

   1. Delete the registry:

      ```bash
      yc container registry delete --name yc-auto-cr
      ```

#### See also {#see-also}

* [{#T}](../../container-registry/concepts/docker-image.md)
* [{#T}](../../container-registry/operations/authentication.md)
* [{#T}](../../container-registry/operations/index.md)