---
title: How to create a service connection in {{ vpc-full-name }}
description: Follow this guide to create a service connection (Private Endpoint) in VPC.
---

# Creating a service connection

{% include [vpc-pe-preview](../../_includes/vpc/pe-preview.md) %}


To create a network connection, you will need one of the following [roles](../security/index.md#roles-list): 

* `vpc.admin`
* `vpc.privateAdmin`
* `admin`
* `vpc.privateEndpoints.editor`
* `vpc.privateEndpoints.admin`

To create a service connection (Private Endpoint):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. View the description of the CLI command to create a service account:

      ```bash
      yc vpc private-endpoint create --help
      ```

  1. Create a service connection to {{ objstorage-short-name }} in the default folder:

     ```bash
     yc vpc private-endpoint create \
        --name s3-vpc-link \
        --description "Private Endpoint to the Object Storage" \
        --network-name default-net \
        --object-storage 
     ```

     Where:

     * `network_id`: ID of the network the service connection will be created in.
     * `--object-storage`: Service connection to Object Storage Other service connection types are not available yet.

     When creating a service connection, you can use the following additional parameters:

     * `--address-spec`: To specify an IP address and/or ID of the subnet to provide an IP address for the new service connection.
     * `--private-dns-records-enable`: To specify whether a separate DNS record is required for the service’s public FQDN. 


  1. Make sure the service connection was created:

     ```bash
     yc vpc private-endpoint list
     ```
     
     Command result:

     ```text
     +----------------------+-------------+--------------------------------+
     |          ID          |    NAME     |          DESCRIPTION           |
     +----------------------+-------------+--------------------------------+
     | enpd7rq************* | s3-vpc-link | Private Endpoint to the Object |
     |                      |             | Storage                        |
     +----------------------+-------------+--------------------------------+
     ```

{% endlist %}
