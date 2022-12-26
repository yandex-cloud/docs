{% if audience != "internal" %}

* From {{ yandex-cloud }} VM instances hosted in the same [virtual network](../../vpc/concepts/network.md).

{% else %}

* From {{ yandex-cloud }} VM instances hosted in the same virtual network.

{% endif %}

* Over the Internet if you have public cluster access configured.

If you have set up public cluster access, only SSL connections are permitted. Otherwise, SSL is optional.

Without an SSL connection, internal cloud network traffic is not encrypted.
