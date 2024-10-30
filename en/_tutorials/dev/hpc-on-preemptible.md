# High-performance computing (HPC) on preemptible VMs

[HPC clusters](https://en.wikipedia.org/wiki/Computer_cluster) are used for computational purposes, for scientific research and computation-intensive scientific calculations in particular. A computer cluster is a set of servers (computing nodes) connected over a network. Each computing node has a number of multicore processors, local memory, and runs its own operating system instance. The most common are homogeneous clusters where all nodes are identical in their architecture and performance.

Follow this guide to create a cluster of [preemptible VMs](../../compute/concepts/preemptible-vm.md) to perform a shared computational task. For example, to solve a system of linear equations using the [Jacobi method](https://en.wikipedia.org/wiki/Jacobi_method).

To create a cluster and run a computational task:
1. [Prepare your cloud](#before-you-begin).
1. [Create a master VM in the cloud](#create-master-vm).
1. [Prepare the VM's cluster](#prepare-cluster).
1. [Create a cluster](#create-cluster).
1. [Create a task for computations in the cluster](#config-hpc).
1. [Run and analyze the computations](#start-hpc).
1. [Delete the resources you created](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost for hosting servers includes:
* Fee for multiple continuously running [VMs](../../compute/concepts/vm.md) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a dynamic or static [public IP address](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Create a master VM in the cloud {#create-master-vm}

### Create a VM {#create-vm}

To create a VM:
1. On the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
1. In the **{{ ui-key.yacloud.common.name }}** field, enter the VM name. For clarity, enter `master-node`.
1. Select an [availability zone](../../overview/concepts/geo-scope.md) to place the VM in.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and select the [Ubuntu](/marketplace?tab=software&search=Ubuntu&categories=os) image.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, select a 13 GB hard [disk](../../compute/concepts/disk.md). Select **{{ ui-key.yacloud.compute.value_disk-type-network-ssd }}** for disk type, because other VMs will use it for network access.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
   * Choose a VM [platform](../../compute/concepts/vm-platforms.md).

      For these computational tasks, specify the following configuration:
      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `4`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`
      * **{{ ui-key.yacloud.component.compute.resources.field_advanced }}**: `{{ ui-key.yacloud.component.compute.resources.field_preemptible }}`
1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
   * Select the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** and **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** to connect your VM to. If you do not have a [network](../../vpc/concepts/network.md#network) or [subnet](../../vpc/concepts/network.md#subnet), create them right on the VM creation page.
   * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field , keep **{{ ui-key.yacloud.component.compute.network-select.switch_auto }}** to assign your VM a random external IP address from the {{ yandex-cloud }} pool, or select a static IP address from the list if you reserved one in advance.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the VM:
   * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter your preferred login for the user to create on the VM.
   * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste your public SSH key. You need to create a key pair for the SSH connection yourself. To learn how, see [Connecting to a VM via SSH](../../compute/operations/vm-connect/ssh.md).
1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

### Set up the VM {#setup-vm}

1. [Use SSH to connect](../../compute/operations/vm-connect/ssh.md) to the VM and change to administrator mode in the console:

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

1. Add the generated key to the list of allowed ones:

   ```bash
   cd ~/.ssh
   cat id_ed25519.pub >> authorized_keys
   ```

## Prepare the VM's cluster {#prepare-cluster}

### Create a cluster {#create-cluster}

1. In the [management console]({{ link-console-main }}), go to **{{ ui-key.yacloud.compute.switch_disks }}**.
1. To the right of the `master-node` VM disk, click ![image](../../_assets/options.svg) and select **{{ ui-key.yacloud.compute.disks.button_action-snapshot }}**. Name it `master-node-snapshot`. After the snapshot is created, it appears in the list under **{{ ui-key.yacloud.compute.switch_snapshots }}**.
1. Go to **{{ ui-key.yacloud.compute.switch_groups }}** and click **{{ ui-key.yacloud.compute.groups.button_create }}**.
1. Create an [instance group](../../compute/concepts/instance-groups/index.md):
   * In the **{{ ui-key.yacloud.compute.groups.create.field_name }}** field, enter a name for the future instance group (e.g., `compute-group`).
   * In the **{{ ui-key.yacloud.compute.groups.create.field_service-account }}** field, add a [service account](../../compute/concepts/instance-groups/access.md) to the instance group. If you do not have a service account, click **{{ ui-key.yacloud.component.service-account-select.button_create-account-new }}**, enter a name, and click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
   * In the **{{ ui-key.yacloud.compute.groups.create.field_zone }}** field, choose the availability zone the `master-node` VM is in. Make sure the VMs are in the same availability zone to reduce latency between them.
   * Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}**. This opens a screen for creating a [template](../../compute/concepts/instance-groups/instance-template.md).
      * Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, select **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**. In the window that opens, specify:
         * **{{ ui-key.yacloud.compute.disk-form.field_type }}**: [SSD](../../compute/concepts/disk.md#disks-types)
         * **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}**: From the created [snapshot](../../compute/concepts/snapshot.md) named `master-node-snapshot`
      * Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, specify the same configuration as that of the master VM:
         * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
         * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
         * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `4`
         * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`
         * **{{ ui-key.yacloud.component.compute.resources.field_advanced }}**: `{{ ui-key.yacloud.component.compute.resources.field_preemptible }}`
      * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, specify the same network and subnet as those of the master VM. Leave **{{ ui-key.yacloud.component.compute.network-select.switch_auto }}** for the IP address type.
      * Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the VM:
         * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter your preferred login for the user to create on the VM.
         * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste your public SSH key. You need to create a key pair for the SSH connection yourself. To learn how, see [Connecting to a VM via SSH](../../compute/operations/vm-connect/ssh.md).
      * Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**. This returns you to the instance group creation screen.
1. Under **{{ ui-key.yacloud.compute.groups.create.section_scale }}**, select the number of instances to be created. Specify 3 instances.
1. Click **{{ ui-key.yacloud.common.create }}**.

### Test the cluster {#test-cluster}

[Log in via SSH](../../compute/operations/vm-connect/ssh.md) to each instance in `compute-group` and make sure you can access `master-node` from them over SSH:

```bash
ping master-node
ssh master-node
```

### Configure the NFS {#configure-nfs}

To allow the VMs to use the same source files, create a shared network directory using [NFS](https://en.wikipedia.org/wiki/Network_File_System):
1. Log in to the `master-node` VM via SSH and install the NFS server:

   ```bash
   ssh <master-node VM public IP address>
   sudo apt install nfs-kernel-server
   ```

1. Create a `shared` directory for the VMs:

   ```bash
   mkdir ~/shared
   ```

1. Open the `/etc/exports` file with a text editor, e.g., `nano`:

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

#### Mount directories on group VMs {#mount}

On each VM in the `compute-group`, mount the directory you created:
1. Create a `shared` directory and mount the directory with the `master-node` VM on it:

   ```bash
   mkdir ~/shared
   sudo mount -t nfs master-node:/home/<username>/shared ~/shared
   ```

1. Make sure that the directory is successfully mounted:

   ```bash
   df -h
   ```

   Result:

   ```text
   Filesystem                                   Size  Used  Avail  Use%  Mounted on
   ...
   master-node:/home/<username>/shared   13G  1.8G   11G  15% /home/<username>/shared
   ```

## Create a task for computations in the cluster {#config-hpc}

1. Log in to the `master-node` VM via SSH, go to the `shared` directory, and download the `task.c` source file with a computational task:

   ```bash
   cd ~/shared
   wget https://raw.githubusercontent.com/cloud-docs-writer/examples/master/hpc-on-preemptible/task.c
   ```

   This code solves a system of linear equations using the Jacobi method. The task has one distributed implementation using MPI.
1. Compile the source file into an executable file:

   ```bash
   mpicc task.c -o task
   ```

   As a result, the `task` executable file should appear in the `shared` directory.

## Run and analyze the computations {#start-hpc}

{% note tip %}

You can check the load on VM cores by running the `htop` command in a separate SSH session on each VM.

{% endnote %}

1. Run the task on two cores using only `master-node` resources:

   ```bash
   mpirun -np 2 task
   ```

   When the task is completed, the program displays the time spent performing it:

   ```text
   JAC1 STARTED
   1: Time of task=45.104153
   0: Time of task=45.103931
   ```

1. Run the task on four cores using only `master-node` resources:

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

1. Run the task on four cores using the resources of two VMs with two cores per VM. To do this, run the task with the `-host` key that accepts parameters, such as `<VM IP address>:<number of cores>[,<ip>:<cores>[,...]]`:

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

1. Similarly, you can continue to increase the number of VMs and cores in use and see how distributed computing can significantly speed up task execution.

## Delete the resources you created {#clear-out}

To stop paying for your deployed server and created instance group, just delete the `master-node` VM and `compute-group` instance group.

If you reserved a static public IP address specifically for this VM:
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** in your folder.
1. Go to the **{{ ui-key.yacloud.vpc.switch_addresses }}** tab.
1. Find the required IP address, click ![ellipsis](../../_assets/options.svg), and select **{{ ui-key.yacloud.common.delete }}**.