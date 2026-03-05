---
title: Connecting to an {{ OS }} cluster in {{ mos-full-name }}
description: Follow this guide to connect to an {{ OS }} cluster database using command line tools, {{ OS }} Dashboards, and from a Docker container.
---

# Connecting to an {{ OS }} cluster from applications

This section provides settings for connecting to {{ mos-name }} cluster hosts using [command line tools](#command-line-tools), [{{ OS }} Dashboards](#dashboards), and from a [Docker container](#connection-docker). To learn how to connect from your application code, see [Code examples](./code-examples.md).

## Command line tools {#command-line-tools}

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

### Linux (Bash) {#bash}

{% list tabs group=connection %}

- Connecting with SSL {#with-ssl}

    {% include [Default connection string](../../../_includes/mdb/mos/default-connstring.md) %}

{% endlist %}

{% include [see-fqdn](../../../_includes/mdb/mos/fqdn-host.md) %}

### Windows (PowerShell) {#powershell}

{% list tabs group=connection %}

- Connecting with SSL {#with-ssl}

   ```powershell
   curl `
     -Certificate <absolute_path_to_certificate_file> `
     -Uri https://<FQDN_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }} `
     -Credential admin
   ```

{% endlist %}

{% include [see-fqdn](../../../_includes/mdb/mos/fqdn-host.md) %}

## Connecting to {{ OS }} Dashboards {#dashboards}


You can connect to {{ OS }} Dashboards:

* Over the internet, if public access is enabled for a host with the `DASHBOARDS` role.
* From a VM in {{ yandex-cloud }}, if public access is not enabled for any of your hosts with the `DASHBOARDS` role.

{% list tabs group=connection_method %}

- Over the internet {#internet}

    1. Install the [SSL certificate](./index.md#ssl-certificate) in your browser's store of trusted root certificates (see the instructions for Mozilla Firefox [here](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate)).
    1. On the cluster page in the management console, click **OpenSearch Dashboards** or go to `https://c-<cluster_ID>.rw.{{ dns-zone }}` in your browser.

        You can get the cluster ID with the [list of clusters in the folder](../cluster-list.md#list-clusters).

    1. Enter `admin` for the username and the password you set when [creating the cluster](../cluster-create.md).

- From a {{ yandex-cloud }} VM {#cloud}

    1. [Create](../../../compute/quickstart/quick-create-linux.md) a Linux VM in the same [virtual network](../../../vpc/concepts/network.md) as the cluster.
    1. [Connect](../../../compute/operations/vm-connect/ssh.md) to the VM over SSH.
    1. Install the dependencies:
    
       ```bash
       sudo apt update && \
       sudo apt install --yes nginx ssl-cert
       ```

    1. Copy the downloaded SSL certificate to the `/etc/nginx/` directory:

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

       This configuration file example uses a self-signed `snakeoil` certificate from the `ssl-cert` package. It is not safe to use this certificate in a real cluster. Instead, specify the path to your public and private SSL certificate keys in the `ssl_certificate` and `ssl_certificate_key` directives.

       {% endnote %}

    1. Restart NGINX:

       ```bash
       sudo systemctl restart nginx
       ```

    1. Add the certificate specified in the `ssl_certificate` directive to the browser's trusted root certificate store (see the instructions for Mozilla Firefox [here](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate)).

    1. In your browser, go to `https://<VM_public_IP_address>`.

    1. Enter the username and password for the `admin` user.

{% endlist %}


{% note info %}

When using the {{ OS }} Dashboards API:

* To send requests, use `{{ port-https }}` instead of the standard port `5601`.
* To use the API, add the SSL certificate path to your application's configuration.

{% endnote %}

## Before you connect from a Docker container {#connection-docker}

To connect to a {{ mos-name }} cluster from a Docker container, add the following lines to the Dockerfile:

{% list tabs group=connection %}


- Connecting without SSL {#without-ssl}

    ```bash
    RUN apt-get update && \
        apt-get install curl --yes
    ```


- Connecting with SSL {#with-ssl}

    ```bash
    RUN apt-get update && \
        apt-get install wget curl --yes && \
        mkdir --parents ~/.opensearch && \
        wget "{{ crt-web-path }}" \
             --output-document ~/.opensearch/root.crt && \
        chmod 0600 ~/.opensearch/root.crt
    ```

{% endlist %}
