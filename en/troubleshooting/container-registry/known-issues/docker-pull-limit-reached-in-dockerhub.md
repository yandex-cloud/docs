# Exceeded limits on images uploaded from a Docker Hub folder


## Issue description {#issue-description} 

When you use `docker pull <image-name>` to pull an image from Docker Hub, you get this error:
```
toomanyrequests: You have reached your pull rate limit. You may increase the limit by authenticating and upgrading: https://www.docker.com/increase-rate-limit
```

## Solution {#issue-resolution}

The error message tells you that you exceeded the limit on image pulls from Docker Hub. 

Due to the changes in the [Docker Terms of Service](https://www.docker.com/increase-rate-limits/) announced in November 2020, the following limitations apply to container pulls from Docker Hub:

* For non-authenticated users: 200 pulls per 6 hours.
* Free plan for authenticated users: 200 pulls per 6 hours.
* Pro plan: 50,000 pulls per 24 hours.
* Team plan: 50,000 pulls per 24 hours.

You can use [{{ container-registry-full-name }}](../../../container-registry/quickstart/index.md) to bypass this limit. First upload images from Docker Hub to your local machine, and then move them to {{ container-registry-name }}, which has no such limits.

In {{ container-registry-name }}, you only pay for actual image storage. However, if multiple [Docker images](../../../container-registry/concepts/docker-image.md) in the same registry use the same layers, you will not pay for each layer every time you use it. Whether the layer is unique is determined by its [hash](../../../container-registry/concepts/docker-image.md#version).

You can learn more about {{ container-registry-name }} pricing policy [here](../../../container-registry/pricing.md).