### When creating a registry in Yandex Container Registry, keep the safe registry settings by default {#secure-registry}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | appsec.secure-registry ||
|#

#### Description

The lack of control over new Docker images leads to risks associated with the following factors:

* use of vulnerable containers;
* introduction of malicious code;
* slower response to threats.

Automatic vulnerability scanning when new images are added to the Container Registry will help reduce these risks.

#### Guides and solutions to use

1. In the [management console](https://console.yandex.cloud/), select the folder where you want to create a registry.
2. Go to Container Registry.
3. Click **Create registry**.
4. Specify a name for the registry. Follow these naming requirements:

    * Length: between 3 and 63 characters.
    * It can only contain lowercase Latin letters, numbers, and hyphens.
    * It must start with a letter and cannot end with a hyphen.
5. Under **Automatic scanning**:

    * Keep the **Scan Docker images on push** option enabled to scan Docker images at their upload to the repository.
    * Keep the **Scan all Docker images in the registry** option enabled, and set scanning frequency if necessary.
6. Click **Create registry**.