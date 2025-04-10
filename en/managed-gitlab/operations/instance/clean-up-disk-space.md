# Cleaning up full instance disk space

A {{ GL }} instance can run out of disk space. This is indicated by the `500 Internal Server Error` HTTP status code. In which case you will not be able to access the {{ GL }} instance.

You can [increase the instance disk space yourself](instance-update.md).

To reduce the probability of running out of disk space in future:

* Clean up the [instance disk space](#manual-cleanup) manually at regular intervals.
* [Configure disk space cleanup policies](#set-cleanup-policy).

## Clean up the instance disk space {#manual-cleanup}

1. [Manually review]({{ gl.docs }}/ee/user/packages/container_registry/#view-the-container-registry) all Docker images and their tags in {{ GL }} Container Registry.
1. [Delete]({{ gl.docs }}/ee/user/packages/container_registry/delete_container_registry_images.html) outdated images and tags.

## Configure disk space cleanup policies {#set-cleanup-policy}

You can use any of the following options:

* [Set the expiration time for job artifacts]({{ gl.docs }}/ee/administration/settings/continuous_integration.html#default-artifacts-expiration) at the instance level. Its default value is 30 days.
* [Create and enable a tag cleanup policy]({{ gl.docs }}/ee/user/packages/container_registry/reduce_container_registry_storage.html#create-a-cleanup-policy) for separate projects utilizing {{ GL }} Container Registry.
* If you are using a [{{ container-registry-full-name }} integration](../../tutorials/image-storage.md), create and configure a [Docker image cleanup policy](../../../container-registry/concepts/lifecycle-policy.md) for {{ container-registry-full-name }}.
