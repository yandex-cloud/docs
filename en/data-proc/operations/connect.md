# Connecting to {{ dataproc-name }} clusters

After you create a {{ dataproc-name }} cluster, you can connect to the host of the main subcluster.

Cluster hosts cannot be assigned a public IP address, so use a VM from the same cloud network to connect to them.

1. [Create a new VM](../../compute/operations/vm-create/create-linux-vm.md) if necessary.
1. Connect to the VM via [SSH](../../compute/operations/vm-connect/ssh).
1. You should also use SSH to connect to the host of the main subcluster from your VM.

## Connecting to a host via SSH {{ dataproc-name }} {#data-proc-ssh}

To connect to a {{ dataproc-name }} host from your VM, make sure the SSH key that you specified when creating the {{ dataproc-name }} cluster is accessible on it. You can copy the key to the VM or connect to it with an SSH agent.

1. Run the SSH agent locally:

    ```bash
    $ eval `ssh-agent -s`
    ```

1. Add the required key to the list of those available to the agent:

   ```bash
   $ ssh-add ~/.ssh/example-key
   ```

1. Open an SSH connection to the {{ dataproc-name }} host for the `root` user, for example:

   ```bash
   $ ssh root@rc1b-dataproc-m-fh4y4nur0i0uqqkz.mdb.yandexcloud.net
   
   root@rc1b-dataproc-m-fh4y4nur0i0uqqkz:~#
   ```

1. Make sure that Hadoop commands are executed, for example:

    ```bash
    ~# hadoop version
    
    Hadoop 2.8.5
    Subversion https://github.yandex-team.ru/mdb/bigtop.git -r 78508f2a4b4f3dc8b3d295ccb50a45a4d24e81b5
    Compiled by robot-pgaas-ci on 2019-04-16T10:35Z
    Compiled with protoc 2.5.0
    From source with checksum 9942ca5c745417c14e318835f420733
    This command was run using /usr/lib/hadoop/hadoop-common-2.8.5.jar
    ```

