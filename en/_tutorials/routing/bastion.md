# Creating a bastion host

## Overview {#overview}

The term bastion comes from the fortifications. A bastion was a part of an outer wall, placed around the corners of a fort. Like Medieval structures, computer networks need layered protection against intruders. Bastion hosts, like their physical counterparts, are a part of this defense perimeter.

{% note info %}

This tutorial may incur costs. Use the [pricing page](/prices) to generate a cost estimate based on your projected usage.

{% endnote %}

This tutorial walks you through the deployment of a bastion host to securely access remote instances within a virtual private cloud. Bastion host is an instance that is provisioned with a public IP address and can be accessed via SSH. Once set up, the bastion host acts as a jump server allowing secure connection to instances provisioned without a public IP address.

To reduce exposure of servers within the VPC you will create and use a bastion host. Administrative tasks on the individual servers are going to be performed using SSH, proxied through the bastion.

Objectives:
* Learn how to set up a bastion host and security groups with rules
* Securely manage servers via the bastion host

Before you begin:
* You need an SSH key to connect to the virtual servers. If you don't have an SSH key, see [the instructions](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) for creating a key.
* The tutorial assumes that you are adding the bastion host in an existing virtual private cloud. If you don't have a virtual private cloud in your account, create one before proceeding with the next steps.

{% note info %}

* Select correct Cloud and Folder in main menu.
* Put all resources (networks/subnets/security groups/vm) to the same availability zone.

{% endnote %}

## Create bastion host {#create-bastion-host}

In this section, you will create and configure a bastion host along with a required networks, segments and security groups.


![bastion-yc](../../_assets/tutorials/bastion-yc.svg)



### Create external network and subnet {#create-external-network}

1. In [Main]({{ link-console-main }}) menu select **{{ vpc-name }}**.
1. Click **Cloud Networks** on the left pane, then click **Create Network**.
   * Enter `external-bastion-network` as name.
   * Do not select Create subnets.
1. Click on newly created network to open network configuration page.
1. Click **Create** button under Subnets part to create a new subnet:
   * Name: `bastion-external-segment`.
   * CIDR: `172.16.17.0/28`.

### Create internal network and subnet {#create-internal-network}

1. In Main menu select {{ vpc-name }}.
1. Click **Cloud Networks** on the left pane, then click **Create Network**.
   * Enter `internal-bastion-network` as name.
1. Click on newly created network to open network configuration page.
1. Click **Create** button under Subnets part to create a new subnet:
   * Name: `bastion-internal-segment`.
   * CIDR: `172.16.16.0/24`.

### Create and configure bastion security group to access from internet {#create-internet-sg}

Let's create a security group and configure inbound rules to your bastion host.

1. Select **Security groups** under **Network** `bastion-external-network`, then click **Create group** button.
1. Enter `secure-bastion-sg` as name.
1. Now, create the following Ingress rules by clicking **Add rule** in the ingress rules section. This allow SSH access from Internet to bastion host:
   * Name: `secure-bastion-sg`.
   * **Ingress** rule:
      * Protocol: `TCP`.
      * Port range: `22`.
      * Source type: `CIDR`.
      * Source: `0.0.0.0/0`.
1. Click **Save** to create it.

### Create and configure bastion security group to internal hosts {#create-internal-hosts-sg}

Let's create a security group and configure inbound rules from bastion host.

1. Select**Security groups** under **Network**: `bastion-internal-network`, then click **Create group** button.
1. Enter `internal-bastion-sg` as name.
1. **Ingress**: create the following Ingress rules by clicking **Add rule** in the ingress rules section:
   * Port range: `22`.
   * Protocol: `TCP`.
   * Source: `CIDR`.
   * CIDR blocks: `172.16.16.254/32` (Internal static IP address of bastion host).
