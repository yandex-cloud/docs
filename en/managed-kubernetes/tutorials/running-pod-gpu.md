# Running workloads with GPUs

To run workloads with GPUs on {{ k8s }} cluster pods:

1. Create a {{ k8s }} cluster.

   You can use an existing {{ k8s }} cluster or create a new one. Make sure that the **Kubernetes version** field is set to version 1.16 or higher.

   {% cut "How to create a cluster" %}

   {% list tabs %}

   - Management console

       {% include [create-cluster](../../_includes/managed-kubernetes/cluster-create.md) %}

   - CLI

       {% include [cli-install](../../_includes/cli-install.md) %}

       {% include [default-catalogue](../../_includes/default-catalogue.md) %}

       Create a {{ k8s }} cluster:

       ```
       yc managed-kubernetes cluster create 
           --name k8s-gpu-cluster \
           --service-account-name k8s \
           --node-service-account-name docker \
           --zone {{ region-id }}-a \     
           --network-name k8s-gpu
       ```

       Where:

       - `--name`: The {{ k8s }} cluster name.
       - `--service-account-id`: The unique ID of the service account for the resources. The resources that the {{ k8s }} cluster needs will be created on behalf of this account.
       - `--node-service-account-id`: The unique ID of the service account for the nodes. Nodes will download the Docker images they require from the registry on behalf of this account.
       - `--zone`: Availability zone.
       - `--network-name`: Name of the network.

       Result:

       ```
       done (6m9s)
       id: catsk2s5f0fmb5h0pd94
       folder_id: b1g12ga82mev0cljderg
       ...
       service_account_id: ajedclfluactb5868n99
       node_service_account_id: ajeo8f063dmnicot7t7j
       release_channel: REGULAR
       ```

   - API

       To create a {{ k8s }} cluster, use the [create](../api-ref/Cluster/create.md) method for the [Cluster](../api-ref/Cluster) resource.

   {% endlist %}

   {% endcut %}

