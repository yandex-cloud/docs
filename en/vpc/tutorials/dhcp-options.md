# DHCP settings for working with a corporate DNS server

If you want your VMs to resolve names in a private corporate DNS zone, use the [DHCP options](../concepts/dhcp-options.md) in the [subnet](../operations/subnet-create.md) configuration. For example, you can specify a DNS suffix and DNS server for subnet nodes.

To run this scenario, make sure you have a corporate DNS server deployed that is available for the VMs in the cloud. You can also [deploy Active Directory](../../tutorials/windows/active-directory.md) to create an infrastructure with a DNS server:

* A cloud network named `ad-network` with subnets in different [availability zones](../../overview/concepts/geo-scope.md):
  * `ad-subnet-a` (10.1.0.0/16)
  * `ad-subnet-b` (10.2.0.0/16)
  * `ad-subnet-c` (10.3.0.0/16)
* Domain controllers and a bastion host:
  * `ad-vm-a` (10.1.0.3)
  * `ad-vm-b` (10.2.0.3)
  * `jump-server-vm` (10.3.0.x)

In this scenario, you'll add a new subnet `10.128.0.0/24` with the DNS suffix and DNS server specified, create a VM, and test the network.

To add a subnet with DHCP settings:

* [Prepare your cloud](#before-begin).
* [Create a subnet](#create-subnet).
* [Test the network](#check-config).

If you no longer need the infrastructure, [delete](#clear-out) the created resources.

## Prepare your cloud {#before-begin}

Before deploying your infrastructure, register in {{ yandex-cloud }} and create a billing account:

{% include [prepare-register-billing](../../_tutorials/_common/prepare-register-billing.md) %}

If you have an active billing account, you can create or select a separate folder to run the scenario. Learn more about [clouds and folders](../../resource-manager/concepts/resources-hierarchy.md).

To pass this scenario in full, [deploy Active Directory](../../tutorials/windows/active-directory.md). If you use your own DNS servers that are available for cloud VMs, specify your own DNS suffix and IP address values in the scenario.

### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* A fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for VM disk storage (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using dynamic or static public IP addresses (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* The cost of outgoing traffic from {{ yandex-cloud }} to the internet (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

## Create a subnet {#create-subnet}

To create a new subnet with DHCP settings, follow these steps:

{% list tabs %}

- Management console

	To create a subnet:
	1. Open the **Virtual Private Cloud** section in the folder where you want to create the subnet.
	1. Click on the name of the `ad-network` cloud network.
	1. Click **Add subnet**.
	1. Fill out the form:
		* Enter a name for the subnet: `test-subnet-1`. Select the availability zone: `ru-central1-b`.
		* Enter the subnet CIDR: `10.128.0.0/24`. For more information about subnet IP address ranges, see [Cloud networks and subnets](../concepts/network.md).
	1. Specify **DHCP settings**:
		* In the **Domain name** field, specify the DNS suffix: `yantoso.net`.
		* In the **Domain name servers** field, click **Add DNS server** and specify its address: `10.1.0.3`. Repeat the steps for the `10.2.0.3` address.
	1. Click **Create subnet**.

- CLI

	{% include [include](../../_includes/cli-install.md) %}

	Run the following command:
	```
	yc vpc subnet create --name test-subnet-1 \
		--description "My test subnet" \
	    --folder-id <folder ID> \
		--network-name ad-network \
		--zone ru-central1-b \
		--range 10.128.0.0/24 \
		--domain-name yantoso.net \
		--domain-name-server 10.1.0.3,10.2.0.3
	```

	`<folder ID>`: ID of the folder where you create your resources. If the folder is specified in the CLI profile, this parameter can be omitted.

	Result:

	```
	id: e2ldy0b1prtj837re3fb
	folder_id: b1gbvco8fejm38siik76
	created_at: "2021-07-12T13:28:54Z"
	name: test-subnet-1
	description: My test subnet
	network_id: enpl0t90hept99f9hsh4
	zone_id: ru-central1-b
	v4_cidr_blocks:
	- 10.128.0.0/24
	dhcp_options:
	  domain_name_servers:
	  - 10.1.0.3
	  - 10.2.0.3
	  domain_name: yantoso.net
	```

{% endlist %}

## Test the network {#check-config}

To check the configuration, create a VM and connect to it via RDP:

1. Create a VM:

	{% list tabs %}

	- Management console

		1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.
		1. In the **Name** field, enter the VM name: `vm-for-tests-in-subnet`.
		1. Select the [availability zone](../../overview/concepts/geo-scope.md) `ru-central1-b`.
		1. Under **Image/boot disk selection**, choose Windows Server. In the drop-down list, select the OS version: **2016 Datacenter**.
		1. Under **Disks**, enter 50 GB for the size of the boot disk.
		1. Under **Computing resources**:
      		* Choose a [platform](../../compute/concepts/vm-platforms.md): Intel Cascade Lake.
      		* Specify the number of vCPUs and amount of RAM:
         		* **vCPU**: 2.
         		* **Guaranteed vCPU share**: 100%.
         		* **RAM**: 4 GB.
      		* If necessary, make your VM [preemptible](../../compute/concepts/preemptible-vm).
		1. Under **Network settings**, select the `ad-network / test-subnet-1` subnet from the list.
		1. Under **Access**, specify the data required to access the VM:
      		* In the **Password** field, enter your password.
		1. Click **Create VM**.

	- CLI

		{% include [include](../../_includes/cli-install.md) %}

		To set a password for the VM, create a metadata.yaml file with the following contents:

		```
		#ps1
		net user administrator '<password>'
		```

		To create a VM, run the command:

		```
		yc compute instance create \
			--name vm-for-tests-in-subnet \
			--metadata-from-file user-data=metadata.yaml \
			--zone ru-central1-b \
			--cores 2 \
			--memory 4 \
			--network-interface subnet-name=test-subnet-1,nat-ip-version=ipv4 \
			--create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk
		```

		If the command is successful, save the IP address from the `one_to_one_nat` field. The address is used in the next step to create an RDP connection:

		```
		...
		status: RUNNING
		...
		primary_v4_address:
	  	  address: 10.128.0.26
		...
		one_to_one_nat:
		  address: 130.193.40.112
		  ip_version: IPV4
		...
		```

	{% endlist %}

1. Wait a few minutes and [connect to the VM](../../compute/operations/vm-connect/rdp.md) via RDP.

1. Run PowerShell on the VM.

1. To view the Windows network configuration, run the command:

	```
	ipconfig /all
	```

	Result:

	```
	Windows IP Configuration

	   Host Name . . . . . . . . . . . . : epdpjtgc4i5eudo
	   Primary Dns Suffix  . . . . . . . :
	   Node Type . . . . . . . . . . . . : Hybrid
	   IP Routing Enabled. . . . . . . . : No
	   WINS Proxy Enabled. . . . . . . . : No
	   DNS Suffix Search List. . . . . . : yantoso.net

	Ethernet adapter Ethernet 2:

	   Connection-specific DNS Suffix  . : yantoso.net
	   Description . . . . . . . . . . . : Red Hat VirtIO Ethernet Adapter #2
	   Physical Address. . . . . . . . . : D0-0D-19-9F-60-C2
	   DHCP Enabled. . . . . . . . . . . : Yes
	   Autoconfiguration Enabled . . . . : Yes
	   Link-local IPv6 Address . . . . . : fe80::1f0:5a1e:76ea:3ded%3(Preferred)
	   IPv4 Address. . . . . . . . . . . : 10.128.0.11(Preferred)
	   Subnet Mask . . . . . . . . . . . : 255.255.255.0
	   Lease Obtained. . . . . . . . . . : Wednesday, July 14, 2021 11:00:09 AM
	   Lease Expires . . . . . . . . . . : Saturday, August 20, 2157 5:33:50 PM
	   Default Gateway . . . . . . . . . : 10.128.0.1
	   DHCP Server . . . . . . . . . . . : 10.128.0.2
	   DHCPv6 IAID . . . . . . . . . . . : 114298137
	   DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-28-80-7B-90-D0-0D-19-9F-60-C2
	   DNS Servers . . . . . . . . . . . : 10.1.0.3
	                                       10.2.0.3
	   NetBIOS over Tcpip. . . . . . . . : Enabled

	Tunnel adapter isatap.yantoso.net:

	   Media State . . . . . . . . . . . : Media disconnected
	   Connection-specific DNS Suffix  . : yantoso.net
	   Description . . . . . . . . . . . : Microsoft ISATAP Adapter
	   Physical Address. . . . . . . . . : 00-00-00-00-00-00-00-E0
	   DHCP Enabled. . . . . . . . . . . : No
	   Autoconfiguration Enabled . . . . : Yes
	```

1. Check if there is a connection to the `yantoso.net` domain controller.

	To do this, run the command:
	```
	ping ad-vm-a
	```

 	If connected, the command output should look as follows:

	```
	PS C:\Users\Administrator> ping ad-vm-a

	Pinging ad-vm-a.yantoso.net [10.1.0.3] with 32 bytes of data:
	Reply from 10.1.0.3: bytes=32 time=1ms TTL=127
	Reply from 10.1.0.3: bytes=32 time<1ms TTL=127
	Reply from 10.1.0.3: bytes=32 time<1ms TTL=127
	Reply from 10.1.0.3: bytes=32 time<1ms TTL=127

	Ping statistics for 10.1.0.3:
	    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
	Approximate round trip times in milli-seconds:
	    Minimum = 0ms, Maximum = 1ms, Average = 0ms
	```

## How to delete created resources {#clear-out}

To release the resources, follow these steps:

1. Delete the `vm-for-tests-in-subnet` VM.

	{% list tabs %}

	- Management console

		1. Select the folder that the VM belongs to.
		1. On the folder dashboard, go to {{ compute-name }}.
		1. Select the VM → click ![image](../../_assets/options.svg) → select **Delete**.
		1. Confirm the deletion.

	- CLI

		{% include [include](../../_includes/cli-install.md) %}

		{% include [default-catalogue](../../_includes/default-catalogue.md) %}

		To delete the VM, run:
		```
		yc compute instance delete vm-for-tests-in-subnet
		```

	{% endlist %}

1. Delete the `test-subnet-1` subnet.

	{% list tabs %}

	- Management console
		1. Open the **Virtual Private Cloud** section in the folder you want to delete the subnet from.
		1. Click on the name of the subnet's cloud network: `ad-network`.
		1. Click ![image](../../_assets/options.svg) in the `test-subnet-1` line.
		1. In the menu that opens, click **Delete**.
		1. Confirm the deletion and click **Delete**.

	- CLI

		{% include [include](../../_includes/cli-install.md) %}

		{% include [default-catalogue](../../_includes/default-catalogue.md) %}

		To delete the subnet, run:
		```
		yc vpc subnet delete --name test-subnet-1
		```

	{% endlist %}

