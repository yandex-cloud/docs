[Документация Yandex Cloud](../../../index.md) > [Yandex Container Registry](../../index.md) > [Пошаговые инструкции](../index.md) > Управление Helm-чартом > Получить информацию об имеющихся Helm-чартах

# Получить информацию об имеющихся Helm-чартах

Вы можете получить список [Helm-чартов](https://helm.sh/docs/topics/charts/) в репозитории Container Registry. В Container Registry Helm-чарты хранятся так же, как и обычные [Docker-образы](../../concepts/docker-image.md).

## Получить информацию о локальных Helm-чартах

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы посмотреть список Helm-чартов локально, выполните команду:

  ```bash
  helm repo list
  ```

{% endlist %}

## Получить информацию о Helm-чартах в реестре

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы посмотреть список Helm-чартов, загруженных в Container Registry, выполните команду, как и для [просмотра](../docker-image/docker-image-list.md#docker-image-list) списка [Docker-образов](../../concepts/docker-image.md):

  ```bash
  yc container image list
  ```

{% endlist %}