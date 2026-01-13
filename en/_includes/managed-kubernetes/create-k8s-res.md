## Create {{ k8s }} resources {#create-k8s-res}

### Create a {{ managed-k8s-name }} cluster {#create-cluster}

{% note tip %}

This example uses the basic cluster parameters. Once the cluster is created, you cannot change some of its settings, e.g., [Container Network Interface](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/) you selected, [secret encryption](../../managed-kubernetes/concepts/encryption.md#k8s-secrets-encryption) using {{ kms-full-name }}, and a number of others. We recommend checking out [our detailed guide on creating a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create).

{% endnote %}

Create a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) and specify the previously created [service accounts](../../iam/concepts/users/service-accounts.md) in the `--service-account-id` and `--node-service-account-id` parameters, and security groups in the `--security-group-ids` parameter.

{% list tabs group=programming_language %}

- Bash {#bash}

  Run this command:

  ```bash
  yc managed-kubernetes cluster create \
    --name k8s-demo \
    --network-name yc-auto-network \
    --zone {{ region-id }}-a \
    --subnet-name yc-auto-subnet-0 \
    --public-ip \
    --service-account-id $RES_SA_ID \
    --node-service-account-id $NODE_SA_ID \
    --security-group-ids <security_group_IDs>
  ```

- PowerShell {#powershell}

  Run this command:

  ```shell script
  yc managed-kubernetes cluster create `
    --name k8s-demo `
    --network-name yc-auto-network `
    --zone {{ region-id }}-a `
    --subnet-name yc-auto-subnet-0 `
    --public-ip `
    --service-account-id $RES_SA_ID `
    --node-service-account-id $NODE_SA_ID `
    --security-group-ids <security_group_IDs>
  ```

{% endlist %}

### Create a {{ managed-k8s-name }} node group {#create-node-groups}

{% note warning %}

To access the {{ container-registry-name }}, a public IP address must be assigned to cluster nodes. Alternatively, a [NAT gateway](../../vpc/operations/create-nat-gateway.md) or [NAT instance](../../vpc/tutorials/nat-instance/index.md) must be configured in the node subnet.

For more information, see [{#T}](../../managed-kubernetes/concepts/network.md#nodes-internet).

{% endnote %}

1. Make sure the {{ managed-k8s-name }} cluster has been created successfully.
   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you created the {{ managed-k8s-name }} cluster.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Make sure the {{ managed-k8s-name }} cluster has been created successfully:
      * The **{{ ui-key.yacloud.k8s.cluster.overview.label_status }}** column should state `Running`.
      * The **{{ ui-key.yacloud.k8s.cluster.overview.label_health }}** column should state `Healthy`.
1. Create a [{{ managed-k8s-name }} node group](../../managed-kubernetes/concepts/index.md#node-group) and specify the previously created security groups in the `--network-interface security-group-ids` parameter:

   {% list tabs group=programming_language %}

   - Bash {#bash}

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
       --network-interface subnets=yc-auto-subnet-0,ipv4-address=nat,security-group-ids=[<security_group_IDs>] \
       --async
     ```

   - PowerShell {#powershell}

     ```shell script
     yc managed-kubernetes node-group create `
       --name k8s-demo-ng `
       --cluster-name k8s-demo `
       --platform standard-v3 `
       --cores 2 `
       --memory 4 `
       --core-fraction 50 `
       --disk-type network-ssd `
       --fixed-size 2 `
       --network-interface subnets=yc-auto-subnet-0,ipv4-address=nat,security-group-ids=[<security_group_IDs>] `
       --async
     ```

   {% endlist %}
