# Backups

Data in {{ container-registry-name }} is stored securely and replicated in the {{ yandex-cloud }} infrastructure. However, you can create backups of [Docker images](../concepts/docker-image.md) at any time.

To back up your Docker images:

1. View the list of available [registries](registry.md):

   {% list tabs %}

   - Management console
     1. In [management console]({{ link-console-main }}), select the folder where you want to view a list of registries.
     1. Select the **{{ container-registry-name }}**.
     1. You can see a list of registries on the **Registries** tab.

   - CLI

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     ```bash
     yc container registry list
     ```

     Command execution result:

     ```bash
     +----------------------+-------------+----------------------+
     |          ID          |   NAME      |      FOLDER ID       |
     +----------------------+-------------+----------------------+
     | crp1abc2tl3def1h2gu6 | my-registry | b1g23ga82bcv0cdeferg |
     +----------------------+-------------+----------------------+
     ```

   - API

     Use the [list](../api-ref/Registry/list.md) method for the [Registry](../api-ref/Registry/) resource.

   {% endlist %}

1. Get information about Docker images in each registry:

   {% list tabs %}

   - Management console
     1. In [management console]({{ link-console-main }}), select the folder where you want to view information about Docker images.
     1. Select the **{{ container-registry-name }}**.
     1. On the **Registries**  tab, click the name of the registry.
     1. On the **Repositories** page, click the name of the repository.
     1. On the **Docker images** page you can see the Docker images.

   - CLI

     ```bash
     yc container image list --registry-name my-registry
     ```

     Where:
     * `registry-name`: Registry name.

     Execution result:

     ```bash
     +----------------------+---------------------+-----------------------------+-------+-----------------+
     |          ID          |       CREATED       |            NAME             | TAGS  | COMPRESSED SIZE |
     +----------------------+---------------------+-----------------------------+-------+-----------------+
     | crpabcpg1pde2f33ekp4 | 2020-10-26 15:45:39 | crp1abc2tl3def1h2gu6/ubuntu | hello | 27.2 MB         |
     +----------------------+---------------------+-----------------------------+-------+-----------------+
     ```

   - API

     Use the [list](../api-ref/Image/list.md) method for the [Image](../api-ref/Image/) resource.

   {% endlist %}

1. Download the Docker images you want from each registry using their full addresses: `cr.yandex/<name>:<tag>`:

   {% list tabs %}

   - CLI

     ```bash
     docker pull cr.yandex/crp1abc2tl3def1h2gu6/ubuntu:hello
     ```

     Command execution result:

     ```bash
     hello: Pulling from crp1abc2tl3def1h2gu6/ubuntu
     Digest: sha256:1d2b339619babc2d008eca2d5293e3c43ff84cbee597ff76dd3e7f7de3e84956
     Status: Downloaded newer image for cr.yandex/crp1abc2tl3def1h2gu6/ubuntu:hello
     cr.yandex/crp1abc2tl3def1h2gu6/ubuntu:hello
     ```

   {% endlist %}

1. Make sure the Docker image has been pulled:

   {% list tabs %}

   - CLI

     ```bash
     docker image list
     ```

     Command execution result:

     ```bash
     REPOSITORY                              TAG                 IMAGE ID            CREATED             SIZE
     cr.yandex/crp1abc2tl3def1h2gu6/ubuntu   hello               d12eaa3277bc        3 days ago          72.9MB
     ubuntu                                  latest              d12eaa3277bc        3 days ago          72.9MB
     ```

   {% endlist %}