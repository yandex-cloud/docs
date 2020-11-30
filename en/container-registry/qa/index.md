# Questions and answers about {{ container-registry-short-name }}

#### Why is the "latest" tag missing or why is it assigned to a Docker image that wasn't the last one pushed? {#latest}

The reason is that you specified a different tag when pushing the Docker image.

The Docker client assigns the `latest` tag automatically if the Docker image is created and pushed without a tag. You can also specify the `latest` tag explicitly.

{% include [latest-info](../../_includes/container-registry/info-about-latest.md) %}

#### How do I make a registry public? {#public-registry}

You can issue the [container-registry.images.puller](../security/index.md) role for your registry to the [allUsers](../../iam/concepts/access-control/system-group.md) system group.

{% note alert %}

This makes all images in the registry available without authentication.

Don't assign the `container-registry.images.pusher`, `editor` or `admin` roles to the system group for the registry. This would allow anyone who learns your registry ID to use it at your expense.

{% endnote %}

#### I encountered an error. What should I do? {#error}

See [{#T}](../error/index.md). It lists common errors and ways to solve them.

{% include [qa-logs.md](../../_includes/qa-logs.md) %}