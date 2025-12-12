## TLS parameters {#tls}

{{ mtr-name }} will use the specified certificates to connect to user database installations. For managed databases, the TLS certificate is added to the connection settings automatically.

## TLS for PG and CH {#tls-pg-ch}

{% note info %}
           
If you are configuring TLS for the {{ CH }}, {{ PG }}, or {{ MY }} connectors, [create a connection](../../metadata-hub/operations/create-connection.md#on-premise-connection) to the custom installation in {{ connection-manager-name }} and enable TLS in the settings.
           
{% endnote %}

## List of certificates {#cert-list}

Provide one or more custom certificates in PEM format:
* Self-signed certificate.
* Certificate issued by a third-party certification authority with a chain of intermediate certificates.
