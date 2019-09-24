# Configuring a virtual machine as a NAT gateway

Yandex.Cloud allows you to configure internet connections for multiple VMs via a NAT gateway. In this case, only one public IP address will be used: the one that will be assigned to the gateway.

{% note important %}

To ensure your NAT gateway functions properly, put it on a subnet without routing tables.

{% endnote %}

## Before you start {#before-begin}

Create a subnet for the NAT gateway.

1. Create a [cloud network](../../vpc/operations/network-create.md) with any name, such as `nat-instance-network`.
1. In the cloud network, create a [subnet](../../vpc/operations/subnet-create.md) for your NAT gateway with any name, such as `nat-subnet`. Do not assign any routing tables to it.

## Create a NAT gateway {#create-nat-instance}

You can automatically create a NAT gateway via the YC CLI, or create a VM and configure it manually.

### Creating a NAT gateway via the YC CLI from an image {#yc-create}

1. Create a virtual machine with the following parameters:
    - VM name: `nat-instance`.
    - Availability zone: `ru-central1-a`.
    - Host name: `nat-instance`.
    - Parameters for boot disk creation: `"image-family=nat-instance-ubuntu, size=40"`.
    - Image folder: `standard-images`.
    - Path to the file with the public part of the SSH key: `ssh-key.pub`.
    - Network interface: `subnet-name="nat-subnet,nat-ip-version=ipv4"`.
    - Amount of RAM: 2.
    - Number of cores: 2.

    ```
    $ yc compute instance create \
        --name nat-instance \
        --zone ru-central1-a \
        --hostname nat-instance \
        --create-boot-disk "image-family=nat-instance-ubuntu,size=40" \
        --image-folder-id=standard-images \
        --ssh-key ssh-key.pub \
        --network-interface subnet-name="nat-subnet,nat-ip-version=ipv4" \
        --memory 2 \
        --cores 2
    done (18s)
    id: fhmp220q3kgoqfop85q6
    folder_id: b1g88tflru0ek1omtsu0
    created_at: "2019-08-12T11:18:41Z"
    name: nat-instance
    zone_id: ru-central1-a
    platform_id: standard-v2
    ...
    ```

1. Look up the internal IP address of the gateway.
    1. In the {{ compute-name }} management console under **Virtual machines**, select the NAT gateway from the list of VMs. In the example, the VM is called `nat-instance`.
    1. Click the line with the VM name to get its details.
    1. The internal IP address is listed under **Network**.

1. Specify the internal IP address when creating the {{ k8s }} cluster.
    - Management console: On the {{ k8s }} cluster creation page under **Network settings**, specify the internal IP address in the **Gateway address** field.
    - YC CLI: Specify the address using the parameter `--default-gateway-v4-address`.

{% endlist %}

### Manually creating and configuring a NAT gateway {#create}

[Create](../../compute/quickstart/quick-create-linux.md) a VM to be used as an internet access gateway. The VM must have a public IP address to access the internet.

Once you create the VM, configure routing:

{% list tabs %}

- Ubuntu 18

  1. Connect to the VM using its public IP address:

     ```
     $ ssh <VM's public IP>
     ```

  1. Enable routing in the **sysctl** configuration. You can edit the configuration file using the `nano` editor:

     ```
     $ sudo nano /etc/sysctl.conf
     ```

     Add the following parameters to the configuration:

     ```
     net.ipv4.ip_forward = 1
     net.ipv4.conf.all.accept_redirects = 1
     net.ipv4.conf.all.send_redirects = 1
     ```

  1. Apply the configuration changes and restart the network service:

     ```
     $ sudo sysctl -p /etc/sysctl.conf
     $ sudo systemctl restart systemd-networkd
     ```

  1. Set up address translation rules.

     1. Update the repositories and install the `iptables-persistent` and `netfilter-persistent` packages:

        ```
        $ sudo apt-get update
        $ sudo apt install iptables-persistent netfilter-persistent 
        ```

     1. Start the installed services:

        ```
        $ sudo systemctl start netfilter-persistent 
        $ sudo systemctl enable netfilter-persistent
        ```

     1. Enable the NAT:

        ```
        $ sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
        ```

     1. Save the `netfilter` configuration:

        ```
        $ sudo netfilter-persistent save
        ```

  1. Specify the internal IP address when creating the {{ k8s }} cluster.
      - Management console: On the {{ k8s }} cluster creation page under **Network settings**, specify the internal IP address in the **Gateway address** field.
      - YC CLI: Specify the address using the parameter `--default-gateway-v4-address`.

- CentOS 7

  1. Connect to the VM using its public IP address:

     ```
     $ ssh <VM's public IP>
     ```

  1. Enable routing in the **sysctl** configuration. You can edit the configuration file using the `nano` editor:

     ```
     $ sudo nano /etc/sysctl.conf
     ```

     Add the following parameters to the configuration:

     ```
     net.ipv4.ip_forward = 1
     net.ipv4.conf.all.accept_redirects = 1
     net.ipv4.conf.all.send_redirects = 1
     ```

  1. Apply the configuration changes and restart the network service:

     ```
     $ sudo sysctl -p /etc/sysctl.conf
     $ sudo systemctl restart network.service
     ```

  1. Set up address translation rules.

     1. Install the `iptables-services` package:

        ```
        $ sudo yum install -y iptables-services 
        ```

     1. Enable the NAT:

        ```
        $ sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
        ```

     1. Enable `iptables`:

        ```
        $ sudo systemctl enable iptables
        ```

     1. Save the `iptables` configuration:

        ```
        $ sudo service iptables save
        ```

  1. Specify the internal IP address when creating the {{ k8s }} cluster.
      - Management console: On the {{ k8s }} cluster creation page under **Network settings**, specify the internal IP address in the **Gateway address** field.
      - YC CLI: Specify the address using the parameter `--default-gateway-v4-address`.

{% endlist %}

