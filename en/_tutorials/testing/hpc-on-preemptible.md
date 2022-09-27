# High-performance computing (HPC) on preemptible VMs

[HPC clusters](https://en.wikipedia.org/wiki/Computer_cluster) are used for computational purposes, particularly scientific research and computation-intensive scientific calculations. A computer cluster is a set of servers (computing nodes) connected over a network. Each computing node has a number of multicore processors, local memory, and runs its own operating system instance. The most common are homogeneous clusters where all nodes are identical in their architecture and performance.

Follow these instructions to create a cluster of [preemptible VMs](../../compute/concepts/preemptible-vm.md) to perform a shared computational task. For example, to solve a system of linear equations using the [Jacobi method](https://en.wikipedia.org/wiki/Jacobi_method).

To create a cluster and run a computational task:

1. [Before you start](#before-you-begin).
1. [Create a master VM in the cloud](#create-master-vm).
   1. [Create a VM](#create-vm).
   1. [Configure the VM](#setup-vm).
1. [Prepare a VM cluster](#prepare-cluster).
   1. [Create a cluster](#create-cluster).
   1. [Test the cluster](#test-cluster).
   1. [Configure the NFS](#configure-nfs).
   1. [Mount directories on group VMs](#mount).
1. [Create a computational task in the cluster](#config-hpc).
1. [Run and analyze the computations](#start-hpc).
1. [How to delete created resources](#clear-out).

## Before you start {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost for hosting servers includes:

* A fee for running multiple VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Create a master VM in the cloud {#create-master-vm}

### Creating VMs {#create-vm}

To create a VM:

1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource**, and select **Virtual machine**.

1. In the **Name** field, enter a name for the VM. For clarity, enter `master-node`.

1. Select the [availability zone](../../overview/concepts/geo-scope.md) to host the VM in.

1. Under **Image/boot disk selection**, click the **{{ marketplace-name }}** tab, and select the [Ubuntu](/marketplace?tab=software&search=Ubuntu&categories=os) image.

1. Under **Disks**, select an SSD with 13 GB. The disk type should be **SSD** since other VMs will use it for network access.

1. Under **Computing resources**:
   - Choose a [platform](../../compute/concepts/vm-platforms.md) for the VM.
   - For these computational tasks, specify the following configuration:
    - **Platform**: Intel Ice Lake.
    - **Guaranteed vCPU share**: 100%.
    - **vCPU**: 4.
    - **RAM**: 4 GB.
    - **Advanced**: Preemptible.

1. Under **Network settings**:
   - Select the **Network** and **Subnet** to connect the VM to. If you don't have a network or subnet, create them right on the VM creation page.
   - In the **Public address** field, leave the **Auto** value to assign a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one in advance.

1. Under **Access**, specify the information required to access the VM:
   - In the **Login** field, enter a username to be created on the VM.
   - In the **SSH key** field, paste your public SSH key. You need to create a key pair for the SSH connection yourself. Learn [how to connect to VMs via SSH](../../compute/operations/vm-connect/ssh.md).

1. Click **Create VM**.

### Configure the VM {#setup-vm}

1. [Log in via SSH](../../compute/operations/vm-connect/ssh.md) to the VM and switch to admin mode in the console:

   ```bash
   sudo -i
   ```

1. Update the repository and install the required utilities:

   ```bash
   apt update
   apt install -y net-tools htop libopenmpi-dev nfs-common
   ```

1. Exit admin mode and generate RSA keys for access between the VMs:

   ```bash
   exit
   ssh-keygen
   ```

1. Add the generated key to the list of allowed ones:

   ```bash
   cd ~/.ssh
   cat id_rsa.pub >> authorized_keys
   ```

## Prepare a VM cluster {#prepare-cluster}

### Create a cluster {#create-cluster}

1. In the [management console]({{ link-console-main }}), go to **Disks** and click **Create snapshot** of the `master-node` disk. Name it `master-node-snapshot`. After the snapshot is created, it appears in the list under **Disk snapshots**.
1. Go to **Instance groups** and click **Create group**.
1. Create an instance group:
   - In the **Name** field, enter a name for the future group (for example, `compute-group`).
   - In the **Service account** field, add a [service account](../../compute/concepts/instance-groups/access.md) to this group. If you don't have a service account, click **Create new**, enter a name, and click **Create**.
   - Choose the same **Availability zone** that the `master-node` is in. VMs should be in the same availability zone to reduce latency between them.
   - Under **Instance template**, click **Define**: You'll see a screen for creating a template.
     - Under **Disks**, select **Add disk**. In the window that opens, specify:
       - **Disk designation**: Boot.
       - **Disk type**: SSD.
       - **Contents**: From `master-node-snapshot`.

     - Under **Computing resources**, specify the same configuration as the master VM:
       - **Platform**: Intel Ice Lake.
       - **Guaranteed vCPU share**: 100%.
       - **vCPU**: 4.
       - **RAM**: 4 GB.
       - **Advanced**: Preemptible.

     - Under **Network settings**, specify the same network and subnet as the master VM. Leave the address type as **Auto**.

     - Under **Access**, specify the information required to access the VM:
       - In the **Login** field, enter a username to be created on the VM.
       - In the **SSH key** field, paste your public SSH key. You need to create a key pair for the SSH connection yourself. Learn [how to connect to VMs via SSH](../../compute/operations/vm-connect/ssh.md).

     - Click **Add**. This returns you to the instance group creation screen.
1. Under **Scalability**, select the number of instances to create. Specify 3 instances.
1. Click **Create**.

### Test the cluster {#test-cluster}

[Log in via SSH](../../compute/operations/vm-connect/ssh.md) to each VM in `compute-group` and make sure you can access `master-node` from them via SSH.

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

1. Open the `/etc/exports` file with a text editor, like `nano`:

   ```bash
   sudo nano /etc/exports
   ```

1. Add an entry to the file to enable access to the `shared` directory:

   ```
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
   Filesystem                            Size  Used Avail Use% Mounted on
   ...
   master-node:/home/<username>/shared   13G  1.8G   11G  15% /home/<username>/shared
   ```

## Create a task for computations in the cluster {#config-hpc}

1. Log in to the `master-node` VM via SSH, go to the `shared` directory, and download the `task.c` source file with a computational task:

   ```bash
   cd ~/shared
   wget https://raw.githubusercontent.com/cloud-docs-writer/examples/master/hpc-on-preemptible/task.c
   ```

   This code solves a system of linear equations using the [Jacobi method](https://en.wikipedia.org/wiki/Jacobi_method). The task has one distributed implementation using MPI.

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

   ```
   JAC1 STARTED
   1: Time of task=45.104153
   0: Time of task=45.103931
   ```

1. Run the task on four cores using only `master-node` resources and get the appropriate results:

   ```bash
   mpirun -np 4 task
   JAC1 STARTED
   1: Time of task=36.562328
   2: Time of task=36.562291
   3: Time of task=36.561989
   0: Time of task=36.561695
   ```

1. Run the task on four cores using the resources of two VMs with two cores per VM. To do this, run the task with the `-host` key that accepts parameters like `<VM IP address>:<number of cores>[,<ip>:<cores>[,...]]`. After computing the task, the program displays the results:

   ```bash
   mpirun -np 4 -host localhost:2,<VM IP address>:2 task
   JAC1 STARTED
   0: Time of task=24.539981
   1: Time of task=24.540288
   3: Time of task=24.540619
   2: Time of task=24.540781
   ```

1. Similarly, you can continue to increase the number of VMs and cores in use and see how distributed computing can significantly speed up task execution.

## How to delete created resources {#clear-out}

To stop paying for your deployed server and created instance group, just delete the `master-node` VM and `compute-group` group.

If you reserved a static public IP address specifically for this VM:

1. Select the **{{ vpc-short-name }}** in your folder.
1. Go to the **IP addresses** tab.
1. Find the address you need, click ![ellipsis](../../_assets/options.svg), and select **Delete**.

