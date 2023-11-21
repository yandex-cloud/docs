## Prepare the {{ k8s }} resources {#create-k8s-res}

### Create a {{ managed-k8s-name }} cluster {#create-cluster}

Create a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) and specify the previously created [service accounts](../../iam/concepts/users/service-accounts.md) in the `--service-account-id` and `--node-service-account-id` parameters.

{% list tabs %}

- Bash

   Run this command:

   ```bash
   yc managed-kubernetes cluster create \
     --name k8s-demo \
     --network-name yc-auto-network \
     --zone {{ region-id }}-a \
     --subnet-name yc-auto-subnet-0 \
     --public-ip \
     --service-account-id $RES_SA_ID \
     --node-service-account-id $NODE_SA_ID
   ```

- PowerShell

   Run this command:

   ```shell script
   > yc managed-kubernetes cluster create `
     --name k8s-demo `
     --network-name yc-auto-network `
     --zone {{ region-id }}-a `
     --subnet-name yc-auto-subnet-0 `
     --public-ip `
     --service-account-id $RES_SA_ID `
     --node-service-account-id $NODE_SA_ID
   ```

{% endlist %}

### Create a {{ managed-k8s-name }} node group {#create-node-groups}

1. Make sure the {{ managed-k8s-name }} cluster was created.
   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ managed-k8s-name }} cluster was created.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Check that your {{ managed-k8s-name }} cluster was created successfully:
      * Look for `Running` in the **{{ ui-key.yacloud.k8s.cluster.overview.label_status }}** column.
      * Look for `Healthy` in the **{{ ui-key.yacloud.k8s.cluster.overview.label_health }}** column.
1. Create a [{{ managed-k8s-name }} node group](../../managed-kubernetes/concepts/index.md#node-group):

   {% list tabs %}

   - Bash

      ```bash
      yc managed-kubernetes node-group create \
        --name k8s-demo-ng \
        --cluster-name k8s-demo \
        --platform standard-v3 \
        --cores 2 \
        --memory 4 \
        --core-fraction 50 \
        --disk-type network-ssd \
        --fixed-size 2 \
        --network-interface subnets=yc-auto-subnet-0,ipv4-address=nat \
        --async
      ```

   - PowerShell

      ```shell script
      > yc managed-kubernetes node-group create `
        --name k8s-demo-ng `
        --cluster-name k8s-demo `
        --platform standard-v3 `
        --cores 2 `
        --memory 4 `
        --core-fraction 50 `
        --disk-type network-ssd `
        --fixed-size 2 `
        --network-interface subnets=yc-auto-subnet-0,ipv4-address=nat `
        --async
      ```

   {% endlist %}