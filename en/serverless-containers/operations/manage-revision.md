# Managing container revisions

You can [create](#create) a revision, get [information](#get) about it or a [list of container revisions](#list), and [add environment variables](#revision-env).

{% note info %}

To ensure the integrity of version links, you can't update or delete container revisions. When creating a new container revision, the previous one becomes obsolete and unavailable for invocations.

{% endnote %}

To manage container revisions, you need the name or unique ID of the container that this revision belongs to. To get them, [get a list of containers](./list.md).

## Creating a revision {#create}

{% include [create-revision](../../_includes/serverless-containers/create-revision.md) %}

## Getting a list of revisions {#list}

{% include [revision-list](../../_includes/serverless-containers/revision-list.md) %}

## Getting information about a revision {#get}

{% include [revision-get](../../_includes/serverless-containers/revision-get.md) %}

## Adding environment variables {#revision-env}

When you add environment variables, a new container revision is created. You can't add environment variables to an existing revision.

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), go to the folder where the container is located.
    1. Open **{{ serverless-containers-name }}**.
    1. Select the container whose version you want to add an environment variable for.
    1. Go to the **Editor** tab.
    1. In the window that opens, under **Image parameters**, specify the environment variable and click **Add**. You can add multiple environment variables.
    1. Click **Create revision**. A new container revision with the specified environment variables is created.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To add environment variables, run the command:

    {% note warning %}

    If the previous revision contained environment variables, this command overwrites them.

    {% endnote %}

    ```
    yc serverless container revision deploy \
       --container-name <container name> \
       --image <Docker_image_URL> \
       --cores 1 \
       --memory 1GB \
       --service-account-id <service_account_id> \
       --environment <environment_variables>
    ```

    Where:
    
    * `--cores`: Number of cores available for the container.
    * `--memory`: Required memory. The default is 128 MB.
    * `--environment`: Environment variables in `key=value` format. You can specify multiple pairs separated by commas.

{% end list %}

