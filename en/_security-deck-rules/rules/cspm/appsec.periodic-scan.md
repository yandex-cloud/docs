### When creating a registry in Yandex Container Registry, keep the safe registry settings by default {#periodic-scan}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | appsec.periodic-scan ||
|#

#### Description

When creating a new [registry](https://yandex.cloud/en/docs/container-registry/concepts/registry), use the default options to make sure it meets the Yandex Cloud security standard:

* Docker images are automatically scanned as they are uploaded to the registry. * Docker images in the registry are regularly re-scanned, i.e., every 7 days with an option to switch to daily scanning in the settings.

#### Instructions and solutions

**Guides and solutions to use:**

1. In the [management console](https://console.yandex.cloud/), select the folder where you want to create a registry. 2. In the list of services, select **Container Registry**. 3. Click **Create registry**. 4. In the **Name** field, enter a name for the registry. The naming requirements are as follows:

* It must be from 2 to 63 characters long. * It can only contain lowercase Latin letters, numbers, and hyphens. * It must start with a letter and cannot end with a hyphen. 5. Under **Automatic scanning**:

* Keep **Scan Docker images on push** enabled to scan Docker images at their upload to the repository. * Keep **Scan all Docker images in the registry** enabled. Adjust the scanning frequency if you need to. 6. Click **Create registry**.
