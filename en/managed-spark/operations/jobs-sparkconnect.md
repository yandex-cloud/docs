---
title: How to manage SparkConnect jobs in {{ msp-full-name }}
description: You will learn how to manage SparkConnect jobs in {{ msp-full-name }}.
---

# Managing SparkConnect jobs

{% include notitle [preview](../../_includes/note-preview.md) %}

## Creating a job {#create}

{% note warning %}

Once created, the job will run automatically.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Click the name of your cluster and open the **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}** tab.
    1. Click **{{ ui-key.yacloud.spark.jobs.create_action }}**.
    1. Enter the job name.
    1. In the **{{ ui-key.yacloud.dataproc.jobs.field_job-type }}** field, select `SparkConnect`.
    1. Optionally, configure advanced settings:

        * Specify paths to required files and archives.
        * Specify paths to your JAR files in the following format:

          {% include [jar-file-path-requirements](../../_includes/managed-spark/jar-file-path-requirements.md) %}

        * In the **{{ ui-key.yacloud.dataproc.jobs.field_properties }}** field, specify component properties as `key-value` pairs.
        * Specify the coordinates of included and excluded Maven packages as well as URLs of additional repositories for package search.

    1. Click **{{ ui-key.yacloud.dataproc.jobs.button_create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a SparkConnect job:

    1. See the description of the CLI command for creating a job:

        ```bash
        yc managed-spark job create-spark-connect --help
        ```
    
    1. Create a job by running this command:

        ```bash
        yc managed-spark job create-spark-connect \
          --cluster-id <cluster_ID> \
          --name <job_name> \
          --jar-file-uris <list_of_paths_to_JAR_files> \
          --file-uris <list_of_paths_to_files> \
          --archive-uris <list_of_paths_to_archives> \
          --packages <list_of_package_Maven_coordinates> \
          --repositories <list_of_URLs_of_repositories_for_package_search>\
          --exclude-packages <list_of_Maven_coordinates_of_excluded_packages> \
          --properties <list_of_properties> 
        ```

        Where:

        * `--cluster-id`: Cluster ID.

          You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        * `--name` (optional): Job name.
        * `--jar-file-uris`: List of paths to JAR files in the following format:
          
          {% include [jar-file-path-requirements](../../_includes/managed-spark/jar-file-path-requirements.md) %}
        
        * `--file-uris`: List of paths to files.
        * `--archive-uris`: List of paths to archives.
        * `--packages`: List of Maven coordinates of JAR files in `groupId:artifactId:version` format.
        * `--repositories`: List of URLs of additional repositories for package search.
        * `--exclude-packages`: List of Maven coordinates of the packages to exclude, in `groupId:artifactId` format.
        * `--properties`: List of component properties in `key=value` format.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

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
            "spark_connect_job": {
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
              "packages": [
                <list_of_package_Maven_coordinates>
              ],
              "repositories": [
                <list_of_URLs_of_repositories_for_package_search>
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

        * `cluster_id`: Cluster ID.

            You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).
        
        * `name` (optional): Job name.
        * `spark_connect_job`: SparkConnect job parameters:

            * `jar_file_uris`: List of paths to JAR files in the following format:
              
              {% include [jar-file-path-requirements](../../_includes/managed-spark/jar-file-path-requirements.md) %}

            * `file_uris`: List of paths to files.
            * `archive_uris`: List of paths to archives.
            * `properties`: List of component properties in `"key":"value"` format.
            * `packages`: List of Maven coordinates of JAR files in `groupId:artifactId:version` format.
            * `repositories`: List of URLs of additional repositories for package search.
            * `exclude_packages`: List of Maven coordinates of the packages to exclude, in `groupId:artifactId` format.

    1. View the [server response](../api-ref/grpc/Job/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

For running SparkConnect jobs, there is an endpoint available you can use to connect via PySpark. You can get the endpoint with the [job information](#get-info). Its value is specified in the `connect_url` field.

> For example: `sc://connect-api-c9q9veov4uql********-c9q8ml85r1oh********.spark.yandexcloud.net:443`.

## Cancel a job {#cancel}

{% include [jobs-cancel](../../_includes/managed-spark/jobs-cancel.md) %}

## Get a list of jobs {#list}

{% include [jobs-list](../../_includes/managed-spark/jobs-list.md) %}

## Get general info about a job {#get-info}

{% include [jobs-get-info](../../_includes/managed-spark/jobs-get-info.md) %}

## Get job execution logs {#get-logs}

{% include [jobs-get-logs](../../_includes/managed-spark/jobs-get-logs.md) %}