# Command line interface ({{ yandex-cloud }} CLI)

The [{{ yandex-cloud }} CLI](../../cli/) is downloadable software you can use to manage your cloud resources via the command line.

## Install the {{ yandex-cloud }} CLI {#install}

{% include [install-cli](../../_includes/cli/install-cli.md) %}

## Get authenticated in the {{ yandex-cloud }} CLI {#cli-auth}

To access the {{ yandex-cloud }} CLI, get authenticated using one of the following methods:

{% list tabs group=authentication %}

- Yandex account {#yandex-account}

  {% include [create-profile](../../_includes/cli/create-profile.md) %}

- Federated account {#federated-account}

  {% include [auth-federated-user](../../_includes/cli/auth-federated-user.md) %}

- Service account {#service-account}

  {% include [auth-as-sa](../../_includes/cli/auth-as-sa.md) %}

{% endlist %}

## Test the {{ yandex-cloud }} CLI operation with {{ objstorage-name }}

{% note info %}

To enable debug output in the console, use the `--debug` flag.

{% endnote %}

### Create a bucket {#create-bucket}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

{% include [create-bucket-via-cli](../../_includes/storage/create-bucket-via-cli.md) %}

### Upload an object to the bucket {#upload-object}

{% include [upload-object-via-cli](../../_includes/storage/upload-obect-via-cli.md) %}

### Download an object from the bucket {#download-object}

{% include [upload-object-via-cli](../../_includes/storage/download-from-bucket-via-cli.md) %}