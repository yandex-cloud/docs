# Получить список публичных образов

В процессе создания виртуальной машины вам необходимо выбрать [образ](../../concepts/image.md) машины с программным обеспечением, которое вы хотите использовать.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Список доступных публичных образов можно посмотреть при создании виртуальной машины:

  1. В [консоли управления](https://console.yandex.cloud) откройте каталог, в котором будет создана виртуальная машина.
  1. Справа сверху нажмите кнопку **Создать ресурс**.
  1. В открывшемся списке выберите **Виртуальная машина**.
  1. В блоке **Образ загрузочного диска** нажмите кнопку **Показать все продукты Marketplace**. Отобразится список всех доступных публичных образов.

  Чтобы [посмотреть информацию](get-info.md) о конкретном образе, нажмите ![image](../../../_assets/console-icons/circle-info.svg).

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Список публичных образов размещен в каталоге **standard-images**.

  * Чтобы получить список доступных образов с помощью CLI, выполните команду:
    
    ```bash
    yc compute image list --folder-id standard-images
    ```
    
    Результат:
    
    ```text
    +----------------------+-------------------------------------+--------------------------+----------------------+--------+
    |          ID          |                NAME                 |          FAMILY          |     PRODUCT IDS      | STATUS |
    +----------------------+-------------------------------------+--------------------------+----------------------+--------+
    ...
    | fdvk34al8k5n******** | centos-7-1549279494                 | centos-7                 | dqni65lfhvv2******** | READY  |
    | fdv7ooobjfl3******** | windows-2016-gvlk-1548913814        | windows-2016-gvlk        | dqnnc72gj2is******** | READY  |
    | fdv4f5kv5cvf******** | ubuntu-1604-lts-1549457823          | ubuntu-1604-lts          | dqnnb6dc7640******** | READY  |
    ...
    +----------------------+-------------------------------------+--------------------------+----------------------+--------+
    ```
    
    Где:
    
    * `ID` — идентификатор образа.
    * `NAME` — имя образа.
    * `FAMILY` — идентификатор [семейства образов](../../concepts/image.md#family), к которому относится образ.
    * `PRODUCT IDS` — идентификаторы [продуктов](../../../marketplace/concepts/product.md) Yandex Cloud Marketplace, связанных с образом.
    * `STATUS` — текущий статус образа. Может принимать одно из значений:
    
        * `STATUS_UNSPECIFIED` — статус образа не определен.
        * `CREATING` — образ в процессе создания.
        * `READY` — образ готов к использованию.
        * `ERROR` — образ нельзя использовать из-за возникшей с ним проблемы.
        * `DELETING` — образ в процессе удаления.

      {% note info %}

      По умолчанию команда выводит лишь первые 1000 образов. Чтобы просмотреть полный список образов, задайте параметр `--limit 0`.

      {% endnote %}

  * Чтобы получить список идентификаторов доступных [семейств образов](../../concepts/image.md#family), выполните команду:

      ```bash
      yc compute image list \
        --folder-id standard-images \
        --limit 0 \
        --jq '.[].family' | sort | uniq
      ```

      Результат:

      ```text
      ...
      ubuntu-2204-lts
      ubuntu-2204-lts-oslogin
      ubuntu-2004-lts-gpu
      ...
      ```

  * Чтобы получить список доступных публичных образов определенного семейства, выполните команду:

      ```bash
      yc compute image list --folder-id standard-images | grep <идентификатор_семейства>
      ```

      Где `<идентификатор_семейства>` — идентификатор нужного семейства образов, например: `ubuntu-2204-lts-oslogin`.

      Результат:

      ```text
      ...
      | fd827n44qr0q******** | ubuntu-2204-lts-oslogin-v20240617 | ubuntu-2204-lts-oslogin | f2eofgd2cj0e******** | READY |
      | fd827ukfjohd******** | ubuntu-2204-lts-oslogin-v20240701 | ubuntu-2204-lts-oslogin | f2evubhrcfsh******** | READY |
      | fd82sdt0b96a******** | ubuntu-2204-lts-oslogin-v20240304 | ubuntu-2204-lts-oslogin | f2ecb2d55npl******** | READY |
      ...
      ```

  Подробнее о команде `yc compute image list` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/image/list.md).

- API {#api}

  1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md), используемый для аутентификации в примерах:
     * [Инструкция](../../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.
     * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
     * [Инструкция](../../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
     * [Инструкция](../../../iam/operations/iam-token/create-for-local.md) для локального аккаунта.
  1. Получите список публичных образов от Yandex Cloud с помощью метода REST API [list](../../api-ref/Image/list.md) для ресурса [Image](../../api-ref/Image/index.md) или вызова gRPC API [ImageService/List](../../api-ref/grpc/Image/list.md). В запросе укажите следующие параметры:
     * В идентификаторе каталога укажите `standard-images`.
     * В каталоге много образов, поэтому укажите `pageSize=1000` или используйте полученное значение `nextPageToken`, чтобы получить продолжение списка.

    Результат запишите в файл, например в `output.json`:

    ```bash
    export IAM_TOKEN=CggaATEVAgA...
    curl \
      --header "Authorization: Bearer ${IAM_TOKEN}" \
      "https://compute.api.cloud.yandex.net/compute/v1/images?folderId=standard-images&pageSize=1000" > output.json
    ```

{% endlist %}

Посмотреть информацию обо всех доступных публичных образах также можно в [Cloud Marketplace](https://yandex.cloud/ru/marketplace).