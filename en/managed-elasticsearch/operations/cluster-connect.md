---
title: "Connecting to an Elasticsearch cluster"
description: "You can connect to Elasticsearch cluster hosts with the Data Node role from the internet if you set up public access to the desired host and from Yandex Cloud VMs located in the same virtual network."
keywords:
  - connecting Elasticsearch clusters
  - Elasticsearch cluster
  - Elasticsearch
---

# Connecting to an {{ ES }} cluster

You can connect to the hosts in the {{ mes-name }} cluster with the [_Data node_ role](../concepts/hosts-roles.md#data-node):

* Over the internet, if you configured public access for the appropriate host.


* From {{ yandex-cloud }} VM instances hosted in the same [virtual network](../../vpc/concepts/network.md).


Regardless of the connection method, {{ mes-name }} only supports cluster host connections with an [SSL certificate](#get-ssl-cert).


## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Settings of rules depend on the connection method you select:

{% list tabs %}

- Over the internet

   [Configure all the cluster security groups](../../vpc/operations/security-group-add-rule.md) to allow incoming traffic from any IP on ports 443 (Kibana GUI and Kibana API) and 9200 ({{ ES }}). To do this, create the following rules for incoming traffic:

   * Port range: `443`, `9200`.
   * Protocol: `TCP`.
   * Source: `CIDR`.
   * CIDR blocks: `0.0.0.0/0`.

   A separate rule is created for each port.

- With a VM in Yandex.Cloud

   1. [Configure all the security groups](../../vpc/operations/security-group-add-rule.md) of your cluster to allow incoming traffic on ports 443 (Kibana GUI and Kibana API) and 9200 ({{ ES }}) from the security group where your VM is located. To do this, create the following rules for incoming traffic in these security groups:

      * Protocol: `TCP`.
      * Port range: `443`, `9200`.
      * Source: `Security group`.
      * Security group: If a cluster and a VM are in the same security group, select `Self` (`Self`) as the value. Otherwise, specify the VM security group.

      A separate rule is created for each port.

   1. [Configure all security groups](../../vpc/operations/security-group-add-rule.md) where your VM is located to allow connections to the VM and traffic between the VM and the cluster hosts.

      Example of rules for a VM:

      * For incoming traffic:

         * Port range: `22`, `443`, and `9200`.
         * Protocol: `TCP`.
         * Source: `CIDR`.
         * CIDR blocks: `0.0.0.0/0`.

         A separate rule is created for each port.

      * For outgoing traffic:

         * Port range: `{{ port-any }}`.
         * Protocol: `Any`.
         * Source type: `CIDR`.
         * CIDR blocks: `0.0.0.0/0`.

         This rule allows all outgoing traffic, which lets you both connect to the cluster and install the certificates and utilities that the VMs need to connect to the cluster.

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If the security group settings are incomplete or incorrect, you might lose access the cluster.

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).


## Getting an SSL certificate {#get-ssl-cert}

To use an encrypted connection, get an SSL certificate:

{% list tabs %}

- Linux (Bash)

   {% include [install-certificate](../../_includes/mdb/mes/install-certificate.md) %}

   The certificate will be saved in the `$HOME/.elasticsearch/root.crt` folder.

- Windows (PowerShell)

   
   ```powershell
   mkdir $HOME\.elasticsearch; curl -o $HOME\.elasticsearch\root.crt https://{{ s3-storage-host }}{{ pem-path }}
   ```


   The certificate will be saved in the `$HOME\.elasticsearch\root.crt` folder.

{% endlist %}

## Automatic selecting the host to connect to {#automatic-host-selection}

When connecting to an {{ ES }} cluster, you can:

* In the connection strings, explicitly specify the names of the hosts with the _Data node_ role.

   This approach is suitable for any connection method. For example, you can use it to connect over the internet if only a few hosts are assigned a public IP address.

* Use a special FQDN in the format `c-<{{ ES }} cluster ID>.rw.{{ dns-zone }}` (such as, `https://c-e4ut2....rw.{{ dns-zone }}`).

   This approach is only suitable if all of the hosts with the _Data node_ role have a public IP address or connections are only made from {{ yandex-cloud }} virtual machines. This is because the host for the connection, which this FQDN is pointing to, is selected randomly from all the hosts with the _Data node_ role.

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mes-conn-strings-env.md) %}

Before connecting, [prepare a certificate](#get-ssl-cert).

To connect, enter the username and password used when [creating a cluster](cluster-create.md#create-cluster).

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mes-connection-strings](../../_includes/mdb/mes-conn-strings.md) %}

If the connection is successful, general information about the {{ ES }} cluster will be displayed.
