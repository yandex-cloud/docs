# Creating a cluster of 1C:Enterprise Linux servers with a {{ mpg-name }} cluster


In {{ yandex-cloud }}, you can create a {{ mpg-full-name }} cluster optimized for 1C:Enterprise.

Your new 1C:Enterprise infrastructure will consist of a 1C working server, a 1C license server, and a [{{ mpg-short-name }} cluster](../../managed-postgresql/concepts/index.md). 1C servers will be running [CentOS 7](/marketplace/products/yc/centos-7) with no internet access. The cluster will be accessed via an encrypted [OpenVPN server connection](../../tutorials/routing/openvpn.md).

To configure a 1C cluster and make sure the created infrastructure works properly, your local computer running Windows (outside {{ yandex-cloud }}) must have the 1C: Enterprise client and the 1C administration console installed.

The process of creating the 1C:Enterprise infrastructure described in this guide was tested in 1C version `8.3.25`.

{% note info %}

To use 1C:Enterprise, you need a license. For more information about licenses, their installation, as well as the distributions you may need, see the [1C:Enterprise website](https://its.1c.ru/).

{% endnote %}

To configure a 1C:Enterprise server cluster:

1. [Get your cloud ready](#before-you-begin).
1. [Set up a VPN to access the cloud infrastructure](#setup-vpn).
1. [Create virtual machines for 1C:Enterprise servers](#create-1c-vms).
1. [Create a {{ mpg-name }} cluster](#create-pg-cluster).
1. [Configure a Samba server on 1C servers](#set-up-samba).
1. [Configure 1C:Enterprise servers](#setup-1c-server).
1. [Configure a 1C server cluster and infobase](#setup-cluster).
1. [Connect to the infobase](#connect-to-infobase).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost for 1C-Enterprise in {{ yandex-cloud }} includes:
* Fee for [disks](../../compute/concepts/disk.md) and continuously running [VMs](../../compute/concepts/vm.md) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for a continuously running {{ mpg-name }} cluster (see [{{ mpg-name }} pricing](../../managed-postgresql/pricing.md)).
* Fee for using a static [public IP address](../../vpc/concepts/address.md) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

## Set up a VPN to access the cloud infrastructure {#setup-vpn}

To ensure secure access to the 1C:Enterprise infrastructure you are creating in {{ yandex-cloud }}, set up a VPN. To address this task, use [OpenVPN Access Server](/marketplace/products/yc/openvpn-access-server) and its Windows client.

### Create a cloud network and subnets {#setup-network}

To create a [cloud network](../../vpc/concepts/network.md) with [subnets](../../vpc/concepts/network.md#subnet) in three [availability zones](../../overview/concepts/geo-scope.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder where you need to create a cloud network.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the top-right corner, click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, enter `my-1c-network`.
  1. Enable **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.

{% endlist %}

### Configure network traffic permissions {#network-settings}

[Security groups](../../vpc/concepts/security-groups.md) act as a virtual firewall for incoming and outgoing traffic. Learn more about the default security group [here](../../vpc/concepts/security-groups.md#default-security-group).
  
To ensure proper operation of OpenVPN Access Server and the {{ mpg-short-name }} cluster, [add](../../vpc/operations/security-group-add-rule.md) additional rules to the default security group of the `my-1c-network` cloud network:

Traffic<br>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
--- | --- | --- | --- | --- | ---
Inbound | `VPN Server 443` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Inbound | `VPN Server 1194` | `1194` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Inbound | `Admin Web UI,`</br>`Client Web UI` | `943` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Inbound | `{{ mpg-short-name }}` | `6432` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`

### Start the VPN server {#create-vpn-server}

Create a VM to serve as a gateway for VPN connections:

{% list tabs group=instructions %}

- Management console {#console}

  1. [Reserve](../../vpc/operations/get-static-ip.md) a public IP address for your VPN server.
  1. On the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) dashboard of the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, enter `OpenVPN Access Server` in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field and select a public [OpenVPN Access Server](/marketplace/products/yc/openvpn-access-server) image.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md), e.g., `{{ region-id }}-b`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, select the `{{ ui-key.yacloud.compute.value_disk-type-network-hdd_cw9XD }}` [disk type](../../compute/concepts/disk.md#disks_types) and specify the size: `20 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and amount of RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select `my-1c-network` and the subnet mapped to the selected VM availability zone.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_list }}` and the previously reserved public IP address from the list.

          When configuring a VPN server, use only a static public IP address. Dynamic IP addresses may change after the VM reboots and the connections will no longer work.

      * Leave the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field blank. The [default security group](../../vpc/concepts/security-groups.md#default-security-group) will be assigned to the new VM.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a username, e.g., `yc-user`. Do not use `root` or other reserved usernames. To perform operations requiring superuser privileges, use the `sudo` command.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `vpn-server`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
  1. This will open a window with the licensing model: BYOL (Bring Your Own License). Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Get the administrator password {#get-admin-password}

{% include [openvpn-get-admin-password](../_tutorials_includes/openvpn-get-admin-password.md) %}

### Activate your license {#get-license}

{% include [openvpn-activate-license](../_tutorials_includes/openvpn-activate-license.md) %}

### Create an OpenVPN user {#configure-openvpn}

{% include [openvpn-create-user](../_tutorials_includes/openvpn-create-user.md) %}

### Connect to the VPN {#test-vpn}

In the admin panel, you can download the [OpenVPN Connect](https://openvpn.net/vpn-client/) client for Windows, Linux, MacOS, Android, and iOS.

As this guide covers configuring the 1C:Enterprise client in the Windows environment, download and install the OpenVPN client for Windows on your local computer:

1. Download the installation distribution:

    * In your browser, open the user panel at `https://<VM_public_IP_address>/`.
    * Sign in using the `test-user` username and password.
    * Download OpenVPN Connect version 2 or 3 by clicking the Windows icon.
1. Install and run OpenVPN Connect.
1. A VPN connection will turn on automatically if auto-login is enabled in the user profile.

You can import a new configuration profile into the application by specifying `https://<VM_public_IP_address>/` or selecting a profile file.

## Create virtual machines for 1C:Enterprise servers {#create-1c-vms}

The 1C:Enterprise license must be installed on a separate server for changes to the configurations of other 1C servers to have no effect on the installed license. At this stage, you will create two virtual machines: one will serve as the 1C:Enterprise server and the other, as the licensing server.

Create a VM for the 1C:Enterprise server: 

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) dashboard of the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, enter `CentOS 7` and select a public [CentOS 7](/marketplace/products/yc/centos-7) image.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the [availability zone](../../overview/concepts/geo-scope.md) hosting the VNP server you created earlier.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the required [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and the amount of RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `4`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select `my-1c-network` and the subnet mapped to the selected VM availability zone.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, leave the `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` value to assign a random external IP address from the {{ yandex-cloud }} pool.

          The virtual machine will need a public IP address for software configuration. Once the software has been configured, unlink the public IP address from the VM. The OpenVPN server will then be used to access the VM.
      * Leave the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field blank. The [default security group](../../vpc/concepts/security-groups.md#default-security-group) will be assigned to the new VM.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a username, e.g., `yc-user`. Do not use `root` or other reserved usernames. For operations requiring root privileges, use the `sudo` command.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `server-1c`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

Similarly, create a VM named `licensing-server-1c` for the licensing server using the same parameters.

## Create a {{ mpg-name }} cluster {#create-pg-cluster}

{{ yandex-cloud }} allows you to create {{ mpg-name }} clusters optimized for 1C:Enterprise. Cluster settings may vary depending on your project requirements.

To create a {{ mpg-name }} cluster optimized for 1C:

{% list tabs group=instructions %}

- Management console {#console}

  1. On the folder page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_managed-postgresql }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

      * In the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field, enter the cluster name: `1c-pg`.
      * From the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** list, select `15-1c`.

  1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**, select `s3-c2-m8`. This configuration will be enough to health check the solution. If you expect a heavy workload on your new 1C:Enterprise database, select a higher performance class host.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**, select `network-ssd` and set the size to `114 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**, specify:

      * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `1c-database`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `user1`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: Password you will use to access the DB.
      * **{{ ui-key.yacloud.mdb.forms.database_field_lc-collate }}**: `ru_RU.UTF-8`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_lc-ctype }}**: `ru_RU.UTF-8`.

  1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select `my-1c-network`.

      Leave the **{{ ui-key.yacloud.mdb.forms.field_security-group }}** field blank. The [default security group](../../vpc/concepts/security-groups.md#default-security-group) will be assigned to the new cluster.

  1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, select different availability zones for your hosts to ensure their fault tolerance.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

{% endlist %}

Creating a DB cluster may take a few minutes.

## Configure a Samba server on 1C servers {#set-up-samba}

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the `server-1c` VM over SSH.

1. Install Samba, the required dependencies, and the `nano` text editor:

    ```bash
    sudo yum install nano samba samba-client samba-common
    ```

1. Disable IPv6 to avoid server conflicts.

    * Open the `/etc/sysctl.conf` file:

        ```bash
        sudo nano /etc/sysctl.conf
        ```

        Add the following lines to the `/etc/sysctl.conf` file:

        ```text
        net.ipv6.conf.all.disable_ipv6 = 1
        net.ipv6.conf.default.disable_ipv6 = 1
        ```

    * Open the `/etc/sysconfig/network` file:

        ```bash
        sudo nano /etc/sysconfig/network
        ```

        Add the following lines to the `/etc/sysconfig/network` file:

        ```text
        NETWORKING_IPv6=no
        HOSTNAME=server-1c
        ```

1. Set up Samba. To do this, open the `/etc/samba/smb.conf` configuration file:

    ```bash
    sudo nano /etc/samba/smb.conf
    ```

    Edit the file as follows:

    ```text
    [global]
            workgroup = WORKGROUP
            server string = Samba Server%v
            netbios name = centos
            security = user
            map to guest = bad user
            dns proxy = no
            passdb backend = tdbsam
            printing = cups
            printcap name = cups
            load printers = yes
            cups iptions = raw
            security = user

    [files]
            path = /1c-files
            browsable = yes
            writable = yes
            guest ok = yes
            read only = no
    ```

1. Create a shared folder and grant the required access permissions for it:

    ```bash
    sudo mkdir /1c-files
    sudo chmod -R 777 /1c-files
    ```

1. Disable SELinux. To do this, open the `/etc/sysconfig/selinux` configuration file:

    ```bash
    sudo nano /etc/sysconfig/selinux
    ```

    Change the value of the `SELINUX` parameter:

    ```text
    SELINUX=disabled
    ```

1. Add the Samba server service to the startup script:

    ```bash
    sudo systemctl enable smb.service
    ```

    Result:

    ```text
    Created symlink from /etc/systemd/system/multi-user.target.wants/smb.service to /usr/lib/systemd/system/smb.service.
    ```

1. Restart the Samba server service:

    ```bash
    sudo systemctl restart smb.service
    ```

Similarly, configure the Samba server on the `licensing-server-1c` VM.

## Configure 1C:Enterprise servers {#setup-1c-server}

1. Copy the 1C:Enterprise server distribution from your local computer to the `server-1c` VM:

    ```bash
    scp <file_name> <username>@<VM_public_IP_address>:/1c-file.
    ```

    Where:
    * `<file_name>`: Name of the binary distribution file, e.g., `setup-full-8.3.25.1257-x86_64.run`.
    * `<username>`: VM username, e.g., `yc-user`.
    * `<VM_public_IP_address>`: Public IP address of the VM with the 1C server.

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the `server-1c` VM over SSH.

1. Install the 1C:Enterprise server on the VM:

    ```bash
    cd /1c-files
    sudo ./<file_name> --mode unattended --enable-components server,ws,server_admin
    ```

    Where `<file_name>` is the name of the binary distribution file, e.g., `setup-full-8.3.25.1257-x86_64.run`.

1. After installation is complete, delete the distribution file by specifying the name of the binary distribution file:

    ```bash
    rm <file_name>
    ```

1. Start the 1C server service and add it to the startup script:

    ```bash
    sudo ln /opt/1cv8/x86_64/8.3.25.1257/srv1cv8-8.3.25.1257@.service /etc/systemd/system
    sudo systemctl start srv1cv8-8.3.25.1257@.services.service
    sudo systemctl enable srv1cv8-8.3.25.1257@.services.service
    ```

    Result:

    ```text
    Created symlink from /etc/systemd/system/multi-user.target.wants/srv1cv8-8.3.25.1257@.services.service to /etc/systemd/system/srv1cv8-8.3.25.1257@.service.
    ```

    The path to the 1C:Enterprise server installation files depends on the 1C platform version installed. The example shows commands to start the 1C:Enterprise `8.3.25` server service.

1. Make sure the 1C:Enterprise server service is running:

    ```bash
    systemctl status -l srv1cv8-8.3.25.1257@.services
    ```

    Result:

    ```bash
    ● srv1cv8-8.3.25.1257@.services.service - 1C:Enterprise Server 8.3 (8.3.25.1257) (.services)
       Loaded: loaded (/etc/systemd/system/srv1cv8-8.3.25.1257@.service; disabled; vendor preset: disabled)
       Active: active (running) since Thu 2024-07-18 09:09:12 UTC; 6min ago
     Main PID: 16656 (ragent)
       CGroup: /system.slice/system-srv1cv8\x2d8.3.25.1257.slice/srv1cv8-8.3.25.1257@.services.service
               ├─16656 /opt/1cv8/x86_64/8.3.25.1257/ragent -d /home/usr1cv8/.1cv8/1C/1cv8 -port 1540 -regport 1541 -range 1560:1591 -seclev 0 -pingPeriod 1000 -pingTimeout 5000
               ├─16670 /opt/1cv8/x86_64/8.3.25.1257/rmngr -port 1541 -host server-1c.ru-central1.internal -range 1560:1591 -d /home/usr1cv8/.1cv8/1C/1cv8/ -clstid 29361c8c-d4b8-47fd-8b53-43d8349f0e94
               └─16769 /opt/1cv8/x86_64/8.3.25.1257/rphost -range 1560:1591 -reghost server-1c.ru-central1.internal -regport 1541 -pid 43049953-184b-453f-985c-604fb96300ae
    ```

Similarly, configure the 1C server on the `licensing-server-1c` VM.

When you are done configuring both 1C servers, [detach the public IP addresses](../../compute/operations/vm-control/vm-detach-public-ip.md) from the `server-1c` and `licensing-server-1c` VMs. For further access to the 1C servers, use the OpenVPN server.

## Configure a 1C server cluster and infobase {#setup-cluster}

Before getting started with 1C:Enterprise, configure the server roles and add the infobase to the cluster:

1. Start the 1C administration console on your local Windows computer with the OpenVPN client running.
1. Add the central 1C:Enterprise server to the cluster:
    1. Right-click **Central 1C:Enterprise 8.3 servers** and select **Create** → **Central 1C:Enterprise 8.3 server** from the context menu that opens. In the window that opens:
        1. In the **Name** field, enter the server's internal FQDN: `server-1c.{{ region-id }}.internal`.

            You can look up the VM's internal FQDN in the [management console]({{ link-console-main }}) by checking the **{{ ui-key.yacloud.compute.instance.overview.label_host }}** field on the VM page.

        1. Click **OK**.

        You will see the local cluster in the tree on the left. 

1. Add the 1C licensing server to the server cluster:
    1. Expand the **Clusters** tab and select **Local cluster**.
    1. Right-click **Working servers** and select **Create** → **Working server** from the context menu that opens.
    1. In the **Computer** field of the window that opens, specify `licensing-server-1c.{{ region-id }}.internal` and click **OK**.

    This server will be used to distribute licenses to other 1C servers.

1. Add functionality assignment requirements to `licensing-server-1c`:
    1. Expand the tab of the `licensing-server-1c.{{ region-id }}.internal` server you added, right-click **Functionality assignment requirements**, and select **Create** → **Functionality assignment requirement** from the context menu that opens. In the window that opens:
        * In the **Requirement object** list, select `Any requirement object`.
        * In the **Requirement type** list, select `Do not assign`.
        * Leave all other parameters as they are and click **OK**.

    1. Open the **Local cluster** context menu and select **Apply functionality assignment requirements (full)** to apply the new requirement to the cluster.
    1. Add another requirement for assigning functionality to the `licensing-server-1c.{{ region-id }}.internal` server with the following parameters:
        * In the **Requirement object** list, select `Licensing service`.
        * In the **Requirement type** list, select `Assign`.
        * Leave all other parameters as they are and click **OK**.

    1. Open the **Local cluster** context menu and select **Apply functionality assignment requirements (full)** to apply the new requirement to the cluster.

1. Add functionality assignment requirements to `server-1c`:
    1. Expand the `server-1c.{{ region-id }}.internal` server tab, right-click **Functionality assignment requirements**, and select **Create** → **Functionality assignment requirement** from the context menu that opens. In the window that opens:
        * In the **Requirement object** list, select `Client connection to infobase`.
        * In the **Requirement type** list, select `Assign`.
        * Leave all other parameters as they are and click **OK**.

    1. Open the **Local cluster** context menu and select **Apply functionality assignment requirements (full)** to apply the new requirement to the cluster.
    1. Add another requirement for assigning functionality to the `server-1c.{{ region-id }}.internal` server with the following parameters:
        * In the **Requirement object** list, select `Licensing service`.
        * In the **Requirement type** list, select `Do not assign`.
        * Leave all other parameters as they are and click **OK**.

    1. Open the **Local cluster** context menu and select **Apply functionality assignment requirements (full)** to apply the new requirement to the cluster.

1. Right-click **Infobases** inside the **Local cluster** section and select **Create** → **Infobase** from the context menu that opens. In the window that opens, specify the following:
    * **Name**: `1c-database`.
    * **Secure connection**: `Continuously`.
    * **Database server**: Your DB host address and port, e.g., `rc1b-cfazv1db********.{{ dns-zone }} port=6432`.

        To find out the host address:

        {% list tabs group=instructions %}

        - Management console {#console}

          * In the [management console]({{ link-console-main }}), go to the folder page.
          * In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
          * In the window that opens, select the `1c-pg` cluster you created earlier.
          * Select the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab in the left-hand menu.
          * In the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** field, hover over the host name (format: `rc1b-cfazv1db********`) and copy the database FQDN by clicking ![copy](../../_assets/copy.svg). The FQDN will be added to the host name, so the **Database server** field should contain a name in `rc1c-cfazv1db********.{{ dns-zone }} port=6432` format.

        {% endlist %}

    * **DBMS type**: `{{ PG }}`.
    * **Database**: Database name, `1c-database`.
    * **Database server user**: `user1`.
    * **Database user password**: User password you set when creating the cluster.
    * **Allow license issuing by 1C:Enterprise server**: `Yes`.
    * **Language (Country)**: `English (United States)`.
    * **Create database if none present**: Disabled.
    * **Lock execution of scheduled jobs**: Disabled.

   Click **OK**.

## Connect to the infobase {#connect-to-infobase}

1. Start the 1C: Enterprise client on your local Windows computer with the OpenVPN client running.
1. Click **Add**.
1. Select **Add an existing infobase to the list** and click **Next**.
1. Enter the infobase name, select **On 1C:Enterprise server**, and specify the following settings:
    * **Server cluster**: `server-1c.{{ region-id }}.internal`.
    * **Infobase name**: `1c-database`.

1. Click **Next**.
1. Click **Ready**.

The infobase should appear on the list of infobases. You can now proceed to configuring and using it.

## Delete the resources you created {#clear-out}

To stop paying for the deployed infrastructure:
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the `server-1c`, `licensing-server-1c`, and `vpn-server` VMs.
1. [Delete](../../managed-postgresql/operations/cluster-delete.md) the `1c-pg` cluster.
1. [Delete](../../vpc/operations/address-delete.md) the public static IP address.