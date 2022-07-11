# Deploying an Always On availability group

This scenario describes how to deploy an Always On availability group in {{ yandex-cloud }}. If one or more nodes in the group fail, the system will continue to run through replication and failover of the write database, thus ensuring high availability of the DBMS.

To create and configure an Always On availability group:

1. [Before you start](#before-begin).
{% if product == "yandex-cloud" %}1. [Required paid resources](#paid-resources).{% endif %}
1. [Create a network infrastructure](#prepare-network).
1. [Prepare VMs for the availability group](#create-vms).
1. [Create a file with administrator credentials](#prepare-admin-credentials).
1. [Create VMs](#create-group-vms).
1. [Create a VM for a bastion host](#create-jump-server).
1. [Create a VM for Active Directory](#create-ad-controller).
1. [Create a VM for MSSQL servers](#create-ad-server).
1. [Install and configure Active Directory](#install-ad).
1. [Create users and groups in Active Directory](#install-ad).
1. [Install and configure MSSQL](#install-mssql).
1. [Install MSSQL on database servers](#mssql-nodes).
1. [Configure Always On](#configure-always-on).
1. [Test the availability group](#test).
1. [Add a bastion host to the domain](#jump-server-domain).
1. [Test the database](#test-always-on).

If you no longer need the created resources, [delete them](#clear-out).

## Before you start {#before-begin}

{% include [before-you-begin](./_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The cost of supporting the availability group includes:

* A fee for continuously running VMs (see [pricing{{ compute-full-name }}](../compute/pricing.md)).
* A fee for using dynamic or static public IP addresses (see [pricing{{ vpc-full-name }}](../vpc/pricing.md)).

You can use [license mobility](../compute/qa/licensing) and use your own MSSQL Server license in {{ yandex-cloud }}.

{% endif %}

## Create a network infrastructure {#prepare-network}

All replicas in the group will have multiple IP addresses that will be routed to using [static routes](../vpc/concepts/static-routes.md). Prepare the network infrastructure to host the availability group.

1. Create a network named `ya-network`:

    {% list tabs %}

    - Management console
       1. Open the **Virtual Private Cloud** section in the folder where you want to create the cloud network.
       1. Click **Create network**.
       1. Enter the network name: `ya-network`.
       1. Click **Create network**.

    - Bash

      [Install](../cli/operations/install-cli.md) the {{ yandex-cloud }} command line interface to use CLI commands in Bash.

      ```
      $ yc vpc network create --name ya-network
      ```

    - PowerShell

      [Install](../cli/operations/install-cli.md) the {{ yandex-cloud }} command line interface to use CLI commands in PowerShell.

      ```
      yc vpc network create --name ya-network
      ```

    {% endlist %}

2. Create an `mssql` route table in the new network and add static routes to it:

    {% list tabs %}

    - Management console
       1. Open the **Virtual Private Cloud** section in the folder where you want to create a static route.
       1. Select the `ya-network` network.
       1. Click ![image](../_assets/plus.svg)**Create route table**.
       1. Enter the route table name: `mssql`.
       1. Click **Add route**.
       1. In the window that opens enter the destination subnet prefix in CIDR notation: `10.0.0.20/32`.
       1. Set the **next hop**: `10.0.0.19`.
       1. Click **Add**.
       1. Add five more routes:
          * `10.0.0.21/32`, next hop `10.0.0.19`.
          * `10.0.0.36/32`, next hop `10.0.0.35`.
          * `10.0.0.37/32`, next hop `10.0.0.35`.
          * `10.0.0.52/32`, next hop `10.0.0.51`.
          * `10.0.0.53/32`, next hop `10.0.0.51`.
       1. Click **Create route table**.

    - Bash

       ```
       $ yc vpc route-table create \
          --name mssql \
          --route destination=10.0.0.20/32,next-hop=10.0.0.19 \
          --route destination=10.0.0.21/32,next-hop=10.0.0.19 \
          --route destination=10.0.0.36/32,next-hop=10.0.0.35 \
          --route destination=10.0.0.37/32,next-hop=10.0.0.35 \
          --route destination=10.0.0.52/32,next-hop=10.0.0.51 \
          --route destination=10.0.0.53/32,next-hop=10.0.0.51 \
          --network-name ya-network
       ```

    - PowerShell

       ```
       yc vpc route-table create `
        --name mssql `
        --route destination=10.0.0.20/32,next-hop=10.0.0.19 `
        --route destination=10.0.0.21/32,next-hop=10.0.0.19 `
        --route destination=10.0.0.36/32,next-hop=10.0.0.35 `
        --route destination=10.0.0.37/32,next-hop=10.0.0.35 `
        --route destination=10.0.0.52/32,next-hop=10.0.0.51 `
        --route destination=10.0.0.53/32,next-hop=10.0.0.51 `
        --network-name ya-network
       ```

    {% endlist %}

3. Create subnets that will host your VMs:

  * A subnet named `ya-subnet-general` for the bastion host and VM with Active Directory.

  * Three subnets for hosting the Always On availability group VMs: `ya-subnet-alwayson1`, `ya-subnet-alwayson2`, and `ya-subnet-alwayson3`. The `mssql` route table will be linked to each of the subnets.

    {% list tabs %}

    - Management console
      1. Open the **Virtual Private Cloud** section in the folder to create the subnets in.
      1. Select the `ya-network` network.
      1. Click **Add subnet**.
      1. Fill out the form: enter the `ya-subnet-general` subnet name and select the `{{ region-id }}-a` availability zone from the drop-down list.
      1. Enter the subnet CIDR: IP address and subnet mask: `10.0.0.0/28`.
      1. Click **Create subnet**.

      Repeat the steps for subnets with the following names and CIDR:
      * `ya-subnet-alwayson1`: `10.0.0.16/28`.
      * `ya-subnet-alwayson2`: `10.0.0.32/28`.
      * `ya-subnet-alwayson3`: `10.0.0.48/28`.

      To use static routes, link the route table to a subnet:
      1. In the line with the desired subnet, click ![image](../_assets/options.svg).
      1. In the menu that opens, select **Link route table**.
      1. In the window that opens, select the created table from the list.
      1. Click **Add**.

    - Bash

      ```
      $ yc vpc subnet create \
         --name ya-subnet-general \
         --network-name ya-network \
         --zone {{ region-id }}-a \
         --route-table-name mssql \
         --range 10.0.0.0/28
      ```

      ```
      $ yc vpc subnet create \
         --name ya-subnet-alwayson1 \
         --network-name ya-network \
         --zone {{ region-id }}-a \
         --route-table-name mssql \
         --range 10.0.0.16/28
      ```

      ```
      $ yc vpc subnet create \
         --name ya-subnet-alwayson2 \
         --network-name ya-network \
         --zone {{ region-id }}-a \
         --route-table-name mssql \
         --range 10.0.0.32/28
      ```

      ```
      $ yc vpc subnet create \
         --name ya-subnet-alwayson3 \
         --network-name ya-network \
         --zone {{ region-id }}-a \
         --route-table-name mssql \
         --range 10.0.0.48/28
      ```

    - PowerShell

      ```
      yc vpc subnet create `
       --name ya-subnet-general `
       --network-name ya-network `
       --zone {{ region-id }}-a `
       --route-table-name mssql `
       --range 10.0.0.0/28
      ```

      ```
      yc vpc subnet create `
       --name ya-subnet-alwayson1 `
       --network-name ya-network `
       --zone {{ region-id }}-a `
       --route-table-name mssql `
       --range 10.0.0.16/28
      ```

      ```
      yc vpc subnet create `
       --name ya-subnet-alwayson2 `
       --network-name ya-network `
       --zone {{ region-id }}-a `
       --route-table-name mssql `
       --range 10.0.0.32/28
      ```

      ```
      yc vpc subnet create `
       --name ya-subnet-alwayson3 `
       --network-name ya-network `
       --zone {{ region-id }}-a `
       --route-table-name mssql `
       --range 10.0.0.48/28
      ```

    {% endlist %}

## Create VMs for the availability group {#create-vms}

### Create a file with administrator credentials {#prepare-admin-credentials}

Create a file named `setpass` with a script to set the administrator's local account password. This script will be executed when creating VMs via the CLI.

{% list tabs %}

- PowerShell

    ```
    #ps1
    Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "QWErty123" -AsPlainText -Force)
    ```

{% endlist %}

{% note warning %}

The set password is only used for testing. Use your own complex password when deploying a cluster to work in a product environment.

The password must meet the [complexity requirements]({{ ms.docs }}/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements#справочные-материалы).

Read more about the best practices for securing Active Directory on the [official website]({{ ms.docs }}/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory).

{% endnote %}

### Create VMs {#create-group-vms}

#### Create a VM for a bastion host {#create-jump-server}

Create a bastion host with a public IP address. This host will provide access to all other VMs:

{% list tabs %}

- Bash

    ```
    $ yc compute instance create \
        --name jump-server-vm \
        --hostname jump-server-vm \
        --memory 4 \
        --cores 2 \
        --zone {{ region-id }}-a \
        --network-interface subnet-name=ya-subnet-general,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-family=windows-2019-gvlk \
        --metadata-from-file user-data=setpass
    ```

- PowerShell

    ```
    yc compute instance create `
      --name jump-server-vm `
      --hostname jump-server-vm `
      --memory 4 `
      --cores 2 `
      --zone {{ region-id }}-a `
      --network-interface subnet-name=ya-subnet-general,nat-ip-version=ipv4 `
      --create-boot-disk image-folder-id=standard-images,image-family=windows-2019-gvlk `
      --metadata-from-file user-data=setpass `
    ```

{% endlist %}

#### Create a VM for Active Directory {#create-ad-controller}

Create a VM to install Active Directory:

{% list tabs %}

- Bash

    ```
    $ yc compute instance create \
       --name ya-ad \
       --hostname ya-ad \
       --zone {{ region-id }}-a \
       --memory 6 \
       --cores 2 \
       --metadata-from-file user-data=setpass \
       --create-boot-disk \
         type=network-nvme,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images \
       --network-interface \
         subnet-name=ya-subnet-general,ipv4-address=10.0.0.3
    ```

- PowerShell

    ```
    yc compute instance create `
     --name ya-ad `
     --hostname ya-ad `
     --zone {{ region-id }}-a `
     --memory 6 `
     --cores 2 `
     --metadata-from-file user-data=setpass `
     --create-boot-disk `
       type=network-nvme,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images `
     --network-interface `
       subnet-name=ya-subnet-general,ipv4-address=10.0.0.3
    ```

{% endlist %}

#### Create a VM for MSSQL servers {#create-ad-server}

Create three VMs for MSSQL servers:

{% list tabs %}

- Bash

    ```
    $ yc compute instance create \
       --name ya-mssql1 \
       --hostname ya-mssql1 \
       --zone {{ region-id }}-a \
       --memory 16 \
       --cores 4 \
       --metadata-from-file user-data=setpass \
       --create-boot-disk \
         type=network-nvme,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images \
       --create-disk \
         type=network-nvme,size=200 \
       --network-interface \
         subnet-name=ya-subnet-alwayson1,ipv4-address=10.0.0.19
    ```

    ```
    $ yc compute instance create \
       --name ya-mssql2 \
       --hostname ya-mssql2 \
       --zone {{ region-id }}-a \
       --memory 16 \
       --cores 4 \
       --metadata-from-file user-data=setpass \
       --create-boot-disk \
         type=network-nvme,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images \
       --create-disk \
         type=network-nvme,size=200 \
       --network-interface \
         subnet-name=ya-subnet-alwayson2,ipv4-address=10.0.0.35
    ```

    ```
    $ yc compute instance create \
       --name ya-mssql3 \
       --hostname ya-mssql3 \
       --zone {{ region-id }}-a \
       --memory 16 \
       --cores 4 \
       --metadata-from-file user-data=setpass \
       --create-boot-disk \
         type=network-nvme,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images \
       --create-disk \
         type=network-nvme,size=200 \
       --network-interface \
         subnet-name=ya-subnet-alwayson3,ipv4-address=10.0.0.51
    ```

- PowerShell

    ```
    yc compute instance create `
     --name ya-mssql1 `
     --hostname ya-mssql1 `
     --zone {{ region-id }}-a `
     --memory 16 `
     --cores 4 `
     --metadata-from-file user-data=setpass `
     --create-boot-disk `
       type=network-nvme,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images `
     --create-disk `
       type=network-nvme,size=200 `
     --network-interface `
       subnet-name=ya-subnet-alwayson1,ipv4-address=10.0.0.19
    ```

    ```
    yc compute instance create `
       --name ya-mssql2 `
       --hostname ya-mssql2 `
       --zone {{ region-id }}-a `
       --memory 16 `
       --cores 4 `
       --metadata-from-file user-data=setpass `
       --create-boot-disk `
         type=network-nvme,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images `
       --create-disk `
         type=network-nvme,size=200 `
       --network-interface `
         subnet-name=ya-subnet-alwayson2,ipv4-address=10.0.0.35
    ```

    ```
    yc compute instance create `
     --name ya-mssql3 `
     --hostname ya-mssql3 `
     --zone {{ region-id }}-a `
     --memory 16 `
     --cores 4 `
     --metadata-from-file user-data=setpass `
     --create-boot-disk `
       type=network-nvme,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images `
     --create-disk `
       type=network-nvme,size=200 `
     --network-interface `
       subnet-name=ya-subnet-alwayson3,ipv4-address=10.0.0.51
    ```

{% endlist %}

### Install and configure Active Directory {#install-ad}

1. Connect to `jump-server-vm` [using RDP](../compute/operations/vm-connect/rdp.md). Enter `Administrator` as the username and then your password.

1. Start the RDP client and connect to the `ya-ad` VM.

1. Set the required server roles. Start PowerShell and run the following command:

   {% list tabs %}

   - PowerShell

       ```
       Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
       ```

   {% endlist %}

1. Create an Active Directory forest:

    {% list tabs %}

    - PowerShell

       ```
       Install-ADDSForest -DomainName 'yantoso.net' -Force:$true -SafeModeAdministratorPassword ('QWErty123' | ConvertTo-SecureString -AsPlainText -Force)
       ```

    {% endlist %}

   After that, the VM restarts.

1. Reconnect to `ya-ad`.

1. Rename the website and add the created subnets to it:

    {% list tabs %}

    - PowerShell

       ```
       Get-ADReplicationSite 'Default-First-Site-Name' | Rename-ADObject -NewName '{{ region-id }}-a'
       New-ADReplicationSubnet -Name '10.0.0.0/28'  -Site '{{ region-id }}-a'
       New-ADReplicationSubnet -Name '10.0.0.16/28' -Site '{{ region-id }}-a'
       New-ADReplicationSubnet -Name '10.0.0.32/28' -Site '{{ region-id }}-a'
       New-ADReplicationSubnet -Name '10.0.0.48/28' -Site '{{ region-id }}-a'
       ```

    {% endlist %}

1. Specify the Forwarder for the DNS server:

    {% list tabs %}

    - PowerShell

       ```
       Set-DnsServerForwarder '10.0.0.2'
       ```

    {% endlist %}

1. Specify the DNS server addresses:

    {% list tabs %}

    - PowerShell

       ```
       Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.0.0.3,127.0.0.1"
       ```

    {% endlist %}

### Create users and groups in Active Directory {#install-ad}

1. Create a service account named `mssql-svc`:

    {% list tabs %}

    - PowerShell

       ```
       New-ADUser `
         -Name mssql-svc `
         -AccountPassword ('QWErty123' | ConvertTo-SecureString -AsPlainText -Force) `
         -CannotChangePassword $true `
         -PasswordNeverExpires $true `
         -Enabled $true
       ```

    {% endlist %}

1. Create groups to access backups and DB servers:

    {% list tabs %}

    - PowerShell

       ```
       New-AdGroup mssql-admins-grp -GroupScope:Global
       New-AdGroup mssql-backups-grp -GroupScope:Global
       ```

    {% endlist %}

1. Add the `Administrator` account to all groups. Add the `mssql-svc` service account to the `mssql-backups-grp` group:

    {% list tabs %}

    - PowerShell

       ```
       Add-ADGroupMember mssql-admins-grp -Members Administrator
       Add-ADGroupMember mssql-backups-grp -Members Administrator
       Add-ADGroupMember mssql-backups-grp -Members mssql-svc
       ```

    {% endlist %}

1. Set the [SPN](https://docs.microsoft.com/en-us/windows/win32/ad/service-principal-names) of the service account:

    {% list tabs %}

    - PowerShell

       ```
       setspn -A MSSQLSvc/ya-mssql1.yantoso.net:1433 yantoso\mssql-svc
       setspn -A MSSQLSvc/ya-mssql1.yantoso.net yantoso\mssql-svc
       
       setspn -A MSSQLSvc/ya-mssql2.yantoso.net:1433 yantoso\mssql-svc
       setspn -A MSSQLSvc/ya-mssql2.yantoso.net yantoso\mssql-svc
       
       setspn -A MSSQLSvc/ya-mssql3.yantoso.net:1433 yantoso\mssql-svc
       setspn -A MSSQLSvc/ya-mssql3.yantoso.net yantoso\mssql-svc
       ```

    {% endlist %}

### Install and configure MSSQL {#install-mssql}

#### Install MSSQL on database servers {#mssql-nodes}

1. Grant internet access to the DB server VM:

    {% list tabs %}

    - Bash

       ```
       $ yc compute instance add-one-to-one-nat ya-mssql1 --network-interface-index 0
       $ yc compute instance add-one-to-one-nat ya-mssql2 --network-interface-index 0
       $ yc compute instance add-one-to-one-nat ya-mssql3 --network-interface-index 0
       ```

    - PowerShell

       ```
       yc compute instance add-one-to-one-nat ya-mssql1 --network-interface-index 0
       yc compute instance add-one-to-one-nat ya-mssql2 --network-interface-index 0
       yc compute instance add-one-to-one-nat ya-mssql3 --network-interface-index 0
       ```

    {% endlist %}

1. Run the RDP client and connect to the `ya-mssql1` VM using the `Administrator` account and your password. Use the public IP address of the VM to connect.

1. Start PowerShell and set the role:

    {% list tabs %}

    - PowerShell

       ```
       Install-WindowsFeature Failover-Clustering -IncludeManagementTools
       ```

    {% endlist %}

1. Restart the VM and PowerShell.

1. Initialize and format the second logical disk:

    {% list tabs %}

    - PowerShell

       ```
       Get-Disk | `
       Where-Object PartitionStyle -Eq "RAW" | `
         Initialize-Disk -PassThru -PartitionStyle:GPT | `
           New-Partition -DriveLetter 'X' -UseMaximumSize | `
             Format-Volume `
               -FileSystem:NTFS `
               -AllocationUnitSize:64KB `
               -Force `
               -ShortFileNameSupport $false `
               -Confirm:$false
       ```

    {% endlist %}

    You'll be asked to confirm that you want to format the disk. Click **Format disk**. Click **Start**. Click **OK**.

1. Create folders for backups and storage for databases, logs, and temporary files:

    {% list tabs %}

    - PowerShell

       ```
       mkdir C:\dist
       mkdir X:\BACKUP
       mkdir X:\TEMPDB
       mkdir X:\TEMPDBLOG
       mkdir X:\DB
       mkdir X:\DBLOG
       ```

    {% endlist %}

1. Download the Microsoft SQL Server distribution from the web to `C:\dist`.

1. Install the SqlServer module:

    {% list tabs %}

    - PowerShell

       ```
       Install-Module -Name SqlServer
       ```

    {% endlist %}

1. Specify the DNS server address:

    {% list tabs %}

    - PowerShell

       ```
       Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.0.0.3"
       ```

    {% endlist %}

   Prepare data to access the domain:

    {% list tabs %}

    - PowerShell

       ```
       $domain_credential = `
         New-Object System.Management.Automation.PSCredential (
           'yantoso\Administrator', `
           ('QWErty123' | ConvertTo-SecureString -AsPlainText -Force))
       ```

    {% endlist %}

   Add the DB server to the domain:

    {% list tabs %}

    - PowerShell

       ```
       Add-Computer -DomainCredential $domain_credential -DomainName 'yantoso.net' -Restart -Force
       ```

    {% endlist %}

   The VM restarts automatically.

1. After it restarts, reconnect to the VM with the `yantoso\Administrator` username and open PowerShell.

1. Give the necessary rights to the service account.

    {% list tabs %}

    - PowerShell

       ```
       & secedit /export /cfg sec_conf_export.ini  /areas user_rights
       
       $secConfig = Get-Content sec_conf_export.ini | Select-Object -SkipLast 3
       $versionSection = Get-Content sec_conf_export.ini | Select-Object -Last 3
       
       $SID = Get-WmiObject `
         -Class Win32_UserAccount `
         -Filter "name='mssql-svc' and domain='yantoso'" | `
           Select-Object -ExpandProperty SID
       
       $isSeManageVolumePrivilegeDefined = $secConfig | `
         Select-String SeManageVolumePrivilege
       
       if ($isSeManageVolumePrivilegeDefined) {
         $secConfig = $secConfig -replace '^SeManageVolumePrivilege .+', "`$0,*$SID"
       } else {
         $secConfig = $secConfig + "SeManageVolumePrivilege = *$SID"
       }
       
       $isSeLockMemoryPrivilegeDefined = $secConfig | `
         Select-String SeLockMemoryPrivilege
       
       if ($isSeLockMemoryPrivilegeDefined) {
         $secConfig = $secConfig -replace '^SeLockMemoryPrivilege .+', "`$0,*$SID"
       } else {
         $secConfig = $secConfig + "SeLockMemoryPrivilege = *$SID"
       }
       
       $secConfig = $secConfig + $versionSection
       $secConfig | Set-Content sec_conf_import.ini
       
       secedit /configure /db secedit.sdb /cfg sec_conf_import.ini /areas user_rights
       
       Remove-Item sec_conf_import.ini
       Remove-Item sec_conf_export.ini
       ```

    {% endlist %}

1. Configure the firewall:

    {% list tabs %}

    - PowerShell

       ```
       New-NetFirewallRule `
        -Group "MSSQL" `
        -DisplayName "MSSQL Server Default" `
        -Name "MSSQLServer-In-TCP" `
        -LocalPort 1433 `
        -Action "Allow" `
        -Protocol "TCP"
       
       New-NetFirewallRule `
        -Group "MSSQL" `
        -DisplayName "MSSQL AAG Default" `
        -Name "MSSQLAAG-In-TCP" `
        -LocalPort 5022 `
        -Action "Allow" `
        -Protocol "TCP" 
       ```

    {% endlist %}

1. Install MSSQL. Mount an image, perform the installation, and dismount the image:

    {% list tabs %}

    - PowerShell

       ```
       Mount-DiskImage -ImagePath C:\dist\<MSSQL Server image name>.iso
       
       & D:\setup.exe /QUIET /INDICATEPROGRESS /IACCEPTSQLSERVERLICENSETERMS `
         /ACTION=INSTALL /FEATURES=SQLENGINE /INSTANCENAME=MSSQLSERVER `
         /SQLSVCACCOUNT="yantoso\mssql-svc" /SQLSVCPASSWORD="QWErty123" `
         /SQLSYSADMINACCOUNTS="yantoso\mssql-admins-grp" /UpdateEnabled=FALSE `
         /SQLBACKUPDIR="X:\BACKUP" /SQLTEMPDBDIR="X:\TEMPDB" /SQLTEMPDBLOGDIR="X:\TEMPDBLOG" `
         /SQLUSERDBDIR="X:\DB" /SQLUSERDBLOGDIR="X:\DBLOG"
       
       Dismount-DiskImage -ImagePath C:\dist\<MSSQL Server image name>.iso
       ```

    {% endlist %}

1. Repeat steps 2-13 for `ya-mssql2` and `ya-mssql3`.

1. Disable internet access for the VM:

    {% list tabs %}

    - Bash

       ```
       $ yc compute instance remove-one-to-one-nat ya-mssql1 --network-interface-index 0
       $ yc compute instance remove-one-to-one-nat ya-mssql2 --network-interface-index 0
       $ yc compute instance remove-one-to-one-nat ya-mssql3 --network-interface-index 0
       ```

    - PowerShell

       ```
       yc compute instance remove-one-to-one-nat ya-mssql1 --network-interface-index 0
       yc compute instance remove-one-to-one-nat ya-mssql2 --network-interface-index 0
       yc compute instance remove-one-to-one-nat ya-mssql3 --network-interface-index 0
       ```

    {% endlist %}

### Configure the Always On availability group {#configure-always-on}

1. Connect to `jump-server-vm` using RDP. Enter Administrator as the username and then your password. Open the RDP client and connect to `ya-mssql1`.

1. The Always On availability group requires a configured Windows Server Failover Cluster. To create it, you need to test all the DB servers:

    {% list tabs %}

    - PowerShell

       ```
       Test-Cluster -Node 'ya-mssql1.yantoso.net'
       Test-Cluster -Node 'ya-mssql2.yantoso.net'
       Test-Cluster -Node 'ya-mssql3.yantoso.net'
       ```

    {% endlist %}

1. Create a cluster of three DB servers:

    {% list tabs %}

    - PowerShell

       ```
       New-Cluster -Name 'wsfc' -Node 'ya-mssql1.yantoso.net', 'ya-mssql2.yantoso.net', 'ya-mssql3.yantoso.net' -NoStorage -StaticAddress 10.0.0.20, 10.0.0.36, 10.0.0.52
       ```

    {% endlist %}

1. Import SqlServer module commands for PowerShell:

    {% list tabs %}

    - PowerShell

       ```
       Import-Module SqlServer
       ```

    {% endlist %}

1. Give server management permissions to the `mssql-svc` service user:

    {% list tabs %}

    - PowerShell

       ```
       Add-SqlLogin -Path "SQLSERVER:\SQL\ya-mssql1.yantoso.net\Default" `
         -LoginName "yantoso\mssql-svc" `
         -LoginType "WindowsUser" `
         -Enable `
         -GrantConnectSql
       
       Add-SqlLogin -Path "SQLSERVER:\SQL\ya-mssql2.yantoso.net\Default" `
         -LoginName "yantoso\mssql-svc" `
         -LoginType "WindowsUser" `
         -Enable `
         -GrantConnectSql
       
       Add-SqlLogin -Path "SQLSERVER:\SQL\ya-mssql3.yantoso.net\Default" `
         -LoginName "yantoso\mssql-svc" `
         -LoginType "WindowsUser" `
         -Enable `
         -GrantConnectSql
       
       $mssql1 = Get-Item "SQLSERVER:\SQL\ya-mssql1.yantoso.net\Default"
       $mssql1.Roles['sysadmin'].AddMember('yantoso\mssql-svc')
       $mssql1.Roles['sysadmin'].Alter()
       
       $mssql2 = Get-Item "SQLSERVER:\SQL\ya-mssql2.yantoso.net\Default"
       $mssql2.Roles['sysadmin'].AddMember('yantoso\mssql-svc')
       $mssql2.Roles['sysadmin'].Alter()
       
       $mssql3 = Get-Item "SQLSERVER:\SQL\ya-mssql3.yantoso.net\Default"
       $mssql3.Roles['sysadmin'].AddMember('yantoso\mssql-svc')
       $mssql3.Roles['sysadmin'].Alter()
       ```

    {% endlist %}

1. Connect to each server in turn and enable SqlAlwaysOn. When Always On is enabled, the DBMS service restarts.

    {% list tabs %}

    - PowerShell

       ```
       Enable-SqlAlwaysOn -ServerInstance 'ya-mssql1.yantoso.net' -Force
       Enable-SqlAlwaysOn -ServerInstance 'ya-mssql2.yantoso.net' -Force
       Enable-SqlAlwaysOn -ServerInstance 'ya-mssql3.yantoso.net' -Force
       ```

    {% endlist %}

1. Create and run [HADR endpoints](https://docs.microsoft.com/en-us/powershell/module/sqlps/new-sqlhadrendpoint?view=sqlserver-ps#description):

    {% list tabs %}

    - PowerShell

       ```
       New-SqlHADREndpoint -Port 5022 -Owner sa `
        -Encryption Supported -EncryptionAlgorithm Aes `
        -Name AlwaysonEndpoint `
        -Path "SQLSERVER:\SQL\ya-mssql1.yantoso.net\Default"
       
       Set-SqlHADREndpoint -Path "SQLSERVER:\SQL\ya-mssql1.yantoso.net\Default\Endpoints\AlwaysonEndpoint" -State Started
       
       New-SqlHADREndpoint -Port 5022 -Owner sa `
           -Encryption Supported -EncryptionAlgorithm Aes `
           -Name AlwaysonEndpoint `
           -Path "SQLSERVER:\SQL\ya-mssql2.yantoso.net\Default"
       
       Set-SqlHADREndpoint -Path "SQLSERVER:\SQL\ya-mssql2.yantoso.net\Default\Endpoints\AlwaysonEndpoint" -State Started
       
       New-SqlHADREndpoint -Port 5022 -Owner sa `
           -Encryption Supported -EncryptionAlgorithm Aes `
           -Name AlwaysonEndpoint `
           -Path "SQLSERVER:\SQL\ya-mssql3.yantoso.net\Default"
       
       Set-SqlHADREndpoint -Path "SQLSERVER:\SQL\ya-mssql3.yantoso.net\Default\Endpoints\AlwaysonEndpoint" -State Started
       ```

    {% endlist %}

1. Create variables with replica parameters. The main replica is `ya-mssql1`, the second and third ones are `ya-mssql2` and `ya-mssql3`, respectively.

    {% list tabs %}

    - PowerShell

       ```
       $PrimaryReplica = New-SqlAvailabilityReplica `
        -Name ya-mssql1 `
        -EndpointUrl "TCP://ya-mssql1.yantoso.net:5022" `
        -FailoverMode "Automatic" `
        -AvailabilityMode "SynchronousCommit" `
        -AsTemplate -Version 13
       
       $SecondaryReplica = New-SqlAvailabilityReplica `
           -Name ya-mssql2 `
           -EndpointUrl "TCP://ya-mssql2.yantoso.net:5022" `
           -FailoverMode "Automatic" `
           -AvailabilityMode "SynchronousCommit" `
           -AsTemplate -Version 13
       
       $ThirdReplica = New-SqlAvailabilityReplica `
           -Name ya-mssql3 `
           -EndpointUrl "TCP://ya-mssql3.yantoso.net:5022" `
           -FailoverMode "Automatic" `
           -AvailabilityMode "SynchronousCommit" `
           -AsTemplate -Version 13
       ```

    {% endlist %}

1. Create a `MyAG` availability group of replicas and add the first server to it:

    {% list tabs %}

    - PowerShell

       ```
       New-SqlAvailabilityGroup `
           -Name 'MyAG' `
           -AvailabilityReplica @($PrimaryReplica, $SecondaryReplica, $ThirdReplica) `
           -Path "SQLSERVER:\SQL\ya-mssql1.yantoso.net\Default"
       ```

    {% endlist %}

1. Add the remaining servers to the availability group:

    {% list tabs %}

    - PowerShell

       ```
       Join-SqlAvailabilityGroup -Path "SQLSERVER:\SQL\ya-mssql2.yantoso.net\Default" -Name 'MyAG'
       Join-SqlAvailabilityGroup -Path "SQLSERVER:\SQL\ya-mssql3.yantoso.net\Default" -Name 'MyAG'
       ```

    {% endlist %}

1. Create a [Listener](https://docs.microsoft.com/en-us/powershell/module/sqlps/new-sqlavailabilitygrouplistener?view=sqlserver-ps#description):

    {% list tabs %}

    - PowerShell

       ```
       New-SqlAvailabilityGroupListener `
         -Name 'MyListener' `
         -Port 1433 `
         -StaticIp @("10.0.0.21/255.255.255.240","10.0.0.37/255.255.255.240","10.0.0.53/255.255.255.240") `
         -Path SQLSERVER:\Sql\ya-mssql1.yantoso.net\Default\AvailabilityGroups\MyAG
       ```

    {% endlist %}

1. Create a database on the `ya-mssql1` server:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -Query "CREATE DATABASE MyDatabase" -ServerInstance 'ya-mssql1.yantoso.net'
       ```

    {% endlist %}

1. Configure access settings for the backup folder on the server:

    {% list tabs %}

    - PowerShell

       ```
       New-SMBShare -Name SQLBackup -Path "X:\BACKUP" -FullAccess "yantoso\mssql-backups-grp"
       
       $Acl = Get-Acl "X:\BACKUP"
       $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("yantoso\mssql-backups-grp","Read", "ContainerInherit, ObjectInherit", "None", "Allow")
       $Acl.AddAccessRule($AccessRule)
       
       $Acl | Set-Acl "X:\BACKUP"
       ```

    {% endlist %}

1. Create a backup of `MyDatabase` on the `ya-mssql1` VM:

    {% list tabs %}

    - PowerShell

       ```
       Backup-SqlDatabase `
           -Database "MyDatabase" -Initialize `
           -BackupFile "MyDatabase.bak" `
           -ServerInstance "ya-mssql1.yantoso.net"
       
       Backup-SqlDatabase `
           -Database "MyDatabase"  -Initialize `
           -BackupFile "MyDatabase.log" `
           -ServerInstance "ya-mssql1.yantoso.net" `
           -BackupAction Log
       ```

    {% endlist %}

1. Restore the database on the `ya-mssql2` server from the backup:

    {% list tabs %}

    - PowerShell

       ```
       Restore-SqlDatabase `
           -Database "MyDatabase" `
           -BackupFile "\\ya-mssql1.yantoso.net\SQLBackup\MyDatabase.bak" `
           -Path "SQLSERVER:\SQL\ya-mssql2.yantoso.net\Default" `
           -NORECOVERY
       
       Restore-SqlDatabase `
           -Database "MyDatabase" `
           -BackupFile "\\ya-mssql1.yantoso.net\SQLBackup\MyDatabase.log" `
           -Path "SQLSERVER:\SQL\ya-mssql2.yantoso.net\Default" `
           -RestoreAction Log `
           -NORECOVERY
       ```

    {% endlist %}

1. Restore the database on the `ya-mssql3` server from the backup:

    {% list tabs %}

    - PowerShell

       ```
       Restore-SqlDatabase `
           -Database "MyDatabase" `
           -BackupFile "\\ya-mssql1.yantoso.net\SQLBackup\MyDatabase.bak" `
           -Path "SQLSERVER:\SQL\ya-mssql3.yantoso.net\Default" `
           -NORECOVERY
       
       Restore-SqlDatabase `
           -Database "MyDatabase" `
           -BackupFile "\\ya-mssql1.yantoso.net\SQLBackup\MyDatabase.log" `
           -Path "SQLSERVER:\SQL\ya-mssql3.yantoso.net\Default" `
           -RestoreAction Log `
           -NORECOVERY
       ```

    {% endlist %}

1. Add all the databases to the availability group:

    {% list tabs %}

    - PowerShell

       ```
       Add-SqlAvailabilityDatabase `
        -Path "SQLSERVER:\SQL\ya-mssql1.yantoso.net\Default\AvailabilityGroups\MyAG" `
        -Database "MyDatabase"
       
       Add-SqlAvailabilityDatabase `
           -Path "SQLSERVER:\SQL\ya-mssql2.yantoso.net\Default\AvailabilityGroups\MyAG" `
           -Database "MyDatabase"
       
       Add-SqlAvailabilityDatabase `
           -Path "SQLSERVER:\SQL\ya-mssql3.yantoso.net\Default\AvailabilityGroups\MyAG" `
           -Database "MyDatabase"
       ```

    {% endlist %}

## Test the availability group {#test}

### Add a bastion host to the domain {#jump-server-domain}

1. Connect to the VM `jump-server-vm` using RDP and start PowerShell.

1. Specify the VM with the domain controller as the DNS server:

    {% list tabs %}

    - PowerShell

       ```
       Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.0.0.3"
       ```

    {% endlist %}

1. Add the VM to the domain:

    {% list tabs %}

    - PowerShell

       ```
       $domain_credential = `
         New-Object System.Management.Automation.PSCredential (
           'yantoso\Administrator', `
           ('QWErty123' | ConvertTo-SecureString -AsPlainText -Force))
       
       Add-Computer -DomainCredential $domain_credential -DomainName 'yantoso.net' -Restart -Force
       ```

    {% endlist %}

    The VM restarts automatically.

1. After restarting, reconnect to the VM and log in to it as `yantoso\Administrator`.

### Test the database {#test-always-on}

1. Install the `SqlServer` PowerShell module:

    {% list tabs %}

    - PowerShell

       ```
       install-Module -Name SqlServer
       ```

    {% endlist %}

1. Create a table in the replicated `MyDatabase` DB:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -ServerInstance 'mylistner.yantoso.net' -Query @"
       CREATE TABLE MyDatabase.dbo.test (
         test_id INT IDENTITY(1,1) PRIMARY KEY,
         test_name VARCHAR(30) NOT NULL
       );
       "@
       ```

    {% endlist %}

1. Add a new row to the DB table:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -ServerInstance 'mylistner.yantoso.net' -Query @"
       INSERT INTO MyDatabase.dbo.test (test_name) 
       VALUES ('one')
       "@
       ```

    {% endlist %}

1. Make sure the row appears in the table:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -ServerInstance 'mylistner.yantoso.net' -Query "SELECT * FROM MyDatabase.dbo.test"
       ```

       ```
       test_id test_name
       ------- ---------
             1 one
       ```

    {% endlist %}

1. Check the name of the main DB replica:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -Query "SELECT @@SERVERNAME" -ServerInstance 'mylistener.yantoso.net'
       ```

       ```
       Column1
       -------
       YA-MSSQL1
       ```

    {% endlist %}

1. Run a failover to the second replica:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -Query "ALTER AVAILABILITY GROUP MyAg FAILOVER" -ServerInstance 'ya-mssql2.yantoso.net'
       ```

    {% endlist %}

1. After a while, check the name of the main replica again:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -Query "SELECT @@SERVERNAME" -ServerInstance 'mylistener.yantoso.net'
       ```

       ```
       Column1
       -------
       YA-MSSQL2
       ```

    {% endlist %}

1. Add another row to the table to check the second replica for writes:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -ServerInstance 'mylistner.yantoso.net' -Query @"
       INSERT INTO MyDatabase.dbo.test (test_name) 
       VALUES ('two')
       "@
       ```

    {% endlist %}

1. Make sure the row was added:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -ServerInstance 'mylistner.yantoso.net' -Query "SELECT * FROM MyDatabase.dbo.test"
       ```

       ```
       test_id test_name
       ------- ---------
             1 one
             2 two
       ```

    {% endlist %}

## Delete the created resources {#clear-out}

To stop paying for the deployed servers, [delete](../compute/operations/vm-control/vm-delete.md) the VMs you created:

* `vm-jump-server`
* `ya-ad`
* `ya-mssql1`
* `ya-mssql2`
* `ya-mssql3`

