### A security group is assigned in managed databases {#db-security-group}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | network.db-security-group ||
|#

#### Description

A managed database in Yandex Cloud can be created without a [security group](https://yandex.cloud/en/docs/vpc/concepts/security-groups). Without one, network access to the database depends on the network's default security group, which usually allows all traffic — anything in the cloud network (and, with a public IP, anything on the internet) can reach the database port.

Even with strong authentication in the database itself, an unrestricted network surface exposes the database to scans, brute-force attacks, and exploitation of any future vulnerability. A security group narrows this surface to a known list of clients.

**Risks if the rule is not followed:** Without a security group, the database port is reachable from any resource in the cloud network and potentially from the internet. This broad exposure makes the database a target for automated attacks and significantly increases the risk of unauthorized access, data exfiltration, or data destruction.

#### Instructions and solutions

Attach a security group to every managed database:

1. [Create a security group](https://yandex.cloud/en/docs/vpc/operations/security-group-create) that allows traffic only from the IP ranges or other security groups that need to connect to the database (typically: application Pods or VMs, BI tools, administrative bastion).
2. Attach the group to the database — for an existing cluster, edit network settings; for a new cluster, set it at creation.
3. Make sure the rule covers only the database port (for example, `5432` for PostgreSQL, `3306` for MySQL) and the right protocol.

For databases with PCI DSS or personal data, additionally restrict access to the IP ranges of trusted networks only — do not leave the database reachable from the internet.
