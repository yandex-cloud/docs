# Creating a bastion host

## Overview {#overview}

If you have ever had an interest in early modern fortifications, the word "bastion" should sound familiar to you. A bastion is a structure projecting outward from the outer wall of a fortification. Just like early modern fortresses, computer networks require multi-layer protection against external attacks. Such network bastions are called bastion hosts, and they form part of a network perimeter.

{% note info %}

The steps provided in this tutorial involve using paid resources. Go to the [service plans](/prices) page to estimate your costs depending on what amount of resources you are going to use.

{% endnote %}

In this tutorial, you will learn how to deploy a bastion host and secure access to remote VMs hosted in your virtual private cloud (VPC). A bastion host is a VM that is assigned a public IP address to enable SSH access. By configuring a bastion host, you get sort of a jump server that allows you to establish secure connections to VMs that have no public IPs.

A bastion host will help you make your VPC servers less vulnerable. At the same time, administrative tasks on specific servers will be handled within a proxy connection via a bastion host over SSH.

In this tutorial, you will learn how to:
* Use bastion host and security group setup rules.
* Manage servers using a bastion host.

Getting started:
* To connect to virtual servers, generate an SSH key. If you have no SSH key, generate one by following [this guide](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
* This tutorial assumes that you will create a bastion host as part of an existing VPC. If you do not have a cloud created in your account, create one before proceeding to the next steps.

{% note info %}

* Select the cloud and folder you need in the main menu.
* Place all resources (networks, subnets, security groups, and VMs) in the same availability zone.

{% endnote %}

## Create a bastion host {#create-bastion-host}

In this section, you will learn how to create and configure a bastion host after setting up all required networks, segments, and security groups.


![](../../_assets/tutorials/bastion-yc.svg)



### Create an external network and subnet {#create-external-network}

1. In the [main]({{ link-console-main }}) menu, select **{{ vpc-name }}**.
1. In the left-hand panel, select **Cloud networks** and click **Create network**.
   * Enter the network name: `external-bastion-network`.
   * Do not select the **Create subnets** option.
1. Click the name of the created network to open the network settings page.
1. Under **Subnets**, click **Create** to create a new subnet:
   * Name: `bastion-external-segment`.
   * CIDR: `172.16.17.0/28`.

### Create an internal network and subnet {#create-internal-network}

1. In the main menu, select {{ vpc-name }}.
1. In the left-hand panel, select **Cloud networks** and click **Create network**.
   * Enter the network name: `internal-bastion-network`.
1. Click the name of the created network to open the network settings page.
1. Under **Subnets**, click **Create** to create a new subnet.
   * Name: `bastion-internal-segment`.
   * CIDR: `172.16.16.0/24`.

### Create and set up a security group for the bastion host {#create-internet-sg}

Create a security group and set up rules for incoming traffic on the bastion host to allow accessing it from the internet:

1. Under **Network**: `bastion-external-network`, select **Security groups** and click **Create group**.
1. Enter the security group name: `secure-bastion-sg`.
1. Go to the section with the incoming traffic rules and add the rules specified below by clicking **Add rule**. This rule allows access to the bastion host from the internet:
   * Name: `secure-bastion-sg`.
   * **Incoming traffic**:
      * Protocol: `TCP`.
      * Port range: `22`.
      * Source type: `CIDR`.
      * Source: `0.0.0.0/0`.
1. Click **Save**. Your rule has been created.

### Create and set up a security group for the bastion host to allow access to internal hosts {#create-internal-hosts-sg}

Create a security group and set up rules for incoming traffic from the bastion host to internal hosts:

1. Under **Network**: `bastion-internal-network`, select **Security groups** and click **Create group**.
1. Enter the security group name: `internal-bastion-sg`.
1. **Incoming traffic**: Go to the section with the incoming traffic rules and add the rules specified below by clicking **Add rule**:
   * Port range: `22`.
   * Protocol: `TCP`.
   * Source: `CIDR`.
   * CIDR blocks: `172.16.16.254/32` (bastion host's internal static IP).
1. **Outgoing traffic**: Go to the section with the outgoing traffic rules and add the following rule by clicking **Add rule**:
   * Port range: `22`.
   * Protocol: `TCP`.
   * Source: `Security group`.
   * `Current`.
   This rule allows SSH access from the bastion host's internal interface IPs to the internal hosts.
1. Click **Save**. Your rule has been created.

### Create a VM for the bastion host {#create-bastion-instance}

After you created the subnet and security group, proceed to create a virtual server for the bastion host:

1. In the main menu, select **{{ compute-name }}**.
1. Click **Create VM** and specify the host name and OS.
1. For most parameters, use the default values.
1. Under **Network settings**, configure the first (**external**) network interface:
   * Select the **Subnet**: `bastion-external-subnet`.
   * Public address: `Auto`.
   * Internal IP address: `Auto`.
   * Select the previously created **Security group**: `secure-bastion-sg`.
1. Click **Add network** to add the second (**internal**) interface:
   * Select the **Subnet**: `bastion-internal-subnet`.
   * Public address: `No address`.
   * Internal IP address: `Manual`.
   * Address field: `172.16.16.254`.
   * Select the **Security group**: `internal-bastion-sg`.

   {% note info %}

   Make sure the first interface on the new VM belongs to an external segment, since the default gateway is automatically specified on this interface.

   {% endnote %}

   The external IP is set on the external segment. Select the static IP to use on the internal segment.
1. Under **Access**, in the **Login** field, enter a Linux username, such as **bastion**. Avoid standard Linux usernames, such as root.
1. Copy your public SSH key and paste it to the **SSH key** field.
1. Click **Create VM**.
1. Once the server VM is started and its status changes to **Running**, you will see the public IP address assigned to it in the **Public IPv4** field (in the table with server VM details).

### Test your bastion host {#test-bastion}

After you start your bastion host, try to connect to it via the SSH client:

```
ssh -i ~/.ssh/<private_key>bastion@<public_IPv4>
```

## Add your virtual server to the bastion host's internal segment {#add-virtual-server}

To administer your servers, add a network interface to the bastion host's internal network segment (in our case, **bastion-internal-segment**).

If you have an existing VM, add the new network interface to it or create a new VM to test the bastion host configuration.
1. In the main menu, select **{{ compute-name }}**.
1. Click **Create VM** and specify the host name and OS.
1. For most parameters, use the default values.
1. Set up another network interface under **Network settings**:
   * Select the **Subnet**: `bastion-internal-subnet`.
   * Public address: `No address`.
   * Internal IP address: `Auto`.
   * Select the **Security group**: `secure-bastion-sg`.
1. Under **Access**, in the **Login** field, enter a Linux username, such as `test`. Avoid standard Linux usernames, such as `root`.
1. Copy your public SSH key and paste it to the **SSH key** field.
1. Click **Create VM**.

### Connect to the created VM {#connect-to-instance}

If you connect to the VM over SSH via a private IP address, you will be using your bastion host as a _jump host_.

Find out your virtual server's private IP in the **{{ compute-name }} > Virtual machines** table.

To simplify SSH access and configure it, add the `-J` (ProxyJump) parameter to the appropriate SSH command. Here is how you can use ProxyJump:

```
ssh -i ~/.ssh/id_rsa -J bastion@<bastion_host_public_IP>test@<private_IP>
```

As a result, the SSH client will automatically connect to the internal server.

The `-J` flag is supported in OpenSSH 7.3+. In earlier versions, `-J` is not available. In this case, the easiest and most secure way is to use standard I/O redirection (the `-W` flag) for connection forwarding through the bastion host, e.g.:

```
ssh -i ~/.ssh/id_rsa -o ProxyCommand="ssh -W %h:%p bastion@<bastion_host_public_IP>test@<private_IP>
```

## Additional connection options {#more-options}

### Make the external IP static {#static-ip-address}

You may want to make the external IP address [static](../../vpc/operations/set-static-ip.md) to avoid issues related to changing the external IP each time the bastion host restarts.

### Using an SSH-agent for connections via the bastion host {#using-ssh-agent}

By default, server access is only set up for authentication using a public SSH key. We do not recommend storing keys directly on bastion hosts, especially without a passphrase. You should use an **SSH agent** instead.  In this case, private SSH keys will only be stored on your computer and you will be able to safely use them for authentication on the next server.

To add a key to an authentication agent, use the **ssh-add** command. If the key is stored in the **~/.ssh/id_rsa** file, it is added automatically. You can also set a specific key to use by running the command below:

```
ssh-add [key_file_path]
```

Mac OS X users can set up the **~/.ssh/config** file. In this case, the keys can be uploaded to the agent with this command:

```
AddKeysToAgent yes
```

The following command used to connect to the bastion host allows you to perform agent forwarding and log in to the next server by providing the credentials from your local machine:

```
SSH -A bastion@bastion_host
```

Windows users can use the Pageant application and upload their private key file to it. Next, to ensure agent forwarding, open the PuTTY configuration window and select **Connection** > **SSH** > **Authentication**.

### Access to services through SSH-tunnels {#ssh-tunneling}

At times SSH access alone is not enough to complete your task. If this is the case, use SSH tunnels to easily connect to web apps and other services that handle incoming connections.

The main types of SSH tunnels are local, remote, and dynamic:
* A **local** tunnel is an open port in a local loopback interface, which connects to the **IP:port** address on your SSH server.
   For example, you can connect local port 8080 to the **web_server_ip:80** address that is accessible from your local bastion host and then open **http://localhost:8080** in your browser:

   ```
   SSH bastion@bastion_public_ip -L 8080:web_server_ip:80
   ```

* This tutorial does not include a detailed description of **remote** tunnels. In brief, a remote tunnel works in the direction opposite to that of a local tunnel by opening a local port to connect to a remote server.
* A **dynamic** tunnel provides a SOCKS proxy on a local port with connections established from a remote host. For example, you can set up a dynamic tunnel on port 1080 and then specify it as a SOCKS proxy in your browser. As a result, you will be able to connect to any resources that are accessible from your bastion host and reside in a private subnet.

   ```
   SSH bastion@bastion_host -D 1080
   ```

These methods are based on a simple replacement that often requires a VPN connection and a combination with ProxyJump or ProxyCommand connections.

Windows users can set up tunnels using PuTTY by selecting **Connection** > **SSH** > **Tunnels**.

To easily establish connections to Remote Desktop Services (RDS), i.e., Windows hosts running in a cloud, you can use port redirection (especially local one) by establishing a tunnel connection to port 3389 and then connecting to the localhost via an RDS client. If the RDS client is already waiting for a connection on the local machine, you can choose a different port as shown in the example below:

```
SSH bastion@bastion_host -L 3390:windows_host:3389
```

### Transferring files {#file-transfers}

For Linux clients and servers, you can configure SCP for a secure file transfer via a bastion host to internal hosts and back. This is done using the same ProxyCommand and ProxyJump options specified in the SSH command line, E.g.:

```
scp -o "ProxyJump bastion@bastion_host" filename bastion@private_host:/path/to/file
```

If you are using a Windows client, one of the most popular SCP apps for Windows is WinSCP. To transfer files via your bastion host to a remote Linux machine:

1. Create a session to connect to a private host IP with no password. Set up an SSH key on the Linux machine.
1. In the left-hand navigation menu, click **Advanced** and select **Tunnel**.
1. Enter the IP address and username for your bastion host. In the **Private key file** field, select and set the private key file to use for authentication on your bastion host.
1. In the left-hand navigation menu, select **Authentication** under **SSH**.
1. Make sure to select **Allow agent forwarding**.
1. Choose the private key to use for authentication on a private host.

This configuration enables a direct file transfer between your Windows machine and Linux private host. The bastion host will secure connections between them.

If the Windows hosts are located behind the Linux bastion, you can transfer files using Remote Desktop Protocol (RDP) via a tunnel. This method ensures an efficient and secure file transfer.
