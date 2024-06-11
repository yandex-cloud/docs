---
title: "Connecting to an {{ OS }} cluster in {{ mos-full-name }}"
description: "You can connect to {{ OS }} cluster hosts with the DATA role from the internet if you set up public access to the appropriate host and from {{ yandex-cloud }} VMs located in the same virtual network."
keywords:
  - connecting OpenSearch clusters
  - OpenSearch cluster
  - OpenSearch
---

# Connecting to an {{ OS }} cluster

You can connect to {{ mos-name }} cluster hosts with the `DATA` [role](../concepts/host-roles.md#data):

* Over the internet, if you configured public access for the appropriate host group.


* From {{ yandex-cloud }} VM instances hosted in the same [virtual network](../../vpc/concepts/network.md).


Regardless of the connection method, {{ mos-name }} only supports cluster host connections with an [SSL certificate](#ssl-certificate).


## Configuring security groups {#security-groups}

{% include notitle [Configuring security groups](../../_includes/mdb/mos/configuring-security-groups.md) %}


## Getting an SSL certificate {#ssl-certificate}

To use an encrypted connection, get an SSL certificate:

{% include [install-certificate](../../_includes/mdb/mos/install-certificate.md) %}

## {{ OS }} host FQDN {#fqdn}

To connect to a host, you need its fully qualified domain name ([FQDN](../concepts/network.md#hostname)). You can obtain it in one of the following ways:

* [Request a list of cluster hosts](host-groups.md#list-hosts).
* In the [management console]({{ link-console-main }}), copy the command for connecting to the cluster. This command contains the host FQDN. To get the command, go to the cluster page and click **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.
* Look up the FQDN in the management console:

   1. Go to the cluster page.
   1. Go to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
   1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.

Hosts with the `DASHBOARDS` role also use [special FQDNs](#special-fqdns).

## Special FQDN {#special-fqdns}

Alongside [regular FQDNs](#fqdn), {{ mos-name }} provides a special FQDN, which you can also use when connecting to a cluster.

Such FQDN as `c-<cluster_ID>.rw.{{ dns-zone }}` always points to the available {{ OS }} host with the `DASHBOARDS` role in the cluster. You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

The service does not provide special FQDNs for hosts with the `DATA` role.

## Connecting to {{ OS }} Dashboards {#dashboards}


You can connect to {{ OS }} Dashboards:

* Over the internet, if public access is enabled for a host with the `DASHBOARDS` role.
* Using a VM instance in {{ yandex-cloud }}, if public access is not enabled for any hosts with the `DASHBOARDS` role.

{% list tabs group=connection_method %}

- Over the internet {#internet}

   1. Install the [SSL certificate](#ssl-certificate) in your browser's trusted root certificate store ([instructions](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate) for Mozilla Firefox).
   1. On the cluster page, in the management console, click **{{ ui-key.yacloud.opensearch.title_opensearch-dashboards-section }}** or go to `https://c-< cluster_ID>.rw.{{ dns-zone }}>` in your browser.

      You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

   1. Enter `admin` for the username and the password you set when [creating the cluster](cluster-create.md).

- From a VM in {{ yandex-cloud }} {#cloud}

   1. [Create](../../compute/quickstart/quick-create-linux.md) a Linux VM in the same [network](../../vpc/concepts/network.md) as the cluster.
   1. [Connect](../../compute/operations/vm-connect/ssh.md) to the virtual machine over SSH.
   1. Install the dependencies:

      ```bash
      sudo apt update && \
      sudo apt install --yes nginx ssl-cert
      ```

   1. Copy the downloaded SSL certificate to the `/etc/nginx/` directory :

      ```bash
      sudo cp ~/.opensearch/root.crt /etc/nginx/root.crt
      ```

   1. Edit the NGINX default configuration file, for example, like this:

      `/etc/nginx/sites-available/default`

      ```nginx
      upstream os-dashboards-nodes {
         server <FQDN_of_host_1_with_DASHBOARDS_role>:443;
         ...
         server <FQDN_of_host_N_with_DASHBOARDS_role>:443;
      }

      server {
         listen 443 ssl;

         ssl_certificate /etc/ssl/certs/ssl-cert-snakeoil.pem;
         ssl_certificate_key /etc/ssl/private/ssl-cert-snakeoil.key;

         server_name _;

         location / {

             proxy_pass https://os-dashboards-nodes;

             proxy_ssl_trusted_certificate /etc/nginx/root.crt;
             proxy_ssl_session_reuse on;
         }
      }
      ```

      {% note warning %}

      This configuration file example uses a self-signed `snakeoil` certificate from the `ssl-cert` package. It is not safe to use this certificate in a real cluster. Instead of the self-signed certificate, specify the path to your public and private SSL certificate keys in the `ssl_certificate` and `ssl_certificate_key` directives.

      {% endnote %}

   1. Restart NGINX:

      ```bash
      sudo systemctl restart nginx
      ```

   1. Add the certificate specified in the `ssl_certificate` directive to the browser's trusted root certificate store ([instructions](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate) for Mozilla Firefox).

   1. In your browser, open `https://<VM_public_IP_address>`.

   1. Enter the `admin` username and password.

{% endlist %}


{% note info %}

When using the {{ OS }} Dashboards API:

* To send requests, use port `{{ port-https }}` instead of standard port `5601`.
* Add the SSL certificate path to your application's configuration to use the API.

{% endnote %}

## Before you connect from a Docker container {#connection-docker}

To connect to a {{ mos-name }} cluster from a Docker container, add the following lines to the Dockerfile:

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
       mkdir --parents ~/.opensearch && \
       wget "{{ crt-web-path }}" \
            --output-document ~/.opensearch/root.crt && \
       chmod 0600 ~/.opensearch/root.crt
   ```

{% endlist %}

## Examples of connection strings {#code-examples}

Before connecting, [prepare a certificate](#ssl-cetificate).

To connect, enter the `admin` username and password used when [creating the cluster](cluster-create.md#create-cluster).

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [Code examples](../../_includes/mdb/mos/code-examples.md) %}
