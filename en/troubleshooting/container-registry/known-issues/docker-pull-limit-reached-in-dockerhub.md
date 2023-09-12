# Exceeded limits on images uploaded from a DockerHub folder

## Issue description {#case-description}
When you use `docker pull <image-name>` to pull an image from Docker Hub, you get the error:
`toomanyrequests: You have reached your pull rate limit. You may increase the limit by authenticating and upgrading: https://www.docker.com/increase-rate-limit`

## Solution {#case-resolution}
The error message says that you exceeded the limit on image pulls from DockerHub.

Due to the changes in the [Docker Terms of Service](https://www.docker.com/increase-rate-limits/) announced in November 2020, the following limitations apply to container pulls from DockerHub:
- For non-authenticated users: 200 pulls per 6 hours.
- Free plan for authenticated users: 200 pulls per 6 hours.
- Pro plan: 50,000 pulls per 24 hours.
- Team plan: 50,000 pulls per 24 hours.


To bypass the image pull rate limit, you can use [Yandex Container Registry](../../../container-registry/quickstart/index.md).
First upload images from Docker Hub to your local instance and then move them to Container Register that has no such limits.

In Container Register, you only pay for image storage. However, if multiple [Docker images](../../../container-registry/concepts/docker-image.md) in the same registry use the same layers, you will not pay for each layer every time you use it. A layer's [digest](../../../container-registry/concepts/docker-image.md#version) indicates whether the layer is unique.

You can learn more about Container Registry pricing terms [here](../../../container-registry/pricing.md).