1. **Egress**: create the following Egress rule by clicking **Add rule** in the egress rules section:
   * Port range: `22`.
   * Protocol: `TCP`.
   * Source: `Security group`.
   * `Current`.
   This allow SSH access from bastion internal interface IP towards internal hosts.
1. Click **Save** to create it.

### Create a bastion instance {#create-bastion-instance}

With the subnet and security group already in place, next, create the bastion virtual server instance.

1. From **Main** menu select **{{ compute-name }}**.
1. Click **Create VM** button and choose the host name and operating system.
1. Leave most parameters as default.
1. Under **Network setting** configure first network interface (**external**):
   * Select **Subnet**: `bastion-external-subnet`.
   * Public IP: `Auto`.
   * Internal IP address: `Auto`.
   * Select **Security group** you created before `secure-bastion-sg`.
1. Click on **Add network** interface to add second interface (**internal**):
   * Select **Subnet**: `bastion-internal-subnet`.
   * Public IP: `No Address`.
   * Internal IP address: `Manual`.
   * Address field: `172.16.16.254`.
   * Select **Security group**: `internal-bastion-sg`.

   {% note info %}

   Make sure the first interface on new VM is from external segment, because the default gateway automatically will be defined on this interface.

   {% endnote %}

   We allocate external IP address on external segment.
   And select to use static IP address on internal segment.
1. In **Access** section fill the **Login** field with linux username for example **bastion** (do not use root or other default linuxuser names).
1. Paste your SSH public key to **SSH key** field.
1. Click **Create VM**.
1. Once the instance is up and **Running**, you may see the public IP address assigned to it, see field **Public IPv4** in instance information table.

### Test your bastion {#test-bastion}

Once your bastion's host is active, try connecting to it using ssh client:

```
ssh -i ~/.ssh/<PRIVATE_KEY>bastion@<PUBLIC_IPv4_ADDRESS>
```

## Add virtual server instance to the internal bastion segment {#add-virtual-server}

For administrative work on the servers, you have to add network interface in the same network segment like bastion host internal segment, in our case **bastion-internal-segment**.

If you have already VMs just add new network interface to it, or create new VM to test bastion host configuration:
1. From **Main** menu select **{{ compute-name }}**.
1. Click **Create VM** button and choose the host name and operating system.
1. Leave most parameters as default.
1. Under **Network setting** configure network interface:
   * Select **Subnet**: `bastion-internal-subnet`.
   * Public IP: `No Address`.
   * Internal IP address: `Auto`.
   * Select **Security group**: `secure-bastion-sg`.
1. In **Access** section fill the **Login** field with linux username for example **test** (do not use root or other default linuxuser names).
1. Paste your SSH public key to **SSH key** field.
1. Click **Create VM**.

### Connect to the instance {#connect-to-instance}

To SSH into an instance using its **private IP**, you will use the bastion host as your **jump host**.

Obtain the private IP address of a virtual server instance under **{{ compute-name }} > Virtual machines** table.

To simplify SSH access and configuration, add the `-J` (ProxyJump) parameter to the ssh command. Following is an example of ProxyJump usage:

```
ssh -i ~/.ssh/id_rsa -J bastion@<BASTION_PUBLIC_IP_ADDRESS>test@<PRIVATE_IP_ADDRESS>
```

As a result, the SSH client automatically connects to internal server.

`-J` flag is supported in OpenSSH version 7.3+. In older versions `-J` is not available. In this case the safest and most straightforward way is to use ssh's stdio forwarding (`-W`) mode to "bounce" the connection through a bastion host. e.g.,

```
ssh -i ~/.ssh/id_rsa -o ProxyCommand="ssh -W %h:%p bastion@<BASTION_PUBLIC_IP_ADDRESS" test@<PRIVATE_IP_ADDRESS>
```

## More connectivity options {#more-options}

### Make external IP address static {#static-ip-address}

In order to fix external IP address and be the same after bastion host reboots, you may [make it static](../../vpc/operations/set-static-ip.md).

