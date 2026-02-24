### No public IP address is assigned in managed databases {#db-security-group}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | network.db-security-group ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for public IP address assignment on managed database clusters.

{% endnote %}

Assigning a public IP to a managed database raises information security risks. We do not recommend assigning an external IP unless it is absolutely necessary.

Remove public access if it is not required.

#### Guides and solutions

* It is recommended to delete the IP address linked to the database: <https://yandex.cloud/en/docs/vpc/operations/address-delete>