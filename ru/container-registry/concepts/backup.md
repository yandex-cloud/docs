# Резервное копирование

Данные в {{ container-registry-name }} надежно хранятся и реплицируются в инфраструктуре {{ yandex-cloud }}, однако в любой момент вы можете сделать резервные копии [Docker-образов](../concepts/docker-image.md).

Чтобы выполнить резервное копирование Docker-образов:

1. Посмотрите список имеющихся [реестров](registry.md):

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите посмотреть список реестров.
     1. Выберите сервис **{{ container-registry-name }}**.
     1. На вкладке **Реестры** отображен список реестров.

   - CLI

     {% include [cli-install](../../_includes/cli-install.md) %}
     
     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     ```bash
     yc container registry list
     ```

     Результат выполнения команды:

     ```bash
     +----------------------+-------------+----------------------+
     |          ID          |   NAME      |      FOLDER ID       |
     +----------------------+-------------+----------------------+
     | crp1abc2tl3def1h2gu6 | my-registry | b1g23ga82bcv0cdeferg |
     +----------------------+-------------+----------------------+
     ```

   - API

     Воспользуйтесь методом [list](../api-ref/Registry/list.md) для ресурса [Registry](../api-ref/Registry/).

   {% endlist %}

1. Получите информацию об имеющихся Docker-образах по каждому реестру:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите посмотреть информацию о Docker-образах.
     1. Выберите сервис **{{ container-registry-name }}**.
     1. На вкладке **Реестры** нажмите на имя нужного реестра.
     1. На странице **Репозитории** нажмите на имя нужного репозитория.
     1. На странице **Docker-образы** отображены Docker-образы.

   - CLI

     ```bash
     yc container image list --registry-name my-registry
     ```

     Где:
     * `registry-name`— имя реестра.

     Результат выполнения:

     ```bash
     +----------------------+---------------------+-----------------------------+-------+-----------------+
     |          ID          |       CREATED       |            NAME             | TAGS  | COMPRESSED SIZE |
     +----------------------+---------------------+-----------------------------+-------+-----------------+
     | crpabcpg1pde2f33ekp4 | 2020-10-26 15:45:39 | crp1abc2tl3def1h2gu6/ubuntu | hello | 27.2 MB         |
     +----------------------+---------------------+-----------------------------+-------+-----------------+
     ```

   - API

     Воспользуйтесь методом [list](../api-ref/Image/list.md) для ресурса [Image](../api-ref/Image/).

   {% endlist %}

1. Скачайте необходимые Docker-образы из каждого реестра, используя полный адрес — `cr.yandex/<имя>:<тег>`:

   {% list tabs %}

   - CLI

     ```bash
     docker pull cr.yandex/crp1abc2tl3def1h2gu6/ubuntu:hello
     ```

     Результат выполнения команды:

     ```bash
     hello: Pulling from crp1abc2tl3def1h2gu6/ubuntu
     Digest: sha256:1d2b339619babc2d008eca2d5293e3c43ff84cbee597ff76dd3e7f7de3e84956
     Status: Downloaded newer image for cr.yandex/crp1abc2tl3def1h2gu6/ubuntu:hello
     cr.yandex/crp1abc2tl3def1h2gu6/ubuntu:hello
     ```

   {% endlist %}

1. Проверьте, что Docker-образ действительно скачался:

   {% list tabs %}

   - CLI

     ```bash
     docker image list
     ```

     Результат выполнения команды:

     ```bash
     REPOSITORY                              TAG                 IMAGE ID            CREATED             SIZE
     cr.yandex/crp1abc2tl3def1h2gu6/ubuntu   hello               d12eaa3277bc        3 days ago          72.9MB
     ubuntu                                  latest              d12eaa3277bc        3 days ago          72.9MB
     ```

   {% endlist %}