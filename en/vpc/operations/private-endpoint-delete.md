---
title: "How to delete a service connection in {{ vpc-full-name }}"
description: "Follow this guide to delete a service connection (Private Endpoint) in VPC." 
---

# Deleting a service connection

{% include [vpc-pe-preview](../../_includes/vpc/pe-preview.md) %}



{% list tabs group=instructions %}

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. View the description of the CLI command for deleting a service connection (Private Endpoint):

      ```bash
      yc vpc private-endpoint delete --help
      ```

  1. Get a list of all service connections:

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

  1. Select the ID (`ID`) or name (`NAME`) of the service connection.
  1. Delete the service connection:

     ```bash
     yc vpc private-endpoint delete s3-vpc-link
     ```

{% endlist %}
