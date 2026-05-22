### ACL by IP address is set up for Yandex Container Registry {#acl-container-registry}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | access.acl-container-registry ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for ACL settings on Container Registry instances.

{% endnote %}

It is recommended that you limit access to your Container Registry to specific IPs.

1. In the management console, select the cloud or folder to check the registry in.
2. In the list of services, select **Container Registry**.
3. In the settings of the specific registry, go to the **Access for IP address** tab.
4. If specific IPs to allow access for are set in the parameters, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

#### Guides and solutions

Guides and solutions to use:

1. In the management console, select the cloud or folder to check the VMs in.
2. In the list of services, select **Compute Cloud**.
3. Open the settings of a specific VM with a **Container Optimized Image**.
4. In the Docker container's Settings, disable the **Privileged mode** parameter.