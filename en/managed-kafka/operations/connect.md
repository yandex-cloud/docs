# Connecting to topics in an Apache Kafka® cluster

You can connect to {{ mkf-name }} cluster hosts:

* Over the internet if you configured public access for the cluster [when creating it](cluster-create.md). You can only connect to this type of cluster using an [SSL connection](#get-ssl-cert).


* From {{ yandex-cloud }} virtual machines located in the same [cloud network](../../vpc/concepts/network.md). If the cluster isn't publicly available, you don't need to use an SSL connection to connect to such VMs.



You can connect to the {{ KF }} cluster both with encryption (`SASL_SSL`, port {{ port-mkf-ssl }}) and without it (`SASL_PLAINTEXT`, port {{ port-mkf-text }}).


To connect to an {{ KF }} cluster:

1. [Create users](cluster-accounts.md#create-user) for clients (producers and consumers) with access to the required topics.
1. Connect the clients to the cluster:
   * Producers using the [Kafka Producer API](https://kafka.apache.org/documentation/#producerapi).
   * Consumers using the [Kafka Consumer API](https://kafka.apache.org/documentation/#consumerapi).

There are ready-made {{ KF }} API implementations for most popular programming languages. See [{#T}](#connection-string) for an example cluster connection code.


## Configuring security groups {#configuring-security-groups}

{% note info %}

{% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}

{% endnote %}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Rule settings depend on the connection method you select:

{% list tabs %}

- Over the internet

   [Configure all security groups](../../vpc/operations/security-group-add-rule.md) in the cluster to allow incoming traffic on port {{ port-mkf-ssl }} from any IP address. To do this, create the following rule for incoming traffic:

   * Port range: `{{ port-mkf-ssl }}`.
   * Protocol: `TCP`.
   * Source: `CIDR`.
   * CIDR blocks: `0.0.0.0/0`.

   To allow connections to [{{ mkf-msr }}](../concepts/managed-schema-registry.md), add a rule for incoming traffic:

   * Port range: `{{ port-https }}`.
   * Protocol: `TCP`.
   * Source: `CIDR`.
   * CIDR blocks: `0.0.0.0/0`.

- With a VM in {{ yandex-cloud }}

   1. [Configure all security groups](../../vpc/operations/security-group-add-rule.md) in the cluster to allow incoming traffic from the security group where the VM is located on ports {{ port-mkf-ssl }} and {{ port-mkf-text }}. To do this, create the following rule for incoming traffic in these groups:

      * Port range: `{{ port-mkf-ssl }}-{{ port-mkf-text }}`.
      * Protocol: `TCP`.
      * Source: `Security group`.
      * Security group: If a cluster and a VM are in the same security group, select `Self` (`Self`) as the value. Otherwise, specify the VM security group.

      To allow connections to [{{ mkf-msr }}](../concepts/managed-schema-registry.md), add a rule for incoming traffic:

      * Port range: `{{ port-https }}`.
      * Protocol: `TCP`.
      * Source: `CIDR`.
      * CIDR blocks: `0.0.0.0/0`.

   1. [Configure the security group](../../vpc/operations/security-group-add-rule.md) where the VM is located to allow connections to the VM and traffic between the VM and the cluster hosts.

      Example of rules for a VM:

      * For incoming traffic:
         * Port range: `{{ port-ssh }}`.
         * Protocol: `TCP`.
         * Source: `CIDR`.
         * CIDR blocks: `0.0.0.0/0`.

         This rule allows you to connect to the VM over SSH.

      * For outgoing traffic:
         * Protocol: `Any`.
         * Port range: `{{ port-any }}`.
         * Destination type: `CIDR`.
         * CIDR blocks: `0.0.0.0/0`.

       This rule allows all outgoing traffic, which enables you to both connect to the cluster and install the certificates and utilities the VMs need to connect to the cluster.

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If the security group settings are incomplete or incorrect, you might lose access the cluster.

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).


## Getting an SSL certificate {#get-ssl-cert}

To use an encrypted connection, get an SSL certificate:

{% include [install-certificate](../../_includes/mdb/mkf/install-certificate.md) %}

The resulting SSL certificate is also used when working with [{{ mkf-msr }}](../concepts/managed-schema-registry.md).

## Connecting from a Docker container {#connection-docker}

You can only use Docker containers to connect to public cluster hosts [using SSL certificates](#get-ssl-cert).

To connect to a {{ mkf-name }} cluster, add the following lines to the Dockerfile:

```bash
RUN apt-get update && \
    apt-get install wget kafkacat --yes && \
    mkdir -p {{ crt-local-dir }} && \
    wget "{{ crt-web-path }}" \
         --output-document {{ crt-local-dir }}{{ crt-local-file }} && \
    chmod 0655 {{ crt-local-dir }}{{ crt-local-file }}
```

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mkf-conn-strings-env.md) %}

Prior to connecting to cluster hosts over an SSL connection, [generate a certificate](#get-ssl-cert). The examples below assume that the `{{ crt-local-file }}` certificate is located in the directory:
* `{{ crt-local-dir }}` for Ubuntu.
* `$HOME\.kafka\` for Windows.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mkf-connection-strings](../../_includes/mdb/mkf-conn-strings.md) %}
