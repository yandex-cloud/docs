---
title: How to connect to a {{ dataproc-full-name }} cluster host over SSH
description: Follow this guide to connect to a {{ dataproc-name }} host over SSH.
---

# Connecting to a {{ dataproc-name }} host over SSH

You can connect to a {{ dataproc-name }} cluster over SSH.

Before connecting:

1. [Configure security groups](security-groups.md).
1. [Get the host FQDN](fqdn.md).

## Connect using a standard SSH client {#connection-ssh}

To connect to a {{ dataproc-name }} host, make sure the SSH key you specified when creating the {{ dataproc-name }} cluster is accessible on the local machine or interim VM. You can copy the key to the machine that will connect to the cluster, or connect to it with an SSH agent.

1. If you do not have public access configured for your subcluster, [connect](../../compute/operations/vm-connect/ssh.md) to the interim VM over SSH.

1. Start the SSH agent:

    ```bash
    eval `ssh-agent -s`
    ```

1. Add the required key to the list of those available to the agent:
 
   ```bash
   ssh-add ~/.ssh/example-key
   ```

1. Open a SSH connection to the {{ dataproc-name }} host by specifying its [FQDN](fqdn.md) or IP address if public access is enabled for the host. For image version 2.0, specify the `ubuntu` user; for image version 1.4, `root`, e.g.:

   ```bash
   ssh ubuntu@rc1b-dataproc-m-fh4y4nur********.{{ dns-zone }}
   ```

   Result:

   ```text
   ubuntu@rc1b-dataproc-m-fh4y4nur********:~#
   ```

1. Make sure Hadoop commands are executed, e.g.:

    ```bash
    hadoop version
    ```

    Result:

    ```text
    Hadoop 2.8.5
    Subversion https://github.yandex-team.ru/mdb/bigtop.git -r 78508f2a4b4f3dc8b3d295ccb50a45a4********
    Compiled by robot-pgaas-ci on 2019-04-16T10:35Z
    Compiled with protoc 2.5.0
    From source with checksum 9942ca5c745417c14e31883********
    This command was run using /usr/lib/hadoop/hadoop-common-2.8.5.jar
    ```