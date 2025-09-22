---
title: Getting started with {{ msp-full-name }}
description: Follow this guide to create a {{ msp-full-name }} cluster and run jobs in it.
---

# Getting started with {{ msp-full-name }}

To get started:

* [Get your cloud ready](#prepare-cloud).
* [Set up your infrastructure](#prepare-infrastructure).
* [Create a cluster](#cluster-create).
* [Prepare a PySpark job](#prepare-task).
* [Run the job in the cluster](#run-task).
* [Check the job completion](#check-task).

## Required paid resources {#paid-resources}

The cost of infrastructure support includes a fee for a {{ objstorage-full-name }} bucket (see [{{ objstorage-name }} pricing](../storage/pricing.md)).

## Get your cloud ready {#prepare-cloud}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet.

1. If you do not have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Assign](../iam/operations/roles/grant.md) the following roles to your {{ yandex-cloud }} account:

    * [managed-spark.admin](security.md#managed-spark-admin): To create a cluster.
    * [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user): To use the cluster [network](../vpc/concepts/network.md#network).
    * [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user): To link a service account to the cluster.

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

## Set up your infrastructure {#prepare-infrastructure}

1. [Create a service account](../iam/operations/sa/create.md#create-sa) and assign it the following roles:

   * `managed-spark.integrationProvider`: For {{ msp-full-name }} to interact with other system components, e.g., for sending logs and metrics.
   * [storage.editor](../storage/security/index.md#storage-editor): For accessing PySpark job files in your {{ objstorage-name }} bucket.

1. [Create an {{ objstorage-name }}](../storage/operations/buckets/create.md) bucket.

1. Grant the service account access to the {{ objstorage-name }} that will be storing your code and data for cluster-specific jobs:

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
      1. Open the bucket you [created earlier](#create-s3-bucket).
      1. Navigate to **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
      1. Click ![image](../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.storage.buckets.button_permissions }}**.
      1. In the **{{ ui-key.yacloud.component.acl-dialog.label_title }}** window that opens:

         1. Start typing the service account name [you created earlier](#before-you-begin) and select it from the drop-down list.
         1. Select the {{ ui-key.yacloud.storage.permissions-dialog.label_role-write }} access permissions.
         1. Click **{{ ui-key.yacloud.common.add }}**.
         1. Click **{{ ui-key.yacloud.common.save }}**.

## Create a cluster {#cluster-create}

{% list tabs group=instructions %}

- Management console

  1. In the management console, select the folder where you want to create a cluster.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Specify a name for the cluster.
  1. In the **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** field, select the [previously created](#before-you-begin) service account.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select a network, subnet, and security group for the cluster.
  1. Set up computing resources for hosts to run drivers and workers.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**, configure logging:

     1. Enable the **{{ ui-key.yacloud.logging.field_logging }}** setting.
     1. In the **{{ ui-key.yacloud.logging.label_destination }}** field, select where the log destination: **{{ ui-key.yacloud.common.folder }}**.
     1. In the **{{ ui-key.yacloud.mdb.forms.base_field_folder }}** field, select your folder from the list.
     1. Select **{{ ui-key.yacloud.logging.label_minlevel }}**: **INFO**.

  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Wait until the cluster is ready: its status on the {{ msp-full-name }} dashboard will change to **Running** and its state, to **Alive**. This may take some time.

{% endlist %}

## Prepare a PySpark job {#prepare-task}

1. Save the [pi.py](https://github.com/apache/spark/blob/master/examples/src/main/python/pi.py) file, that contains the job code, to a local computer from the {{ SPRK }} repository. This code calculates the approximate value of pi using the Monte Carlo method.

1. Upload the file to the {{ objstorage-name }} bucket [you created earlier](#before-you-begin).

## Run your PySpark job {#run-task}

1. In the [management console]({{ link-console-main }}), open the cluster you created earlier.
1. Navigate to **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}**.
1. Click **{{ ui-key.yacloud.spark.jobs.create_action }}**.
1. Select the **Job type**: **{{ ui-key.yacloud.dataproc.jobs.field_pyspark-job-type }}**.
1. In the **Main python file** field, specify the path to `pi.py` in the following format: `s3a://<Object_Storage_bucket_name>/<file_name>`.
1. Click **Submit job**.

## Check the job completion {#check_task}

1. Wait for the job to become **Running**.
1. Navigate to the **{{ ui-key.yacloud.common.logs }}** tab.
1. In the logs, look for a line with the job results, such as the following:

   ```
   Pi is roughly 3.144720
   ```
