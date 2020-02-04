## Prepare {{ k8s }} resources {#create-k8s-res}

### Create a {{ k8s }} cluster {#create-cluster}

Create a {{ k8s }} cluster and specify the previously created service accounts in the `--service-account-id` and `--node-service-account-id` parameters.

{% list tabs %}

- Bash

    Run the command:

    ```
    $ yc managed-kubernetes cluster create \
     --name k8s-demo --network-name yc-auto-network \
     --zone ru-central1-a --subnet-name yc-auto-subnet-0 \
     --public-ip \
     --service-account-id $RES_SA_ID \
     --node-service-account-id $NODE_SA_ID
    ```

- PowerShell

    Run the command:

    ```
    > yc managed-kubernetes cluster create `
     --name k8s-demo --network-name yc-auto-network `
     --zone ru-central1-a --subnet-name yc-auto-subnet-0 `
     --public-ip `
     --service-account-id $RES_SA_ID `
     --node-service-account-id $NODE_SA_ID
    ```

{% endlist %}

### Create a node group {#create-node-groups}

1. Make sure the {{ k8s }} cluster was created.
    1. In the [management console]({{ link-console-main }}), select the folder where you created the {{ k8s }} cluster.
    1. In the list of services, select **{{ managed-k8s-name }}**.
    1. Make sure that the {{ k8s}} cluster was created:
        * The **Status** column value must be `Running`.
        * The **Health** column value must be `Healthy`.

1. Create a node group:

    {% list tabs %}

    - Bash

        ```
        $ yc managed-kubernetes node-group create \
         --name k8s-demo-ng \
         --cluster-name k8s-demo \
         --platform-id standard-v2 \
         --public-ip \
         --cores 2 \
         --memory 4 \
         --core-fraction 50 \
         --disk-type network-ssd \
         --fixed-size 2 \
         --location subnet-name=yc-auto-subnet-0,zone=ru-central1-a \
         --async
        ```

    - PowerShell

        ```
        > yc managed-kubernetes node-group create `
         --name k8s-demo-ng `
         --cluster-name k8s-demo `
         --platform-id standard-v2 `
         --public-ip `
         --cores 2 `
         --memory 4 `
         --core-fraction 50 `
         --disk-type network-ssd `
         --fixed-size 2 `
         --location subnet-name=yc-auto-subnet-0,zone=ru-central1-a `
         --async
        ```

    {% endlist %}

