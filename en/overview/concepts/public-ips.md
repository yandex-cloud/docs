# Public IP address ranges in {{ yandex-cloud }}

{% include [ip-intro](../../_includes/public-ip/ip-intro.md) %}


## IP addresses of {{ yandex-cloud }} resources available to customers {#yandex-resource-ips}

### {{ vpc-name }}


{% include [vpc-ip-ru](../../_includes/public-ip/ru/vpc-ipv4.md) %}



For example, the resources assigned such IP address ranges are:

* {{ compute-name }} VMs
* DB hosts
* NAT instances
* {{ network-load-balancer-name }} and {{ alb-name }} load balancers



### {{ baremetal-name }}

{% include [baremetal-ip-ru](../../_includes/public-ip/ru/baremetal.md) %}


### {{ cdn-name }}

{% include [cdn-ip-ru](../../_includes/public-ip/ru/cdn.md) %}


### {{ captcha-name }} {#smartcaptcha-ips}

{% include [smartcaptcha-ip-list](../../_includes/smartcaptcha-ips.md) %}

These IP addresses cannot be assigned to user resources. They serve to ensure an API request sent to `/validate` works correctly.



## IP addresses used by {{ yandex-cloud }} for its services {#yandex-cloud-ips}

The following IP address ranges are assigned to the resources that support {{ yandex-cloud }} operation:


{% include [yc-ip-ru](../../_includes/public-ip/ru/vpc-ipv6.md) %}



These IP address ranges are not available to users.


#### See also {#see-also}

* [{#T}](../../smartcaptcha/concepts/ips.md)
* [IP address ranges used by Yandex]({{ link-yandex }}/ips)