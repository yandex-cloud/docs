# High-performance computing (HPC) on preemptible VMs

[HPC clusters](https://en.wikipedia.org/wiki/Computer_cluster) are used for computation, particularly for computation-intensive scientific calculations. A computing cluster consists of multiple servers (computing nodes) connected over a network. Each computing node has a number of multicore processors, local memory, and runs its own autonomous operating system. The most widespread are homogeneous clusters, where all nodes are identical in their architecture and performance.

Follow this tutorial to create a cluster of [preemptible VMs](../../compute/concepts/preemptible-vm.md) for performing a shared computational task. For example, you can solve a system of linear equations using the [Jacobi method](https://en.wikipedia.org/wiki/Jacobi_method).

To create a cluster and run a computational task:
1. [Get your cloud ready](#before-you-begin).
1. [Create a master VM in the cloud](#create-master-vm).
1. [Prepare the VM cluster](#prepare-cluster).
1. [Create a cluster](#create-cluster).
1. [Create a task for computations in the cluster](#config-hpc).
1. [Run and analyze the computations](#start-hpc).
1. [Delete the resources you created](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The costs for hosting servers include:
* Fee for multiple continuously running [VMs](../../compute/concepts/vm.md) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a dynamic or static [public IP address](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Create a master VM in the cloud {#create-master-vm}

### Create a VM {#create-vm}

To create a VM:

1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create your VM in.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the [Ubuntu](/marketplace?tab=software&search=Ubuntu&categories=os) image.
1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) the VM will reside in.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, select `{{ ui-key.yacloud.compute.value_disk-type-network-ssd }}` as the boot [disk](../../compute/concepts/disk.md) type.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, go to the **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** tab and specify parameters for your current computing tasks:

    * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
    * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `4`
    * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
    * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`
    * **{{ ui-key.yacloud.component.compute.resources.field_advanced }}**: `{{ ui-key.yacloud.component.compute.resources.field_preemptible }}`

1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

    * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, enter the ID of a subnet in the new VM’s availability zone. Alternatively, you can select a [cloud network](../../vpc/concepts/network.md#network) from the list.

        * Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet). If there is no subnet, create one by selecting **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
        * If you do not have a network, click **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** to create one:

            * In the window that opens, enter the network name and select the folder to host the network.
            * Optionally, enable the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** setting to automatically create subnets in all availability zones.
            * Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

    * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign the VM a random external IP address from the {{ yandex-cloud }} pool. Alternatively, select a static address from the list if you reserved one.

1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

    * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a name for the user you want to create on the VM, e.g., `ubuntu`.

      {% note alert %}

      Do not use `root` or other reserved usernames. To perform operations requiring root privileges, use the `sudo` command.

      {% endnote %}

    * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name. For clarity, enter `master-node`.
1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

### Set up the VM {#setup-vm}

1. [Use SSH to connect](../../compute/operations/vm-connect/ssh.md) to the VM and switch to administrator mode in the console:

   ```bash
   sudo -i
   ```

1. Update the repository and install the required utilities:

   ```bash
   apt update
   apt install -y net-tools htop libopenmpi-dev nfs-common
   ```

1. Exit admin mode and generate SSH keys for access between the VMs:

   ```bash
   exit
   ssh-keygen -t ed25519
   ```

1. Add the key you generated to the list of allowed ones:

   ```bash
   cd ~/.ssh
   cat id_ed25519.pub >> authorized_keys
   ```

## Prepare the VM cluster {#prepare-cluster}

### Create a cluster {#create-cluster}

1. In the [management console]({{ link-console-main }}), go to **{{ ui-key.yacloud.compute.switch_disks }}**.
1. To the right of the `master-node` VM disk, click ![image](../../_assets/options.svg) and select **{{ ui-key.yacloud.compute.disks.button_action-snapshot }}**. Enter the name: `master-node-snapshot`. After you create the snapshot, it will appear in the list under **{{ ui-key.yacloud.compute.switch_snapshots }}**.
1. Go to **{{ ui-key.yacloud.compute.switch_groups }}** and click **{{ ui-key.yacloud.compute.groups.button_create }}**.
1. Create an [instance group](../../compute/concepts/instance-groups/index.md):
   * In the **{{ ui-key.yacloud.compute.groups.create.field_name }}** field, enter a name for your instance group, e.g., `compute-group`.
   * In the **{{ ui-key.yacloud.compute.groups.create.field_service-account }}** field, add a [service account](../../compute/concepts/instance-groups/access.md) to the instance group. If you do not have a service account, click **{{ ui-key.yacloud.component.service-account-select.button_create-account-new }}**, enter a name, and click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

     To create, update, and delete VMs in the group, assign the [compute.editor](../../compute/security/index.md#compute-editor) role to the service account. By default, all operations in {{ ig-name }} are performed on behalf of a service account.

   * In the **{{ ui-key.yacloud.compute.groups.create.field_zone }}** field, select the availability zone where the `master-node` VM resides. Make sure the VMs are in the same availability zone to reduce latency between them.
   * Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}**. This will open a screen for creating a [template](../../compute/concepts/instance-groups/instance-template.md).
     * Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, select **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**. In the window that opens, specify:
       * **{{ ui-key.yacloud.compute.disk-form.field_type }}**: [SSD](../../compute/concepts/disk.md#disks-types).
       * **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}**: From the created [snapshot](../../compute/concepts/snapshot.md) named `master-node-snapshot`.
     * Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, reproduce the the master VM configuration:
       * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
       * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `4`
       * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
       * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`
       * **{{ ui-key.yacloud.component.compute.resources.field_advanced }}**: `{{ ui-key.yacloud.component.compute.resources.field_preemptible }}`
     * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, specify the same network and subnet as those of the master VM. Leave **{{ ui-key.yacloud.component.compute.network-select.switch_auto }}** as the IP address type.
     * Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the VM:
       * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter your preferred login for the user you will create on the VM.
       * Paste your public SSH key into the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field. You will need to create a key pair for the SSH connection on your own. To learn more, see [Connecting to a VM over SSH](../../compute/operations/vm-connect/ssh.md).
     * Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**. This will take you back to the instance group creation screen.
1. Under **{{ ui-key.yacloud.compute.groups.create.section_scale }}**, select the number of instances to create. Specify three instances.
1. Click **{{ ui-key.yacloud.common.create }}**.

### Test the cluster {#test-cluster}

[Log in over SSH](../../compute/operations/vm-connect/ssh.md) to each VM in `compute-group` and make sure you can access the `master-node` VM from them over SSH:

```bash
ping master-node
ssh master-node
```

### Configure the NFS {#configure-nfs}

To allow the VMs to use the same source files, create a shared network directory using [NFS](https://en.wikipedia.org/wiki/Network_File_System):
1. Log in to the `master-node` VM over SSH and install an NFS server:

   ```bash
   ssh <master-node VM public IP address>
   sudo apt install nfs-kernel-server
   ```

1. Create a `shared` directory for the VMs:

   ```bash
   mkdir ~/shared
   ```

1. Open the `/etc/exports` file in any text editor, e.g., `nano`:
   
   ```bash
   sudo nano /etc/exports
   ```

1. Add an entry to the file to enable access to the `shared` directory:

   ```text
   /home/<username>/shared *(rw,sync,no_root_squash,no_subtree_check)
   ```

   Save the file.
1. Apply the settings and restart the service:

   ```bash
   sudo exportfs -a
   sudo service nfs-kernel-server restart
   ```

#### Mount the directories on the group VMs {#mount}

On each VM in `compute-group`, mount the directory you created:
1. Create a `shared` directory and mount the directory with the `master-node` VM on it:

   ```bash
   mkdir ~/shared
   sudo mount -t nfs master-node:/home/<username>/shared ~/shared
   ```

1. Make sure the directory is successfully mounted:

   ```bash
   df -h
   ```

   Result:

   ```text
   Filesystem                                   Size  Used  Avail  Use%  Mounted on
   ...
   master-node:/home/<username>/shared  13G   1.8G  11G    15%   /home/<username>/shared
   ```

## Create a computing task in the cluster {#config-hpc}

1. Log in to the `master-node` VM over SSH, go to the `shared` directory, and download the `task.c` source file with a computing task:

   ```bash
   cd ~/shared
   wget https://raw.githubusercontent.com/cloud-docs-writer/examples/master/hpc-on-preemptible/task.c
   ```

   This code solves a system of linear equations using the Jacobi method. This task has one distributed implementation using MPI.
1. Compile the source file into an executable:

   ```bash
   mpicc task.c -o task
   ```

   As a result, the `task` executable file should appear in the `shared` directory.

## Run and analyze the computations {#start-hpc}

{% note tip %}

You can check the load on the VM cores by running the `htop` command in a separate SSH session on each VM.

{% endnote %}

1. Run the task on two cores using only the `master-node` VM resources:

   ```bash
   mpirun -np 2 task
   ```

   Once the task has been completed, the program will display the time spent performing it:

   ```text
   JAC1 STARTED
   1: Time of task=45.104153
   0: Time of task=45.103931
   ```

1. Run the task on four cores using only the `master-node` VM resources:

   ```bash
   mpirun -np 4 task
   ```

   Result:

   ```text
   JAC1 STARTED
   1: Time of task=36.562328
   2: Time of task=36.562291
   3: Time of task=36.561989
   0: Time of task=36.561695
   ```

1. Run the task on four cores using the resources of two VMs with two cores per VM. To do this, run the task with the `-host` key that accepts parameters in `<VM IP address>:<number of cores>[,<ip>:<cores>[,...]]` format:

   ```bash
   mpirun -np 4 -host localhost:2,<VM IP address>:2 task
   ```

   Result:

   ```bash
   JAC1 STARTED
   0: Time of task=24.539981
   1: Time of task=24.540288
   3: Time of task=24.540619
   2: Time of task=24.540781
   ```

1. Similarly, you can further increase the number of VMs and cores in use and see how distributed computing can significantly speed up the task resolution.

## Delete the resources you created {#clear-out}

To stop paying for the deployed server and VM group you created, delete the `master-node` VM and `compute-group`.

If you reserved a static public IP address specifically for this VM:
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** in your folder.
1. Go to the **{{ ui-key.yacloud.vpc.switch_addresses }}** tab.
1. Find the required IP address, click ![ellipsis](../../_assets/options.svg), and select **{{ ui-key.yacloud.common.delete }}**.
