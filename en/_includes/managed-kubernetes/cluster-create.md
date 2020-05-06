To create a {{ k8s }} cluster:

1. On the folder page in the [management console]({{ link-console-main }}), select **{{ managed-k8s-name }}** from the list of services.
1. Click **Create cluster**.
1. Enter a name and description for the {{ k8s }} cluster.
1. Under **Master configuration**:
    - Select the [availability zone](../../overview/concepts/geo-scope.md) where you want to create a [master](../../managed-kubernetes/concepts/index.md#master).
    - Select a **service account for resources** to use when creating resources.
    - Select a **service account for nodes** that nodes will use to access the Docker image registry.
    - In the **Public IP** field, select the **Auto** method for assigning an IP address.
    - In the **Network format** field, select:
        - **List**: To specify a network and subnet from the lists. If you don't have any networks, you can create them right on the cluster creation page.
        - **ID**: To specify the network ID and subnet ID.
1. Under **Cluster network settings**:
    - Specify the **cluster CIDR**, which is a range of IP addresses for allocating pod addresses.
    - Specify the **service CIDR**, which is a range of IP addresses for allocating service addresses.
1. Click **Create cluster**.

