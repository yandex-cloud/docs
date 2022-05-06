{% note warning %}

To connect using encryption, [create a cluster](../../../../managed-redis/operations/cluster-create.md) with {{ RD }} version 6 or higher and enabled **TLS support**.

{{ RD }} version 6.0 or lower returns the host's IP instead of its FQDN. Because of this, when connecting to a cluster with SSL, hostname verification for the certificate fails and the connection isn't established. That's why this check is disabled in the connection string examples.

{% endnote %}
