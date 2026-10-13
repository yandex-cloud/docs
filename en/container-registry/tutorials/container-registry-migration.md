---
title: Migrating from {{ container-registry-name }} to {{ cloud-registry-name }}
description: This tutorial explains how to migrate from {{ container-registry-name }} to {{ cloud-registry-name }}.
---

# Migrating from {{ container-registry-name }} to {{ cloud-registry-name }}

{% include [sunset](../../_includes/container-registry/sunset.md) %}

There are two ways to launch migration:

* **Across folder**: You migrate all registries in the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) of your choice.
* **Across cloud**: You migrate all registries in all folders of the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) of your choice.

When you start migrating, it starts running in all registries in the folder or cloud concurrently. You can it launch it only for specific registries. If your folder or cloud houses any registries you do not need, make sure to delete them prior to running your migration.

Both registry IDs and Docker image addresses persist after migration, so you will not have to edit links to Docker images.

When migrating, the system will transfer all data and metadata from {{ container-registry-name }} to {{ cloud-registry-name }}, which includes:
* Registry metadata.
* Access permission settings, such as permissions to access a registry and repositories within it.
* IP address access policies.
* Lifecycle policies.
* Scan settings.
* Registry aliases.

## Getting started {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

1. Get the cloud or folder ID (depending on which type of migration you are running) and save it to a variable:

    * For folder migration, [get the folder ID](../../resource-manager/operations/folder/get-id.md) and save it to `FOLDER_ID`:

        ```bash
        export FOLDER_ID="<folder_ID>"
        ```

    * For cloud migration, [get the cloud ID](../../resource-manager/operations/cloud/get-id.md) and save it to `CLOUD_ID`:

        ```bash
        export CLOUD_ID="<cloud_ID>"
        ```

