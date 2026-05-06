# Cleaning up full instance disk space

A {{ GL }} instance can run out of disk space. This is indicated by the `500 Internal Server Error` HTTP status code. In this case, you will not be able to sign in to the {{ GL }} instance.

You can [increase the instance disk space](instance-update.md) on your own.

To prevent disk space from filling up in the future:

* Regularly clean up the [instance disk space](#manual-cleanup) manually.
* Periodically [delete irrelevant pipelines](#pipeline-cleanup).
* [Configure disk space cleanup policies](#set-cleanup-policy).

You can also set up alerts for the **Data disk** chart in [Monitoring](./monitoring.md#monitoring-integration).

## Clean up the instance disk space {#manual-cleanup}

1. [Manually review]({{ gl.docs }}/ee/user/packages/container_registry/#view-the-container-registry) all Docker images and their tags in {{ GL }} Container Registry.
1. [Delete]({{ gl.docs }}/ee/user/packages/container_registry/delete_container_registry_images.html) obsolete images and tags.

## Delete obsolete pipelines {#pipeline-cleanup}

Pipelines create jobs, which in turn generate logs. The longer and more actively you use a {{ GL }} instance, the more disk space you need to store logs. To free up space, you can [delete irrelevant pipelines]({{ gl.docs }}/ci/pipelines/#delete-a-pipeline), thus also deleting jobs with their logs.

In the {{ GL }} web UI, you can only delete one pipeline at a time. To bulk delete irrelevant pipelines and their logs, use the following script:

{% note warning %}

Once you run it, the script will immediately permanently bulk delete the pipelines and all associated data, such as jobs, logs, artifacts, and triggers. You cannot undo this action.

{% endnote %}

{% note info %}

For the script to work correctly, download and install [jq](https://stedolan.github.io/jq/download/).

{% endnote %}

```bash
#!/bin/sh
set -e

TOKEN=<your_token>
PER_PAGE=<number_of_pipelines_to_delete>
UPDATED_BEFORE=<date_of_last_update>
GITLAB_URL=<{{ GL }}_instance_FQDN>

for PROJECT in $(curl -sL --header "PRIVATE-TOKEN: $TOKEN" "$GITLAB_URL/api/v4/projects?per_page=$PER_PAGE" | jq '.[].id') ; do
  echo "Deleting in project $PROJECT"
  for PIPELINE in $(curl -sL --header "PRIVATE-TOKEN: $TOKEN" "$GITLAB_URL/api/v4/projects/$PROJECT/pipelines?per_page=$PER_PAGE&sort=asc&updated_before=${UPDATED_BEFORE}T00:00:00Z" | jq '.[].id') ; do
      echo "Deleting pipeline $PIPELINE"
      curl -L --header "PRIVATE-TOKEN: $TOKEN" --request "DELETE" "$GITLAB_URL/api/v4/projects/$PROJECT/pipelines/$PIPELINE"
  done
done

```

Where:
* `TOKEN`: [{{ GL }} token]({{ gl.docs }}/user/profile/personal_access_tokens/) of the user with the `Owner` role in the project. 
* `PER_PAGE`: Number of pipelines to delete per request. You can delete a maximum of 100 pipelines at a time. If you have more, you will need to run the script several times.
* `UPDATED_BEFORE`: Upper limit of the update date in `YYYY-MM-DD` format. The script will delete all pipelines updated prior to this date.
* `GITLAB_URL`: {{ GL }} instance FQDN.

## Configure disk space cleanup policies {#set-cleanup-policy}

You can use any of the following options:

* [Set the expiration time for build artifacts]({{ gl.docs }}/ee/administration/settings/continuous_integration.html#default-artifacts-expiration) at the instance level. By default, it is 30 days.
* [Create and enable a tag cleanup policy]({{ gl.docs }}/ee/user/packages/container_registry/reduce_container_registry_storage.html#create-a-cleanup-policy) for individual projects using {{ GL }} Container Registry.
* If you are using the [{{ container-registry-full-name }} integration](../../tutorials/image-storage.md), set up a [Docker image cleanup policy](../../../container-registry/concepts/lifecycle-policy.md) within {{ container-registry-full-name }}.
