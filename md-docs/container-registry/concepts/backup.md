# Резервное копирование Docker-образов в Container Registry

Данные в Container Registry надежно хранятся и реплицируются в инфраструктуре Yandex Cloud, однако в любой момент вы можете сделать резервные копии [Docker-образов](docker-image.md).

Чтобы выполнить резервное копирование Docker-образов:

1. Посмотрите список имеющихся [реестров](registry.md):

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите посмотреть список реестров.
     1. Выберите сервис **Container Registry**.
     1. На вкладке **Реестры** отображен список реестров.

   - CLI {#cli}

     Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
     
     По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

     ```bash
     yc container registry list
     ```

     Результат:

     ```text
     +----------------------+-------------+----------------------+
     |          ID          |   NAME      |      FOLDER ID       |
     +----------------------+-------------+----------------------+
     | crp1abc2tl3d******** | my-registry | b1g23ga82bcv******** |
     +----------------------+-------------+----------------------+
     ```

   - API {#api}

     Воспользуйтесь методом [list](../api-ref/Registry/list.md) для ресурса [Registry](../api-ref/Registry/index.md).

   {% endlist %}

1. Получите информацию об имеющихся Docker-образах по каждому реестру:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите посмотреть информацию о Docker-образах.
     1. Выберите сервис **Container Registry**.
     1. На вкладке **Реестры** нажмите на имя нужного реестра.
     1. На странице **Репозитории** нажмите на имя нужного репозитория.
     1. На странице **Docker-образы** отображены Docker-образы.

   - CLI {#cli}

     ```bash
     yc container image list --registry-name my-registry
     ```

     Где `registry-name`— имя реестра.

     Результат:

     ```text
     +----------------------+---------------------+-----------------------------+-------+-----------------+
     |          ID          |       CREATED       |            NAME             | TAGS  | COMPRESSED SIZE |
     +----------------------+---------------------+-----------------------------+-------+-----------------+
     | crpabcpg1pde******** | 2020-10-26 15:45:39 | crp1abc2tl3d********/ubuntu | hello | 27.2 MB         |
     +----------------------+---------------------+-----------------------------+-------+-----------------+
     ```

   - API {#api}

     Воспользуйтесь методом [list](../api-ref/Image/list.md) для ресурса [Image](../api-ref/Image/index.md).

   {% endlist %}

1. Скачайте необходимые Docker-образы из каждого реестра, используя полный адрес — `cr.yandex/<имя>:<тег>`:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     docker pull cr.yandex/<идентификатор_реестра>/ubuntu:hello
     ```

     Результат:

     ```text
     hello: Pulling from crp1abc2tl3d********/ubuntu
     Digest: sha256:1d2b339619babc2d008eca2d5293e3c43ff84cbee597ff76dd3e7f7d********
     Status: Downloaded newer image for cr.yandex/crp1abc2tl3d********/ubuntu:hello
     cr.yandex/crp1abc2tl3d********/ubuntu:hello
     ```

   {% endlist %}

1. Проверьте, что Docker-образ действительно скачался:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     docker image list
     ```

     Результат:

     ```text
     REPOSITORY                                   TAG     IMAGE ID      CREATED     SIZE
     cr.yandex /crp1abc2tl3d********/ubuntu       hello   d12e********  3 days ago  72.9MB
     ubuntu                                       latest  d12e********  3 days ago  72.9MB
     ```

   {% endlist %}