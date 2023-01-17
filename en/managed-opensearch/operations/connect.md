---
title: "Connecting to {{ OS }} clusters"
description: "You can connect to {{ OS }} cluster hosts with the DATA role from the internet if you set up public access to the desired host and from {{ yandex-cloud }} VMs located in the same virtual network."
keywords:
  - connecting OpenSearch clusters
  - OpenSearch cluster
  - OpenSearch
---

# Connecting to an {{ OS }} cluster

You can connect to {{ mos-name }} cluster hosts with the `DATA` [role](../concepts/host-roles.md#data):

* Over the internet, if you configured public access for the appropriate host group.

{% if audience != "internal" %}

* From {{ yandex-cloud }} VM instances hosted in the same [virtual network](../../vpc/concepts/network.md).

{% else %}

* From {{ yandex-cloud }} VM instances hosted in the same virtual network.

{% endif %}

Regardless of the connection method, {{ mos-name }} only supports cluster host connections with an [SSL certificate](#ssl-certificate).

{% if audience != "internal" %}

## Configuring security groups {#security-groups}

{% include notitle [Configuring security groups](../../_includes/mdb/mos/configuring-security-groups.md) %}

{% endif %}

## Getting an SSL certificate {#ssl-certificate}

To use an encrypted connection, get an SSL certificate:

{% list tabs %}

- Linux (Bash)

   {% include [install-certificate](../../_includes/mdb/mos/install-certificate.md) %}

   The certificate will be saved in the `$HOME/.opensearch/root.crt` directory.

- Windows (PowerShell)

   ```powershell
   mkdir $HOME\.opensearch; curl -o $HOME\.opensearch\root.crt {{ crt-web-path }}
   ```

   The certificate will be saved in the `$HOME\.opensearch\root.crt` directory.

{% endlist %}

## Connecting to {{ OS }} Dashboards {#dashboards}

{% if audience == "internal" %}

1. Install the [SSL certificate](#ssl-certificate) in the browser's trusted root certificate store ([instructions](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate) for Mozilla Firefox).
1. On the cluster page, in the management console, click **OpenSearch Dashboards** or go to `https://c-< cluster ID>.rw.{{ dns-zone }}>` in your browser.

   You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

1. Enter the `admin` username and password that you set when [creating a cluster](cluster-create.md).

{% else %}

You can connect to {{ OS }} Dashboards:

* Over the internet, if a host with the `DASHBOARDS` role is assigned a public IP address.
* Using a VM instance in {{ yandex-cloud }}, if no host with the `DASHBOARDS` role is assigned a public IP address.

{% list tabs %}

- Over the internet

   1. Install the [SSL certificate](#ssl-certificate) in the browser's trusted root certificate store ([instructions](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate) for Mozilla Firefox).
   1. On the cluster page, in the management console, click **OpenSearch Dashboards** or go to `https://c-< cluster ID>.rw.{{ dns-zone }}>` in your browser.

      You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

   1. Enter the `admin` username and password that you set when [creating a cluster](cluster-create.md).

- From a VM in {{ yandex-cloud }}

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
         server <FQDN of host 1 with DASHBOARDS role>:443;
         ...
         server <FQDN of host N with the DASHBOARDS role>:443;
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

      This configuration file example uses a self-signed `snakeoil` certificate from the `ssl-cert` package. It's not safe to use this certificate in a real cluster. Instead of the self-signed certificate, specify the path to your public and private SSL certificate keys in the `ssl_certificate` and `ssl_certificate_key` directives.

      {% endnote %}

   1. Restart NGINX:

      ```bash
      sudo systemctl restart nginx
      ```

   1. Add the certificate specified in the `ssl_certificate` directive to the browser's trusted root certificate store ([instructions](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate) for Mozilla Firefox).

   1. In the browser, go to `https://<public IP address of the VM instance>`.

   1. Enter the `admin` username and password.

{% endlist %}

{% endif %}

{% note info %}

When using the {{ OS }} Dashboards API:

* To send requests, use port `{{ port-https }}` instead of standard port `5601`.
* Add the SSL certificate path to your application's configuration to use the {% if lang == "ru" and audience != "internal" %}[API](../../glossary/rest-api.md){% else %}API{% endif %}.

{% endnote %}

## Sample connection strings {#code-examples}

Before connecting, [prepare a certificate](#ssl-cetificate).

To connect, enter the `admin` username and password used when [creating your cluster](cluster-create.md#create-cluster).

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [Code examples](../../_includes/mdb/mos/code-examples.md) %}

## Special FQDNs {#special-fqdns}

Just like usual FQDNs, which can be requested with a [list of cluster hosts](host-groups.md#list-hosts), {{ mos-name }} provides a number of special FQDNs, which can also be used when connecting to a cluster.

### Available Dashboards host {#fqdn-dashboards}

A FQDN like `c-<cluster ID>.rw.{{ dns-zone }}` always points to the available {{ OS }} host with the `DASHBOARDS` role in the cluster. You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).
