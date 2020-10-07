1. In [management console]({{ link-console-main }}), select the folder where you want to create your {{ k8s }} cluster.
1. In the list of services, select **{{ managed-k8s-name }}**.
1. Click **Create cluster**.
1. Enter a name and description for the {{ k8s }} cluster.
1. Specify a **service account for the resources**. This is used to create the resources.
1. Specify a **service account for nodes**. The nodes use this service account to access the Docker image registry.
1. Specify a [release channel](../../managed-kubernetes/concepts/release-channels-and-updates.md).
1. Under **Master configuration**:
    - In the **{{ k8s }} version** field, select the {{ k8s }} version to be installed on the master.

    - In the **Public IP** field, choose a method for assigning an IP address:
        - **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
        - **No address**: Don't assign a public IP address.

    - In the **Master type** field, select the type of master:
        - **Zonal**: A master created in a subnet in one availability zone.
        - **Regional**: A master created and distributed in three subnets in each availability zone.

    - Select the [availability zone](../../overview/concepts/geo-scope.md) where you want to create the [master](../../managed-kubernetes/concepts/index.md#master) node address.

        This step is only available for the zonal master.

    - In the **Network format** field, choose how networks are displayed:
        - **List**: Available networks are displayed as a list. If you don't have a cloud network, click **Create network**:
            - In the window that opens, enter a name for the network. Specify that subnets should be created. Click **Create network**. By default, networks are created with subnets in each availability zone.
        - **ID**: Enter the unique ID of the required networks.

    - In the **Cloud network** field, select the network to create the master in.

    - In the **Subnet** field, select the subnet to create the master in.

        For the regional master, specify three subnets in each availability zone.
1. Under **Maintenance window settings**:
    - In the **Maintenance frequency / Disable** field, configure the maintenance window:
        - **Disabled**: Automatic updates are disabled.
        - **Anytime**: Maintenance is allowed at any time.
        - **Daily**: Maintenance is performed in the time interval specified in the **Time (UTC) and duration** field.
        - **On selected days**: Maintenance is performed in the time interval specified in the **Weekly schedule** field.
1. Under **Cluster network settings**:
    - Specify the **cluster CIDR**, which is a range of IP addresses for allocating pod addresses.
    - Specify the **service CIDR**, which is a range of IP addresses for allocating service addresses.
1. Click **Create cluster**.

