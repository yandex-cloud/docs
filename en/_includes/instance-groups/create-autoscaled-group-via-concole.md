1. In the management console, select the folder where you want to create an instance group.
1. Select **{{compute-name}}**.
1. On the **Virtual machines** page, go to the **Instance groups** tab.
1. Click **Create group**.
1. Under **Basic parameters**:
    - Enter the name and description of the group.

        {% include [name-format](../name-format.md) %}

    - Select a service account from the list or create a new one. Service accounts must have the `{{ roles-editor }}` role to create, update, and delete instances in a group. If you don't have a service account, create one.
1. In the **Allocation** section, select the desired availability zones. Group instances may reside in different availability zones and regions. [Learn more about Yandex.Cloud geography](../../overview/concepts/geo-scope.md).
1. In the **Instance template** section, click **Set** to set the basic instance configuration:
    - Select a public [image](../../compute/operations/images-with-pre-installed-software/get-list.md).
    - In the **Disks** section:
        - Select the [disk type](../../compute/concepts/disk.md#disks_types).

        - Specify the disk size.

            To add more disks, click **Add disk**.
    - Under **Computing resources**:
        - Choose a [platform](../../compute/concepts/vm-platforms.md).
        - Specify the [guaranteed share](../../compute/concepts/performance-levels.md) and the necessary number of vCPUs and amount of RAM.
        - {% include [include](specify-preemptible-vm.md) %}
    - Under **Network settings**:
        - Select the [cloud network](../../compute/concepts/vm.md#network) and the subnet. If the necessary subnet is not in the list, [create it](../../vpc/operations/subnet-create.md).
        - Specify if a public IP address is required.
    - Under **Access**, specify the data required to access the VM:
        - Enter the username in the **Login** field.
        - Under **SSH key**, paste the contents of the public key file. You have to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for SSH connections on your own.
    - Click **Add**.
1. Under **Allow when creating and updating**, specify:
    - The number of instances that can be additionally allocated in order to expand the group size.

    - The number of instances the group size can be reduced by.

    - The number of instances that can be created simultaneously.

    - The number of instances that can be deleted simultaneously.

        For more information, see [{#T}](../../compute/concepts/instance-groups/policies/deploy-policy.md).
1. In the **Scalability** section:
    - Select the automatic [scaling type](../../compute/concepts/instance-groups/scale.md).
    - Indicate the following:
        - Target group size.
        - Maximum group size.
        - The minimum number of instances per availability zone.
        - Time to average metrics.
        - Startup duration of an instance in the group.
        - Time to monitor the maximum load on a service.
        - Select the metric type:
            - [CPU](../../compute/concepts/instance-groups/scale.md#cpu-utilization): Specify the average CPU load level that {{ ig-name }} must support.
            - [Custom](../../compute/concepts/instance-groups/scale.md#custom-metrics): Specify the name of the custom metric and target value that {{ ig-name }} must support.
1. Click **Create**.

