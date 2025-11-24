---
title: Pre-configuring {{ KF }} cluster connection in {{ mkf-full-name }}
description: Follow this guide to pre-configure a connection to hosts in an {{ KF }} cluster.
---

# Pre-configuring an {{ KF }} cluster connection


You can connect to {{ mkf-name }} cluster hosts:

* Over the internet if you configured [public access](../cluster-update.md#change-sg-set) for the cluster. You can only connect to this type of cluster using an [SSL connection](#get-ssl-cert).
* From {{ yandex-cloud }} virtual machines located in the same [cloud network](../../../vpc/concepts/network.md). If the cluster is not publicly available, you do not need to use an SSL connection to connect to such VMs.

You can connect to an {{ KF }} cluster both with encryption (`SASL_SSL`, port {{ port-mkf-ssl }}) and without it (`SASL_PLAINTEXT`, port {{ port-mkf-text }}).


To connect to an {{ KF }} cluster:

1. [Create users](../cluster-accounts.md#create-account) for clients (producers and consumers) with access to the required topics.
1. Connect the clients to the cluster:
   * Producers using the [Kafka Producer API](https://kafka.apache.org/documentation/#producerapi).
   * Consumers using the [Kafka Consumer API](https://kafka.apache.org/documentation/#consumerapi).

There are ready-made {{ KF }} API implementations for most popular programming languages. To view use examples, see the [Code examples](code-examples.md) section.


## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../../_includes/mdb/sg-rules-connect.md) %}

Rule settings depend on the chosen connection method:

{% list tabs group=connection_method %}

- Over the internet {#internet}

  [Configure all cluster security groups](../../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on port {{ port-mkf-ssl }} from any IP address. To do this, create the following inbound rule:

  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mkf-ssl }}`
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

  To allow the use of [{{ mkf-name }} API](../../concepts/available-apis.md), e.g., to work with [{{ mkf-msr }}](../../concepts/managed-schema-registry.md), add a rule for incoming traffic:

  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

- From a {{ yandex-cloud }} VM {#cloud}

  1. [Configure all the cluster security groups](../../../vpc/operations/security-group-add-rule.md) to allow incoming traffic from the security group where the VM is located on ports {{ port-mkf-ssl }} and {{ port-mkf-text }}. To do this, create the following inbound rule in these groups:

     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mkf-ssl }}-{{ port-mkf-text }}`
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: If your cluster and VM are in the same security group, select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`). Otherwise, specify the VM security group.

     To allow the use of [{{ mkf-name }} API](../../concepts/available-apis.md), e.g., to work with [{{ mkf-msr }}](../../concepts/managed-schema-registry.md), add a rule for incoming traffic:

       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

  1. [Configure the VM security group](../../../vpc/operations/security-group-add-rule.md) to allow VM connections and traffic between the VM and the cluster hosts.

     For example, you can set the following rules for a VM:

     * For incoming traffic:
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

       This rule allows VM connections over SSH.

     * For outgoing traffic:
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`)
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

       This rule allows all outgoing traffic, thus enabling you not only to connect to the cluster but also to install all required certificates and tools on your VM.

{% endlist %}

{% note info %}

You can specify more granular rules for your security groups, such as allowing traffic only within specific subnets.

Make sure to configure the security groups properly for all subnets where the cluster hosts will reside. With incomplete or incorrect security group settings, you may lose access to the cluster.

{% endnote %}

For more information about security groups, see [{#T}](../../concepts/network.md#security-groups).


## Getting an SSL certificate {#get-ssl-cert}

To use an encrypted connection, get an SSL certificate:

{% include [install-certificate](../../../_includes/mdb/mkf/install-certificate.md) %}

This certificate is also used to access the [{{ mkf-short-name }} REST API](../../concepts/available-apis.md).

## Getting FQDNs of {{ KF }} hosts {#get-fqdn}

To connect to a host, you will need its [FQDN](../../concepts/network.md#hostname). Example of a {{ KF }} host FQDN:

```text
{{ host-name }}.{{ dns-zone }}
```

You can get the FQDN by doing one of the following:

* View the FQDN in the management console:

    1. Open to the cluster page.
    1. Navigate to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** value.

* In the [management console]({{ link-console-main }}), copy the cluster connection command. This command contains the broker host FQDN. To get the command, go to the cluster page and click **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.

* [Get the list of cluster hosts](../cluster-hosts.md#list-hosts) using the CLI or API.

With the [{{ mkf-short-name }} REST API](../../concepts/available-apis.md), you can send requests to any broker host: the API is available from all the cluster's broker hosts.

## What's next {#whats-next}

* [Connect](clients.md) to the cluster using command line tools.
* [Integrate](code-examples.md) the cluster connection into your application code.
