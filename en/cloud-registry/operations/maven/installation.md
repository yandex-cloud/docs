---
title: Setting up Maven
description: Follow this guide to configure Maven.
---

# Setting up Maven

1. {% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}
1. Open the file with the global Maven settings.

    By default, the configuration file is located in the current user's `.m2` directory (`~/.m2/settings.xml` for Unix-like OSes and `%USERPROFILE%\.m2\settings.xml` for Windows). You can learn more about the configuration file structure in the [Maven documentation](https://maven.apache.org/settings.html).

1. Add a new repository to the `repositories` section of the Maven settings file:

    ```xml
    <repository>
        <id>local</id>
        <url>{{ cloud-registry }}/maven/<registry_ID></url>
    </repository>
    ```

1. Add a new server to the `servers` section of the Maven settings file:

    ```xml
    <server>
        <id>local</id>
        <username>${env.REGISTRY_USERNAME}</username>
        <password>${env.REGISTRY_PASSWORD}</password>
    </server>
    ```
