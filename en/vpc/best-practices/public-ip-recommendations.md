# Recommendations for using public IP addresses

[Public IPv4 addresses](../concepts/address.md#public-addresses) are a limited resource that becomes more and more expensive. However, the use of public IPv4 addresses is often not required and may even make your infrastructure vulnerable in some cases. {{ yandex-cloud }} provides services and [VM images](../../compute/concepts/image.md) that allow you to minimize the use of public IPv4 addresses and build a more cost-effective and stable infrastructure.

#### Use a NAT gateway {#use-nat}

If your cloud resources need to exchange data with the internet and other external resources (e.g., to download updates, packages, and code from public repositories), we recommend using [NAT gateways](../operations/create-nat-gateway.md). They allow you to manage access to external resources via a shared pool of [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) [IP addresses](../concepts/address.md).

#### Set up routing through a NAT instance {#nat-instance-routing}

To enable access to the internet from specific IP addresses, [use a dedicated NAT instance](../../tutorials/routing/nat-instance/index.md) and register its address as static. This is suitable, for example, for setting up access policies or firewalls when interacting with partner companies. This way your VMs can use a shared internet access point via a fixed IP address as part of the access [network](../../vpc/concepts/network.md#network).

This model also enables secure access to [{{ objstorage-full-name }}](../../storage/) without accessing the internet. To do this, set up an [access policy](../../storage/concepts/policy.md) for a [bucket](../../storage/concepts/bucket.md) by only adding your NAT instance's fixed IP address to the white list (see [these sample settings](https://github.com/alex-vlasov-l1/nat-insatnce-terraform-example)).

#### Use load balancers {#use-load-balancer}

To publish your applications, use [{{ network-load-balancer-full-name }}](../../network-load-balancer/) and [{{ alb-full-name }}](../../application-load-balancer/) load balancers or a service like `LoadBalancer` in [{{ managed-k8s-full-name }}](../../managed-kubernetes/operations/create-load-balancer.md). They allow you to publish services on a shared IP address using different ports or path-based and SNI routing.

#### Publish static files using {{ objstorage-name }} and {{ cdn-name }} {#publishing-static-files}

To publish static files, use [{{ objstorage-name }}](../../storage/) in combination with [{{ cdn-full-name }}](../../cdn/). This will save your VMs' computing resources and boost their cost-effectiveness. {{ cdn-full-name }} also speeds up content delivery to users and makes your services more reliable.

For more information, see the following:
* [{#T}](../../storage/operations/hosting/setup.md).
* [{#T}](../../tutorials/web/blue-green-canary-deployment.md).

#### Use a site-to-site VPN {#site-to-site}

To set up networking between various sites and external clouds, use a site-to-site VPN. This will protect your applications against unauthorized access and prevent outside access. This also allows you to save on public IP addresses: you will only need a single public IP address for a VPN connection.

For more information, see the following:
* [{#T}](../../tutorials/routing/ipsec/index.md).
* [Setting up a VPN with the Azure cloud](https://github.com/yandex-cloud/yc-solution-library-for-azure/tree/main/Yandex-Azure%20VPN).
* [Setting up a VPN with the AWS cloud](https://github.com/yandex-cloud/yc-solution-library-for-aws/tree/main/VPN/modules/vpn).


#### Use {{ interconnect-full-name }} {#cic}

Connect your local network and cloud infrastructures using [{{ interconnect-name }}](../../interconnect/index.yaml). This allows you to avoid using public IP addresses both in your network and in {{ yandex-cloud }}. Instead, you can use [internal IP addresses](../concepts/address.md#internal-addresses) from a custom range of [subnets](../../vpc/concepts/network.md#subnet).

For more information, see the following:
* [Traffic routing with {{ interconnect-name }}](../../cloud-router/concepts/routing-instance.md).

#### Connect to VMs using the serial console {#serial-console}

If you only need SSH access to a VM, use the [serial console](../../compute/operations/index.md#serial-console) instead of a public IP connection. We recommend disabling connections via the serial console when you do not use it.
