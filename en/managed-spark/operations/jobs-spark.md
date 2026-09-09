---
title: How to manage Spark jobs in {{ msp-full-name }}
description: In this guide, you will learn how to manage Spark jobs in {{ msp-full-name }}.
---

# Managing Spark jobs

## Creating a job {#create}

{% note warning %}

Once created, the job will run automatically.

{% endnote %}

To create a job:

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder.
    1. [Navigate]({{ link-console-main }}/link/managed-spark) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Click the cluster name and go to **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}**.
    1. Click **{{ ui-key.yacloud.spark.jobs.create_action }}**.
    1. Enter the job name.
    1. Select an existing [service account](../../iam/concepts/users/service-accounts.md) or [create a new one](../../iam/operations/sa/create.md).
    1. Select the environment the job will be executed in. Here are available options:
       * **{{ ui-key.yacloud.spark.EnvironmentSelect.field_environment_cluster_sP4vs }}**: Environment specified in the cluster parameters.
       * **{{ ui-key.yacloud.spark.EnvironmentSelect.base_environments_fq7iF }}**: One of several base environments with preinstalled {{ SPRK }} and Python versions.
       * **{{ ui-key.yacloud.spark.EnvironmentSelect.user_environments_fwNXU }}**: One of the [custom environments you created](environment-create.md).
    1. In the **{{ ui-key.yacloud.dataproc.jobs.field_job-type }}** field, select `{{ ui-key.yacloud.dataproc.jobs.field_spark-job-type }}`.
    1. In the **{{ ui-key.yacloud.dataproc.jobs.field_main-jar }}** field, specify the path to the application's main JAR file in the following format:

        {% include [jar-file-path-requirements](../../_includes/managed-spark/jar-file-path-requirements.md) %}

    1. In the **{{ ui-key.yacloud.dataproc.jobs.field_main-class }}** field, specify the name of the main application class.
    1. Specify job arguments.

        {% include [job-properties-requirements](../../_includes/managed-spark/job-properties-requirements.md) %}

    1. Optionally, specify the paths to JAR files, if any.
    1. Optionally, configure advanced settings:

        * Specify paths to the required files and archives.
        * In the **{{ ui-key.yacloud.dataproc.jobs.field_properties }}** field, specify [{{ SPRK }} properties](../concepts/spark-properties.md) as `key-value` pairs.
        * Specify the coordinates of included and excluded Maven packages as well as URLs of additional repositories for package search.

    1. Click **{{ ui-key.yacloud.dataproc.jobs.button_create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a Spark job:

    1. See the description of the CLI command for creating a job:

        ```bash
        {{ yc-mdb-sp }} job create-spark --help
        ```
    
    1. Create a job by running this command:

        ```bash
        {{ yc-mdb-sp }} job create-spark \
          --cluster-id <cluster_ID> \
          --name <job_name> \
          --main-class <main_class_name> \
          --main-jar-file-uri <path_to_main_JAR_file> \
          --jar-file-uris <list_of_paths_to_JAR_files> \
          --file-uris <list_of_paths_to_files> \
          --archive-uris <list_of_paths_to_archives> \
          --packages <list_of_package_Maven_coordinates> \
          --repositories <list_of_URLs_of_repositories_for_package_search> \
          --exclude-packages <list_of_Maven_coordinates_of_excluded_packages> \
          --properties <list_of_Apache_Spark™_properties> \
          --args <list_of_arguments> 
        ```

        Where:

        * `--cluster-id`: Cluster ID.

          You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        * `--name` (optional): Job name.
        * `--main-class`: Main class name.
        * `--main-jar-file-uri`: Path to the application's main JAR file.
        * `--jar-file-uris`: List of paths to JAR files.
        * `--file-uris`: List of paths to files.
        * `--archive-uris`: List of paths to archives.
        * `--packages`: List of Maven coordinates of packages in `groupId:artifactId:version` format.
        * `--repositories`: List of URLs of additional repositories for package search.
        * `--exclude-packages`: List of Maven coordinates of the packages to exclude, in `groupId:artifactId` format.
        * `--properties`: List of [{{ SPRK }} properties](../concepts/spark-properties.md) in `key=value` format.
        * `--args`: List of application arguments.

        Available file formats:
          
          {% include [jar-file-path-requirements](../../_includes/managed-spark/jar-file-path-requirements.md) %}

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [JobService/Create](../api-ref/grpc/Job/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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
                   "service_account_id": "<service_account_ID>",
                   "environment_id": "<environment_ID>",
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
                       <list_of_Apache_Spark™_properties>
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

        * `cluster_id`: Cluster ID. You can get it with the [list of clusters in the folder](cluster-list.md#list-clusters).
        * `name`: Spark job name.
        * `service_account_id`: ID of the service account you want to use to run the job.
        * `environment_id`: ID of the base or custom environment the job will be run in. Call the [EnvironmentService/List](../environment/api-ref/grpc/Environment/list.md) method to get the custom environment ID or [EnvironmentService/ListBase](../environment/api-ref/grpc/Environment/listBase.md) to get the base environment ID.
        * `spark_job`: Spark job parameters:

            * `args`: Job arguments.
            * `jar_file_uris`: Paths to JAR files.
            * `file_uris`: Paths to files.
            * `archive_uris`: Paths to archives.
            * `properties`: [{{ SPRK }} properties](../concepts/spark-properties.md) as `key:value` pairs.
            * `main_jar_file_uri`: Path to the application's main JAR file in the following format:

                {% include [jar-file-path-requirements](../../_includes/managed-spark/jar-file-path-requirements.md) %}

            * `main_class`: Main class name.
            * `packages`: Maven coordinates of packages in `groupId:artifactId:version` format.
            * `repositories`: URLs of additional repositories for package search.
            * `exclude_packages`: Maven coordinates of the packages to exclude, in `groupId:artifactId` format.

    1. Check the [server response](../api-ref/grpc/Job/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Canceling a job {#cancel}

{% include [jobs-cancel](../../_includes/managed-spark/jobs-cancel.md) %}

## Getting a list of jobs {#list}

{% include [jobs-list](../../_includes/managed-spark/jobs-list.md) %}

## Getting general info about a job {#get-info}

{% include [jobs-get-info](../../_includes/managed-spark/jobs-get-info.md) %}

## Getting job execution logs {#get-logs}

{% include [jobs-get-logs](../../_includes/managed-spark/jobs-get-logs.md) %}
