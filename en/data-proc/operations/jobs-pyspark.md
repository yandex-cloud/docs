---
title: "How to manage PySpark jobs in {{ dataproc-full-name }}"
description: "In this tutorial, you will learn how to manage PySpark jobs in {{ dataproc-full-name }}."
---

# Managing PySpark jobs

## Create a job {#create}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.
   1. Click on the name of the cluster and open the **Jobs** tab.
   1. Click **Submit job**.
   1. (optional) Enter a name for the job.
   1. In the **Job type** field, select `PySpark`.
   1. In the **Main python file** field, specify the path to the main PY application file in the following format:

      {% include [jar-file-path-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}

   1. (optional) Specify the paths to PY files, if any.
   1. Specify job arguments.

      {% include [job-properties-requirements](../../_includes/data-proc/job-properties-requirements.md) %}

   1. (optional) Specify the paths to JAR files, if any.
   1. (optional) Configure advanced settings:

      * Specify paths to the necessary files and archives.
      * In the **{{ ui-key.yacloud.dataproc.jobs.field_properties }}** field, specify [component properties](../concepts/settings-list.md) as `key-value` pairs.

   1. Click **Submit job**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a job:

   1. View a description of the CLI create command for `PySpark` jobs:

      ```bash
      {{ yc-dp }} job create-pyspark --help
      ```

   1. Create a job (the example doesn't show all the available parameters):

      ```bash
      {{ yc-dp }} job create-pyspark \
         --cluster-name=<cluster name> \
         --name=<job name> \
         --main-python-file-uri=<path to main application py file> \
         --python-file-uris=<paths to additional py files> \
         --jar-file-uris=<paths to jar files> \
         --archive-uris=<paths to archives> \
         --properties=<key-value> \
         --args=<arguments passed to job> \
         --packages=<Maven coordinates of jar files as groupId:artifactId:version> \
         --repositories=<additional repositories to search for packages> \
         --exclude-packages=<packages to exclude as groupId:artifactId>
      ```

      Pass in the paths to the files required for the job in the following format:

      {% include [jar-file-path-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}

   You can find out the cluster ID and name in a [list of clusters in the folder](./cluster-list.md#list).

- API

   Use the [create](../api-ref/Job/create) API method and include the following information in the request:

   * Cluster ID in the `clusterId` parameter.
   * Job name in the `name` parameter.
   * The job properties in the `pysparkJob` parameter.

   You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list).

{% endlist %}

## Cancel a job {#cancel}

{% include [jobs-cancel](../../_includes/data-proc/jobs-cancel.md) %}

## Get a list of jobs {#list}

{% include [jobs-list](../../_includes/data-proc/jobs-list.md) %}

## Get general information about the job {#get-info}

{% include [jobs-get-info](../../_includes/data-proc/jobs-get-info.md) %}


## Get job execution logs {#get-logs}

{% include [jobs-get-logs](../../_includes/data-proc/jobs-get-logs.md) %}