1. Create a node group with GPUs.

   When creating a node group, select the **Intel Broadwell with Nvidia Tesla v100** platform and specify the required **number of GPUs**.

   {% cut "How to create a node group with GPU" %}

   {% list tabs %}

   - Management console
     1. In [management console]({{ link-console-main }}), select the folder where you want to create your {{ k8s }} cluster.
     1. In the list of services, select **{{ managed-k8s-name }}**.
     1. Select the {{ k8s }} cluster to create a node group for.
     1. On the {{ k8s }} cluster page, go to the **Node groups** tab.
     1. Click **Create node group**.
     1. Enter a name and description for the node group.
     1. Specify the **{{ k8s }} version** for the nodes.
     1. In the **Scalability** section:
         - Select the scaling policy type.
         - Specify the number of nodes in the node group.
     1. Under **Allow when creating and updating**, specify the maximum number of instances that you can exceed and reduce the size of the group by.
     1. Under **Computing resources**:
         - Choose a [platform](../../compute/concepts/vm-platforms.md) **Intel Broadwell with Nvidia Tesla v100**.
         - Choose the [configuration](../../compute/concepts/gpus.md#config) of the VM by specifying the required number of GPUs.  The vCPU and RAM amount will be selected automatically.
         - (optional) Specify that the VM must be [preemptible](../../compute/concepts/preemptible-vm.md).
     1. Under **Storage**:
         - Specify the **Disk type**:
             - **HDD**: Standard network drive. Network block storage on an HDD.
             - **SSD**: Fast network drive. Network block storage on an SSD.
         - Specify the disk size.
     1. Under **Network settings**:
         - In the **Public IP** field, choose a method for assigning an IP address:
             - **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
             - **No address**: Don't assign a public IP address.
         - Specify how nodes should be distributed across availability zones and networks.

         
         - (optional) Click **Add location** and specify an additional availability zone and network to create nodes in different zones.


     1. Under **Access**, specify the information required to access the node:
         - Enter the username in the **Login** field.
         - In the **SSH key** field, paste the contents of the [public key](../operations/node-connect-ssh.md#creating-ssh-keys) file.
     1. Under **Maintenance window settings**:
         - In the **Maintenance frequency / Disable** field, choose the maintenance window:
            - **Disabled**: Automatic updates are disabled.
            - **Anytime**: Maintenance is allowed at any time.
            - **Daily**: Maintenance is performed during the interval specified in the **Time (UTC) and duration** field.
            - **On selected days**: Maintenance is performed during the interval specified in the **Schedule by day** field.
     1. Click **Create node group**.

   - CLI

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     Create a node group:

     ```
     yc managed-kubernetes node-group create \
      --name k8s-gpu-cluster \
      --cluster-name k8s-gpu-cluster \
      --gpus 1 \  
      --public-ip \
      --location zone={{ region-id }}-a \  
      --fixed-size 1
     ```

     Where:

     - `--name`: Name of the node group.
     - `--cluster-name`: Name of the {{ k8s }} cluster where the node group is created.
     - `--gpus`: Number of GPUs for the nodes.
     - `--public-ip`: The flag that is specified if the node group needs a public IP address.
     - `--location`: Availability zone to host the nodes in. You can specify several options.
     - `--fixed-size`: Number of nodes in the group.

     Result:

     ```
     done (3m53s)
     id: cat3rmrrna8p93kafdce
     cluster_id: cattv5gvhqdbhi5f234m
     created_at: "2020-08-18T13:08:00Z"
     name: k8s-gpu-cluster
     status: RUNNING
     node_template:
       platform_id: gpu-standard-v1
       resources_spec:
         memory: "103079215104"
         cores: "8"
         core_fraction: "100"
         gpus: "1"
       boot_disk_spec:
         disk_type_id: network-ssd
         disk_size: "103079215104"
       v4_address_spec:
         one_to_one_nat_spec:
           ip_version: IPV4
       scheduling_policy: {}
     scale_policy:
       fixed_scale:
         size: "1"
     allocation_policy:
       locations:
       - zone_id: {{ region-id }}-a
         subnet_id: e9bl18jrs4f4smm67ma6
     deploy_policy:
       max_expansion: "3"
     instance_group_id: cl1f9sfccj3s3818u9pb
     node_version: "1.17"
     version_info:
       current_version: "1.17"
       new_revision_available: true
     maintenance_policy:
       auto_upgrade: true
       auto_repair: true
       maintenance_window:
         anytime: {}
     ```

   - API

     To create a node group, use the [create](../api-ref/NodeGroup/create.md) method for the [NodeGroup](../api-ref/NodeGroup) resource.

   {% endlist %}

   {% endcut %}

1. Create a pod with a GPU.

   Save the following GPU pod creation specification to a YAML file named `cuda-vector-add.yaml`:

    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: cuda-vector-add
    spec:
      restartPolicy: OnFailure
      containers:
        - name: cuda-vector-add
          # https://github.com/kubernetes/kubernetes/blob/v1.7.11/test/images/nvidia-cuda/Dockerfile
          image: "k8s.gcr.io/cuda-vector-add:v0.1"
          resources:
            limits:
              nvidia.com/gpu: 1 # Request for 1 GPU.
    ```

   To learn more about the pod creation specification, see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#pod-v1-core).

1. Run the command:

    ```
    kubectl create -f cuda-vector-add.yaml
    pod/cuda-vector-add created
    ```

1. View information about the pod created:

    ```
    kubectl describe pod cuda-vector-add
    Name:         cuda-vector-add
    Namespace:    default
    Priority:     0
    Node:         cl1i7hcbti99j6bbua6u-ebyq/10.0.0.16
    Start Time:   Thu, 13 Aug 2020 17:52:46 +0300
    Labels:       <none>
    Annotations:  <none>
    Status:       Succeeded
    ...
    Events:
      Type    Reason     Age   From                                Message
      ----    ------     ----  ----                                -------
      Normal  Scheduled  17m   default-scheduler                   Successfully assigned default/cuda-vector-add to cl1i7hcbti99j6bbua6u-ebyq
      Normal  Pulling    17m   kubelet, cl1i7hcbti99j6bbua6u-ebyq  Pulling image "k8s.gcr.io/cuda-vector-add:v0.1"
      Normal  Pulling    16m   kubelet, cl1i7hcbti99j6bbua6u-ebyq  Successfully pulled image "k8s.gcr.io/cuda-vector-add:v0.1"
      Normal  Created    16m   kubelet, cl1i7hcbti99j6bbua6u-ebyq  Created container cuda-vector-add
      Normal  Started    16m   kubelet, cl1i7hcbti99j6bbua6u-ebyq  Created container
    ```

1. View the pod logs:

    ```
    kubectl logs -f cuda-vector-add
    [Vector addition of 50000 elements]
    Copy input data from the host memory to the CUDA device
    CUDA kernel launch with 196 blocks of 256 threads
    Copy output data from the CUDA device to the host memory
    Test PASSED
    Done
    ```