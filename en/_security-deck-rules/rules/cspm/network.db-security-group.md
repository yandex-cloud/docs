### A security group is assigned in managed databases {#db-security-group}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | network.db-security-group ||
|#

#### Description

We recommend prohibiting internet access to databases that contain critical data, in particular PCI DSS data or private data. Configure security groups to only allow connections to the DBMS from particular IP addresses. To do this, follow the steps in [Creating a security group](https://yandex.cloud/en/docs/vpc/operations/security-group-create). You can specify a security group in the cluster settings or when creating the cluster in the network settings section.

#### Instructions and solutions

It is recommended to [set up](https://yandex.cloud/en/docs/vpc/concepts/security-groups) a security group for the database cluster
