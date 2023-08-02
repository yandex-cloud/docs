---
title: "How to manage MapReduce jobs in {{ dataproc-full-name }}"
description: "In this tutorial, you will learn how to manage MapReduce jobs in {{ dataproc-full-name }}."
---

# Managing MapReduce jobs

{% include [MapReduce](../../_includes/data-proc/mapreduce-intro.md) %}

## Create a job {#create}

{% list tabs %}

- Management console

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.
    1. Click on the name of the cluster and open the **Jobs** tab.
    1. Click **Submit job**.
    1. (optional) Enter a name for the job.
    1. In the **Job type** field, select `Mapreduce`.
    1. Select one of the driver types and specify which to use to start the job:
        * Main class name.
        * Path to the main JAR file in the following format:

           {% include [jar-file-path-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}

    1. Specify job arguments.

       {% include [job-properties-requirements](../../_includes/data-proc/job-properties-requirements.md) %}

    1. (optional) Specify paths to the additional JAR files, if any.
    1. (optional) Configure advanced settings:

        * Specify paths to the necessary files and archives.
        * In the **{{ ui-key.yacloud.dataproc.jobs.field_properties }}** field, specify [component properties](../concepts/settings-list.md) as `key-value` pairs.

    1. Click **Submit job**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a job:

    1. View a description of the CLI create command for `Mapreduce` jobs:

        ```bash
        {{ yc-dp }} job create-mapreduce --help
        ```

    1. Create a job (the example doesn't show all the available parameters):

        ```bash
        {{ yc-dp }} job create-mapreduce \
           --cluster-name=<cluster name> \
           --name=<job name> \
           --main-class=<main class name> \
           --file-uris=<path to file> \
           --archive-uris=<path to archives> \
           --properties=<key-value> \
           --args=<argument>
        ```

        Pass in the paths to the files required for the job in the following format:

        {% include [jar-file-path-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}

    You can find out the cluster ID and name in a [list of clusters in the folder](./cluster-list.md#list).

- API

    Use the [create](../api-ref/Job/create) API method and include the following information in the request:

    * Cluster ID in the `clusterId` parameter.
    * Job name in the `name` parameter.
    * Job properties in the `mapreduceJob` parameter.

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


{% note info %}

To work with MapReduce, you can use the libraries from the `/usr/lib/hadoop-mapreduce/` directory.

{% endnote %}