1. [Assign](../../iam/operations/roles/grant.md) the following [roles](../../iam/concepts/access-control/roles.md) for the cloud or folder (depending on which type of migration you are running):

    * `cloud-registry.registries.migrationRunner`: For the [subject](../../iam/concepts/access-control/index.md#subject) ([user](../../iam/concepts/users/accounts.md) or [service account](../../iam/concepts/users/service-accounts.md)) that will be launching migration. This role includes the permission to launch migration (`cloud-registry.registries.startMigration`) and view its status (`cloud-registry.registries.getMigrationStatus`).

        To assign this role, you must be the resource owner or admin.

    * `cloud-registry.registries.migrationViewer`: For subjects that only need to track the migration status.

    * `container-registry.images.puller` and `container-registry.images.pusher`: For subjects that will run test Docker pull and push. These roles do not grant access to Docker images.

    For more on how to assign roles, see [{#T}](../../iam/operations/roles/grant.md).

## Start migration {#start-migration}

You may want to use `--async`: this way, you will get the operation ID without needing to wait until it completes.

{% list tabs group=migration_scope %}

- Folder migration {#folder}

    ```bash
    yc cloud-registry v1 migration start-folder "$FOLDER_ID" \
      --profile <profile_name> \
      --async \
      --format json
    ```

- Cloud migration {#cloud}

    ```bash
    yc cloud-registry v1 migration start-cloud "$CLOUD_ID" \
      --profile <profile_name> \
      --async \
      --format json
    ```

{% endlist %}

The `id` field that will be returned means the operation ID.

{% note warning %}

Before running this command again, check the current operation’s status.

{% endnote %}

To get the status, run the following command:

```bash
yc cloud-registry v1 operation get <operation_ID> --profile <profile_name>
```

If the operation is complete, the migration is also complete. To see how the data transfer is going, you can view the [migration dashboard](#check-overall-status).

### Managing redirects when launching migration {#disable-redirects-on-start}

By default, launching registry migration triggers redirects, which means all requests to `{{ registry }}` get redirected to {{ cloud-registry-name }}. This allows you to use the current address without changing anything in your infrastructure.

If this is not an option for you and you want to split your traffic, i.e., send requests to `{{ registry }}` to {{ container-registry-name }}, and those to `registry.yandexcloud.net`, to {{ cloud-registry-name }}, launch migration using `--disable-redirects`:

{% list tabs group=migration_scope %}

- Folder migration {#folder}

    ```bash
    yc cloud-registry v1 migration start-folder "$FOLDER_ID" \
      --profile <profile_name> \
      --disable-redirects \
      --async \
      --format json
    ```

- Cloud migration {#cloud}

    ```bash
    yc cloud-registry v1 migration start-cloud "$CLOUD_ID" \
      --profile <profile_name> \
      --disable-redirects \
      --async \
      --format json
    ```

{% endlist %}

When redirects are disabled, {{ container-registry-name }} and {{ cloud-registry-name }} work as two independent data copies. If you apply this configuration, make sure to update your links from `{{ registry }}` to `registry.yandexcloud.net`.

You can also enable or disable redirects later on. For details, see [{#T}](#toggle-redirects).

## Check the migration status {#check-overall-status}

View the migration dashboard to see the overall status, registry, repository, and tag count, and objects with errors and those currently being migrated.

To open this dashboard, run:

{% list tabs group=migration_scope %}

- Folder migration {#folder}

    ```bash
    yc cloud-registry v1 migration get-folder-migration-status-dashboard "$FOLDER_ID" \
      --profile <profile_name>
    ```

- Cloud migration {#cloud}

    ```bash
    yc cloud-registry v1 migration get-cloud-migration-status-dashboard "$CLOUD_ID" \
      --profile <profile_name>
    ```

{% endlist %}

The status meanings are as follows:

| Status | Meaning |
|---|---|
| `CREATED` | Object added to migration queue |
| `SCHEDULED` | Object migration scheduled |
| `IN_PROGRESS` | Data being transferred |
| `COMPLETED` | Migration complete |
| `FAILED` | Migration error |

The migration is complete if:

* The overall status is `COMPLETED`.
* `failed` is `0` for registries, repositories, and tags.
* `completed`is `total`.

Docker pull and push requests depend on the migration status:

* `CREATED`: Docker pull requests go to {{ container-registry-name }}. Docker push requests may temporary end with the `429 Too Many Requests` error and `Retry-After` header; in this case, just run your request again after the time specified.
* `SCHEDULED`: all Docker pull and push requests are redirected to {{ cloud-registry-name }}.

## Managing redirects after migration {#toggle-redirects}

You can also enable or disable redirects after migration, both for a specific registry, all registries in a folder, or in the cloud. For this, use `--enabled`:
* `true` means the redirects are on, and the requests to `{{ registry }}` go to {{ cloud-registry-name }}.
* `false` means the redirects are off, and the requests to `{{ registry }}` still go to {{ container-registry-name }}.

{% list tabs group=redirect_scope %}

- Registry {#registry}

    ```bash
    yc cloud-registry v1 migration toggle-registry-redirects <registry_ID> \
      --profile <profile_name> \
      --enabled=<true_or_false>
    ```

- Folder {#folder}

    ```bash
    yc cloud-registry v1 migration toggle-folder-redirects "$FOLDER_ID" \
      --profile <profile_name> \
      --enabled=<true_or_false>
    ```

- Cloud {#cloud}

    ```bash
    yc cloud-registry v1 migration toggle-cloud-redirects "$CLOUD_ID" \
      --profile <profile_name> \
      --enabled=<true_or_false>
    ```

{% endlist %}

## Check Docker pull and push {#check-docker-pull-push}

If the redirects are:
* On: You can use the same {{ container-registry-name }} address, i.e., `{{ registry }}`.
* Off: You need to use the {{ cloud-registry-name }} address, i.e., `registry.yandexcloud.net`.

Save the registry ID to `REGISTRY_ID`:

```bash
export REGISTRY_ID="<registry_ID>"
```

Save the repository name to `REPOSITORY_NAME`:

```bash
export REPOSITORY_NAME="<repository_name>"
```

Save the local Docker image name to `LOCAL_IMAGE`:

```bash
export LOCAL_IMAGE="<Docker_image_name>"
```

Save the Docker image tag to `TAG`:

```bash
export TAG="<tag>"
```

Check whether the Docker pull and push commands run correctly:

```bash
yc iam create-token --profile <profile_name> \
  | docker login --username iam --password-stdin {{ registry }}

docker pull \
  "{{ registry }}/$REGISTRY_ID/$REPOSITORY_NAME:$TAG"

docker tag "$LOCAL_IMAGE" \
  "{{ registry }}/$REGISTRY_ID/migration-check:test"

docker push \
  "{{ registry }}/$REGISTRY_ID/migration-check:test"
```

The hash of the image you downloaded should match the one before you launched migration. After running Docker push, the new tag should appear in {{ cloud-registry-name }}.

## If the migration terminated with an error {#contact-support}

If your migration failed, reach out to our [support]({{ link-console-support }}). In your ticket, include:

* The ID of the cloud or folder you were running migration for.
* Migration dashboard as JSON.
* Error time and request ID, if you have one in the CLI output.