### Using ssh-agent to Connect Through the Bastion Host {#using-ssh-agent}

By default, access to the server is configured to use only SSH public key authentication. We recommend using **ssh-agent** instead of storing SSH keys (especially without a passphrase) on the bastion hosts. This way, private SSH keys exist only on your computer and can be safely used to authenticate to the next server.

To add a key to the authentication agent, use the **ssh-add** command. If the key is **~/.ssh/id_rsa**, it’s added automatically. You can also specify which key to use by running the following command:

```
ssh-add [path_to_keyfile]
```

Mac OS X users can configure the **~/.ssh/config** file to enable loading keys into the agent with the following command:

```
AddKeysToAgent yes
```

Using the following command to connect to the bastion host enables agent forwarding and allows logging in to the next server by forwarding credentials from your local machine:

```
SSH -A bastion@bastion_host
```

Windows users can use the Pageant application, import their private key file there, and enable agent forwarding by selecting **Connection**, then **SSH**, and then **Auth** in the PuTTY Configuration window.

### Service Access Through SSH Tunneling {#ssh-tunneling}

Sometimes SSH access might not be enough to perform the task. In this case, SSH tunneling can provide an easy way to access a web application or other listening service.

The main types of SSH tunneling are local, remote, and dynamic:
* The **local** tunnel provides an exposed port on the local loopback interface that’s connected to the **IP:port** from your SSH server.
  For example, you can connect local port 8080 to **web_server_ip:80**, which is accessible from your bastion host, and point your web browser to **http://localhost:8080**:

   ```
   SSH bastion@bastion_public_ip -L 8080:web_server_ip:80
   ```

* The **remote** tunnel is outside the scope of this tutorial, but it works the opposite of local forwarding — it exposes a local port to connections coming to the remote server.
* The **dynamic** tunnel provides a SOCKS proxy on the local port, but connections originate from the remote host. For example, you can set up a dynamic tunnel on port 1080 and configure it as SOCKS proxy in the web browser. As a result, you can connect to all the resources available from your bastion host that are in the private subnet.

   ```
   SSH bastion@bastion_host -D 1080
   ```

These techniques are simple replacements that often require a VPN connection and can be combined with ProxyJump or ProxyCommand connections.

Windows users can find the tunnel configuration in PuTTY by selecting **Connection**, **SSH**, and then **Tunnels**.

You can use port forwarding, especially a local one, to easily establish the connection to Remote Desktop Services — enabled Windows hosts in the cloud, by tunneling port 3389 and connecting to localhost from a Remote Desktop client. If RDS is already listening on the local machine, you can select another port, as shown in the following example:

```
SSH bastion@bastion_host -L 3390:windows_host:3389
```

### File Transfers {#file-transfers}

For a Linux client and servers, you can use secure copy protocol (SCP) to securely transfer files to and from hosts through the bastion host by using the same ProxyCommand or ProxyJump options specified from the SSH command line. For example:

```
scp -o "ProxyJump bastion@bastion_host" filename bastion@private_host:/path/to/file
```

If you’re using a Windows client, one of the most popular applications for SCP is WinSCP. To transfer the files through the bastion host to a remote Linux instance, use the following steps:

1. Create a session with a private host IP address without a password. The Linux instance is configured with the SSH key.
1. In the left navigation menu, click **Advanced** and select **Tunnel**.
1. Enter your bastion host IP address and username. In the **Private key file** field, navigate and select the private key to authenticate with the bastion host.
1. In the left navigation menu, under **SSH**, select **Authentication**.
1. Ensure that **Allow agent forwarding** is selected.
1. Select the private key that authenticates with the private host.

This setup allows direct file transfer between your Windows machine and Linux private host, protected by the bastion.

For Windows hosts behind a Linux bastion, you can transfer files by using Remote Desktop Protocol (RDP) and tunneling. This method is effective and secure for transferring files.
