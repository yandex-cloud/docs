---
title: How to connect to a {{ dataproc-full-name }} cluster host via {{ oslogin }}
description: Follow this guide to connect to a {{ dataproc-name }} host via {{ oslogin }}.
---

# Connecting to a {{ dataproc-name }} host via {{ oslogin }} 

{% note warning %}

You can enable {{ oslogin }} access to hosts only when [creating a cluster](cluster-create.md).

{% endnote %}

[{{ oslogin }}](../../organization/concepts/os-login.md) is used instead of SSH keys to access {{ yandex-cloud }} virtual machines.

You can connect to {{ dataproc-name }} cluster hosts via {{ oslogin }} using a [standard SSH client](connect-oslogin.md#os-login-ssh) or the [{{ yandex-cloud }} CLI](connect-oslogin.md#os-login-cli).

Before connecting:

1. [Enable access via {{ oslogin }}](../../organization/operations/os-login-access.md) at the organization level.
1. [Configure security groups](security-groups.md).
1. Assign one of the following roles to the user or [service account](../../iam/concepts/users/service-accounts.md) you will use for connection:
    
    * `compute.osLogin`
    * `compute.osAdminLogin`
  
    When connecting using the {{ yandex-cloud }} CLI, you additionally need the `compute.operator` role.

1. {% include [cli-install](../../_includes/cli-install.md) %}

## Connect using a standard SSH client {#os-login-ssh}

1. [Export the {{ oslogin }} certificate](../../compute/operations/vm-connect/os-login-export-certificate.md).

   {% note info %}

   The certificate is valid for one hour, after which you need to export it again.

   {% endnote %}

   The certificate includes the public and private parts. Save the path to the `Identity` private part as you will need it to connect to the host.

1. Learn the {{ dataproc-name }} host IP:

    1. Get a list of hosts:

       ```bash
       {{ yc-dp }} cluster list-hosts <cluster_name_or_ID>
       ```

       You can get the cluster ID and name with the [list of clusters](cluster-list.md#list) in the folder.

       Result:

       ```bash
       +------------------------------------------------------+----------------------+------------+----------------------+--------+
       |                         NAME                         | COMPUTE INSTANCE ID  |    ROLE    |    SUBCLUSTER ID     | HEALTH |
       +------------------------------------------------------+----------------------+------------+----------------------+--------+
       | rc1a-dataproc-d-q8659net********.mdb.yandexcloud.net | fhmr7sd33fl8******** | DATANODE   | c9qaps7qjj2d******** | ALIVE  |
       | rc1a-dataproc-m-hhhifdgl********.mdb.yandexcloud.net | fhmg686pspri******** | MASTERNODE | c9q7aen26lid******** | ALIVE  |
       +------------------------------------------------------+----------------------+------------+----------------------+--------+
       ```

       From the `COMPUTE INSTANCE ID` column, save the VM ID that matches your host.

   1. Get the VM info:

      ```bash
      yc compute instance get <VM_ID>
      ```

      Result:

      ```yml
      ...
      primary_v4_address:
        address: <internal_IP_address>
        one_to_one_nat:
          address: <external_IP_address>
          ip_version: IPV4
      ...
      ```

      If you are connecting to the host from the internet, save the external IP address; for connections from an intermediate VM, save the internal IP address.

1. Connect to the host:

    ```bash
    ssh -i <certificate_file_path> <user_login>@<host_IP_address>
    ```

    Where:

    * `<path_to_certificate_file>`: Path to the certificate's `Identity` file you saved earlier, e.g., `/home/user1/.ssh/yc-cloud-id-b1gia87mbaom********-orgusername`.
    * `<user_login>`: User login as set in their [{{ oslogin }}](../../organization/concepts/os-login.md#os-login-profiles) profile. This login is also specified at the end of the name of the exported {{ oslogin }} certificate. In the example above, it is `orgusername`.
    * `<host_IP_address>`: Host IP address you got earlier.

    When connecting to the host for the first time, you will get an unknown host warning:

    ```text
    The authenticity of host '158.160.**.** (158.160.**.**)' can't be established.
    ECDSA key fingerprint is SHA256:PoaSwqxRc8g6iOXtiH7ayGHpSN0MXwUfWHk********.
    Are you sure you want to continue connecting (yes/no)?
    ```

    Type `yes` into the terminal and press **Enter**.  

## Connect using the CLI {#os-login-cli}

1. Get a list of {{ dataproc-name }} hosts:

   ```bash
   {{ yc-dp }} cluster list-hosts <cluster_name_or_ID>
   ```

   You can get the cluster ID and name with the [list of clusters](cluster-list.md#list) in the folder.

   Result:

   ```bash
   +------------------------------------------------------+----------------------+------------+----------------------+--------+
   |                         NAME                         | COMPUTE INSTANCE ID  |    ROLE    |    SUBCLUSTER ID     | HEALTH |
   +------------------------------------------------------+----------------------+------------+----------------------+--------+
   | rc1a-dataproc-d-q8659net********.mdb.yandexcloud.net | fhmr7sd33fl8******** | DATANODE   | c9qaps7qjj2d******** | ALIVE  |
   | rc1a-dataproc-m-hhhifdgl********.mdb.yandexcloud.net | fhmg686pspri******** | MASTERNODE | c9q7aen26lid******** | ALIVE  |
   +------------------------------------------------------+----------------------+------------+----------------------+--------+
   ```

   From the `COMPUTE INSTANCE ID` column, save the VM ID that matches your host.

1. Connect to the host:

    ```bash
    yc compute ssh --id <VM_ID>
    ```