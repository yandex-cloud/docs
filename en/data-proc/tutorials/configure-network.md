# Configuring networks for {{ dataproc-name }}

According to the [network concept](../../vpc/concepts/network.md) in {{ yandex-cloud }}, hosts without public IP addresses in {{ dataproc-name }} clusters can't access resources outside of the {{vpc-short-name}} virtual network. To interact with nodes from other networks, {{ yandex-cloud }} service interfaces, and internet nodes, you need to set up a public IP address for the host or use egress NAT for the subnet.

## Egress NAT {#nat}

The ability to set up egress NAT for {{ vpc-short-name }} subnets is at the Preview stage. If this feature isn't available to you for now, the management console lets you fill out a request to access it.

To enable egress NAT for a subnet:

1. Log in to [management console]({{ link-console-main }}).
1. Select {{ vpc-short-name }} in the proper folder.
1. Click on the line of the subnet you need.
1. Click ![options](../../_assets/options.svg) in the subnet line and select **Enable egress NAT**.

## Using a NAT instance and static routes {#nat-routing-tables}

When using a NAT instance, all traffic passes through an additional VM (the NAT instance):

* You can monitor all outbound traffic, and when necessary, you can also deploy a [VPN between the {{ yandex-cloud }} subnet and the resources you need](../../tutorials/routing/ipsec-vpn.md).
* This creates additional expenses on the NAT instance and the bandwidth limit on a single VM port can become substantial.

To use a NAT configuration, you need two virtual subnets: one subnet hosts the {{ dataproc-name }} clusters and the second hosts the VM with the public IP address.

Examples of subnets:

- `dataproc-net` — Subnet hosting the {{ dataproc-name }} clusters with CIDR `192.168.1.0/24`.
- `dataproc-nat-net` — Subnet for the NAT instance with CIDR `192.168.100.0/24`.

To get access from the `dataproc-net` subnet to the external resources:

1. In the `dataproc-nat-net` network, create a virtual machine based on the [NAT instance](/marketplace/products/yc/nat-instance-ubuntu-18-04-lts) image from the **{{ marketplace-name }}** with a public IP address.

2. Copy the internal IP address of this VM.

2. On the subnet network page, create a routing table named `nat`.

3. Add a static route to the routing table:
   * **Destination prefix** — `0.0.0.0/0`
   * **Next hop** — Internal IP address of the NAT instance.

4. On the network page, link the `nat` routing table to the `dataproc-net` subnet.

5. Enable routing on the NAT instance by adding the following lines to the file `/etc/sysctl.conf`:

   ```(ini)
   net.ipv4.ip_forward = 1
   net.ipv4.conf.all.accept_redirects = 1
   net.ipv4.conf.all.send_redirects = 1
   ```

1. To enable execution of `/etc/rc.local` on boot, use the commands:

   ```bash
   sudo systemctl enable rc-local
   sudo touch /etc/rc.local
   sudo chmod 755 /etc/rc.local
   ```

1. Add the following code to the end of `/etc/rc.local`:

   ```bash
   #!/bin/sh
   
   iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
   ```

1. Restart the VM:

   ```bash
   sudo reboot -f
   ```

To check whether you configured NAT correctly, run the following command on the NAT instance:

```bash
curl ifconfig.co
```

If the configuration is correct, the command outputs the public IP address of the NAT instance.

