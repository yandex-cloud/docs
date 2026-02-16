---
title: How to manage Spark jobs in {{ dataproc-full-name }}
description: In this tutorial, you will learn how to manage Spark jobs in {{ dataproc-full-name }}.
---

# Managing Spark jobs

## Creating a job {#create}

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}** tab.
    1. Click **{{ ui-key.yacloud.dataproc.jobs.button_create }}**.
    1. Optionally, enter a name for the job.
    1. In the **{{ ui-key.yacloud.dataproc.jobs.field_job-type }}** field, select `{{ ui-key.yacloud.dataproc.jobs.field_spark-job-type }}`.
    1. In the **{{ ui-key.yacloud.dataproc.jobs.field_main-jar }}** field, specify the path to the application's main JAR file in the following format:

        {% include [jar-file-path-requirements](../../_includes/data-processing/jar-file-path-requirements.md) %}

    1. In the **{{ ui-key.yacloud.dataproc.jobs.field_main-class }}** field, specify the name of the main application class.
    1. Specify job arguments.

        {% include [job-properties-requirements](../../_includes/data-processing/job-properties-requirements.md) %}

    1. Optionally, specify the paths to JAR files, if any.
    1. Optionally, configure advanced settings:

        * Specify paths to the required files and archives.
        * In the **{{ ui-key.yacloud.dataproc.jobs.field_properties }}** field, specify [component properties](../concepts/settings-list.md) as `key-value` pairs.

    1. Click **{{ ui-key.yacloud.dataproc.jobs.button_create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a job:

    1. View the description of the CLI create command for `spark` jobs:

        ```bash
        {{ yc-dp }} job create-spark --help
        ```

    1. Create a job (the example does not illustrate all available parameters):

        ```bash
        {{ yc-dp }} job create-spark \
           --cluster-name=<cluster_name> \
           --name=<job_name> \
           --main-class=<application_main_class_name> \
           --main-jar-file-uri=<path_to_main_jar_file> \
           --jar-file-uris=<path_to_jar_file> \
           --file-uris=<file_path> \
           --archive-uris=<path_to_archive> \
           --properties=<component_properties> \
           --args=<arguments> \
           --packages=<Maven_coordinates_of_jar_files> \
           --repositories=<additional_repositories> \
           --exclude-packages=<packages_to_exclude>
        ```

        Where: 
        
        * `--properties`: Component properties as `key-value` pairs.
        * `--args`: Arguments provided to the job.
        * `--packages`: Maven coordinates of JAR files in `groupId:artifactId:version` format.
        * `--repositories`: Additional repositories to search for `packages`.
        * `--exclude-packages`: Packages to exclude in `groupId:artifactId` format.

        Provide the paths to the files required for the job in the following format:

        {% include [job-properties-requirements](../../_includes/data-processing/jar-file-path-requirements.md) %}

    You can get the cluster ID and name with the [list of clusters in the folder](./cluster-list.md#list).

- API {#api}

    Call the [create](../api-ref/Job/create) API method and provide the following in the request:

    * Cluster ID in the `clusterId` parameter.
    * Job name in the `name` parameter.
    * Job properties in the `sparkJob` parameter.

    You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list).

{% endlist %}

## Cancel a job {#cancel}

{% include [jobs-cancel](../../_includes/data-processing/jobs-cancel.md) %}

## Get a list of jobs {#list}

{% include [jobs-list](../../_includes/data-processing/jobs-list.md) %}

## Get general info about a job {#get-info}

{% include [jobs-get-info](../../_includes/data-processing/jobs-get-info.md) %}

## Get job execution logs {#get-logs}

{% include [jobs-get-logs](../../_includes/data-processing/jobs-get-logs.md) %}