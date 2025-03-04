# Deploying an Always On availability group with an internal network load balancer


{% include [ms-disclaimer](../../_includes/ms-disclaimer.md) %}



This tutorial will tell you how to deploy an Always On availability group in {{ yandex-cloud }} and enable load balancing across the nodes using an internal network load balancer. You will set up network interfaces to combine multiple subnets into a single common subnet. Therefore, you do not need [Multisubnet Failover]({{ ms.docs }}/sql/sql-server/failover-clusters/windows/sql-server-multi-subnet-clustering-sql-server?view=sql-server-ver15). It is the replica to where you will be writing that will get the primary IP address. The same replica will have an open port, and the load balancer will route traffic to this port. Since the port specified for connecting to the load balancer becomes unavailable, you will use an additional non-standard port to receive traffic.

To set up an Always On availability group with an internal network load balancer:

1. [Get your cloud ready](#before-begin).
1. [Create a network infrastructure](#prepare-network).
1. [Create an internal network load balancer](#create-load-balancer).
1. [Prepare VMs for the availability group](#create-vms).
1. [Test the availability group](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% include [ms-additional-data-note](../_tutorials_includes/ms-additional-data-note.md) %}

### Required paid resources {#paid-resources}

The cost of supporting the availability group includes:

* Fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a network load balancer (see [{{ network-load-balancer-full-name }} pricing](../../network-load-balancer/pricing.md)).
* Fee for using a dynamic or static public IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

You can use [license mobility](../../compute/qa/licensing.md) and bring your own SQL Server license to {{ yandex-cloud }}.

## Create a network infrastructure {#prepare-network}

Prepare the network infrastructure to host the availability group.

1. Create a network named `ya-network`:

    {% list tabs group=programming_language %}

    - Management console {#console}

       1. Open the **{{ vpc-name }}** section of the folder where you want to create a cloud network.
       1. Click **Create network**.
       1. Enter the network name: `ya-network`.
       1. Click **Create network**.

    - Bash {#bash}
      
      {% include [cli-install](../../_includes/cli-install.md) %}
  
      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      ```
      yc vpc network create --name ya-network
      ```

    - PowerShell {#powershell}

      [Install](../../cli/operations/install-cli.md) the {{ yandex-cloud }} command line interface to use CLI commands in PowerShell. 

      ```
      yc vpc network create --name ya-network
      ```

    {% endlist %}

1. Create subnets that will host your VMs and network load balancer: 

   * Three subnets to host SQLServer VMs: `ya-sqlserver-rc1a`, `ya-sqlserver-rc1b`, and `ya-sqlserver-rc1d`. Each subnet will be linked to the `mssql` route table.
   * `ya-ilb-rc1a` subnet for the network load balancer.
   * `ya-ad-rc1a` subnet for Active Directory.


    {% list tabs group=programming_language %}

    - Management console {#console}

      1. Open the **{{ vpc-name }}** section in the folder where you want to create a subnet.
      1. Select the `ya-network` network.
      1. Click ![image](../../_assets/console-icons/plus.svg) **Add subnet**.
      1. Fill out the form: enter `ya-sqlserver-rc1a` as the subnet name and select the `{{ region-id }}-a` availability zone from the drop-down list.
      1. Enter the subnet CIDR: IP address and subnet mask: `192.168.1.0/28`.
      1. Click **Create subnet**.

      Repeat these steps for the subnets with the following names and CIDR:

      * `ya-sqlserver-rc1b` in the `{{ region-id }}-b` availability zone: `192.168.1.16/28`.
      * `ya-sqlserver-rc1d` in the `{{ region-id }}-d` availability zone: `192.168.1.32/28`.
      * `ya-ilb-rc1a` in the `{{ region-id }}-a` availability zone: `192.168.1.48/28`.
      * `ya-ad-rc1a` in the `{{ region-id }}-a` availability zone: `10.0.0.0/28`.

    - Bash {#bash}

      ```
      yc vpc subnet create \
         --name ya-sqlserver-rc1a \
         --zone {{ region-id }}-a \
         --range 192.168.1.0/28 \
         --network-name ya-network
      ```

      ```
      yc vpc subnet create \
        --name ya-sqlserver-rc1b \
        --zone {{ region-id }}-b \
        --range 192.168.1.16/28 \
        --network-name ya-network
      ```

      ```
      yc vpc subnet create \
         --name ya-sqlserver-rc1d \
         --zone {{ region-id }}-d \
         --range 192.168.1.32/28 \
         --network-name ya-network
      ```

      ```
      yc vpc subnet create \
         --name ya-ilb-rc1a \
         --zone {{ region-id }}-a \
         --range 192.168.1.48/28 \
         --network-name ya-network
      ```

      ```
      yc vpc subnet create \
        --name ya-ad-rc1a \
        --zone {{ region-id }}-a \
        --range 10.0.0.0/28 \
        --network-name ya-network
      ```

    - PowerShell {#powershell}

      ```
      yc vpc subnet create `
         --name ya-sqlserver-rc1a `
         --zone {{ region-id }}-a `
         --range 192.168.1.0/28 `
         --network-name ya-network
      ```

      ```
      yc vpc subnet create `
         --name ya-sqlserver-rc1b `
         --zone {{ region-id }}-b `
         --range 192.168.1.16/28 `
         --network-name ya-network
      ```

      ```
      yc vpc subnet create `
         --name ya-sqlserver-rc1d `
         --zone {{ region-id }}-d `
         --range 192.168.1.32/28 `
         --network-name ya-network
      ```

      ```
      yc vpc subnet create `
         --name ya-ilb-rc1a `
         --zone {{ region-id }}-a `
         --range 192.168.1.48/28 `
         --network-name ya-network
      ```

      ```
      yc vpc subnet create `
         --name ya-ad-rc1a `
         --zone {{ region-id }}-a `
         --range 10.0.0.0/28 `
         --network-name ya-network
      ```

    {% endlist %}

## Create an internal network load balancer {#create-load-balancer}

{% list tabs group=programming_language %}

- Bash {#bash}

  ```
  yc load-balancer network-load-balancer create \
     --name ya-loadbalancer \
     --type internal
  ```

- PowerShell {#powershell}
  
  ```
  yc load-balancer network-load-balancer create `
     --name ya-loadbalancer `
     --type internal
  ```

{% endlist %}

### Create a listener {#create-listener}

{% list tabs group=programming_language %}

- Bash {#bash}
  
  Get the subnet ID:

  ```
  yc vpc subnet get --name ya-ilb-rc1a
  ```
  
  Create a listener and specify the subnet ID:

  ```
  yc load-balancer network-load-balancer add-listener \
     --name ya-loadbalancer \
     --listener name=ya-listener,port=1433,target-port=14333,protocol=tcp,internal-address=192.168.1.62,internal-subnet-id=<subnet_ID>
  ```

- PowerShell {#powershell}

  ```
  $inlbSubnet = yc vpc subnet get `
     --name ya-ilb-rc1a `
     --format json | ConvertFrom-Json
  ```

  ```
  yc load-balancer network-load-balancer add-listener `
     --name ya-loadbalancer `
     --listener name=ya-listener,port=1433,target-port=14333,protocol=tcp,internal-address=192.168.1.62,internal-subnet-id=$($inlbSubnet.id)
  ```


{% endlist %}

### Create and connect the target group to the network load balancer {#create-target-group}

{% list tabs group=programming_language %}

- Bash {#bash}

  ```
  yc load-balancer target-group create \
     --name ya-tg \
     --target address=192.168.1.3,subnet-name=ya-sqlserver-rc1a \
     --target address=192.168.1.19,subnet-name=ya-sqlserver-rc1b \
     --target address=192.168.1.35,subnet-name=ya-sqlserver-rc1d
  ```
  
  Copy the target group ID from the response and run this command:

  ```
  yc load-balancer network-load-balancer attach-target-group \
     --name ya-loadbalancer \
     --target-group target-group-id=<target_group_ID>,healthcheck-name=listener,healthcheck-tcp-port=59999
  ```

- PowerShell {#powershell}

  ```
  yc load-balancer target-group create `
     --name ya-tg `
     --target address=192.168.1.3,subnet-name=ya-sqlserver-rc1a `
     --target address=192.168.1.19,subnet-name=ya-sqlserver-rc1b `
     --target address=192.168.1.35,subnet-name=ya-sqlserver-rc1d
  ```
  
  ```
  $TargetGroup = yc load-balancer target-group get `
     --name ya-tg `
     --format json | ConvertFrom-Json
  ```

  ```
  yc load-balancer network-load-balancer attach-target-group `
     --name ya-loadbalancer `
     --target-group target-group-id=$($TargetGroup.id),healthcheck-name=listener,healthcheck-tcp-port=59999
  ```

{% endlist %}

## Prepare VMs for the availability group {#create-vms}


### Prepare Windows Server images {#prepare-images}

Before creating VMs, prepare a Windows Server image to use in {{ yandex-cloud }} with your own license.


### Create a file with administrator credentials {#prepare-admin-credentials}

Create a file named `setpass` with a script to set the password for the local administrator account. This script will be executed when you create VMs via the CLI.

{% note alert %}

The `setpass` file must be UTF-8 encoded.

{% endnote %}

{% list tabs group=programming_language %}

- Bash {#bash}

  ```
  touch ~/setpass
  ```
  
  ```
  echo '#ps1' >> ~/setpass
  ```
  
  ```
  echo 'Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "YaQWErty123" -AsPlainText -Force)' >> ~/setpass
  cd
  ```

- PowerShell {#powershell}

  ```
  ni ~/setpass
  ```
  
  ```
  echo '#ps1' >> ~/setpass
  ```
  
  ```
  echo 'Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "YaQWErty123" -AsPlainText -Force)' >> ~/setpass
  ```

{% endlist %}

{% note warning %}

The password provided above is for testing only. Use your own complex password when deploying a cluster to work in a product environment.

The password must meet the [complexity requirements]({{ ms.docs }}/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements#справочник).

You can read more about the best practices for securing Active Directory on the [MS official website]({{ ms.docs }}/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory).

{% endnote %}

### Create VMs {#create-group-vms}

Make sure to create your VMs on [dedicated hosts](../../compute/concepts/dedicated-host.md). You can get the dedicated host ID in the {{ yandex-cloud }} CLI by running the `yc compute host-group list-hosts` command. To learn more about this command, see [this reference](../../cli/cli-ref/compute/cli-ref/host-group/list-hosts.md).

#### Create a VM for a bastion host {#create-jump-server}

Create a bastion host with Windows Server 2022 Datacenter and a public IP address to access other VMs:

{% list tabs group=programming_language %}

- Bash {#bash}

  ```
  yc compute instance create \
     --name ya-jump1 \
     --hostname ya-jump1 \
     --zone {{ region-id }}-a \
     --memory 4 \
     --cores 2 \
     --metadata-from-file user-data=setpass \
     --create-boot-disk \
       type=network-ssd,size=50,image-id=<Windows_image_ID> \
     --network-interface \
       subnet-name=ya-ad-rc1a,nat-ip-version=ipv4 \
     --host-id <dedicated_host_ID> \
     --async
  ```

  {% include [cli-metadata-variables-substitution-notice](../../_includes/compute/create/cli-metadata-variables-substitution-notice.md) %}

- PowerShell {#powershell}

  ```
  yc compute instance create `
     --name ya-jump1 `
     --hostname ya-jump1 `
     --zone {{ region-id }}-a `
     --memory 4 `
     --cores 2 `
     --metadata-from-file user-data=setpass `
     --create-boot-disk `
       type=network-ssd,size=50,image-id=<Windows_image_ID> `
     --network-interface `
       subnet-name=ya-ad-rc1a,nat-ip-version=ipv4 `
     --host-id <dedicated_host_ID> `
     --async

  ```

  {% include [cli-metadata-variables-substitution-notice](../../_includes/compute/create/cli-metadata-variables-substitution-notice.md) %}

{% endlist %}

#### Create a VM for Active Directory {#create-ad-controller}

{% list tabs group=programming_language %}

- Bash {#bash}

  ```
  yc compute instance create \
     --name ya-ad \
     --hostname ya-ad \
     --zone {{ region-id }}-a \
     --memory 6 \
     --cores 2 \
     --metadata-from-file user-data=setpass \
     --create-boot-disk \
       type=network-ssd,size=50,image-id=<Windows_image_ID> \
     --network-interface \
       subnet-name=ya-ad-rc1a,ipv4-address=10.0.0.3 \
     --host-id <dedicated_host_ID> \
     --async
  ```

- PowerShell {#powershell}

  ```
  yc compute instance create `
     --name ya-ad `
     --hostname ya-ad `
     --zone {{ region-id }}-a `
     --memory 6 `
     --cores 2 `
     --metadata-from-file user-data=setpass `
     --create-boot-disk `
       type=network-ssd,size=50,image-id=<Windows_image_ID> `
     --network-interface `
       subnet-name=ya-ad-rc1a,ipv4-address=10.0.0.3 `
     --host-id <dedicated_host_ID> `
     --async

  ```

{% endlist %}

#### Create VM instances for SQL Server {#create-ad-server}

Create three VMs with Windows Server 2022 Datacenter for SQL Server:

{% list tabs group=programming_language %}

- Bash {#bash}

  ```
  yc compute instance create \
     --name ya-mssql1 \
     --hostname ya-mssql1 \
     --zone {{ region-id }}-a \
     --memory 16 \
     --cores 4 \
     --metadata-from-file user-data=setpass \
     --create-boot-disk \
       type=network-ssd,size=50,image-id=<Windows_image_ID> \
     --create-disk \
       type=network-ssd,size=200 \
     --network-interface \
       subnet-name=ya-sqlserver-rc1a,ipv4-address=192.168.1.3 \
     --host-id <dedicated_host_ID> \
     --async
  ```

  ```
  yc compute instance create \
     --name ya-mssql2 \
     --hostname ya-mssql2 \
     --zone {{ region-id }}-b \
     --memory 16 \
     --cores 4 \
     --metadata-from-file user-data=setpass \
     --create-boot-disk \
       type=network-ssd,size=50,image-id=<Windows_image_ID> \
     --create-disk \
       type=network-ssd,size=200 \
     --network-interface \
       subnet-name=ya-sqlserver-rc1b,ipv4-address=192.168.1.19 \
     --host-id <dedicated_host_ID> \
     --async
  ```

  ```
  yc compute instance create \
     --name ya-mssql3 \
     --hostname ya-mssql3 \
     --zone {{ region-id }}-d \
     --memory 16 \
     --cores 4 \
     --metadata-from-file user-data=setpass \
     --create-boot-disk \
       type=network-ssd,size=50,image-id=<Windows_image_ID> \
     --create-disk \
       type=network-ssd,size=200 \
     --network-interface \
       subnet-name=ya-sqlserver-rc1d,ipv4-address=192.168.1.35 \
     --host-id <dedicated_host_ID> \
     --async
  ```

- PowerShell {#powershell}

  ```
  yc compute instance create `
     --name ya-mssql1 `
     --hostname ya-mssql1 `
     --zone {{ region-id }}-a `
     --memory 16 `
     --cores 4 `
     --metadata-from-file user-data=setpass `
     --create-boot-disk `
       type=network-ssd,size=50,image-id=<Windows_image_ID> `
     --create-disk `
       type=network-ssd,size=200 `
     --network-interface `
       subnet-name=ya-sqlserver-rc1a,ipv4-address=192.168.1.3 `
     --host-id <dedicated_host_ID> `
     --async
  ```

  ```
  yc compute instance create `
     --name ya-mssql2 `
     --hostname ya-mssql2 `
     --zone {{ region-id }}-b `
     --memory 16 `
     --cores 4 `
     --metadata-from-file user-data=setpass `
     --create-boot-disk `
       type=network-ssd,size=50,image-id=<Windows_image_ID> `
     --create-disk `
       type=network-ssd,size=200 `
     --network-interface `
       subnet-name=ya-sqlserver-rc1b,ipv4-address=192.168.1.19 `
     --host-id <dedicated_host_ID> `
     --async
  ```

  ```
  yc compute instance create `
     --name ya-mssql3 `
     --hostname ya-mssql3 `
     --zone {{ region-id }}-d `
     --memory 16 `
     --cores 4 `
     --metadata-from-file user-data=setpass `
     --create-boot-disk `
       type=network-ssd,size=50,image-id=<Windows_image_ID> `
     --create-disk `
       type=network-ssd,size=200 `
     --network-interface `
       subnet-name=ya-sqlserver-rc1d,ipv4-address=192.168.1.35 `
     --host-id <dedicated_host_ID> `
     --async
  ```

{% endlist %}

### Bring your own Windows Server licenses {#byol}

Connect to each VM you created and [activate your own Windows Server license on these VMs](../../microsoft/byol.md).


### Install and configure Active Directory {#install-ad}

1. Connect to `ya-jump1` through [RDP](../../compute/operations/vm-connect/rdp.md). Use `Administrator` as the username and your password. 
1. From `ya-jump1`, connect to the `ya-ad` VM under the same account using RDP.
1. On `ya-ad`, run PowerShell and set the required server roles:

   {% list tabs group=programming_language %}

   - PowerShell {#powershell}

       ```
       Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
       ```

   {% endlist %}

1. Create an Active Directory forest:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Install-ADDSForest `
         -DomainName 'yantoso.net' `
         -Force:$true `
         -SafeModeAdministratorPassword `
           ('YaP@ssw0rd!11' | ConvertTo-SecureString -AsPlainText -Force)
       ```
       
    {% endlist %}

   After that, the VM will restart. 

1. Reconnect to `ya-ad`.

1. Rename the website and add to it the subnets you created:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Get-ADReplicationSite 'Default-First-Site-Name' | Rename-ADObject -NewName '{{ region-id }}'
       New-ADReplicationSubnet -Name '10.0.0.0/28'  -Site '{{ region-id }}'
       New-ADReplicationSubnet -Name '192.168.1.0/28'  -Site '{{ region-id }}'
       New-ADReplicationSubnet -Name '192.168.1.16/28' -Site '{{ region-id }}'
       New-ADReplicationSubnet -Name '192.168.1.32/28' -Site '{{ region-id }}'
       New-ADReplicationSubnet -Name '192.168.1.48/28' -Site '{{ region-id }}'
       ```

    {% endlist %}

1. Specify the forwarder for the DNS server:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Set-DnsServerForwarder '10.0.0.2'
       ```

    {% endlist %}

1. Specify the DNS server addresses:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.0.0.3,127.0.0.1"
       ```

    {% endlist %}

### Create users and groups in Active Directory {#create-ad-users-groups}

1. Connect to `ya-jump1` through [RDP](../../compute/operations/vm-connect/rdp.md). Use `Administrator` as the username and your password.

1. Connect to the `ya-ad` VM from `ya-jump1` under the same account using RDP.

1. On `ya-ad`, run PowerShell and create the `mssql-svc` service account:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       New-ADUser `
         -Name mssql-svc `
         -AccountPassword ('YaQWErty123' | ConvertTo-SecureString -AsPlainText -Force) `
         -CannotChangePassword $true `
         -PasswordNeverExpires $true `
         -Enabled $true
       ```

    {% endlist %}

1. Create groups to access backups and DB servers:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       New-AdGroup mssql-admins-grp -GroupScope:Global
       New-AdGroup mssql-backups-grp -GroupScope:Global
       ```

    {% endlist %} 

1. Add the `Administrator` account to all groups. Add the `mssql-svc` service account to the `mssql-backups-grp` group:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Add-ADGroupMember mssql-admins-grp -Members Administrator
       Add-ADGroupMember mssql-backups-grp -Members Administrator
       Add-ADGroupMember mssql-backups-grp -Members mssql-svc
       ```

    {% endlist %}

1. Set the service account [SPN](https://docs.microsoft.com/en-us/windows/win32/ad/service-principal-names):

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       setspn -A MSSQLSvc/ya-mssql1.yantoso.net:1433 yantoso\mssql-svc
       setspn -A MSSQLSvc/ya-mssql1.yantoso.net yantoso\mssql-svc

       setspn -A MSSQLSvc/ya-mssql2.yantoso.net:1433 yantoso\mssql-svc
       setspn -A MSSQLSvc/ya-mssql2.yantoso.net yantoso\mssql-svc

       setspn -A MSSQLSvc/ya-mssql3.yantoso.net:1433 yantoso\mssql-svc
       setspn -A MSSQLSvc/ya-mssql3.yantoso.net yantoso\mssql-svc
       ```

    {% endlist %}

### Install and configure SQL Server {#install-mssql}

Install SQL Server on your database servers:

1. Configure internet access on the VMs with DB servers:

    {% list tabs group=programming_language %}

    - Bash {#bash}

       ```
       yc compute instance add-one-to-one-nat <ya-mssql1_VM_ID> --network-interface-index 0
       yc compute instance add-one-to-one-nat <ya-mssql2_VM_ID> --network-interface-index 0
       yc compute instance add-one-to-one-nat <ya-mssql3_VM_ID> --network-interface-index 0
       ```

    - PowerShell {#powershell}

       ```
       yc compute instance add-one-to-one-nat <ya-mssql1_VM_ID> --network-interface-index 0
       yc compute instance add-one-to-one-nat <ya-mssql2_VM_ID> --network-interface-index 0
       yc compute instance add-one-to-one-nat <ya-mssql3_VM_ID> --network-interface-index 0
       ```

    {% endlist %}

1. Run RDP and connect to the `ya-mssql1` VM using the `Administrator` account and your password. To connect, use the public IP address of the VM.

1. Start PowerShell and set the role: 

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Install-WindowsFeature Failover-Clustering -IncludeManagementTools
       ```

    {% endlist %}

1. [Restart the VM](../../compute/operations/vm-control/vm-stop-and-start.md#restart).

1. Reconnect to the `ya-mssql1` VM and run PowerShell.

1. Initialize and format the second logical disk:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

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

    A message will appear asking you to confirm disk formatting. Click **Format disk**. Click **Start**. After formatting is complete, click **OK**. 
    
1. Create folders for the distribution kit, backups and storage for databases, logs, and temporary files:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       mkdir C:\dist
       mkdir X:\BACKUP
       mkdir X:\DB
       mkdir X:\DBLOG
       mkdir X:\TEMPDB
       mkdir X:\TEMPDBLOG
       ```

    {% endlist %}

1. Download the SQL Server 2022 (English) image from the web and save it to `C:\dist`.

1. Install the `SqlServer` module:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Install-Module -Name SqlServer
       ```
       
    {% endlist %}

1. When prompted to confirm the installation, enter `Y`.

1. Import the `SqlServer` module commands for PowerShell:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Import-Module SQLServer
       ```

    {% endlist %} 

1. Specify the DNS server address:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.0.0.3"
       ```

    {% endlist %}

   Prepare the data for accessing the domain:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       $domain_credential = `
         New-Object System.Management.Automation.PSCredential (
             'yantoso\Administrator', `
             ('YaQWErty123' | ConvertTo-SecureString -AsPlainText -Force))
       ```
       
    {% endlist %}

   Add the DB server to the domain:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Add-Computer -DomainCredential $domain_credential -DomainName 'yantoso.net' -Restart -Force
       ```

    {% endlist %}
   
   The VM will restart automatically. 

1. Following that, reconnect to the VM with the `yantoso\Administrator` username and open PowerShell.

1. Configure the required permissions for the service account: 

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       & secedit /export /cfg sec_conf_export.ini /areas user_rights

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

1. Set up a firewall: 
   
    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       New-NetFirewallRule `
         -Group "MSSQL" `
         -DisplayName "SQL Server Default" `
         -Name "MSSQLServer-In-TCP" `
         -LocalPort 1433 `
         -Action "Allow" `
         -Protocol "TCP"

       New-NetFirewallRule `
         -Group "MSSQL" `
         -DisplayName "SQL Server AAG Custom" `
         -Name "MSSQLAAG-In-TCP" `
         -LocalPort 14333 `
         -Action "Allow" `
         -Protocol "TCP"

       New-NetFirewallRule `
         -Group "MSSQL" `
         -DisplayName "MSSQL HADR Default" `
         -Name "MSSQLHADR-In-TCP" `
         -LocalPort 5022 `
         -Action "Allow" `
         -Protocol "TCP"

       New-NetFirewallRule `
         -Group "MSSQL" `
         -DisplayName "MSSQL NLB Probe" `
         -Name "MSSQLAAG-NLB-In-TCP" `
         -LocalPort 59999 `
         -Action "Allow" `
         -Protocol "TCP"
        ```

    {% endlist %}

1. Install SQL Server. Mount an image, run the installation, and detach the image:

   {% list tabs group=programming_language %}

   - PowerShell {#powershell}

      ```
      Mount-DiskImage -ImagePath C:\dist\<SQL_Server_image_name>.iso
      ```

      ```
      & D:\setup.exe /QUIET /INDICATEPROGRESS /IACCEPTSQLSERVERLICENSETERMS `
        /ACTION=INSTALL /FEATURES=SQLENGINE /INSTANCENAME=MSSQLSERVER `
        /SQLSVCACCOUNT="yantoso\mssql-svc" /SQLSVCPASSWORD="YaQWErty123" `
        /SQLSYSADMINACCOUNTS="yantoso\mssql-admins-grp" /UpdateEnabled=FALSE `
        /SQLBACKUPDIR="X:\BACKUP" /SQLTEMPDBDIR="X:\TEMPDB" /SQLTEMPDBLOGDIR="X:\TEMPDBLOG" `
        /SQLUSERDBDIR="X:\DB" /SQLUSERDBLOGDIR="X:\DBLOG"
      ```

      ```
      Dismount-DiskImage -ImagePath C:\dist\<MSSQL_Server_image_name>.iso
      ```

   {% endlist %}

1. Repeat steps 2-16 for the `ya-mssql2` and `ya-mssql3` VMs. 

1. Disable internet access for the VM:

    {% list tabs group=programming_language %}

    - Bash {#bash}

       ```
       yc compute instance remove-one-to-one-nat <ya-mssql1_VM_ID> --network-interface-index 0
       yc compute instance remove-one-to-one-nat <ya-mssql2_VM_ID> --network-interface-index 0
       yc compute instance remove-one-to-one-nat <ya-mssql3_VM_ID> --network-interface-index 0
       ```
    - PowerShell {#powershell}

       ```
       yc compute instance remove-one-to-one-nat <ya-mssql1_VM_ID> --network-interface-index 0
       yc compute instance remove-one-to-one-nat <ya-mssql2_VM_ID> --network-interface-index 0
       yc compute instance remove-one-to-one-nat <ya-mssql3_VM_ID> --network-interface-index 0
       ```

    {% endlist %}

1. Connect to `ya-jump1` through [RDP](../../compute/operations/vm-connect/rdp.md). Use `Administrator` as the username and your password.

1. Connect to the `ya-mssql1` VM from `ya-jump1` under the same account using RDP. Configure a static IP address with its own subnet mask:

   ```
   $IPAddress = Get-NetAdapter | Get-NetIPAddress -AddressFamily IPv4 | Select-Object -ExpandProperty IPAddress
   $InterfaceName = Get-NetAdapter | Select-Object -ExpandProperty Name
   $Gateway = Get-NetIPConfiguration | Select-Object -ExpandProperty IPv4DefaultGateway | Select-Object -ExpandProperty NextHop

   netsh interface ip set address $InterfaceName static $IPAddress 255.255.255.192 $Gateway
   ```

1. Repeat steps 19-20 for the `ya-mssql2` and `ya-mssql3` VMs.

1. The Always On availability group requires a configured Windows Server failover cluster. To create one, you need to test the DB servers. On any of the cluster VMs, run:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Test-Cluster -Node 'ya-mssql1.yantoso.net'
       Test-Cluster -Node 'ya-mssql2.yantoso.net'
       Test-Cluster -Node 'ya-mssql3.yantoso.net'
       ```

    {% endlist %}

### Create a Windows Server failover cluster {#configure-failover-cluster}

1. Connect to `ya-jump1` through [RDP](../../compute/operations/vm-connect/rdp.md). Use `Administrator` as the username and your password.
1. Connect to the `ya-mssql1` VM from `ya-jump1` using RDP as `yantoso\Administrator`.
1. Create a cluster of three DB servers:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       New-Cluster `
         -Name 'wsfc' `
         -Node 'ya-mssql1.yantoso.net','ya-mssql2.yantoso.net','ya-mssql3.yantoso.net' `
         -NoStorage `
         -StaticAddress 192.168.1.4

       Test-Cluster

       Get-ClusterResource -Name 'Cluster IP Address' | `
         Stop-ClusterResource

       Get-ClusterResource -Name 'Cluster IP Address' | `
         Set-ClusterParameter -Multiple `
           @{
             "Address"="169.254.1.1";
             "SubnetMask"="255.255.255.255";
             "OverrideAddressMatch"=1;
             "EnableDhcp"=0
           }

       Get-ClusterResource -Name 'Cluster Name' | Start-ClusterResource -Wait 60
       ```

    {% endlist %}

1. Enable TCP/IP on all VMs and add port `14333` to receive traffic:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       [reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")
       [reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.SqlWmiManagement")
       
       $nodes = @('ya-mssql1.yantoso.net','ya-mssql2.yantoso.net','ya-mssql3.yantoso.net')

       foreach ($node in $nodes) {
         $smo = [Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer]::new($node)
         $np = $smo.GetSmoObject("ManagedComputer[@Name=`'$node`']/ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='NP']")
         $tcp = $smo.GetSmoObject("ManagedComputer[@Name=`'$node`']/ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Tcp']")
         $ipall = $smo.GetSmoObject("ManagedComputer[@Name=`'$node`']/ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Tcp']/IPAddress[@Name='IPAll']")

         if (-not $ipall.IPAddressProperties['TcpPort'].Value -ne '1433,14333') {
           $ipall.IPAddressProperties['TcpPort'].Value = '1433,14333'
           $tcp.Alter()
           $altered = $true
         }

         if (-not $tcp.IsEnabled) {
           $tcp.IsEnabled = $true
           $tcp.Alter()
           $altered = $true
         }
         if (-not $np.IsEnabled) {
           $np.IsEnabled = $true
           $np.Alter()
           $altered = $true
         }

         if ($altered) {
           Get-Service -Name 'MSSQLSERVER' -ComputerName $node | Restart-Service -Force
           Start-Sleep -Seconds 60
         }
       }
       ```
    
    {% endlist %}

1. Grant server management permissions to the `mssql-svc` user:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Add-SqlLogin -Path "SQLSERVER:\SQL\ya-mssql1\Default" `
         -LoginName "yantoso\mssql-svc" `
         -LoginType "WindowsUser" `
         -Enable `
         -GrantConnectSql

       Add-SqlLogin -Path "SQLSERVER:\SQL\ya-mssql2\Default" `
         -LoginName "yantoso\mssql-svc" `
         -LoginType "WindowsUser" `
         -Enable `
         -GrantConnectSql

       Add-SqlLogin -Path "SQLSERVER:\SQL\ya-mssql3\Default" `
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

### Configure Always On {#configure-always-on}

1. Connect to each server one by one and enable `SqlAlwaysOn`:

   1. Connect to the Windows Server failover cluster (WSFC) node that hosts the SQL Server instance.
   1. Open the **Start** menu and select **All programs** → **Microsoft SQL Server** → **Configuration Tools** → **SQL Server Configuration Manager**.
   1. In the SQL Server Configuration Manager, right-click the SQL Server instance for which you need to enable Always On Availability Groups, and select **Properties**.
   1. Go to the **Always On High Availability** tab.
   1. Select **Enable Always On Availability Groups** and restart the SQL Server instance service.

1. Create and start [HADR endpoints](https://docs.microsoft.com/en-us/powershell/module/sqlps/new-sqlhadrendpoint?view=sqlserver-ps#description):

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

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

1. Create variables with replica parameters. The main replica is `ya-mssql1`; the second and third replicas are `ya-mssql2` and `ya-mssql3`, respectively. 

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

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

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       New-SqlAvailabilityGroup `
           -Name 'MyAG' `
           -AvailabilityReplica @($PrimaryReplica, $SecondaryReplica, $ThirdReplica) `
           -Path "SQLSERVER:\SQL\ya-mssql1.yantoso.net\Default"
        ```

    {% endlist %}

1. Add the remaining servers to the availability group:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Join-SqlAvailabilityGroup -Path "SQLSERVER:\SQL\ya-mssql2.yantoso.net\Default" -Name 'MyAG'
       Join-SqlAvailabilityGroup -Path "SQLSERVER:\SQL\ya-mssql3.yantoso.net\Default" -Name 'MyAG'
       ```

    {% endlist %}

1. Create a [listener](https://docs.microsoft.com/en-us/powershell/module/sqlps/new-sqlavailabilitygrouplistener?view=sqlserver-ps#description) with the `192.168.1.62` IP address, which belongs to the internal network load balancer:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       $NLBIPAddress = '192.168.1.62'

       Get-Cluster | `
         Add-ClusterResource -Name 'MyAG Network Name' -Group 'MyAG' -ResourceType 'Network Name'
       Get-ClusterResource -Name 'MyAG Network Name' | `
         Set-ClusterParameter -Multiple `
           @{
             Name = 'MyAGlistener'
             DnsName = 'MyAGlistener'
           }

       Get-Cluster | `
         Add-ClusterResource -Name 'My AG listener IP Address' -Group 'MyAG' -ResourceType 'IP Address'
       Get-ClusterResource -Name 'My AG listener IP Address' | `
         Set-ClusterParameter -Multiple `
           @{
             Address=$NLBIPAddress
             ProbePort=59999
             SubnetMask="255.255.255.255"
             Network="Cluster Network 1"
             EnableDhcp=0
           }

       Add-ClusterResourceDependency `
         -Resource 'MyAG Network Name' `
         -Provider 'My AG listener IP Address'

       Stop-ClusterResource 'MyAG'

       Add-ClusterResourceDependency `
         -Resource 'MyAG' `
         -Provider 'MyAG Network Name'

       Start-ClusterResource 'MyAG'
       ```

    {% endlist %}

1. Assign the listener port `14333`:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

      ```
      Set-SqlAvailabilityGroupListener `
        -Port 14333 `
        -Path "SQLSERVER:\Sql\ya-mssql1.yantoso.net\Default\AvailabilityGroups\MyAG\AvailabilityGroupListeners\MyAGlistener"
      ```

    {% endlist %}

1. Open port `14333` on all VMs in the cluster:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

      ```
      $nodes = @('ya-mssql1.yantoso.net','ya-mssql2.yantoso.net','ya-mssql3.yantoso.net')

      foreach ($node in $nodes) {
        $smo = [Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer]::new($node)
        $tcp = $smo.GetSmoObject("ManagedComputer[@Name=`'$node`']/ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Tcp']")
        $np = $smo.GetSmoObject("ManagedComputer[@Name=`'$node`']/ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='NP']")
        $ipall = $smo.GetSmoObject("ManagedComputer[@Name=`'$node`']/ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Tcp']/IPAddress[@Name='IPAll']")

        if (-not $ipall.IPAddressProperties['TcpPort'].Value -ne '1433,14333') {
          $ipall.IPAddressProperties['TcpPort'].Value = '1433,14333'
          $tcp.Alter()
          $altered = $true
        }

        if (-not $tcp.IsEnabled) {
          $tcp.IsEnabled = $true
          $tcp.Alter()
          $altered = $true

        }
        if (-not $np.IsEnabled) {
          $np.IsEnabled = $true
          $np.Alter()
          $altered = $true
        }

        if ($altered) {
          Get-Service -Name 'MSSQLSERVER' -ComputerName $node | Restart-Service
          Start-Sleep -Seconds 60
        }
      }
      ```

    {% endlist %}


1. Create a database on the `ya-mssql1` server:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Invoke-Sqlcmd -Query "CREATE DATABASE MyDatabase" -ServerInstance 'ya-mssql1.yantoso.net'
       ```

    {% endlist %}

1. Configure access for the backup directory on the server:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       New-SMBShare -Name SQLBackup -Path "X:\BACKUP" -FullAccess "yantoso\mssql-backups-grp"

       $Acl = Get-Acl "X:\BACKUP"
       $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("yantoso\mssql-backups-grp","Read", "ContainerInherit, ObjectInherit", "None", "Allow")
       $Acl.AddAccessRule($AccessRule)

       $Acl | Set-Acl "X:\BACKUP"
       ```

    {% endlist %}

1. Create a backup of `MyDatabase` on the `ya-mssql1` VM:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Backup-SqlDatabase `
         -Database "MyDatabase" -Initialize `
         -BackupFile "MyDatabase.bak" `
         -ServerInstance "ya-mssql1.yantoso.net"

       Backup-SqlDatabase `
         -Database "MyDatabase" -Initialize `
         -BackupFile "MyDatabase.log" `
         -ServerInstance "ya-mssql1.yantoso.net" `
         -BackupAction Log
       ```

    {% endlist %}

1. Restore the database on the `ya-mssql2` server from the backup: 

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

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

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

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

1. Add all databases to the availability group:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

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

You can test DB performance on any domain VM. Log in as `yantoso\Administrator`.

1. Create a table in the `MyDatabase` database under replication:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Invoke-Sqlcmd -ServerInstance 'MyAGlistener.yantoso.net' -Query @"
       CREATE TABLE MyDatabase.dbo.test (
         test_id INT IDENTITY(1,1) PRIMARY KEY,
         test_name VARCHAR(30) NOT NULL
       );
       "@
       ```

    {% endlist %}

1. Add a new row to the DB table:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Invoke-Sqlcmd -ServerInstance 'MyAGlistener.yantoso.net' -Query @"
       INSERT INTO MyDatabase.dbo.test (test_name) 
       VALUES ('one')
       "@
       ```

    {% endlist %}

1. Make sure the table now has this row:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Invoke-Sqlcmd -ServerInstance 'MyAGlistener.yantoso.net' -Query @"
       SELECT *
       FROM MyDatabase.dbo.test;
       "@
       ```

       Result:
       ```
       test_id test_name
       ------- ---------
             1 one
       ```

    {% endlist %}

1. Check the name of the main DB replica:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Invoke-Sqlcmd -Query "SELECT @@SERVERNAME" -ServerInstance 'MyAGlistener.yantoso.net'
       ```

       Result:
       ```
       Column1
       -------
       YA-MSSQL1
       ```

    {% endlist %}


1. Run a failover to the second replica:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Invoke-Sqlcmd -Query "ALTER AVAILABILITY GROUP MyAg FAILOVER" -ServerInstance 'ya-mssql2.yantoso.net'
       ```

    {% endlist %}

1. Verify the name of the main replica again:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Invoke-Sqlcmd -Query "SELECT @@SERVERNAME" -ServerInstance 'MyAGlistener.yantoso.net'
       ```

       Result:
       ```
       Column1
       -------
       YA-MSSQL2
       ```

    {% endlist %}

1. Add another row to the table to check the second replica for writes:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Invoke-Sqlcmd -ServerInstance 'MyAGlistener.yantoso.net' -Query @"
       INSERT INTO MyDatabase.dbo.test (test_name) 
       VALUES ('two')
       "@
       ```

    {% endlist %}

1. Make sure the row is there:

    {% list tabs group=programming_language %}

    - PowerShell {#powershell}

       ```
       Invoke-Sqlcmd -ServerInstance 'MyAGlistener.yantoso.net' -Query "SELECT * FROM MyDatabase.dbo.test"
       ```

       Result:
       ```
       test_id test_name
       ------- ---------
             1 one
             2 two
       ```

    {% endlist %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, [delete](../../compute/operations/vm-control/vm-delete.md) the VMs and the load balancer: 

* `ya-jump1`
* `ya-ad`
* `ya-mssql1`
* `ya-mssql2`
* `ya-mssql3`
* `ya-loadbalancer`
