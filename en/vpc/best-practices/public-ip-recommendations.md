# Recommendations for using public IP addresses

[Public IPv4 addresses](../concepts/address.md#public-addresses) are a limited resource with constantly increasing prices. However, the use of public IPv4 addresses is often not required and may even make your infrastructure vulnerable in some cases. {{ yandex-cloud }} provides services and [VM images](../../compute/concepts/image.md) that allow you to minimize the use of public IPv4 addresses and build a more cost-effective and stable infrastructure.

#### Use a NAT gateway {#use-nat}

If your cloud resources need to exchange data with the internet and other external resources (for instance, to download updates, packages, and code from public repositories), we recommend using [NAT gateways](../operations/create-nat-gateway.md). They allow you to manage access to external resources via a shared pool of [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) [IP addresses](../concepts/address.md).

#### Set up routing through a NAT instance {#nat-instance-routing}

To enable access to the internet from specific IP addresses, [use a dedicated NAT instance](../../tutorials/routing/nat-instance.md) and register its address as static. This is suitable, for example, for setting up access policies or firewalls when interacting with partner companies. This way your VMs can use a shared internet access point via a fixed IP address as part of the access [network](../../vpc/concepts/network.md#network).

This model also lets you enable secure access to [{{ objstorage-full-name }}](../../storage/) without accessing the internet. To do this, set up an [access policy](../../storage/concepts/policy.md) for a [bucket](../../storage/concepts/bucket.md) by only adding your NAT instance's fixed IP address to the white list (see [sample settings](https://github.com/alex-vlasov-l1/nat-insatnce-terraform-example)).

#### Use load balancers {#use-load-balancer}

To publish your applications, use [{{ network-load-balancer-full-name }}](../../network-load-balancer/) and [{{ alb-full-name }}](../../application-load-balancer/) load balancers or a service like `LoadBalancer` in [{{ managed-k8s-full-name }}](../../managed-kubernetes/operations/create-load-balancer.md). They allow you to publish services on a shared IP address using different ports or path-based and SNI routing.

#### Publish static files using {{ objstorage-name }} and {{ cdn-name }} {#publishing-static-files}

To publish static files, use [{{ objstorage-name }}](../../storage/) along with [{{ cdn-full-name }}](../../cdn/). This will save the computing resources of your VMs and make their usage more cost-effective. You can also use a {{ cdn-full-name }} to speed up content delivery to users and make your services more reliable.

Read more:
* [{#T}](../../storage/operations/hosting/setup.md).


* [{#T}](../../cdn/tutorials/blue-green-canary-deployment.md).


#### Use a site-to-site VPN {#site-to-site}

To set up networking between various sites and external clouds, use a site-to-site VPN. This will protect your applications against unauthorized access and make sure they cannot be accessed from outside. This also allows you to save on public IP addresses: you will only need a single public IP for a VPN connection.

Read more:
* [{#T}](../../tutorials/routing/ipsec/index.md).
* [Setting up a VPN with the Azure cloud](https://github.com/yandex-cloud/yc-solution-library-for-azure/tree/main/Yandex-Azure%20VPN).
* [Setting up a VPN with the AWS cloud](https://github.com/yandex-cloud/yc-solution-library-for-aws/tree/main/VPN/modules/vpn).


#### Use {{ interconnect-full-name }} {#cic}

Connect your local network and cloud infrastructures using [{{ interconnect-name }}](../../interconnect/index.yaml). This allows you to avoid using public IPs both in your network and in {{ yandex-cloud }}. Instead, you can use [internal IP addresses](../concepts/address.md#internal-addresses) from a custom range of [subnets](../../vpc/concepts/network.md#subnet).

Read more:
* [Traffic routing with {{ interconnect-name }}](../../interconnect/concepts/routing.md).


#### Connect to VMs using the serial console {#serial-console}

If you only need SSH access to a VM, use the [serial console](../../compute/operations/index.md#serial-console) instead of a public IP connection. We recommend disabling connections via the serial console when you do not use it.