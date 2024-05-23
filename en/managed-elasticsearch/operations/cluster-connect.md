---
title: "Connecting to an {{ ES }} cluster"
description: "You can connect to {{ ES }} cluster hosts with the Data Node role from the internet if you set up public access to the desired host and from {{ yandex-cloud }} VMs located in the same virtual network."
keywords:
  - connecting Elasticsearch clusters
  - Elasticsearch cluster
  - Elasticsearch
---

# Connecting to an {{ ES }} cluster

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

You can connect to the hosts in the {{ mes-name }} cluster with the [_Data node_ role](../concepts/hosts-roles.md#data-node):

* Over the internet, if you configured public access for the appropriate host.


* From {{ yandex-cloud }} VM instances hosted in the same [virtual network](../../vpc/concepts/network.md).


Regardless of the connection method, {{ mes-name }} only supports cluster host connections with an [SSL certificate](#get-ssl-cert).


## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Rule settings depend on the connection method you select:

{% list tabs group=connection_method %}

- Over the internet {#internet}

   [Configure all the cluster security groups](../../vpc/operations/security-group-add-rule.md) to allow incoming traffic from any IP on ports 443 (Kibana GUI and Kibana API) and 9200 ({{ ES }}). To do this, create the following rules for incoming traffic:

   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `443`, `9200`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

   A separate rule is created for each port.

- From a VM in {{ yandex-cloud }} {#cloud}

   1. [Configure all the security groups](../../vpc/operations/security-group-add-rule.md) of your cluster to allow incoming traffic on ports 443 (Kibana GUI and Kibana API) and 9200 ({{ ES }}) from the security group where your VM is located. To do this, create the following rules for incoming traffic in these security groups:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `443`, `9200`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: If your cluster and VM are in the same security group, select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`) as the value. Otherwise, specify the VM security group.

      A separate rule is created for each port.

   1. [Configure all security groups](../../vpc/operations/security-group-add-rule.md) where your VM is located to allow connections to the VM and traffic between the VM and the cluster hosts.

      For example, you can set the following rules for a VM:

      * For incoming traffic:

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `22`, `443`, `9200`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

         A separate rule is created for each port.

      * For outgoing traffic:

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`)
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

         This rule allows all outgoing traffic, which enables you not only to connect to the cluster but also to install the certificates and utilities your VM needs for the connection.

{% endlist %}

{% note info %}

You can specify more detailed rules for your security groups, e.g., to allow traffic only in specific subnets.

You must configure security groups correctly for all subnets in which the cluster hosts will reside. If security group settings are incomplete or incorrect, you may lose access to the cluster.

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).


## Getting an SSL certificate {#get-ssl-cert}

To use an encrypted connection, get an SSL certificate:

{% include [install-certificate](../../_includes/mdb/mes/install-certificate.md) %}

## {{ ES }} host FQDN {#fqdn}

To connect to a host, you need its fully qualified domain name ([FQDN](../concepts/network.md#hostname)). You can obtain it in one of the following ways:

* [Request a list of cluster hosts](cluster-hosts.md#list-hosts).
* In the [management console]({{ link-console-main }}), copy the command for connecting to the cluster. This command contains the host FQDN. To get the command, go to the cluster page and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-connect }}**.
* Look up the FQDN in the management console:

   1. Go to the cluster page.
   1. Go to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
   1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.

Cluster hosts also use [special FQDNs](#automatic-host-selection).

## Automatically selecting a host for connection {#automatic-host-selection}

When connecting to an {{ ES }} cluster, you can:

* In the connection strings, explicitly specify the names of the hosts with the _Data node_ role.

   This approach is suitable for any connection method. For example, you can use it to connect over the internet if public access is only enabled for certain hosts.

* Use a special FQDN, such as `c-<{{ ES }}_cluster_ID>.rw.{{ dns-zone }}` (e.g., `https://c-e4ut2....rw.{{ dns-zone }}`). The host to connect to is selected randomly among all the hosts with the _Data node_ role.

   Use this approach only if you have enabled public access for all hosts with the _Data node_ role, or if you are connecting exclusively from {{ yandex-cloud }} instances.

## Before you connect from a Docker container {#connection-docker}

To connect to a {{ mes-name }} cluster from a Docker container, add the following lines to the Dockerfile:

{% list tabs group=connection %}


- Connecting without SSL {#without-ssl}

   ```bash
   RUN apt-get update && \
       apt-get install curl --yes
   ```


- Connecting via SSL {#with-ssl}

   ```bash
   RUN apt-get update && \
       apt-get install wget curl --yes && \
       mkdir --parents ~/.elasticsearch && \
       wget "{{ crt-web-path }}" \
            --output-document ~/.elasticsearch/root.crt && \
       chmod 0600 ~/.elasticsearch/root.crt
   ```

{% endlist %}

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mes-conn-strings-env.md) %}

Before connecting, [prepare a certificate](#get-ssl-cert).

To connect, enter the username and password used when [creating a cluster](cluster-create.md#create-cluster).

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mes-connection-strings](../../_includes/mdb/mes-conn-strings.md) %}

If the connection is successful, general information about the {{ ES }} cluster will be displayed.
