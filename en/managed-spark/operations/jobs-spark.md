---
title: How to manage Spark jobs in {{ msp-full-name }}
description: In this tutorial, you will learn how to manage Spark jobs in {{ msp-full-name }}.
---

# Managing Spark jobs

{% include notitle [preview](../../_includes/note-preview.md) %}

## Create a job {#create}

{% note warning %}

Once created, the job will run automatically.

{% endnote %}

To create a job:

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}** tab.
    1. Click **{{ ui-key.yacloud.spark.jobs.create_action }}**.
    1. Enter the job name.
    1. In the **{{ ui-key.yacloud.dataproc.jobs.field_job-type }}** field, select `{{ ui-key.yacloud.dataproc.jobs.field_spark-job-type }}`.
    1. In the **{{ ui-key.yacloud.dataproc.jobs.field_main-jar }}** field, specify the path to the main JAR application file in the following format:

        {% include [jar-file-path-requirements](../../_includes/managed-spark/jar-file-path-requirements.md) %}

    1. In the **{{ ui-key.yacloud.dataproc.jobs.field_main-class }}** field, specify the name of the main application class.
    1. Specify job arguments.

        {% include [job-properties-requirements](../../_includes/managed-spark/job-properties-requirements.md) %}

    1. (Optional) Specify the paths to the JAR files, if any.
    1. (Optional) Configure advanced settings:

        * Specify paths to the required files and archives.
        * In the **{{ ui-key.yacloud.dataproc.jobs.field_properties }}** field, specify component properties as `key-value` pairs.
        * Specify the coordinates of included and excluded Maven packages as well as URLs of additional repositories for package search.

    1. Click **{{ ui-key.yacloud.dataproc.jobs.button_create }}**.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [JobService.Create](../api-ref/grpc/Job/create.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/spark/v1/job_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                   "cluster_id": "<cluster_ID>",
                   "name": "<job_name>",
                   "spark_job": {
                     "args": [
                       <list_of_arguments>
                     ],
                     "jar_file_uris": [
                       <list_of_paths_to_JAR_files>
                     ],
                     "file_uris": [
                       <list_of_paths_to_files>
                     ],
                     "archive_uris": [
                       <list_of_paths_to_archives>
                     ],
                     "properties": {
                       <list_of_properties>
                     },
                     "main_jar_file_uri": "<path_to_main_JAR_file>",
                     "main_class": "<main_class_name>",
                     "packages": [
                       <list_of_package_Maven_coordinates>
                     ],
                     "repositories": [
                       <URLs_of_repositories_for_package_search>
                     ],
                     "exclude_packages": [
                       <list_of_Maven_coordinates_of_excluded_packages>
                     ]
                   }
               }' \
            {{ api-host-spark }}:{{ port-https }} \
            yandex.cloud.spark.v1.JobService.Create
        ```

        Where:

        * `name`: Spark job name.
        * `spark_job`: Spark job parameters:

            * `args`: Job arguments.
            * `jar_file_uris`: Paths to JAR files.
            * `file_uris`: Paths to files.
            * `file_uris`: Paths to archives.
            * `properties`: Component properties as `key:value` pairs.
            * `main_jar_file_uri`: Path to the main JAR application file in the following format:

                {% include [jar-file-path-requirements](../../_includes/data-processing/jar-file-path-requirements.md) %}

            * `main_class`: Main class name.
            * `packages`: Maven coordinates of the JAR files in `groupId:artifactId:version` format.
            * `repositories`: URLs of additional repositories for package search.
            * `exclude_packages`: Maven coordinates of the packages to exclude, in `groupId:artifactId` format.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Job/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Cancel a job {#cancel}

{% include [jobs-cancel](../../_includes/managed-spark/jobs-cancel.md) %}

## Get a list of jobs {#list}

{% include [jobs-list](../../_includes/managed-spark/jobs-list.md) %}

## Get general information about the job {#get-info}

{% include [jobs-get-info](../../_includes/managed-spark/jobs-get-info.md) %}

## Get job execution logs {#get-logs}

{% include [jobs-get-logs](../../_includes/managed-spark/jobs-get-logs.md) %}
