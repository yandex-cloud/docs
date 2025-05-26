# Configuring a network for {{ dataproc-name }}

To grant {{ dataproc-name }} cluster access to resources outside their {{ vpc-short-name }} virtual network, set up public [IP addresses](../../vpc/concepts/network.md) for them. If you do not want to use public IP addresses, you can set up egress NAT (Network Address Translation) for the subnet.

In this tutorial, you will learn how to create a {{ dataproc-name }} cluster and set up subnets and a VM (a NAT instance).

To enable egress NAT for a {{ dataproc-name }} cluster:

1. [Prepare your infrastructure](#deploy-infrastructure):
    1. [Create a network and subnet for your {{ dataproc-name }} cluster with egress NAT](#create-network).
    1. [Create the rest of the resources](#create-other-resources).
1. [Set up NAT for the {{ dataproc-name }} cluster](#setup-nat).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare the infrastructure {#deploy-infrastructure}

You have to create:

* Network.
* Subnet for your {{ dataproc-name }} cluster.
* Subnet for the NAT instance.
* Security groups and rules for the cluster and NAT instance.
* Service account for the cluster.
* Cluster.
* NAT instance.

### Create a network and subnet for your {{ dataproc-name }} cluster with egress NAT {#create-network}

1. [Create a network](../../vpc/operations/network-create.md) named `network-data-proc`.
1. In `network-data-proc`, [create a subnet](../../vpc/operations/subnet-create.md) with the following parameters:

    * **Name**: `subnet-cluster`
    * **Zone**: `{{ region-id }}-a`
    * **CIDR**: `192.168.1.0/24`
1. Save the IDs for `network-data-proc` and `subnet-cluster` as you will need them later.
1. [Set up a NAT gateway](../../vpc/operations/create-nat-gateway.md).

### Create the rest of the resources {#create-other-resources}

{% list tabs group=instructions %}

- Manually {#manual}

    1. In `network-data-proc`, [create a subnet](../../vpc/operations/subnet-create.md) with the following parameters:

        * **Name**: `subnet-nat`
        * **Zone**: `{{ region-id }}-b`
        * **CIDR**: `192.168.100.0/24`

    1. [Create and configure security groups for the {{ dataproc-name }} cluster](../../data-proc/operations/cluster-create.md#change-security-groups).

    1. [Create a security group](../../vpc/operations/security-group-create.md) for the NAT instance.

    1. In the security group for the NAT instance, [create the following rules](../../vpc/operations/security-group-add-rule.md):

        **For incoming traffic:**

        * A rule that allows all traffic from the {{ dataproc-name }} cluster's security group:

            * **Port range**: `0-65535`.
            * **Protocol**: `Any`.
            * **Source**: `Security group`.
            * **Security group**: `From list`. Select the {{ dataproc-name }} cluster security group.

        * A rule allowing an SSH connection to the NAT instance over the internet:

            * **Port range**: `22`
            * **Protocol**: `TCP`
            * **Source**: `CIDR`
            * **CIDR blocks**: `0.0.0.0/0`

        **For outgoing traffic**:

        A rule allowing all egress traffic:

        * **Port range**: `0-65535`
        * **Protocol**: `Any`
        * **Source**: `CIDR`
        * **CIDR block**: `0.0.0.0/0`

    1. [Create a service account](../../iam/operations/sa/create.md) with the following roles:

        * [dataproc.agent](../../data-proc/security/index.md#dataproc-agent)
        * [dataproc.provisioner](../../data-proc/security/index.md#dataproc-provisioner)
        * [storage.uploader](../../storage/security/index.md#storage-uploader)
        * [storage.viewer](../../storage/security/index.md#storage-viewer)

    1. [Create an {{ objstorage-full-name }} bucket](../../storage/operations/buckets/create.md) with restricted access.

    1. [Create a {{ dataproc-name }} cluster](../../data-proc/operations/cluster-create.md) of any suitable configuration with the following settings:

        * **Service account**: Select the service account you created previously.
        * **Bucket ID format**: `List`.
        * **Bucket name**: Select a previously created bucket.
        * **Network**: `network-data-proc`.
        * **Security groups**: Select the security groups you created earlier.

    1. In the network named `network-dataproc`, [create a VM](../../compute/operations/vm-create/create-linux-vm.md) based on the [NAT instance](/marketplace/products/yc/nat-instance-ubuntu-18-04-lts) image from **{{ marketplace-name }}** with a public IP address. Specify the security groups that you configured previously.

    1. Go to the NAT properties and copy the VM IP address.

    1. In the `network-data-proc` network, [create a routing table](../../vpc/operations/static-route-create.md) named `route-table-nat` and add a static route to it:

        * **Destination prefix**: `0.0.0.0/0`.
        * **Next hop**: Internal IP address of the NAT instance.

- {{ TF }} {#tf}

    1. {% include [terraform-install](../../_includes/terraform-install.md) %}
    1. Download the [file with provider settings](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
    1. [Download the cluster and the NAT instance configuration file](https://github.com/yandex-cloud-examples/yc-data-proc-configure-network/blob/main/data-proc-nat-gateway.tf) to the same working directory.

        This file describes:

        * Network.
        * Subnets.
        * Security groups.
        * {{ dataproc-name }} cluster.
        * Service account to work with cloud resources.
        * NAT instance.
        * Bucket.

    1. In the configuration file, specify all the relevant parameters.

    1. Run the `terraform init` command in the working directory with the configuration files. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.

    1. Check that the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Import the previously created network and subnet.

        {% note alert %}

        Do not use the IDs of a network and subnets created outside of this tutorial: the `terraform apply` and `terraform destroy` commands will update or destroy them, respectively.

        {% endnote %}

        Import the `network-data-proc` network:

        ```bash
        terraform import yandex_vpc_network.network-data-proc <network ID>
        ```

        Import the `subnet-cluster` subnet:

        ```bash
        terraform import yandex_vpc_subnet.subnet-cluster <subnet_ID>
        ```

    1. Create the required infrastructure:

        1. Run the command to view the planned changes:

            ```bash
            terraform plan
            ```

            If the resource configurations are correct, the terminal will display a list of the resources to modify and their parameters. This is a test step. No resources are updated.

        1. If you are happy with the planned changes, apply them:

            1. Run this command:

                ```bash
                terraform apply
                ```

            1. Confirm updating the resources.

            1. Wait for the operation to complete.

    All the resources you need will be created in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-cloud }}).

{% endlist %}

## Set up NAT for the {{ dataproc-name }} cluster {#setup-nat}

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the NAT instance over SSH.

1. To enable routing, add the following lines to the end of the `/etc/sysctl.conf` file:

    ```ini
    net.ipv4.ip_forward = 1
    net.ipv4.conf.all.accept_redirects = 1
    net.ipv4.conf.all.send_redirects = 1
    ```

1. To enable the execution of `/etc/rc.local` at OS startup, run these commands:

    ```bash
    sudo systemctl enable rc-local && \
        sudo touch /etc/rc.local && \
        sudo chmod 755 /etc/rc.local
    ```

1. Add the following code to the `/etc/rc.local` file:

    ```bash
    #!/bin/sh

    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
    ```

1. Reboot the NAT instance OS:

     ```bash
     sudo reboot -f
     ```

1. Check that NAT is configured properly. To do this, reconnect to the NAT instance over SSH and run the command:

    ```bash
    curl ifconfig.co
    ```

    If the configuration is correct, the command outputs the public IP address of the NAT instance.

## Delete the resources you created {#clear-out}

{% list tabs group=instructions %}

If you no longer need the resources you created, delete them:

- Manually {#manual}

    1. [Delete the {{ dataproc-name }} cluster](../../data-proc/operations/cluster-delete.md).
    1. [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
    1. If you reserved public static IP addresses for the clusters, release and [delete them](../../vpc/operations/address-delete.md).
    1. [Delete the subnets](../../vpc/operations/subnet-delete.md).
    1. [Delete the route table](../../vpc/operations/delete-route-table.md).
    1. [Delete the NAT gateway](../../vpc/operations/delete-nat-gateway.md).
    1. [Delete the network](../../vpc/operations/network-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
