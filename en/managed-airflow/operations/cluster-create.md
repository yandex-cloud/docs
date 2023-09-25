---
title: "Creating an {{ AF }} cluster"
description: "Every {{ maf-name }} cluster consists of a set of {{ AF }} components, each of which can be represented in multiple instances. The instances may reside in different availability zones."
keywords:
  - Creating an {{ AF }} cluster
  - {{ AF }} cluster
  - {{ AF}}
  - Airflow
---

# Creating an {{ AF }} cluster

Every {{ maf-name }} cluster consists of a set of {{ AF }} components, each of which can be represented in multiple instances. The instances may reside in different availability zones.

## Before creating a cluster {#before-creating}

1. In the folder where you want to create a cluster, [create a service account](../../iam/operations/sa/create.md) with the `storage.viewer` role.
1. [Create a static access key](../../iam/operations/sa/create-access-key.md) for the service account.
1. [Create a {{ objstorage-full-name }} bucket](../../storage/operations/buckets/create.md) to store [DAG files](../concepts/index.md#about-the-service).

## Create a cluster {#create-cluster}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
   1. Click **{{ ui-key.yacloud.airflow.button_create-cluster }}**.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, enter:

      * Cluster name. The name must be unique within the folder.
      * (Optional) Cluster description.
      * Admin user password. The password must be not less than 8 characters long and contain at least:

         * One uppercase letter
         * One lowercase letter
         * One digit
         * One special character

      {% note info %}

      Save the password locally or memorize it. The service does not show passwords after the registry is created.

      {% endnote %}

   1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select:

      * [Availability zones](../../overview/concepts/geo-scope) for the cluster
      * Cloud network
      * Subnet in each of the selected availability zones

   1. Set the number of instances and resources for the {{ maf-name }} [components](../concepts/index.md#components):

      * Web server
      * Scheduler
      * Workers

         {% note info %}

         If the minimum and maximum number of workers are the same, a fixed amount of workers will be created. If the minimum value is smaller than the maximum one, then, if there are no jobs in the queue, the number of workers will be equal to the minimum value; otherwise, the number of workers will be increasing without exceeding the specified maximum value.

         {% endnote %}

      * (Optional) Triggerer services

   1. Under **{{ ui-key.yacloud.airflow.section_storage }}**, specify:

      * Name of the previously created bucket that will store DAG files
      * Parameters of a static access key for the service account

   1. (Optional) Under **{{ ui-key.yacloud.airflow.section_airflow-configuration }}**, specify [{{ AF }} additional properties](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html) in `key:value` format, such as `api.maximum_page_limit` **:** `150`.

   1. (Optional) Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**, enable cluster deletion protection.

   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
