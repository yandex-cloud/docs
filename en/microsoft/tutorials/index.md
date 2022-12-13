# Practical guidelines

{% if product == "cloud-il" %}

* [Deploying Active Directory](active-directory.md)
{% if audience == "draft" %}
* [Deploying Microsoft Exchange](exchange.md)
* [Deploying Remote Desktop Services](rds.md)
* [Deploying an Always On availability group with an internal network load balancer](mssql-alwayson-lb.md)
{% endif %}
* [Setting up Remote Desktop Gateway](rds-gw.md)
{% if audience == "draft" %}
* [Upgrading Windows Server to Datacenter edition](edition-update-datacenter.md)
{% endif %}

{% endif %}

{% if product == "yandex-cloud" %}

* [Preparing your own images with Microsoft products](../prepare-image.md)
* [Using personal licenses for Microsoft products](../byol.md)

{% endif %}
