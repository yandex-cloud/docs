### No public IP address is assigned in managed databases {#db-ip}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | network.db-ip ||
|#

#### Description

Managed databases in Yandex Cloud can be created with a public IP — a host that is reachable directly from the internet. With a public IP, the database listens for connections from any address; only its security group and the database's authentication stand between an attacker and the data.

For most workloads, application servers and the database run inside the same cloud network and a public IP on the database is unnecessary. Public IPs are appropriate only when the database really has to be reached from outside Yandex Cloud, and even then access should be tightly restricted at the network level.

**Risks if the rule is not followed:** A database with a public IP is exposed to automated scanning, brute-force attacks against database credentials, and exploitation of database engine vulnerabilities. Even with a strong password, a zero-day or a misconfigured security group can give an attacker direct access to all data stored in the database.

#### Instructions and solutions

For each managed database with a public IP:

* If external access is not required, [remove the public IP](https://yandex.cloud/en/docs/vpc/operations/address-delete) so that the database is reachable only from the cloud network.
* If external access is required, attach a [security group](https://yandex.cloud/en/docs/vpc/concepts/security-groups) that allows traffic only from a small list of trusted IP ranges and only on the database port.
* Make sure the database uses TLS for client connections and that authentication uses strong passwords or, where supported, certificates.
