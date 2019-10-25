# All questions on the same page

#### Why is the "latest" tag missing or why is it assigned to a Docker image that isn't the last one pushed? {#latest}

The reason is that you specified a different tag when pushing the image.

The Docker client assigns the `latest` tag automatically if the Docker image is created and pushed without a tag. You can also specify the `latest` tag explicitly.

{% include [latest-info](../../_includes/container-registry/info-about-latest.md) %}

#### I encountered an error. What should I do? {#error}

See [{#T}](../error/index.md). It lists common errors and ways to solve them.

