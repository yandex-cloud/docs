### No public IP address is assigned in managed databases {#db-ip}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | network.db-ip ||
|#

#### Description

Assigning a public IP to a managed database raises information security risks. We do not recommend assigning an external IP unless it is absolutely necessary.

#### Instructions and solutions

It is recommended to [delete](https://yandex.cloud/ru/docs/vpc/operations/address-delete) the IP address linked to the database
