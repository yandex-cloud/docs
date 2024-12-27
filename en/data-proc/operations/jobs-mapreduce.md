---
title: How to manage MapReduce jobs in {{ dataproc-full-name }}
description: In this tutorial, you will learn how to manage MapReduce jobs in {{ dataproc-full-name }}.
---

# Managing MapReduce jobs

{% include [MapReduce](../../_includes/data-processing/mapreduce-intro.md) %}

## Create a job {#create}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}** tab.
    1. Click **{{ ui-key.yacloud.dataproc.jobs.button_create }}**.
    1. (Optional) Enter a name for the job.
    1. In the **{{ ui-key.yacloud.dataproc.jobs.field_job-type }}** field, select `{{ ui-key.yacloud.dataproc.jobs.field_mapreduce-job-type }}`.
    1. Select one of the driver types and specify which to use to start the job:
        * Main class name.
        * Path to the main JAR file in the following format:

           {% include [jar-file-path-requirements](../../_includes/data-processing/jar-file-path-requirements.md) %}

    1. Specify job arguments.

       {% include [job-properties-requirements](../../_includes/data-processing/job-properties-requirements.md) %}

    1. (Optional) Specify the paths to the additional JAR files, if any.
    1. (Optional) Configure advanced settings:

        * Specify paths to the required files and archives.
        * In the **{{ ui-key.yacloud.dataproc.jobs.field_properties }}** field, specify [component properties](../concepts/settings-list.md) as `key-value` pairs.

    1. Click **{{ ui-key.yacloud.dataproc.jobs.button_create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a job:

    1. View the description of the CLI create command for `Mapreduce` jobs:

        ```bash
        {{ yc-dp }} job create-mapreduce --help
        ```

    1. Create a job (the example does not show all the available parameters):

        ```bash
        {{ yc-dp }} job create-mapreduce \
           --cluster-name=<cluster_name> \
           --name=<job_name> \
           --main-class=<main_class_name> \
           --file-uris=<path_to_file> \
           --archive-uris=<paths_to_archives> \
           --properties=<component_properties> \
           --args=<argument>
        ```

        Where `--properties` stands for component properties as a `key-value` pair.

        Provide the paths to the files required for the job in the following format:

        {% include [jar-file-path-requirements](../../_includes/data-processing/jar-file-path-requirements.md) %}

    You can get the cluster ID and name with a [list of clusters in the folder](./cluster-list.md#list).

- API {#api}

    Use the [create](../api-ref/Job/create) API method and include the following information in the request:

    * Cluster ID in the `clusterId` parameter.
    * Job name in the `name` parameter.
    * Job properties in the `mapreduceJob` parameter.

    You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list).

{% endlist %}

## Cancel a job {#cancel}

{% include [jobs-cancel](../../_includes/data-processing/jobs-cancel.md) %}

## Get a list of jobs {#list}

{% include [jobs-list](../../_includes/data-processing/jobs-list.md) %}

## Get general information about the job {#get-info}

{% include [jobs-get-info](../../_includes/data-processing/jobs-get-info.md) %}


## Get job execution logs {#get-logs}

{% include [jobs-get-logs](../../_includes/data-processing/jobs-get-logs.md) %}


{% note info %}

To work with MapReduce, you can use the libraries from the `/usr/lib/hadoop-mapreduce/` directory.

{% endnote %}
