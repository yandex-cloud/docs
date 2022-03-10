---
title: Connecting to an Elasticsearch cluster
description: 'You can connect to Elasticsearch cluster hosts with the Data node role over the Internet if you have configured public access for the required host. From Yandex Cloud virtual machines located in the same virtual network.'
keywords:
  - connecting the Elasticsearch cluster
  - Elasticsearch cluster
  - Elasticsearch
---

# Connecting to a cluster

You can connect to {{ mes-name }} cluster hosts with the [_Data node_](../concepts/hosts-roles.md#data-node) role:

- Over the internet, if you configured public access for the appropriate host.
- From {{ yandex-cloud }} VM instances hosted in the same [virtual network](../../vpc/concepts/network.md).

Regardless of the connection method, {{ mes-name }} only supports connections to cluster hosts with an [SSL certificate](#get-ssl-cert).

## Configuring security groups {#configuring-security-groups}

[Security groups](../../vpc/concepts/security-groups.md) might prevent connection to the cluster. If this is the case, make changes to the group rules.

Settings of rules depend on the connection method you select:

{% list tabs %}

- Over the internet

    [Configure all the security groups](../../vpc/operations/security-group-update.md#add-rule) of the cluster to allow incoming traffic on ports 443 (Kibana) and 9200 ({{ ES }}) from any IP address. To do this, create the following rules for incoming traffic:
    - Protocol: `TCP`.
    - Port range: `443`, `9200`.
    - Source type: `CIDR`.
    - Source: `0.0.0.0/0`.

    A separate rule is created for each port.

- With a VM in {{ yandex-cloud }}

    1. [Configure all the security groups](../../vpc/operations/security-group-update.md#add-rule) of the cluster to allow incoming traffic on ports 443 (Kibana) and 9200 ({{ ES }}) from the security group assigned to the VM. To do this, create the following rules for incoming traffic in these security groups:
        - Protocol: `TCP`.
        - Port range: `443`, `9200`.
        - Source type: `Security group`.
        - Source: Security group assigned to the VM. If it is the same as the configured group, specify **Current**.

        A separate rule is created for each port.

    1. [Configure all the security groups](../../vpc/operations/security-group-update.md#add-rule) assigned to the VM to allow connections to the VM and traffic between the VM and the cluster hosts.

        Example of rules for a VM:

        - For incoming traffic:
            - Protocol: `TCP`.
            - Port range: `22`, `443`, `9200`.
            - Source type: `CIDR`.
            - Source: `0.0.0.0/0`.

            A separate rule is created for each port.

        - For outgoing traffic:
            - Protocol: `Any`.
            - Port range: `0-65535`.
            - Destination type: `CIDR`.
            - Destination: `0.0.0.0/0`.

            This rule allows any outgoing traffic: this lets you both connect to the cluster and install certificates and utilities you might need to connect to the cluster.

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, such as to allow traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If the security group settings are incomplete or incorrect, you might lose access the cluster.

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).

## Getting an SSL certificate {#get-ssl-cert}

To use an encrypted connection, get an SSL certificate:

{% list tabs %}

- Linux (Bash)

  {% if audience == "internal" %}

  ```bash
  mkdir ~/.elasticsearch && \
  wget "https://crls.yandex.net/allCAs.pem" -O ~/.elasticsearch/root.crt && \
  chmod 0600 ~/.elasticsearch/root.crt
  ```

  {% else %}

  ```bash
  mkdir ~/.elasticsearch && \
  wget  "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.elasticsearch/root.crt && \
  chmod 0600 ~/.elasticsearch/root.crt
  ```

  {% endif %}

  The certificate will be saved in the `$HOME/.elasticsearch/root.crt` folder.

- Windows (PowerShell)

  {% if audience == "internal" %}

  ```powershell
  mkdir $HOME\.elasticsearch; curl -o $HOME\.elasticsearch\root.crt https://crls.yandex.net/allCAs.pem
  ```

  {% else %}

  ```powershell
  mkdir $HOME\.elasticsearch; curl -o $HOME\.elasticsearch\root.crt https://{{ s3-storage-host }}{{ pem-path }}
  ```

  {% endif %}

  The certificate will be saved in the `$HOME\.elasticsearch\root.crt` folder.

{% endlist %}

## Automatically selecting the host to connect to {#automatic-host-selection}

When connecting to an {{ ES }} cluster, you can:

- In the connection strings, explicitly specify the names of the hosts with the _Data node_ role.

  This approach is suitable for any connection method. For example, you can use it to connect over the internet if only a few hosts are assigned a public IP address.

- Use a special FQDN like: `c-<cluster ID {{ ES }}>.rw.mdb.yandexcloud.net` (for example, `https://c-e4ut2....rw.mdb.yandexcloud.net`).

  This approach is only suitable if all of the hosts with the _Data node_ role have a public IP address or connections are only made from {{ yandex-cloud }} virtual machines. This is because the host for the connection, which this FQDN is pointing to, is selected randomly from all the hosts with the _Data node_ role.

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mes-conn-strings-env.md) %}

Before connecting, [prepare your certificate](#get-ssl-cert).

To connect, enter the username and password used when [creating a cluster](cluster-create.md#create-cluster).

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mes-connection-strings](../../_includes/mdb/mes-conn-strings.md) %}

If the connection is successful, general information about the {{ ES }} cluster will be displayed.

