# Creating a schema registry to deliver data in Debezium CDC format from {{ KF }}


You can create a schema registry to track schema evolution for an {{ KF }} or {{ mkf-full-name }} source using [{{ data-transfer-full-name }}](../../../data-transfer). This tutorial tracks the evolution of schemas for a {{ mkf-name }} source. 

To track schema changes for a {{ mkf-name }} source:

1. [Set up your infrastructure](#prepare-infrastructure).
1. [Create a schema registry](#create-schema-registry).
1. [Prepare and run your transfer](#set-up-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#prepare-cloud}


{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

* {{ mkf-name }} cluster, which includes the use of computing resources allocated to hosts, storage and backup size (see [{{ mkf-name }} pricing](../../../managed-kafka/pricing.md)).
* Each transfer: use of computing resources and the number of transferred data rows (see [{{ data-transfer-name }} pricing](../../../data-transfer/pricing.md)).


## Set up your infrastructure {#prepare-infrastructure}

[Create a {{ mkf-name }} cluster](../../../managed-kafka/operations/cluster-create.md) of any suitable configuration. If you intend to connect to broker hosts from the internet, enable public access. In this case, you can only connect to them using SSL.

## Create a schema registry {#create-schema-registry}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you are going to use to work with your schema registry.
  1. [Navigate to](../../../console/operations/select-service.md#select-service) **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layout-cells.svg) **{{ schema-registry-name }}** / **Namespace**.
  1. Click **Create namespace**. 
  1. Specify [namespace settings](../../../metadata-hub/operations/create-name-space.md). After saving a namespace, you can use its ID to get the {{ schema-registry-name }} URL: `{namespace_id}.{{ schema-registry-endpoint }}`.

{% endlist %}

## Prepare and run your transfer {#set-up-transfer}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [management console]({{ link-console-main }}).
  1. [Navigate to](../../../console/operations/select-service.md#select-service) **{{ data-transfer-full-name }}**. 
  1. [Create an {{ KF }} source endpoint](../../../data-transfer/operations/endpoint/source/kafka.md) with the following settings:

      * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: **{{ KF }}**.
      * **Connection type**: **Manual setup**.
      * **Installation type**: **{{ mkf-name }}** cluster.
      * Under **{{ mkf-name }} cluster**:

          * **{{ mkf-name }} cluster**: Select the {{ mkf-name }} cluster you created previously.
          * **Authentication**: **SASL**.
          * **Username** and **Password**: User credentials in the {{ mkf-name }} cluster.

      * Under **Advanced settings** → **Conversion rules**:

          * **Conversion rules**: **Debezium CDC parser**.
          * **{{ schema-registry-name }} connection settings**: **On Premise {{ schema-registry-name }}**.
          * **{{ schema-registry-name }} URL**: {{ schema-registry-name }} URL you [got earlier](#create-schema-registry).

  1. [Create and run](../../../data-transfer/operations/transfer.md) a data transfer.

{% endlist %}

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the resources, [deactivate the transfer](../../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Management console {#console}

  1. [{{ mkf-name }} cluster](../../../managed-kafka/operations/cluster-delete.md)
  1. [Transfer in {{ data-transfer-name }}](../../../data-transfer/operations/transfer.md#delete)

{% endlist %}
