# Integration with {{ container-registry-name }}


[{{ container-registry-full-name }}](../../container-registry/) offers storage and distribution of [Docker images](../../container-registry/concepts/docker-image.md). By integrating it, you enable {{ managed-k8s-name }} to run [pods](../../managed-kubernetes/concepts/index.md#pod) with applications from Docker images stored in the [{{ container-registry-name }}](../../container-registry/concepts/registry.md). To use {{ container-registry-name }}, [set up](#config-ch) a Docker credential helper. It enables access to private registries using a [service account](../../iam/concepts/users/service-accounts.md).

To integrate {{ managed-k8s-name }} with {{ container-registry-name }}:
1. [Create service accounts](#create-sa).
   1. [Create a service account for resources](#res-sa).
   1. [Create a service account for {{ managed-k8s-name }} nodes](#node-sa).
1. [Create security groups](#create-sg).
1. [Create the required {{ k8s }} resources](#create-k8s-res).
   1. [Create a {{ managed-k8s-name }} cluster](#create-cluster).
   1. [Create a {{ managed-k8s-name }} node group](#create-node-groups).
1. [Create the required {{ container-registry-name }} resources](#create-cr-res).
   1. [Create a registry](#registry-create).
   1. [Configure a credential helper](#config-ch).
   1. [Set up a Docker image](#docker-image).
1. [Connect to the {{ managed-k8s-name }} cluster](#cluster-connect).
1. [Run the test app](#test-app).
1. [Delete the resources you created](#delete-resources).

{% include [requirements](../archive/kubernetes-backup.md#requirements) %}

{% include [before-you-begin](../../_includes/before-begin.md) %}


### Required paid resources {#paid-resources}

The support cost for this solution includes:

* Fee for using the master and outgoing traffic in a {{ managed-k8s-name }} cluster (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for using computing resources, OS, and storage in cluster nodes (VMs) (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for public IP addresses assigned to cluster nodes (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).
* Fee for {{ container-registry-name }} [storage](../../container-registry/pricing.md).


## Create service accounts {#create-sa}

Create these [service accounts](../../iam/operations/sa/create.md):
* Service account for resources with the `k8s.clusters.agent` and `vpc.publicAdmin` [roles](../../managed-kubernetes/security/index.md#yc-api) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to host the new {{ managed-k8s-name }} cluster. This service account will be used to create resources for your {{ managed-k8s-name }} cluster.
* Service account for [{{ managed-k8s-name }} nodes](../../managed-kubernetes/concepts/index.md#node-group) with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) role for the folder containing the Docker image registry. The {{ managed-k8s-name }} nodes will use this account to pull the required Docker images from the registry.

### Create a service account for resources {#res-sa}

To create a service account that will be used to create the resources for the {{ managed-k8s-name }} cluster:
1. Save the folder ID from your CLI profile configuration to a variable:

   {% list tabs group=programming_language %}

   - Bash {#bash}

     ```bash
     FOLDER_ID=$(yc config get folder-id)
     ```

   - PowerShell {#powershell}

     ```shell script
     $FOLDER_ID = yc config get folder-id
     ```

   {% endlist %}

1. Create a service account:

   {% list tabs group=programming_language %}

   - Bash {#bash}

     ```bash
     yc iam service-account create --name k8s-res-sa-$FOLDER_ID
     ```

   - PowerShell {#powershell}

     ```shell script
     yc iam service-account create --name k8s-res-sa-$FOLDER_ID
     ```

   {% endlist %}

1. Save the service account ID to a variable:

   {% list tabs group=programming_language %}

   - Bash {#bash}

     ```bash
     RES_SA_ID=$(yc iam service-account get --name k8s-res-sa-${FOLDER_ID} --format json | jq .id -r)
     ```

   - PowerShell {#powershell}

     ```shell script
     $RES_SA_ID = (yc iam service-account get --name k8s-res-sa-$FOLDER_ID --format json | ConvertFrom-Json).id
     ```

   {% endlist %}

1. Assign the [k8s.clusters.agent](../../managed-kubernetes/security/index.md#k8s-clusters-agent) role for the folder to the service account:

   ```bash
   yc resource-manager folder add-access-binding \
     --id $FOLDER_ID \
     --role k8s.clusters.agent \
     --subject serviceAccount:$RES_SA_ID
   ```

1. Assign the [vpc.publicAdmin](../../vpc/security/index.md#vpc-public-admin) role for the folder to the service account:

   ```bash
   yc resource-manager folder add-access-binding \
     --id $FOLDER_ID \
     --role vpc.publicAdmin \
     --subject serviceAccount:$RES_SA_ID
   ```

### Create a service account for cluster nodes {#node-sa}

To create a service account the {{ managed-k8s-name }} nodes will use to pull the required Docker images from the registry:
1. Save the folder ID from your CLI profile configuration to a variable:

   {% list tabs group=programming_language %}

   - Bash {#bash}

     ```bash
     FOLDER_ID=$(yc config get folder-id)
     ```

   - PowerShell {#powershell}

     ```shell script
     $FOLDER_ID = yc config get folder-id
     ```

   {% endlist %}

1. Create a service account:

   {% list tabs group=programming_language %}

   - Bash {#bash}

     ```bash
     yc iam service-account create --name k8s-node-sa-$FOLDER_ID
     ```

   - PowerShell {#powershell}

     ```shell script
     yc iam service-account create --name k8s-node-sa-$FOLDER_ID
     ```

   {% endlist %}

1. Save the service account ID to a variable:

   {% list tabs group=programming_language %}

   - Bash {#bash}

     ```bash
     NODE_SA_ID=$(yc iam service-account get --name k8s-node-sa-${FOLDER_ID} --format json | jq .id -r)
     ```

   - PowerShell {#powershell}

     ```shell script
     $NODE_SA_ID = (yc iam service-account get --name k8s-node-sa-$FOLDER_ID --format json | ConvertFrom-Json).id
     ```

   {% endlist %}

1. Assign the [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) role for the folder to the service account:

   ```bash
   yc resource-manager folder add-access-binding \
     --id $FOLDER_ID \
     --role container-registry.images.puller \
     --subject serviceAccount:$NODE_SA_ID
   ```

## Create security groups {#create-sg}

{% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

{% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Set up {{ k8s }} resources {#create-k8s-res}

{% include notitle [create-k8s-res](../../_includes/managed-kubernetes/create-k8s-res.md) %}

## Create {{ container-registry-name }} resources {#create-cr-res}

### Create a registry {#registry-create}

Create a container registry:

```bash
yc container registry create --name yc-auto-cr
```

### Configure a Docker credential helper {#config-ch}

To simplify authentication in {{ container-registry-name }}, configure a [Docker credential helper](../../container-registry/operations/authentication.md#cred-helper). It enables you to use private {{ yandex-cloud }} registries without running the `docker login` command.

To configure a credential helper, run this command:

```bash
yc container registry configure-docker
```

### Set up a Docker image {#docker-image}

Build a Docker image and push it to the registry.
1. Create a Dockerfile named `hello.dockerfile` and paste the following lines into it:

   ```bash
   FROM ubuntu:latest
   CMD echo "Hi, I'm inside"
   ```

1. Build the Docker image.
   1. Get the ID of the [previously created](#registry-create) registry and save it to a variable:

      {% list tabs group=programming_language %}

      - Bash {#bash}

        ```bash
        REGISTRY_ID=$(yc container registry get --name yc-auto-cr --format json | jq .id -r)
        ```

      - PowerShell {#powershell}

        ```shell script
        $REGISTRY_ID = (yc container registry get --name yc-auto-cr --format json | ConvertFrom-Json).id
        ```

      {% endlist %}

   1. Build the Docker image:

      ```
      docker build . -f hello.dockerfile -t {{ registry }}/$REGISTRY_ID/ubuntu:hello
      ```

   1. Push the Docker image to the registry:

      ```
      docker push {{ registry }}/${REGISTRY_ID}/ubuntu:hello
      ```

1. Make sure the image is now in the registry:

   ```bash
   yc container image list
   ```

   Result:

   ```text
   +----------------------+---------------------+-----------------------------+-------+-----------------+
   |          ID          |       CREATED       |            NAME             | TAGS  | COMPRESSED SIZE |
   +----------------------+---------------------+-----------------------------+-------+-----------------+
   | crpa2mf008mp******** | 2019-11-20 11:52:17 | crp71hkgiolp********/ubuntu | hello | 27.5 MB         |
   +----------------------+---------------------+-----------------------------+-------+-----------------+
   ```

## Connect to the {{ managed-k8s-name }} cluster {#cluster-connect}

{% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Run the test app {#test-app}

Run the pod with the app from the Docker image and make sure no additional authentication in {{ container-registry-name }} was required to push the Docker image.
1. Run the pod with the app from the Docker image:

   ```
   kubectl run --attach hello-ubuntu --image {{ registry }}/${REGISTRY_ID}/ubuntu:hello
   ```

1. Check the running pod and view its full name:

   ```
   kubectl get po
   ```

   Result:

   ```
   NAME                           READY  STATUS     RESTARTS  AGE
   hello-ubuntu-5847fb9***-*****  0/1    Completed  3         61s
   ```

1. Check the logs of the container running on that pod:

   ```
   kubectl logs hello-ubuntu-5847fb9***-*****
   ```

   Result:

   ```
   Hi, I'm inside
   ```

   The pod pulled the Docker image with no additional authentication required on the {{ container-registry-name }} side.

## Delete the resources you created {#delete-resources}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:
1. Delete the {{ managed-k8s-name }} cluster:

   ```bash
   yc managed-kubernetes cluster delete --name k8s-demo
   ```

1. Delete the service accounts:

   {% note warning %}

   Do not delete the service account until you delete the {{ managed-k8s-name }} cluster.

   {% endnote %}

   - Delete the service account for resources:

     ```bash
     yc iam service-account delete --id $RES_SA_ID
     ```

   - Delete the service account for {{ managed-k8s-name }} nodes:

     ```bash
     yc iam service-account delete --id $NODE_SA_ID
     ```

1. Delete the {{ container-registry-name }} resources.
   1. Get the name of the Docker image pushed to the registry:

      {% list tabs group=programming_language %}

      - Bash {#bash}

        ```bash
        IMAGE_ID=$(yc container image list --format json | jq .[0].id -r)
        ```

      - PowerShell {#powershell}

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
