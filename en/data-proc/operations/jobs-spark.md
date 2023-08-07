---
title: "How to manage Spark jobs in {{ dataproc-full-name }}"
description: "In this tutorial, you will learn how to manage Spark jobs in {{ dataproc-full-name }}."
---

# Managing Spark jobs

## Create a job {#create}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.
   1. Click on the name of the cluster and open the **Jobs** tab.
   1. Click **Submit job**.
   1. (Optional) Enter a name for the job.
   1. In the **Job type** field, select `Spark`.
   1. In the **Main jar**, specify the path to the main JAR application file in the following format:

      {% include [jar-file-path-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}

   1. In the **Main class** field, specify the name of the main application class.
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

   1. View a description of the CLI create command for `spark` jobs:

      ```bash
      {{ yc-dp }} job create-spark --help
      ```

   1. Create a job (the example doesn't show all the available parameters):

      ```bash
      {{ yc-dp }} job create-spark \
         --cluster-name=<cluster name> \
         --name=<job name> \
         --main-class=<application main class name> \
         --main-jar-file-uri=<path to main jar file> \
         --jar-file-uris=<path to jar file> \
         --file-uris=<path to file> \
         --archive-uris=<path to archive> \
         --properties=<key-value> \
         --args=<arguments passed to job> \
         --packages=<Maven coordinates of jar files as groupId:artifactId:version> \
         --repositories=<additional repositories to search for packages> \
         --exclude-packages=<packages to exclude as groupId:artifactId>
      ```

      Pass in the paths to the files required for the job in the following format:

      {% include [job-properties-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}

   You can find out the cluster ID and name in a [list of clusters in the folder](./cluster-list.md#list).

- API

   Use the [create](../api-ref/Job/create) API method and include the following information in the request:

   * Cluster ID in the `clusterId` parameter.
   * Job name in the `name` parameter.
   * Job properties in the `sparkJob` parameter.

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

