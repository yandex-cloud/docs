### Container images used in the production environment have the last scan date of one week ago or less {#registry-recently-scan}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | appsec.registry-recently-scan ||
|#

#### Description

Checking Docker images used in production environments with the last scan date not older than a week ensures that you continuously monitor and update security measures, eliminating potential vulnerabilities that might have occurred since the last scan. This also helps you make sure you are not deploying containers with recently detected vulnerabilities and enhance the security level. 

You can automate this process by setting up a [schedule](https://yandex.cloud/en/docs/container-registry/operations/scanning-docker-image#scheduled).

#### Guides and solutions to use

**Guides and solutions to use:**

[Set up](https://yandex.cloud/en/docs/container-registry/operations/scanning-docker-image#scheduled) automatically scheduled Docker images scanning for vulnerabilities 
