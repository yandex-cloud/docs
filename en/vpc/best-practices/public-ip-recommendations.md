# Recommendations for using public IP addresses

Public IPv4 addresses are a limited resource that continues to increase in price. However, the use of public IPv4 addresses is often not required and may even make your infrastructure vulnerable in some cases. {{ yandex-cloud }} provides a set of services and virtual machine images that let you minimize the use of public IPv4 addresses and build a more cost-efficient and stable infrastructure.

#### Enable egress NAT {#use-nat}

If your cloud resources need to exchange data with the internet and other external resources (for instance, to download updates, packages, and code from public repositories), we recommend using the [Egress NAT](../operations/enable-nat.md) option. It lets you manage access to external resources via a shared pool of cloud addresses.

#### Set up routing through a NAT instance {#nat-instance-routing}

To enable access to the internet from specific addresses, [use a dedicated NAT instance](../../tutorials/routing/nat-instance.md) and register its address as static. This is suitable, for example, for setting up access policies or firewalls when interacting with partner companies. This way your VMs can use a shared internet access point via a fixed address as part of the access network.

This model also lets you enable secure access to [{{ objstorage-short-name }}](../../storage/) without accessing the internet. To do this, set up an [access policy](../../storage/concepts/policy.md) for a [bucket](../../storage/concepts/bucket.md) by only adding your NAT instance's fixed IP address to the white list (see [sample settings](https://github.com/alex-vlasov-l1/nat-insatnce-terraform-example)).

#### Use load balancers {#use-load-balancer}

To publish your applications, use [{{ network-load-balancer-name }}](../../network-load-balancer/) and [{{ alb-name }}](../../application-load-balancer/) load balancers or a service like `LoadBalancer` in [{{ managed-k8s-name }}](../../managed-kubernetes/operations/create-load-balancer.md). They let you publish services on a shared IP address using different ports or path-based and SNI routing.

#### Publish static files using {{ objstorage-short-name }} and {{ cdn-short-name }} {#publishing-static-files}

To publish static files, use [{{ objstorage-short-name }}](../../storage/) along with [{{ cdn-short-name }}](../../cdn/). This way you'll save the computing resources of your VMs and make their usage more cost-efficient. You can also use a CDN to speed up content delivery to users and make your services more reliable.

Read more:

* [{#T}](../../storage/operations/hosting/setup.md).
* [{#T}](../../cdn/tutorials/blue-green-canary-deployment.md).

#### Use a site-to-site VPN {#site-to-site}

To set up networking between various sites and external clouds, use a site-to-site VPN. This way you'll protect your applications against unauthorized access and make sure they can't be accessed from outside. This also lets you save on using public IP addresses: you'll only need a single public IP for a VPN connection.

Read more:

* [{#T}](../../tutorials/routing/ipsec-vpn.md).
* [Setting up a VPN with the Azure cloud](https://github.com/yandex-cloud/yc-solution-library-for-azure/tree/main/Yandex-Azure%20VPN).
* [Setting up a VPN with the AWS cloud](https://github.com/yandex-cloud/yc-solution-library-for-aws/tree/main/VPN/modules/vpn).



#### Use {{ interconnect-name }} {#cic}

Connect your local network and cloud infrastructures using {{ interconnect-name }}. This lets you avoid using public IPs on the side of both your network and {{ yandex-cloud }}. Instead, you can use internal IP addresses from a custom range of subnets.

Read more:

* [{#T}](../../interconnect/manual.md).
* [Traffic routing with {{ interconnect-name }}](../../interconnect/concepts/routing.md).



#### Connect to VMs using the serial console {#serial-console}

If you only need SSH access to a VM, use the [serial console](../../compute/operations/index.md#serial-console) instead of a public IP connection. We recommend disabling connections via the serial console when you don't use it.