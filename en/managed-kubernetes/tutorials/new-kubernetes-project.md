# Creating a new {{ k8s }} project in {{ yandex-cloud }}

This article describes how to run a new {{ k8s }} project in {{ yandex-cloud }}. An application from [{{ container-registry-full-name }}](../../container-registry/) is deployed in a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) and published on the internet via the [{{ alb-full-name }}](../../application-load-balancer/) Ingress controller.

To launch an app:
1. [{#T}](#create-sa).
1. [{#T}](#create-k8s-res).
1. [{#T}](#create-cr-res).
1. [{#T}](#setup-alb).
1. [{#T}](#create-ingress).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. Install the `jq` [JSON stream processor](https://stedolan.github.io/jq/):

   ```bash
   sudo apt update && sudo apt install jq
   ```

### Create a network and subnet {#create-network}

1. [Create a network](../../vpc/operations/network-create.md) named `yc-auto-network`:

   ```bash
   yc vpc network create --name yc-auto-network
   ```

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md).

   ```bash
   yc vpc subnet create \
     --name yc-auto-subnet-0 \
     --network-name yc-auto-network \
     --range 192.168.1.0/24 \
     --zone {{ region-id }}-a
   ```

### Register a domain zone and add a certificate {#register-domain}

1. [Register a public domain zone and delegate your domain](../../dns/operations/zone-create-public.md).
1. If you already have a [certificate](../../certificate-manager/concepts/index.md#types) for the [domain zone](../../dns/concepts/dns-zone.md), [add information about it](../../certificate-manager/operations/import/cert-create.md) to the {{ certificate-manager-full-name }} service.

   If you don't have a certificate, [create a new certificate from Let's Encrypt®](../../certificate-manager/operations/managed/cert-create.md).
1. Get the certificate ID:

   ```bash
   yc certificate-manager certificate list
   ```

   Command result:

   ```text
   +------+--------+---------------+---------------------+----------+--------+
   |  ID  |  NAME  |    DOMAINS    |      NOT AFTER      |   TYPE   | STATUS |
   +------+--------+---------------+---------------------+----------+--------+
   | <ID> | <name> | <domain name> | 2022-04-06 17:19:37 | IMPORTED | ISSUED |
   +------+--------+---------------+---------------------+----------+--------+
   ```

## Create service accounts {#create-sa}

For a {{ k8s }} cluster and [load balancer](../../application-load-balancer/concepts/application-load-balancer.md) to run, the following [service accounts](../../iam/concepts/users/service-accounts.md) are required:
* With the [{{ roles-editor }}](../../iam/concepts/access-control/roles.md#editor) role for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where a {{ k8s }} cluster is created. This service account will be used to create resources that the {{ k8s }} cluster needs.
* With the [{{ roles-cr-puller }}](../../iam/concepts/access-control/roles.md#cr-images-puller) role for the folder containing a [Docker image](../../container-registry/concepts/docker-image.md) [registry](../../container-registry/concepts/registry.md). [Nodes](../../managed-kubernetes/concepts/index.md#node-group) will pull the required Docker images from the registry on behalf of this service account.
* For the {{ alb-name }} Ingress controller to run, you need service accounts with the following roles:
  * [alb.editor](../../iam/concepts/access-control/roles.md#alb-editor): To create the required resources.
  * [vpc.publicAdmin](../../iam/concepts/access-control/roles.md#vpc-public-admin): To manage [external connectivity](../../vpc/security/index.md#roles-list).
  * [certificate-manager.certificates.downloader](../../iam/concepts/access-control/roles.md#certificate-manager-certificates-downloader): To use certificates registered in [{{ certificate-manager-name }}](../../certificate-manager/).
  * [compute.viewer](../../iam/concepts/access-control/roles.md#compute-viewer): To use {{ k8s }} cluster nodes in load balancer [target groups](../../application-load-balancer/concepts/target-group.md).

### Service account for resources {#res-sa}

To create a service account for making the resources required by the {{ managed-k8s-name }} cluster:
1. Write the folder ID from your {{ yandex-cloud }} CLI profile configuration to the variable:

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
     RES_SA_ID=$(yc iam service-account get --name k8s-res-sa-$FOLDER_ID --format json | jq .id -r)
     ```

   - PowerShell

     ```shell script
     $RES_SA_ID = (yc iam service-account get --name k8s-res-sa-$FOLDER_ID --format json | ConvertFrom-Json).id
     ```

   {% endlist %}

1. Assign the service account the role [{{ roles-editor }}](../../iam/concepts/access-control/roles.md#editor) for the folder.

   ```bash
   yc resource-manager folder add-access-binding \
     --id $FOLDER_ID \
     --role editor \
     --subject serviceAccount:$RES_SA_ID
   ```

### Service account for nodes {#node-sa}

To create a service account that lets nodes download the necessary Docker images from the registry:
1. Write the folder ID from your {{ yandex-cloud }} CLI profile configuration to the variable:

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
     NODE_SA_ID=$(yc iam service-account get --name k8s-node-sa-$FOLDER_ID --format json | jq .id -r)
     ```

   - PowerShell

     ```shell script
     $NODE_SA_ID = (yc iam service-account get --name k8s-node-sa-$FOLDER_ID --format json | ConvertFrom-Json).id
     ```

   {% endlist %}

1. Assign the service account the role [{{ roles-cr-puller }}](../../iam/concepts/access-control/roles.md#cr-images-puller) for the folder.

   ```bash
   yc resource-manager folder add-access-binding \
     --id $FOLDER_ID \
     --role container-registry.images.puller \
     --subject serviceAccount:$NODE_SA_ID
   ```

### Service account required for the {{ alb-name }} Ingress controller to run {#ic-sa}

1. Write the folder ID from your {{ yandex-cloud }} CLI profile configuration to the variable:

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
     yc iam service-account create --name k8s-ic-sa-$FOLDER_ID
     ```

   - PowerShell

     ```shell script
     yc iam service-account create --name k8s-ic-sa-$FOLDER_ID
     ```

   {% endlist %}

1. Write the service account ID to the variable:

   {% list tabs %}

   - Bash

     ```bash
     IC_SA_ID=$(yc iam service-account get --name k8s-ic-sa-$FOLDER_ID --format json | jq .id -r)
     ```

   - PowerShell

     ```shell script
     $RES_SA_ID = (yc iam service-account get --name k8s-ic-sa-$FOLDER_ID --format json | ConvertFrom-Json).id
     ```

   {% endlist %}

1. Assign the service account the following roles for the folder:
   * [{{ roles-alb-editor }}](../../iam/concepts/access-control/roles.md#alb-editor).
   * [{{ roles-vpc-public-admin }}](../../iam/concepts/access-control/roles.md#vpc-public-admin).
   * [certificate-manager.certificates.downloader](../../iam/concepts/access-control/roles.md#certificate-manager-certificates-downloader).
   * [compute.viewer](../../iam/concepts/access-control/roles.md#compute-viewer).

   ```bash
   yc resource-manager folder add-access-binding \
     --id $FOLDER_ID \
     --role alb.editor \
     --role vpc.publicAdmin \
     --role certificate-manager.certificates.downloader \
     --role compute.viewer \
     --subject serviceAccount:$IC_SA_ID
   ```

1. Create an [authorized key](../../iam/concepts/authorization/access-key.md) for the service account and save it to a file named `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-id $IC_SA_ID \
     --output sa-key.json
   ```

{% include [create-k8s-res](../../_includes/managed-kubernetes/create-k8s-res.md) %}

1. [Configure {{ k8s }} cluster security groups and node groups](../operations/connect/security-groups.md). A security group for a group of nodes must allow incoming TCP traffic from the load balancer subnets on ports 10501 and 10502 or from the load balancer security group (you'll need to specify the subnets and the group to [create a load balancer](#create-ingress-and-apps) later).
1. Check that you can connect to the cluster using `kubectl`:

   ```bash
   kubectl cluster-info
   ```

## Create resources {{ container-registry-name }} {#create-cr-res}

### Create a registry {#registry-create}

Create a container registry:

```bash
yc container registry create --name yc-auto-cr
```

### Configure Docker Credential Helper {#config-ch}

To facilitate authentication in {{ container-registry-name }}, configure [Docker Credential helper](../../container-registry/operations/authentication.md#cred-helper). It lets you use private {{ yandex-cloud }} registries without running the `docker login`command.

To configure the Credential helper, run the following command:

```bash
yc container registry configure-docker
```

### Prepare a Docker image {#docker-image}

Build a Docker image and push it to the registry.
1. Create a Dockerfile named `hello.dockerfile` and add the following lines to it:

   ```docker
   FROM nginx
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

      ```bash
      docker build . -f hello.dockerfile -t {{ registry }}/$REGISTRY_ID/nginx:hello
      ```

   1. Push the Docker image to the registry:

      ```bash
      docker push {{ registry }}/$REGISTRY_ID/nginx:hello
      ```

1. Make sure the Docker image was pushed to the registry:

   ```bash
   yc container image list
   ```

   Command result:

   ```text
   +----------------------+---------------------+----------------------------+-------+-----------------+
   |          ID          |       CREATED       |            NAME            |  TAGS | COMPRESSED SIZE |
   +----------------------+---------------------+----------------------------+-------+-----------------+
   | crpa2mf008mpjig73rp6 | 2019-11-20 11:52:17 | crp71hkgiolp6677hg9i/nginx | hello | 27.5 MB         |
   +----------------------+---------------------+----------------------------+-------+-----------------+
   ```

### Run the test app {#test-app}

Create a [pod](../concepts/index.md#pod) with the app from the Docker image and make sure that no additional authentication in {{ container-registry-name }} was required to push the Docker image.
1. Run the pod with the app from the Docker image:

   ```bash
   kubectl run --attach hello-nginx --image {{ registry }}/$REGISTRY_ID/nginx:hello
   ```

1. Check that the pod's state is `Running` and get its full name:

   ```bash
   kubectl get pods
   ```

   Command result:

   ```text
   NAME                          READY  STATUS   RESTARTS  AGE
   hello-nginx-5847fb96b4-54g48  1/1    Running  0         1h
   ```

1. Check the logs of the container running on this pod:

   ```bash
   kubectl logs hello-nginx-5847fb96b4-54g48
   ```

   Command result:

   ```text
   Hi, I'm inside
   ```

   The pod pushed the Docker image with no additional authentication on the {{ container-registry-name }} side.

## Install {{ alb-name }} {#setup-alb}

1. Create a [namespace](../concepts/index.md#namespace) to enable the load balancer:

   ```bash
   kubectl create namespace yc-alb-ingress
   ```


1. [Install the load balancer using {{ marketplace-full-name }}](../operations/applications/alb-ingress-controller.md#install-alb-marketplace).



## Create a load balancer {#create-ingress}

1. Create a load balancer for [{{ k8s }} services](../concepts/index.md#service).
   1. Create an `ingress.yaml` file with the Ingress controller manifest:

      ```yaml
      ---
      apiVersion: networking.k8s.io/v1
      kind: Ingress
      metadata:
        name: alb-demo-tls
        annotations:
          ingress.alb.yc.io/subnets: <list of subnet IDs>
          ingress.alb.yc.io/security-groups: <list of security group IDs>
          ingress.alb.yc.io/external-ipv4-address: <auto or static IP address>
          ingress.alb.yc.io/group-name: <Ingress group name>
      spec:
        tls:
          - hosts:
              - <domain name>
            secretName: yc-certmgr-cert-id-<TLS certificate ID>
      rules:
        - host: <domain name>
          http:
            paths:
              - pathType: Prefix
                path: "/"
                backend:
                  service:
                    name: service-hello
                    port:
                      name: http
      ---
      apiVersion: v1
        kind: Service
        metadata:
          name: service-hello
        spec:
          selector:
            run: hello-nginx
          type: NodePort
          ports:
            - name: http
              port: 80
              targetPort: 80
              protocol: TCP
              nodePort: 30080
      ```

      Where:
      * `ingress.alb.yc.io/subnets`: Specify one or more [subnets](../../vpc/concepts/network.md#subnet) that {{ alb-name }} is going to work with.
      * `ingress.alb.yc.io/security-groups`: Specify one or more [security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) for {{ alb-name }}. If the parameter is omitted, the default security group is used. At least one of the security groups must allow outgoing TCP connections to ports 10501 and 10502 in the node group subnet or security group.
      * `ingress.alb.yc.io/external-ipv4-address`: To get a new IP or provide public access to {{ alb-name }} from the internet, specify the [previously obtained IP address](../../vpc/operations/get-static-ip.md) or set the value to `auto`.
      * `ingress.alb.yc.io/group-name`: Specify the group name. It groups {{ k8s }} Ingress resources served by a separate {{ alb-name }} instance.
   1. Create a load balancer:

      ```bash
      kubectl apply -f ingress.yaml
      ```

   1. Wait until the load balancer is created and assigned a public IP address. This may take several minutes:

      ```bash
      kubectl get ingress alb-demo-tls
      ```

      The expected result is a non-empty value in the `ADDRESS` field for the created load balancer:

      ```bash
      NAME          CLASS   HOSTS           ADDRESS     PORTS    AGE
      alb-demo-tls  <none>  <domain name>  <IP-adress>  80, 443  15h
      ```

      Based on the load balancer configuration, an [L7 load balancer](../../application-load-balancer/concepts/application-load-balancer.md) will be automatically deployed.
1. Follow the `https://<domain name>` link and make sure that your application is published.

## Delete the resources you created {#clear-out}

If you no longer need the created resources, delete them.
1. [Delete the {{ k8s }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-delete.md):

   ```bash
   yc managed-kubernetes cluster delete --name k8s-demo
   ```

1. Delete the service accounts.
   * Delete the service account created for resources:

      ```bash
      yc iam service-account delete --id $RES_SA_ID
      ```

   * Delete the service account created for nodes:

      ```bash
      yc iam service-account delete --id $NODE_SA_ID
      ```

   * Delete the service account created for the load balancer:

      ```bash
      yc iam service-account delete --id $IC_SA_ID
      ```

1. Delete resources {{ container-registry-name }}.
   1. Find out the ID of the Docker image pushed to the registry:

      {% list tabs %}

      - Bash

         ```bash
         IMAGE_ID=$(yc container image list --format json | jq .[0].id -r)
         ```

      - PowerShell

         ```powershell
         $IMAGE_ID = (yc container image list --format json | ConvertFrom-Json).id
         ```

      {% endlist %}

   1. [Delete the Docker image](../../container-registry/operations/docker-image/docker-image-delete.md):

      ```bash
      yc container image delete --id $IMAGE_ID
      ```

   1. [Delete the registry](../../container-registry/operations/registry/registry-delete.md):

      ```bash
      yc container registry delete --name yc-auto-cr
      ```

1. Delete the [L7 load balancer](../../application-load-balancer/operations/application-load-balancer-delete.md).