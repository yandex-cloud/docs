---
title: "Pre-configuration for connection to an {{ KF }} cluster in {{ mkf-full-name }}"
description: "Follow this guide to prepare for connection to hosts in an {{ KF }} cluster."
---

# Pre-configuration for connection to an {{ KF }} cluster

You can connect to {{ mkf-name }} cluster hosts:

* Over the internet if you configured [public access](../cluster-update.md#change-sg-set) for the cluster. You can only connect to this type of cluster using an [SSL connection](#get-ssl-cert).


* From {{ yandex-cloud }} virtual machines located in the same [cloud network](../../../vpc/concepts/network.md). If the cluster is not publicly available, you do not need to use an SSL connection to connect to such VMs.



You can connect to the {{ KF }} cluster both with encryption (`SASL_SSL`, port {{ port-mkf-ssl }}) and without it (`SASL_PLAINTEXT`, port {{ port-mkf-text }}).


To connect to an {{ KF }} cluster:

1. [Create users](../cluster-accounts.md#create-user) for clients (producers and consumers) with access to the required topics.
1. Connect the clients to the cluster:
   * Producers using the [Kafka Producer API](https://kafka.apache.org/documentation/#producerapi).
   * Consumers using the [Kafka Consumer API](https://kafka.apache.org/documentation/#consumerapi).

There are ready-made {{ KF }} API implementations for most popular programming languages. To view use examples, see the [Code examples](code-examples.md) section.


## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../../_includes/mdb/sg-rules-connect.md) %}

Rule settings depend on the connection method you select:

{% list tabs group=connection_method %}

- Over the internet {#internet}

   [Configure all security groups](../../../vpc/operations/security-group-add-rule.md) in the cluster to allow incoming traffic on port {{ port-mkf-ssl }} from any IP address. To do this, create the following rule for incoming traffic:

   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mkf-ssl }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

   To allow connections to [{{ mkf-msr }}](../../concepts/managed-schema-registry.md), add a rule for incoming traffic:

   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

- From a VM in {{ yandex-cloud }} {#cloud}

   1. [Configure all cluster security groups](../../../vpc/operations/security-group-add-rule.md) to allow incoming traffic on {{ port-mkf-ssl }} and {{ port-mkf-text }} ports from the security group covering the VM. To do this, create the following rule for incoming traffic in these groups:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mkf-ssl }}-{{ port-mkf-text }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: If your cluster and VM are in the same security group, select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`) as the value. Otherwise, specify the VM security group.

      To allow connections to [{{ mkf-msr }}](../../concepts/managed-schema-registry.md), add a rule for incoming traffic:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

   1. [Configure the security group](../../../vpc/operations/security-group-add-rule.md) where the VM is located to enable connections to the VM and traffic between the VM and the cluster hosts.

      For example, you can set the following rules for a VM:

      * For incoming traffic:
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

         This rule allows you to connect to the VM over SSH.

      * For outgoing traffic:
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`)
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

         This rule allows all outgoing traffic, which enables you not only to connect to the cluster but also to install the certificates and utilities your VM needs for the connection.

{% endlist %}

{% note info %}

You can specify more detailed rules for your security groups, e.g., to allow traffic only in specific subnets.

You must configure security groups correctly for all subnets in which the cluster hosts will reside. If security group settings are incomplete or incorrect, you may lose access to the cluster.

{% endnote %}

For more information about security groups, see [{#T}](../../concepts/network.md#security-groups).


## Getting an SSL certificate {#get-ssl-cert}

To use an encrypted connection, get an SSL certificate:

{% include [install-certificate](../../../_includes/mdb/mkf/install-certificate.md) %}

The resulting SSL certificate is also used when working with [{{ mkf-msr }}](../../concepts/managed-schema-registry.md).

## What's next {#whats-next}

* [Get the FQDN of the host](fqdn.md) you want to connect to.
* [Connect](clients.md) to the cluster using command line tools.
* [Integrate](code-examples.md) the cluster connection into your aplication code.
