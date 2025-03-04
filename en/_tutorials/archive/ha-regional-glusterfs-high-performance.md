# Deploying GlusterFS in high performance mode

[GlusterFS](https://ru.wikipedia.org/wiki/GlusterFS) is a parallel, distributed, and scalable file system. With horizontal scaling, the system provides the cloud with an aggregate bandwidth in the tens of GB/s and hundreds of thousands of [IOPS](https://ru.wikipedia.org/wiki/IOPS).

Use this tutorial to create an infrastructure made up of 30 segments sharing a common GlusterFS file system. Placing storage [disks](../../compute/concepts/disk.md) in a single [availability zone](../../overview/concepts/geo-scope.md) will ensure the high performance of your file system. In our scenario, it is the speed of accessing physical disks that limits performance, while network latency is less important.

To configure a high-performance file system:

1. [Get your cloud ready](#prepare-cloud).
1. [Configure the CLI profile](#setup-profile).
1. [Set up an environment for deploying the resources](#setup-environment).
1. [Deploy your resources](#deploy-resources).
1. [Install and configure GlusterFS](#install-glusterfs).
1. [Test the solution’s availability](#test-glusterfs).
1. [Test the solution’s performance](#test-glusterfs-performance).

If you no longer need the resources you created, [delete them](#clear-out).
 
## Get your cloud ready {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support costs include:

* Fee for continuously running VMs and disks (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for IP addresses and outbound traffic (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

## Configure the CLI profile {#setup-profile}

1. If you do not have the {{ yandex-cloud }} command line interface yet, [install](../../cli/quickstart.md) it and sign in.
1. Create a service account:
   
   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create a service account.
      1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Specify the service account name, e.g., `sa-glusterfs`.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   - CLI {#cli}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Run the command below to create a service account, specifying `sa-glusterfs` as its name:

      ```bash
      yc iam service-account create --name sa-glusterfs
      ```

      Where `name` is the service account name.

      Result:
      ```text
      id: ajehr0to1g8b********
      folder_id: b1gv87ssvu49********
      created_at: "2023-06-20T09:03:11.665153755Z"
      name: sa-glusterfs
      ```

   - API {#api}

      To create a service account, use the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call or the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the `ServiceAccount` resource.

   {% endlist %}

1. Assign the service account the administrator [role](../../iam/concepts/access-control/roles.md) for the folder: 

   {% list tabs group=instructions %}

   - Management console {#console}

      1. On the management console [home page]({{ link-console-main }}), select a folder.
      1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
      1. In the list, find the `sa-glusterfs` account and click ![image](../../_assets/options.svg).
      1. Click **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
      1. Click **{{ ui-key.yacloud_components.acl.button.add-role }}** in the dialog that opens and select the `admin` role.

   - CLI {#cli}

      Run this command:
      ```
      yc resource-manager folder add-access-binding <folder_ID> \
         --role admin \
         --subject serviceAccount:<service_account_ID>
      ```

   - API {#api}

      To assign a service account a role for a folder, use the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md) gRPC API call.

   {% endlist %}

1. Set up the CLI profile to run operations on behalf of the service account:

   {% list tabs group=instructions %}

   - CLI {#cli}

      1. Create an [authorized key](../../iam/concepts/authorization/key.md) for the service account and save it into the file:
         ```
         yc iam key create \
         --service-account-id <service_account_ID> \
         --folder-id <service_account_folder_ID> \
         --output key.json
         ```
         Where:
         * `service-account-id`: Service account ID.
         * `folder-id`: ID of the service account folder.
         * `output`: Name of the authorized key file.

         Result:
         ```
         id: aje8nn871qo4********
         service_account_id: ajehr0to1g8b********
         created_at: "2023-06-20T09:16:43.479156798Z"
         key_algorithm: RSA_2048
         ```

      1. Create a CLI profile to run operations on behalf of the service account:
         ```
         yc config profile create sa-glusterfs
         ```

         Result:
         ```
         Profile 'sa-glusterfs' created and activated
         ```

      1. Configure the profile:
         ```
         yc config set service-account-key key.json
         yc config set cloud-id <cloud_ID>
         yc config set folder-id <folder_ID>  
         ```

         Where:
         * `service-account-key`: File with the service account authorized key.
         * `cloud-id`: [Cloud ID](../../resource-manager/operations/cloud/get-id.md).
         * `folder-id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).

      1. Add the credentials to the environment variables:
         ```
         export YC_TOKEN=$(yc iam create-token)
         export YC_CLOUD_ID=$(yc config get cloud-id)
         export YC_FOLDER_ID=$(yc config get folder-id)
         ```

    {% endlist %}


## Prepare an environment for deploying the resources {#setup-environment}

1. Create an SSH key pair:
   ```bash
   ssh-keygen -t ed25519
   ```
   We recommend using the default key file name.
1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
1. Clone the `yandex-cloud-examples/yc-distributed-ha-storage-with-glusterfs` GitHub repository and go to the `yc-distributed-ha-storage-with-glusterfs` folder:
    ```
    git clone https://github.com/yandex-cloud-examples/yc-distributed-ha-storage-with-glusterfs.git
    cd ./yc-distributed-ha-storage-with-glusterfs
    ```
1. Edit the `variables.tf` file, specifying the parameters of the resources you are deploying:

   {% note warning %}

   The values set in the file result in deploying a resource-intensive infrastructure.
   To deploy the resources within your available quotas, use the values below or adjust the values to your specific needs.

   {% endnote %}

   1. Under `is_ha`, change `default` to `false`.
   1. Under `client_node_per_zone`, change `default` to `30`.
   1. Under `storage_node_per_zone`, change `default` to `30`.

      {% note info %}

      In our scenario, we will deploy 30 VMs. You can change this number depending on the requirements for the final storage size or total bandwidth.
      To calculate the maximum aggregate bandwidth of the entire system, multiply each segment's bandwidth (450 MB/s for [network SSDs](../../compute/concepts/disk.md#disks-types)) by the number of segments (30), which amounts to around 13.5 GB/s.
      To calculate the system capacity, multiply the number of segments (30) by the size of each storage (1 TB), which amounts to 30 TB.

      {% endnote %}

   1. If you specified a name other than the default one when creating the SSH key pair, change `default` to `<public_SSH_key_path>` under `local_pubkey_path`.
   1. If you need enhanced performance while guaranteed data integrity is optional to you, you can use [non-replicated SSDs](../../compute/concepts/disk.md#nr-disks). To do this, change `default` to `network-ssd-nonreplicated` under `disk_type`. In addition, make sure the `default` value under `disk_size` is a multiple of 93.

## Deploy your resources {#deploy-resources}
   
   1. Initialize {{ TF }}:
      ```bash
      terraform init
      ```
   1. Check the {{ TF }} file configuration:
      ```bash
      terraform validate
      ```
   1. Check the list of cloud resources you are about to create:
      ```bash
      terraform plan
      ```
   1. Create the resources:
      ```bash
      terraform apply -auto-approve
      ```
   1. Wait until you are notified it has been completed:
      ```bash
      Outputs:

      connect_line = "ssh storage@158.160.108.137"
      public_ip = "158.160.108.137"
      ```

   This will create 30 VMs for hosting client code (`client01`, `client02`, etc.) in the folder and 30 VMs for distributed data storage (`gluster01`, `gluster02`, etc.) bound to the client VMs and placed in the same availability zone.

## Install and configure GlusterFS {#install-glusterfs}

   1. Connect to the `client01` VM using the command from the process completion output:
      ```bash
      ssh storage@158.160.108.137
      ```
   1. Switch to the `root` mode:
      ```bash
      sudo -i
      ```
   1. Install [ClusterShell](https://clustershell.readthedocs.io/en/latest/intro.html):
      ```bash
      dnf install epel-release -y
      dnf install clustershell -y
      echo 'ssh_options: -oStrictHostKeyChecking=no' >> /etc/clustershell/clush.conf
      ```
   1. Create the configuration files:
      ```bash
      cat > /etc/clustershell/groups.conf <<EOF
      [Main]
      default: cluster
      confdir: /etc/clustershell/groups.conf.d $CFGDIR/groups.conf.d
      autodir: /etc/clustershell/groups.d $CFGDIR/groups.d
      EOF      

      cat > /etc/clustershell/groups.d/cluster.yaml <<EOF
      cluster:
         all: '@clients,@gluster'
         clients: 'client[01-30]'
         gluster: 'gluster[01-30]'
      EOF 
      ```
   1. Install GlusterFS:
      ```bash
      clush -w @all hostname # check and auto add fingerprints
      clush -w @all dnf install centos-release-gluster -y
      clush -w @all dnf --enablerepo=powertools install glusterfs-server -y
      clush -w @gluster mkfs.xfs -f -i size=512 /dev/vdb
      clush -w @gluster mkdir -p /bricks/brick1
      clush -w @gluster "echo '/dev/vdb /bricks/brick1 xfs defaults 1 2' >> /etc/fstab"
      clush -w @gluster "mount -a && mount"
      ```
   1. Restart GlusterFS:
      ```bash
      clush -w @gluster systemctl enable glusterd
      clush -w @gluster systemctl restart glusterd
      ```
   1. Check the availability of the `gluster02` through `gluster30` VMs:
      ```bash
      clush -w gluster01 'for i in {2..9}; do gluster peer probe gluster0$i; done'
      clush -w gluster01 'for i in {10..30}; do gluster peer probe gluster$i; done'
      ```
   1. Create a `vol0` folder in each data storage VM and configure availability and fault tolerance by connecting to the `stripe-volume` shared folder:
      ```bash
      clush -w @gluster mkdir -p /bricks/brick1/vol0
      export STRIPE_NODES=$(nodeset -S':/bricks/brick1/vol0 ' -e @gluster)
      clush -w gluster01 gluster volume create stripe-volume ${STRIPE_NODES}:/bricks/brick1/vol0 
      ```

   1. Make use of the additional performance settings:
      ```bash
      clush -w gluster01 gluster volume set stripe-volume client.event-threads 8
      clush -w gluster01 gluster volume set stripe-volume server.event-threads 8
      clush -w gluster01 gluster volume set stripe-volume cluster.shd-max-threads 8
      clush -w gluster01 gluster volume set stripe-volume performance.read-ahead-page-count 16
      clush -w gluster01 gluster volume set stripe-volume performance.client-io-threads on
      clush -w gluster01 gluster volume set stripe-volume performance.quick-read off
      clush -w gluster01 gluster volume set stripe-volume performance.parallel-readdir on
      clush -w gluster01 gluster volume set stripe-volume performance.io-thread-count 32
      clush -w gluster01 gluster volume set stripe-volume performance.cache-size 1GB
      clush -w gluster01 gluster volume set stripe-volume performance.cache-invalidation on
      clush -w gluster01 gluster volume set stripe-volume performance.md-cache-timeout 600
      clush -w gluster01 gluster volume set stripe-volume performance.stat-prefetch on
      clush -w gluster01 gluster volume set stripe-volume server.allow-insecure on
      clush -w gluster01 gluster volume set stripe-volume network.inode-lru-limit 200000
      clush -w gluster01 gluster volume set stripe-volume features.shard-block-size 128MB
      clush -w gluster01 gluster volume set stripe-volume features.shard on
      clush -w gluster01 gluster volume set stripe-volume features.cache-invalidation-timeout 600
      clush -w gluster01 gluster volume set stripe-volume storage.fips-mode-rchecksum on
      ```
   1. Mount the `stripe-volume` shared folder on the client VMs:
      ```bash
      clush -w gluster01  gluster volume start stripe-volume
      clush -w @clients mount -t glusterfs gluster01:/stripe-volume /mnt/
      ```

## Test the solution’s availability {#test-glusterfs}

   1. Check the status of the `stripe-volume` shared folder:
      ```bash
      clush -w gluster01  gluster volume status
      ```      

   1. Create a text file:
      ```bash
      cat > /mnt/test.txt <<EOF
      Hello, GlusterFS!
      EOF
      ```
   
   1. Make sure the file is available on all client VMs:
      ```bash
      clush -w @clients sha256sum /mnt/test.txt
      ```
      Result:
      ```bash
      client01: 5fd9c031531c39f2568a8af5512803fad053baf3fe9eef2a03ed2a6f0a884c85  /mnt/test.txt
      client02: 5fd9c031531c39f2568a8af5512803fad053baf3fe9eef2a03ed2a6f0a884c85  /mnt/test.txt
      client03: 5fd9c031531c39f2568a8af5512803fad053baf3fe9eef2a03ed2a6f0a884c85  /mnt/test.txt
      ...
      client30: 5fd9c031531c39f2568a8af5512803fad053baf3fe9eef2a03ed2a6f0a884c85  /mnt/test.txt
      ```

## Test the solution’s performance {#test-glusterfs-performance}

   [IOR](https://github.com/hpc/ior) is a benchmark for concurrent I/O operations you can use to test the performance of parallel data storage systems using various interfaces and access patterns.

   1. Install the dependencies:
      ```bash
      clush -w @clients dnf install -y autoconf automake pkg-config m4 libtool git mpich mpich-devel make fio
      cd /mnt/
      git clone https://github.com/hpc/ior.git
      cd ior
      mkdir prefix
      ```

   1. Close the shell and open it again:
      ```bash
      ^C
      sudo -i
      module load mpi/mpich-x86_64
      cd /mnt/ior
      ```

   1. Install IOR:
      ```bash
      ./bootstrap
      ./configure --disable-dependency-tracking  --prefix /mnt/ior/prefix
      make 
      make install
      mkdir -p /mnt/benchmark/ior
      ```

   1. Run IOR:
      ```bash
      export NODES=$(nodeset  -S',' -e @clients)
      mpirun -hosts $NODES -ppn 16 /mnt/ior/prefix/bin/ior  -o /mnt/benchmark/ior/ior_file -t 1m -b 16m -s 16 -F
      mpirun -hosts $NODES -ppn 16 /mnt/ior/prefix/bin/ior  -o /mnt/benchmark/ior/ior_file -t 1m -b 16m -s 16 -F -C
      ```

      Result:
      ```bash
      IOR-4.1.0+dev: MPI Coordinated Test of Parallel I/O
      Options:
      api                 : POSIX
      apiVersion          :
      test filename       : /mnt/benchmark/ior/ior_file
      access              : file-per-process
      type                : independent
      segments            : 16
      ordering in a file  : sequential
      ordering inter file : no tasks offsets
      nodes               : 30
      tasks               : 480
      clients per node    : 16
      memoryBuffer        : CPU
      dataAccess          : CPU
      GPUDirect           : 0
      repetitions         : 1
      xfersize            : 1 MiB
      blocksize           : 16 MiB
      aggregate filesize  : 120 GiB

      Results:

      access    bw(MiB/s)  IOPS       Latency(s)  block(KiB) xfer(KiB)  open(s)    wr/rd(s)   close(s)   total(s)   iter
      ------    ---------  ----       ----------  ---------- ---------  --------   --------   --------   --------   ----
      write     1223.48    1223.99    4.65        16384      1024.00    2.44       100.39     88.37      100.44     0
      read      1175.45    1175.65    4.83        16384      1024.00    0.643641   104.52     37.97      104.54     0
      ```


## How to delete the resources you created {#clear-out}

To stop paying for the resources created, delete them:
   ```bash
   terraform destroy -auto-approve
   ```
