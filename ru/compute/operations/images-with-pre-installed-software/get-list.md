# Получить список публичных образов

В процессе создания виртуальной машины вам необходимо выбрать [образ](../../concepts/image.md) машины с программным обеспечением, которое вы хотите использовать.

{% list tabs %}

- Консоль управления

  Список доступных публичных образов можно посмотреть при создании виртуальной машины:

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором будет создана виртуальная машина.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}**.
  1. В открывшемся списке выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.image_button_show-all-os-products }}**. Отобразится список всех доступных публичных образов.

  Чтобы посмотреть информацию о конкретном образе, нажмите ![image](../../../_assets/compute/info.svg).

- CLI

  {% include [standard-images](../../../_includes/standard-images.md) %}

- API

  1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md), используемый для аутентификации в примерах:
     * [Инструкция](../../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.
     * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
     * [Инструкция](../../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
  1. Получите список публичных образов от {{ yandex-cloud }} с помощью метода REST API [list](../../api-ref/Image/list.md) для ресурса [Image](../../api-ref/Image/index.md) или вызова gRPC API [ImageService/List](../../api-ref/grpc/image_service.md#List). В запросе укажите следующие параметры:
     * В идентификаторе каталога укажите `standard-images`.
     * В каталоге много образов, поэтому укажите `pageSize=1000` или используйте полученное значение `nextPageToken`, чтобы получить продолжение списка.

    Результат запишите в файл, например в `output.json`:

    ```bash
    export IAM_TOKEN=CggaATEVAgA...
    curl -H "Authorization: Bearer ${IAM_TOKEN}" "https://compute.{{ api-host }}/compute/v1/images?folderId=standard-images&pageSize=1000" > output.json
    ```

{% endlist %}

Посмотреть информацию обо всех доступных публичных образах также можно в [{{ marketplace-name }}](/marketplace).
