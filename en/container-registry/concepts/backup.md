---
title: Backing up Docker images
description: Data in {{ container-registry-name }} is stored securely and replicated in the {{ yandex-cloud }} infrastructure. However, you can create backups of Docker images at any time. To back up your Docker images, follow the instructions in this article.
---

# Backing up Docker images in {{ container-registry-name }}

Data in {{ container-registry-name }} is stored securely and replicated in the {{ yandex-cloud }} infrastructure. However, you can create backups of [Docker images](../concepts/docker-image.md) at any time.

To back up your Docker images:

1. View the list of available [registries](registry.md):

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder where you want to view the list of registries.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
     1. You can see a list of registries on the **{{ ui-key.yacloud.cr.switch_registry }}** tab.

   - CLI {#cli}

     {% include [cli-install](../../_includes/cli-install.md) %}
     
     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     ```bash
     yc container registry list
     ```

     Result:

     ```text
     +----------------------+-------------+----------------------+
     |          ID          |   NAME      |      FOLDER ID       |
     +----------------------+-------------+----------------------+
     | crp1abc2tl3d******** | my-registry | b1g23ga82bcv******** |
     +----------------------+-------------+----------------------+
     ```

   - API {#api}

     Use the [list](../api-ref/Registry/list.md) method for the [Registry](../api-ref/Registry/) resource.

   {% endlist %}

1. Get information about Docker images in each registry:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder where you want to view information about Docker images.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
     1. On the **{{ ui-key.yacloud.cr.switch_registry }}** tab, click the name of the registry.
     1. On the **{{ ui-key.yacloud.cr.registry.overview.section_repositories }}** page, click the name of the repository.
     1. On the **{{ ui-key.yacloud.cr.registry.overview.section_images }}** page you can see the Docker images.

   - CLI {#cli}

     ```bash
     yc container image list --registry-name my-registry
     ```

     Where `registry-name` is the registry name.

     Result:

     ```text
     +----------------------+---------------------+-----------------------------+-------+-----------------+
     |          ID          |       CREATED       |            NAME             | TAGS  | COMPRESSED SIZE |
     +----------------------+---------------------+-----------------------------+-------+-----------------+
     | crpabcpg1pde******** | 2020-10-26 15:45:39 | crp1abc2tl3d********/ubuntu | hello | 27.2 MB         |
     +----------------------+---------------------+-----------------------------+-------+-----------------+
     ```

   - API {#api}

     Use the [list](../api-ref/Image/list.md) method for the [Image](../api-ref/Image/) resource.

   {% endlist %}

1. Download the Docker images you want from each registry using their full address, `{{ registry }}/<name>:<tag>`:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     docker pull {{ registry }}/<registry_ID>/ubuntu:hello
     ```

     Result:

     ```text
     hello: Pulling from crp1abc2tl3d********/ubuntu
     Digest: sha256:1d2b339619babc2d008eca2d5293e3c43ff84cbee597ff76dd3e7f7d********
     Status: Downloaded newer image for {{ registry }}/crp1abc2tl3d********/ubuntu:hello
     {{ registry }}/crp1abc2tl3d********/ubuntu:hello
     ```

   {% endlist %}

1. Make sure the Docker image has been pulled:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     docker image list
     ```

     Result:

     ```text
     REPOSITORY                                   TAG     IMAGE ID      CREATED     SIZE
     {{ registry }} /crp1abc2tl3d********/ubuntu       hello   d12e********  3 days ago  72.9MB
     ubuntu                                       latest  d12e********  3 days ago  72.9MB
     ```

   {% endlist %}