### Docker images are scanned when uploaded to Container Registry {#periodic-scan}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | appsec.periodic-scan ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for Docker image scanning policies in Container Registry.

{% endnote %}

When creating a new [registry](https://yandex.cloud/en/docs/container-registry/concepts/registry), use the default options to make sure it meets the Yandex Cloud security standard:

* Docker images are automatically scanned as they are uploaded to the registry.

* Docker images in the registry are regularly re-scanned, i.e., every 7 days with an option to switch to daily scanning in the settings.

**How to manually check rule:**

1. In the [management console](https://console.yandex.cloud/), select the folder the registry with Docker images belongs to.

2. Select the appropriate registry in **Container Registry**.

3. Navigate to the **Vulnerability scanner** tab and click **Edit settings**.

4. Make sure that scheduled Docker image scans are enabled with a frequency of at least once a week.

#### Guides and solutions

Guides and solutions to use:

* [Guide on scheduled scanning of Docker images](https://yandex.cloud/en/docs/container-registry/operations/scanning-docker-image#scheduled)