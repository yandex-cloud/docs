# Удаление объекта


{% if product == "yandex-cloud" %}

## Удалить объект без блокировки {#wo-object-lock}

{% endif %}

{% note info %}

Объект, [составная загрузка](../../concepts/multipart.md) которого не завершена, удаляется по другой [инструкции](deleting-multipart.md).

{% endnote %}

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Выберите сервис **{{ objstorage-name }}**.
  1. Нажмите на имя необходимого бакета.
  1. Чтобы удалить один объект, нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) справа от имени объекта и в появившемся меню нажмите **Удалить**.
      
      Чтобы выполнить это же действие с несколькими объектами, отметьте их в списке и нажмите кнопку **Удалить** в нижней части экрана.
  
      {% note info %}
  
      Можно удалить папку с объектами. Это асинхронная операция, после запуска которой объекты не исчезают сразу из бакета, а удаляются постепенно. Вы в это время можете выполнять другие операции в консоли управления, в том числе загрузку новых объектов в удаляемую папку. Детали смотрите в разделе [Папка](../../concepts/object.md#folder).
  
      {% endnote %}
     
  1. Подтвердите удаление.

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  {% if audience != "internal" %}

  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% endif %}

  Чтобы удалить объект из бакета, созданный с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием объекта.

     {% cut "Пример описания объекта в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_storage_object" "cute-cat-picture" {
       access_key = "YCAJEX9Aw2ge1VKjlYXf-w-lJ"
       secret_key = "YCONxG7rSdzVF9UMxLA_NRy5VbKzKlqZMcSJz2N0"
       bucket     = "cat-pictures"
       key        = "cute-cat"
       source     = "/images/cats/cute-cat.jpg"
     }
     ...
     ```

     {% endcut %}

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.

  1. Проверьте конфигурацию командой:

     ```bash
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```bash
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```bash
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

     ```bash
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}).

{% endlist %}


{% if product == "yandex-cloud" %}

## Удалить версию объекта с блокировкой (object lock) {#w-object-lock}

{% list tabs %}

- AWS CLI

  1. Получите информацию о блокировке версии объекта:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
       s3api head-object \
       --bucket <имя_бакета> \
       --key <ключ_объекта> \
       --version-id <идентификатор_версии>
     ```
   
     Где:
   
     * `bucket` — имя вашего бакета.
     * `key` — [ключ](../../concepts/object.md#key) объекта.
     * `version-id` — идентификатор версии объекта.
     
     Если на версию установлена блокировка, информация о ней отобразится в результате выполнения команды:
   
     ```json
     {
       ...
       "ObjectLockMode": "<тип_временной_блокировки>",
       "ObjectLockRetainUntilDate": "<дата_и_время_окончания_временной_блокировки>",
       "ObjectLockLegalHoldStatus": "<статус_бессрочной_блокировки>",
       ...
     }
     ```
     
     Где:
   
     * `ObjectLockMode` — [тип](../../concepts/object-lock.md#types) временной блокировки:
    
       * `GOVERNANCE` — временная управляемая блокировка. Удалить версию объекта может пользователь с ролью `storage.admin`.
       * `COMPLIANCE` — временная строгая блокировка. Удалить версию объекта нельзя.
    
     * `ObjectLockRetainUntilDate` — дата и время окончания временной блокировки в любом из форматов, описанных в [стандарте HTTP](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats). Например, `Mon, 12 Dec 2022 09:00:00 GMT`. Указывается только вместе с параметром `object-lock-mode`.
    
     * `ObjectLockLegalHoldStatus` — статус [бессрочной блокировки](../../concepts/object-lock.md#types):
    
       * `ON` — включена. Удалить версию объекта нельзя. [Снять блокировку](edit-object-lock.md#remove-legal-hold) может пользователь с ролью `storage.uploader`.
       * `OFF` — выключена.
 
  1. Если установлена временная управляемая блокировка (`"ObjectLockMode": "GOVERNANCE"`) и у вас есть роль `storage.admin`, удалите версию объекта:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
       s3api delete-object \
       --bucket <имя_бакета> \
       --key <ключ_объекта> \
       --version-id <идентификатор_версии> \
       --bypass-governance-retention
     ```
     
     Где:

     * `bucket` — имя вашего бакета.
     * `key` — [ключ](../../concepts/object.md#key) объекта.
     * `version-id` — идентификатор версии объекта.
     * `bypass-governance-retention` — флаг, подтверждающий обход блокировки.

{% endlist %}

{% endif %}
