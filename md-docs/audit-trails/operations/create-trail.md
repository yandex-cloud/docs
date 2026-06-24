# Создание трейла для загрузки аудитных логов


Вы можете создать трейл, который будет загружать аудитные логи [уровня конфигурации](../concepts/format.md) и [уровня сервисов](../concepts/format-data-plane.md) в один из [объектов назначения](../concepts/trail.md#target):

* бакет [Yandex Object Storage](../../storage/index.md);
* лог-группу [Yandex Cloud Logging](../../logging/index.md);
* поток данных [Yandex Data Streams](../../data-streams/index.md);
* шину [Yandex EventRouter](../../serverless-integrations/index.md).

{% note info %}

В настоящий момент создать трейл с объектом назначения **EventRouter** можно только с помощью [консоли управления](https://console.yandex.cloud), Yandex Cloud [CLI](../../cli/index.md) и [API](../../api-design-guide/index.md).

{% endnote %}

## Перед началом работы {#before-you-begin}

В зависимости от выбранного [объекта назначения](../concepts/trail.md#target) для логов, подготовьте необходимую инфраструктуру для создания трейла:

{% list tabs group=trail-target %}

- Бакет Object Storage {#bucket}

  1. [Создайте бакет](../../storage/operations/buckets/create.md) с ограниченным доступом, в который будут загружаться аудитные логи.
  1. (Опционально) Включите шифрование для бакета.

      [Убедитесь](../../iam/operations/roles/get-assigned-roles.md), что у аккаунта, от имени которого вы собираетесь создавать ключ шифрования для бакета, есть [роль](../../kms/security/index.md#kms-editor) `kms.editor` на каталог.
  1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) для трейла.
  1. [Назначьте роли сервисному аккаунту](../../iam/operations/sa/assign-role-for-sa.md), чтобы трейл мог собирать и загружать логи:

      * [storage.uploader](../../storage/security/index.md#storage-uploader) на [бакет](../../storage/concepts/bucket.md).
      * [kms.keys.encrypter](../../kms/security/index.md#kms-keys-encrypter) на [ключ шифрования](../../kms/concepts/key.md) для бакета.

          Эта роль необходима, только если для бакета было включено шифрование.

      * [audit-trails.viewer](../security/index.md#at-viewer) на один из ресурсов, который определяет [нужную область сбора](../concepts/trail.md#collecting-area) логов:
      
          * [Организация](../../organization/operations/add-role.md) — чтобы собирать логи в выбранных облаках организации.
          * [Облако](../../resource-manager/operations/cloud/set-access-bindings.md#access-to-sa) — чтобы собирать логи в выбранных каталогах облака.
          * [Каталог](../../resource-manager/operations/folder/set-access-bindings.md#access-to-sa) — чтобы собирать логи в этом каталоге.
      
          Права доступа наследуются от родительского ресурса к дочерним. Например, если сервисному аккаунту [назначить роль на облако](../../resource-manager/operations/cloud/set-access-bindings.md), то трейл, использующий этот аккаунт, сможет собирать логи ресурсов во всех каталогах этого облака. Однако трейл не сможет собирать логи в других облаках, принадлежащих организации, — для этого потребуется [назначить роль на организацию](../../organization/operations/add-role.md).

  1. [Убедитесь](../../iam/operations/roles/get-assigned-roles.md), что у [аккаунта](../../iam/concepts/users/accounts.md), от имени которого вы собираетесь создавать трейл, есть необходимые роли:
     
     * [audit-trails.editor](../security/index.md#at-editor) на каталог, в котором будет находиться трейл.
     * [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) на сервисный аккаунт для трейла.

- Лог-группа Cloud Logging {#logging}

  1. [Создайте лог-группу](../../logging/operations/create-group.md), в которую будут загружаться аудитные логи.
  1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) для трейла.
  1. [Назначьте роли сервисному аккаунту](../../iam/operations/sa/assign-role-for-sa.md), чтобы трейл мог собирать и загружать логи:

      * [logging.writer](../../logging/security/index.md#logging-writer) на [лог-группу](../../logging/concepts/log-group.md).

      * [audit-trails.viewer](../security/index.md#at-viewer) на один из ресурсов, который определяет [нужную область сбора](../concepts/trail.md#collecting-area) логов:
      
          * [Организация](../../organization/operations/add-role.md) — чтобы собирать логи в выбранных облаках организации.
          * [Облако](../../resource-manager/operations/cloud/set-access-bindings.md#access-to-sa) — чтобы собирать логи в выбранных каталогах облака.
          * [Каталог](../../resource-manager/operations/folder/set-access-bindings.md#access-to-sa) — чтобы собирать логи в этом каталоге.
      
          Права доступа наследуются от родительского ресурса к дочерним. Например, если сервисному аккаунту [назначить роль на облако](../../resource-manager/operations/cloud/set-access-bindings.md), то трейл, использующий этот аккаунт, сможет собирать логи ресурсов во всех каталогах этого облака. Однако трейл не сможет собирать логи в других облаках, принадлежащих организации, — для этого потребуется [назначить роль на организацию](../../organization/operations/add-role.md).

  1. [Убедитесь](../../iam/operations/roles/get-assigned-roles.md), что у [аккаунта](../../iam/concepts/users/accounts.md), от имени которого вы собираетесь создавать трейл, есть необходимые роли:
     
     * [audit-trails.editor](../security/index.md#at-editor) на каталог, в котором будет находиться трейл.
     * [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) на сервисный аккаунт для трейла.

- Поток данных Data Streams {#data-streams}

  1. [Создайте поток данных](../../data-streams/operations/manage-streams.md#create-data-stream), в который будут загружаться аудитные логи.

      {% note tip %}

      Рекомендуем включить [автопартиционирование](../../data-streams/concepts/glossary.md#autopartitioning) на принимающем потоке данных.

      Часть событий может потеряться при перегрузке отдельных [сегментов](../../data-streams/concepts/glossary.md#shard) или всего [потока](../../data-streams/concepts/glossary.md#stream-concepts). Автопартиционирование автоматически добавляет сегменты и распределяет нагрузку, что помогает избежать потерь. Если автопартиционирование отключено, самостоятельно проверяйте и увеличивайте количество сегментов при необходимости.

      {% endnote %}

  1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) для трейла.
  1. [Назначьте роли сервисному аккаунту](../../iam/operations/sa/assign-role-for-sa.md), чтобы трейл мог собирать и загружать логи:

      * [yds.writer](../../data-streams/security/index.md#yds-writer) на [поток данных](../../data-streams/concepts/glossary.md#stream-concepts).

      * [audit-trails.viewer](../security/index.md#at-viewer) на один из ресурсов, который определяет [нужную область сбора](../concepts/trail.md#collecting-area) логов:
      
          * [Организация](../../organization/operations/add-role.md) — чтобы собирать логи в выбранных облаках организации.
          * [Облако](../../resource-manager/operations/cloud/set-access-bindings.md#access-to-sa) — чтобы собирать логи в выбранных каталогах облака.
          * [Каталог](../../resource-manager/operations/folder/set-access-bindings.md#access-to-sa) — чтобы собирать логи в этом каталоге.
      
          Права доступа наследуются от родительского ресурса к дочерним. Например, если сервисному аккаунту [назначить роль на облако](../../resource-manager/operations/cloud/set-access-bindings.md), то трейл, использующий этот аккаунт, сможет собирать логи ресурсов во всех каталогах этого облака. Однако трейл не сможет собирать логи в других облаках, принадлежащих организации, — для этого потребуется [назначить роль на организацию](../../organization/operations/add-role.md).

  1. [Убедитесь](../../iam/operations/roles/get-assigned-roles.md), что у [аккаунта](../../iam/concepts/users/accounts.md), от имени которого вы собираетесь создавать трейл, есть необходимые роли:
     
     * [audit-trails.editor](../security/index.md#at-editor) на каталог, в котором будет находиться трейл.
     * [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) на сервисный аккаунт для трейла.

- Шина EventRouter {#eventrouter}

  1. [Создайте](../../serverless-integrations/operations/eventrouter/bus/create.md) шину Yandex EventRouter.

      {% note info %}

      В настоящий момент создать [коннектор](../../serverless-integrations/concepts/eventrouter/connector.md) шины EventRouter с типом источника `Audit Trails` можно только в [консоли управления](https://console.yandex.cloud) при создании или изменении трейла, а также с помощью [API EventRouter](../../serverless-integrations/eventrouter/api-ref/Connector/create.md).

      {% endnote %}

  1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) для трейла.
  1. [Назначьте роли сервисному аккаунту](../../iam/operations/sa/assign-role-for-sa.md), чтобы трейл мог собирать и загружать логи:

      * [serverless.eventrouter.supplier](../../serverless-integrations/security/eventrouter.md#serverless-eventrouter-supplier) на каталог, в котором находится нужная [шина](../../serverless-integrations/concepts/eventrouter/bus.md) EventRouter.

      * [audit-trails.viewer](../security/index.md#at-viewer) на один из ресурсов, который определяет [нужную область сбора](../concepts/trail.md#collecting-area) логов:
      
          * [Организация](../../organization/operations/add-role.md) — чтобы собирать логи в выбранных облаках организации.
          * [Облако](../../resource-manager/operations/cloud/set-access-bindings.md#access-to-sa) — чтобы собирать логи в выбранных каталогах облака.
          * [Каталог](../../resource-manager/operations/folder/set-access-bindings.md#access-to-sa) — чтобы собирать логи в этом каталоге.
      
          Права доступа наследуются от родительского ресурса к дочерним. Например, если сервисному аккаунту [назначить роль на облако](../../resource-manager/operations/cloud/set-access-bindings.md), то трейл, использующий этот аккаунт, сможет собирать логи ресурсов во всех каталогах этого облака. Однако трейл не сможет собирать логи в других облаках, принадлежащих организации, — для этого потребуется [назначить роль на организацию](../../organization/operations/add-role.md).

  1. [Убедитесь](../../iam/operations/roles/get-assigned-roles.md), что у [аккаунта](../../iam/concepts/users/accounts.md), от имени которого вы собираетесь создавать трейл, есть необходимые роли:
     
     * [audit-trails.editor](../security/index.md#at-editor) на каталог, в котором будет находиться трейл.
     * [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) на сервисный аккаунт для трейла.

{% endlist %}

## Создать трейл {#create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите разместить трейл.
  1. Перейдите в сервис **Audit Trails**.
  1. Нажмите кнопку **Создать трейл**.
  1. Введите имя трейла. Оно должно быть уникальным в рамках каталога.
  1. (Опционально) Введите описание трейла.
  1. В блоке **Назначение** выберите один из объектов назначения и укажите его настройки:

      * **Object Storage** — загружать аудитные логи в бакет Object Storage. Рекомендуется для долгосрочного хранения данных. Задайте настройки хранения логов:

          * **Бакет** — бакет, который [был создан ранее](#before-you-begin).
          * **Префикс объекта** — [префикс](../concepts/format.md#log-file-name), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../concepts/format.md#log-file-name) файла аудитного лога.

              {% note info %}
              
              Используйте [префикс](../../storage/concepts/object.md#key), если вы храните аудитные логи и сторонние данные в одном и том же бакете. Не используйте одинаковый префикс для логов и других объектов в бакете, так как в этом случае логи и сторонние объекты могут перезаписать друг друга.
              
              {% endnote %}

          * **Ключ шифрования** — ключ шифрования для бакета. Выбирать его необходимо, только если для бакета было включено шифрование.
      * **Cloud Logging** — лог-группа, которая [была создана ранее](#before-you-begin). В нее будут загружаться аудитные логи. Рекомендуется для быстрого сбора и анализа логов.
      * **Data Streams** — поток данных, который [был создан ранее](#before-you-begin). В этот поток будут загружаться аудитные логи. Рекомендуется для потоковой передачи логов в другие сервисы или системы.
      * **EventRouter** — коннектор шины EventRouter. Рекомендуется для подробного анализа логов и дальнейшей отправки их в различные обработчики и системы в зависимости от заданных в шине условий.

          В поле **Коннектор** выберите нужный [коннектор](../../serverless-integrations/concepts/eventrouter/connector.md) шины EventRouter с типом источника `Audit Trails` или нажмите кнопку **Создать**, чтобы создать новый коннектор в нужной шине.

  1. В блоке **Сервисный аккаунт** выберите [созданный ранее](#before-you-begin) сервисный аккаунт, от имени которого будет работать трейл.

  1. Включите и настройте сбор событий с одного или двух уровней. Такие события попадут в аудитные логи.

      Чтобы настроить **Сбор событий c уровня конфигурации**:

      1. Выберите [область сбора логов](../concepts/trail.md) — `Организация`, `Облако` или `Каталог`. События, которые попадут в логи, будут собираться в указанной области.

          Права сервисного аккаунта, [созданного ранее](#before-you-begin), должны позволять сбор логов из указанной области.

      1. В зависимости от выбранной области сбора логов выберите конкретные облака или каталоги, с которых будут собираться события:

          * Для области сбора `Организация` выберите из выпадающего списка **Облако** одно или несколько облаков, с которых будут собираться события.

              Оставьте значение по умолчанию (`Все`), чтобы собирать события со всех облаков в организации.

          * Для области сбора `Облако` выберите из выпадающего списка **Каталог** один или несколько каталогов, с которых будут собираться события.

              Оставьте значение по умолчанию (`Все`), чтобы собирать события со всех каталогов в облаке.

      Чтобы настроить **Сбор событий с уровня сервисов**:

      {% note warning %}
      
      В консоли управления сбор некоторых событий [уровня сервисов](../concepts/control-plane-vs-data-plane.md#data-plane-events) включен [по умолчанию](../concepts/trail.md#default). Их доставка оплачивается в соответствии с [правилами тарификации](../pricing.md). Если события уровня сервисов вам не нужны, отключите их сбор.
      
      {% endnote %}

      1. Выберите один или несколько сервисов, с которых будут собираться события.

      1. Для каждого такого сервиса выберите [область сбора логов](../concepts/trail.md) — `Организация`, `Облако` или `Каталог`. События, которые попадут в логи, будут собираться в указанной области.

          Права сервисного аккаунта, [созданного ранее](#before-you-begin), должны позволять сбор логов из указанной области.

      1. В зависимости от выбранной области сбора логов выберите конкретные облака или каталоги, с которых будут собираться события:

          * Для области сбора `Организация` выберите из выпадающего списка **Облако** одно или несколько облаков, с которых будут собираться события.

              Оставьте значение по умолчанию (`Все`), чтобы собирать события со всех облаков в организации.

          * Для области сбора `Облако` выберите из выпадающего списка **Каталог** один или несколько каталогов, с которых будут собираться события.

              Оставьте значение по умолчанию (`Все`), чтобы собирать события со всех каталогов в облаке.

      1. Для каждого такого сервиса выберите один из следующих фильтров по [событиям](../concepts/events-data-plane.md#dns):

          * `Получать все` — чтобы собирать все события сервиса.
          * `Выбранные` — чтобы собирать только выбранные события. Затем выберите события.
          * `Исключить` — чтобы собирать все события, кроме выбранных. Затем выберите события.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Посмотрите описание команды [CLI](../../cli/index.md) для создания трейла, чтобы получить подробную информацию о доступных аргументах:

  ```bash
  yc audit-trails trail create --help
  ```

  Трейл можно создать, указав его параметры одним из двух способов:

  {% cut "В YAML-спецификации:" %}

  [Создайте YAML-спецификацию](prepare-spec.md#spec-for-create), содержащую параметры трейла, и укажите этот файл в команде для создания трейла.
  
  Этот способ упрощает работу с параметрами трейла и снижает вероятность ошибки. Кроме того, настроить регистрацию [событий уровня сервисов](../concepts/control-plane-vs-data-plane.md#data-plane-events) можно только с помощью YAML-спецификации.

  1. Создайте YAML-файл с конфигурацией трейла:

      ```yaml
      name: <имя_трейла>
      folder_id: <идентификатор_каталога>
      destination:
        # Должно быть указано только одно место назначения:
        # object_storage, cloud_logging, data_stream или eventrouter
        # Настройки для всех мест назначения приведены для иллюстрации
        object_storage:
          bucket_id: <имя_бакета>
          object_prefix: <префикс_для_объектов>
        cloud_logging:
          log_group_id: <идентификатор_лог_группы>
        data_stream:
          stream_name: <имя_потока_данных_YDS>
          database_id: <идентификатор_базы_данных_YDS>
          codec: <метод_сжатия_событий>
        eventrouter:
          eventrouter_connector_id: <идентификатор_коннектора_шины>
      service_account_id: <идентификатор_сервисного_аккаунта>
      filtering_policy:
        management_events_filter:
          resource_scopes:
            - id: <идентификатор_организации_облака_или_каталога>
              type: <тип>
        data_events_filters:
          - service: <имя_сервиса>
            resource_scopes:
              - id: <идентификатор_организации_облака_или_каталога>
                type: <тип>
            # Допустимо указать либо included_events, либо excluded_events,
            # либо не указывать оба этих параметра, чтобы собирались все события сервиса
            # Оба параметра приведены для иллюстрации
            included_events:
              event_types:
                - <эти_события_будут_собираться>
            excluded_events:
              event_types:
                - <эти_события_не_будут_собираться>
      ```

      Где:

      * `name` — имя трейла. Оно должно быть уникальным в рамках каталога.
      * `folder_id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, в котором будет размещен трейл.
      * `destination` — настройки выбранного места назначения, куда будут загружаться аудитные логи.

          {% note warning %}

          Настройки мест назначения — взаимоисключающие. Использование одних настроек делает невозможным использование других.

          {% endnote %}

          * `object_storage` — загружать логи в [бакет](../../storage/concepts/bucket.md#naming) Yandex Object Storage:

              * `bucket_id` — [имя](../../storage/concepts/bucket.md#naming) созданного [ранее](#before-you-begin) бакета.

                  Имя бакета можно запросить со списком бакетов в каталоге (используется каталог по умолчанию):

                  ```bash
                  yc storage bucket list
                  ```
              * `object_prefix` — [префикс](../../storage/concepts/object.md#folder), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../concepts/format.md#log-file-name) файла аудитного лога.

                  {% note info %}
                  
                  Используйте [префикс](../../storage/concepts/object.md#key), если вы храните аудитные логи и сторонние данные в одном и том же бакете. Не используйте одинаковый префикс для логов и других объектов в бакете, так как в этом случае логи и сторонние объекты могут перезаписать друг друга.
                  
                  {% endnote %}

          * `cloud_logging` — загружать логи в [лог-группу](../../logging/concepts/log-group.md) Yandex Cloud Logging.

              В параметре `log_group_id` укажите идентификатор [созданной ранее](#before-you-begin) лог-группы. Идентификатор можно запросить со [списком лог-групп в каталоге](../../logging/operations/list.md).
          * `data_stream` — загружать логи в [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) Yandex Data Streams:

              * `stream_name` — имя [созданного ранее](#before-you-begin) потока данных. Имя можно запросить со [списком потоков данных в каталоге](../../data-streams/operations/manage-streams.md#list-data-streams).
              * `database_id` — идентификатор базы данных YDB, которая используется потоком данных Data Streams. Идентификатор можно запросить со [списком баз данных YDB в каталоге](../../ydb/operations/manage-databases.md#list-db).
              * `codec` — метод сжатия событий при записи в поток данных Data Streams. Возможные значения: `RAW` (без сжатия, по умолчанию), `GZIP`, `ZSTD`. Включайте сжатие, если ожидается поток событий более 1 МБ/с.
          * `eventrouter` — загружать логи в [шину](../../serverless-integrations/concepts/eventrouter/bus.md) Yandex EventRouter:

              * `eventrouter_connector_id` — идентификатор [коннектора](../../serverless-integrations/concepts/eventrouter/connector.md) шины EventRouter с типом источника `Audit Trails`.
      * `service_account_id` — [идентификатор](../../iam/operations/sa/get-id.md) созданного [ранее](#before-you-begin) сервисного аккаунта.

      * `filtering_policy` — настройки политики фильтрации, которая определяет, какие события будут собираться и попадут в аудитные логи. Политика состоит из набора фильтров, которые относятся к разным уровням событий.
      
          {% note warning %}
      
          Для политики обязательно должен быть настроен хотя бы один фильтр, иначе не получится создать трейл.
      
          {% endnote %}
      
          Доступные фильтры:
      
          * `management_events_filter` — фильтр событий уровня конфигурации.
      
              {#filter-cli}
      
              Укажите [область сбора логов](../concepts/trail.md#collecting-area) в параметре `resource_scopes`:
      
              * `id` — идентификатор организации, облака или каталога.
              * `type` — тип области согласно указанному идентификатору:
      
                  * `organization-manager.organization` — [организация](../../organization/concepts/organization.md);
                  * `resource-manager.cloud` — [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud);
                  * `resource-manager.folder` — [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
      
              Можно комбинировать в одном параметре `resource_scopes` несколько областей, которые принадлежат одной организации. Например, собирать логи из одного облака целиком, а из другого — только из определенных каталогов:
      
              ```yaml
              resource_scopes:
              # Сбор логов из облака 1 целиком
              - id: <идентификатор_облака_1>
                  type: resource-manager.cloud
              # Сбор логов из каталога 1 облака 2
              - id: <идентификатор_каталога_1>
                  type: resource-manager.folder
              # Сбор логов из каталога 2 облака 2
              - id: <идентификатор_каталога_2>
                  type: resource-manager.folder
              ```
      
              Права сервисного аккаунта должны позволять сбор логов из указанных областей.
      
          * `data_events_filters` — фильтры событий уровня сервисов. Можно настроить несколько фильтров такого типа — по одному для каждого сервиса.
      
              Фильтр для одного сервиса имеет следующую структуру:
      
              * `service` — имя сервиса. Его можно получить в [справочнике событий уровня сервисов](../concepts/events-data-plane.md).
      
              * `resource_scopes` — места, откуда собирать события уровня сервисов. Этот параметр настраивается аналогично фильтру событий уровня конфигурации.
      
              * `*_events` — фильтры событий уровня сервиса:
      
                  * `included_events.event_types` — собирать только указанные события.
                  * `excluded_events.event_types` — собирать все события, кроме указанных.
      
                  Перечень событий можно получить в [справочнике событий уровня сервисов](../concepts/events-data-plane.md).
      
                  {% note warning %}
      
                  Фильтры `included_events` и `excluded_events` взаимоисключающие, настройте только один из них. Если оба фильтра не настроены, будут собираться все события.
      
                  {% endnote %}

  1. Выполните команду:

      ```bash
      yc audit-trails trail create --file <путь_к_файлу>
      ```

  {% endcut %}

  {% cut "В аргументах команды:" %}

  Используйте этот способ, если конфигурация трейла простая и содержит небольшое количество параметров.

  {% note info %}

  Настроить регистрацию [событий уровня сервисов](../concepts/control-plane-vs-data-plane.md#data-plane-events) можно только с помощью YAML-спецификации.

  {% endnote %}

  Выполните команду:

  ```bash
  yc audit-trails trail create \
    --name <имя_трейла> \
    --description <описание_трейла> \
    --labels <список_меток> \
    --service-account-id <идентификатор_сервисного_аккаунта> \
    --destination-bucket <имя_бакета> \
    --destination-bucket-object-prefix <префикс_для_объектов> \
    --destination-log-group-id <идентификатор_лог_группы> \
    --destination-yds-stream <имя_потока_данных_YDS> \
    --destination-yds-database-id <идентификатор_базы_данных_YDS> \
    --destination-yds-codec <метод_сжатия_событий> \
    --destination-eventrouter-connector-id <идентификатор_коннектора_шины> \
    --filter-all-folder-id <идентификатор_каталога> \
    --filter-all-cloud-id <идентификатор_облака> \
    --filter-all-organisation-id <идентификатор_организации> \
    --filter-some-folder-ids <список_каталогов_в_облаке> \
    --filter-from-cloud-id <идентификатор_облака_с_выбранными_каталогами> \
    --filter-some-cloud-ids <список_облаков_в_организации> \
    --filter-from-organisation-id <идентификатор_организации_с_выбранными_облаками>
    ```

    Где:
    * `--name` — имя создаваемого трейла.

    * `--description` — описание трейла. Необязательный параметр.
    * `--labels` — список [меток](../../resource-manager/concepts/labels.md). Необязательный параметр. Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.
    * `--service-account-id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта.
    * `--destination-bucket` — [имя](../../storage/concepts/bucket.md#naming) бакета Yandex Object Storage, в который будут загружаться аудитные логи.
    
        С этим параметром нельзя использовать параметры `--destination-log-group-id`, `--destination-yds-stream` и `--destination-eventrouter-connector-id`.
    * `--destination-bucket-object-prefix` — [префикс](../../storage/concepts/object.md#folder), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../concepts/format.md#log-file-name) файла аудитного лога.
    
        {% note info %}
        
        Используйте [префикс](../../storage/concepts/object.md#key), если вы храните аудитные логи и сторонние данные в одном и том же бакете. Не используйте одинаковый префикс для логов и других объектов в бакете, так как в этом случае логи и сторонние объекты могут перезаписать друг друга.
        
        {% endnote %}
    
    * `--destination-log-group-id` — идентификатор [лог-группы](../../logging/concepts/log-group.md) Yandex Cloud Logging, в которую будут загружаться аудитные логи.
    
        С этим параметром нельзя использовать параметры `--destination-bucket`, `--destination-yds-stream` и `--destination-eventrouter-connector-id`.
    * `--destination-yds-stream` — имя [потока данных](../../data-streams/concepts/glossary.md#stream-concepts) Yandex Data Streams, в который будут загружаться аудитные логи.
    
        С этим параметром нельзя использовать параметры `--destination-bucket`, `--destination-log-group-id` и `--destination-eventrouter-connector-id`.
    * `--destination-yds-database-id` — идентификатор базы данных YDB, которая используется потоком данных Data Streams.
    * `--destination-yds-codec` — метод сжатия событий при записи в поток данных Data Streams. Возможные значения: `RAW` (без сжатия, по умолчанию), `GZIP`, `ZSTD`. Включайте сжатие, если ожидается поток событий более 1 МБ/с.
    * `--destination-eventrouter-connector-id` — идентификатор [коннектора](../../serverless-integrations/concepts/eventrouter/connector.md) шины EventRouter с типом источника `Audit Trails`, в которую будут загружаться аудитные логи.
    
        С этим параметром нельзя использовать параметры `--destination-bucket`, `--destination-log-group-id` и `--destination-yds-stream`.
    * `--filter-all-folder-id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, для всех ресурсов которого будут регистрироваться события уровня конфигурации.
    * `--filter-all-cloud-id` — [идентификатор](../../resource-manager/operations/cloud/get-id.md) облака, для всех ресурсов которого будут регистрироваться события уровня конфигурации.
    * `--filter-all-organisation-id` — [идентификатор](../../organization/operations/organization-get-id.md) организации, для всех ресурсов которой будут регистрироваться события уровня конфигурации.
    * `--filter-some-folder-ids` — список идентификаторов каталогов, для всех ресурсов которых будут регистрироваться события уровня конфигурации в облаке, заданном в поле `--filter-from-cloud-id`.
    
        Параметр используется только в паре с параметром `--filter-from-cloud-id`.
    * `--filter-from-cloud-id` — идентификатор облака, в котором находятся каталоги, заданные в параметре `--filter-some-folder-ids`.
    
        Параметр используется только в паре с параметром `--filter-some-folder-ids`.
    * `--filter-some-cloud-ids` — список идентификаторов облаков, для всех ресурсов которых будут регистрироваться события уровня конфигурации в организации, заданной в поле `--filter-from-organisation-id`.
    
        Параметр используется только в паре с параметром `--filter-from-organisation-id`.
    * `--filter-from-organisation-id` — идентификатор организации, в которой находятся облака, заданные в параметре `--filter-some-folder-ids`.
    
        Параметр используется только в паре с параметром `--filter-some-cloud-ids`.

  {% endcut %}

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры трейла, который будет собирать аудитные логи:

      ```hcl
      resource "yandex_audit_trails_trail" "basic_trail" {
        name        = "<имя_трейла>"
        folder_id   = "<идентификатор_каталога>"
        description = "<описание_трейла>"
        labels = {
          key = "value"
        }
        service_account_id = "<идентификатор_сервисного_аккаунта>"
      
      
        # Должно быть указано только одно место назначения:
        # storage_destination , logging_destination, data_stream_destination
        # Настройки для всех мест назначения приведены для иллюстрации
      
        logging_destination {
          log_group_id = "<идентификатор_лог-группы>"
        }
        storage_destination {
          bucket_name   = "<идентификатор_бакета>"
          object_prefix = "<префикс>"
        }
        data_stream_destination {
          database_id = "<идентификатор_базы_данных_YDS>"
          stream_name = "<имя_потока_данных_YDS>"
          codec       = "<метод_сжатия_событий>"
        }
      
        # Настройки политики фильтрации
      
        filtering_policy {
          management_events_filter {
            resource_scope {
              resource_id   = "<идентификатор_организации>"
              resource_type = "organization-manager.organization"
            }
          }  
          data_events_filter {
            service = "<сервис>"
            included_events = ["<тип_событий_сервиса>","<тип_событий_сервиса_2>"]
            resource_scope {
              resource_id   = "<идентификатор_облака>"
              resource_type = "resource-manager.cloud"
            }
            resource_scope {
              resource_id   = "<идентификатор_каталога>"
              resource_type = "resource-manager.folder"
            }
          }
          data_events_filter {
            service = "<сервис_2>"
            resource_scope {
              resource_id   = "<идентификатор_облака_2>"
              resource_type = "resource-manager.cloud"
            }
            resource_scope {
              resource_id   = "<идентификатор_облака_3>"
              resource_type = "resource-manager.cloud"
            }
          }
          data_events_filter {
            service = "<сервис_3>"
            resource_scope {
              resource_id   = "<идентификатор_каталога_2>"
              resource_type = "resource-manager.folder"
            }
            resource_scope {
              resource_id   = "<идентификатор_каталога_3>"
              resource_type = "resource-manager.folder"
            }
          }
        }
      }
      ```

      Где:

      * `name` — имя создаваемого трейла. Требования к формату имени:
      
          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.
      
      * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором создается трейл.
      * `description` — описание трейла, которое позволит отличать его от других трейлов. Например `My very first trail`. Необязательный параметр.
      * `labels` — список [меток](../../resource-manager/concepts/labels.md) в формате `ключ=значение`. Необязательный параметр.
      * `service_account_id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта, от имени которого трейл будет загружать файлы аудитного лога в бакет.
      
          В зависимости от [области сбора](../concepts/trail.md#collecting-area) аудитных логов, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md) должна быть назначена [роль](../../iam/concepts/access-control/roles.md) `audit-trails.viewer` на организацию, облако или каталог, в которых трейл будет собирать аудитные логи.

      {% note warning %}
      
      Должно быть указано только одно место назначения: `storage_destination` , `logging_destination` или `data_stream_destination`.
      
      {% endnote %}
      
      * `logging_destination` — загружать логи в [лог-группу](../../logging/concepts/log-group.md) Yandex Cloud Logging.
      
          * `log_group_id` — [идентификатор лог-группы](../../logging/operations/get-group.md), в которую трейл будет сохранять аудитные логи.
      * `storage_destination` — загружать логи в [бакет](../../storage/concepts/bucket.md) Yandex Object Storage:
      
          * `bucket_name` — имя бакета, куда трейл будет сохранять аудитные логи.
          * `object_prefix` — [префикс](../../storage/concepts/object.md#folder), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../concepts/format.md#log-file-name) файла аудитного лога.
      
              {% note info %}
              
              Используйте [префикс](../../storage/concepts/object.md#key), если вы храните аудитные логи и сторонние данные в одном и том же бакете. Не используйте одинаковый префикс для логов и других объектов в бакете, так как в этом случае логи и сторонние объекты могут перезаписать друг друга.
              
              {% endnote %}
      
      * `data_stream_destination` — загружать логи в [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) Yandex Data Streams:
      
          * `stream_name` — имя потока данных, в который трейл будет сохранять аудитные логи.
          * `database_id` — идентификатор базы данных Yandex Managed Service for YDB, которая используется потоком данных Data Streams.
          * `codec` — метод сжатия событий при записи в поток данных Data Streams. Возможные значения: `RAW` (без сжатия, по умолчанию), `GZIP`, `ZSTD`. Включайте сжатие, если ожидается поток событий более 1 МБ/с.

      * `filtering_policy` — настройки политики фильтрации, которая определяет, какие события будут собираться и попадут в аудитные логи. Политика состоит из набора фильтров, которые относятся к разным уровням событий. Содержит объекты `management_events_filter` и `data_events_filters`.
      
          * `management_events_filter` — фильтр событий уровня конфигурации.
          * `resource_scopes` — [область сбора логов](../concepts/trail.md#collecting-area). Можно комбинировать в одном параметре `resource_scopes` несколько областей, которые принадлежат одной организации. Например, собирать логи из одного облака целиком, а из другого — только из определенных каталогов. Права сервисного аккаунта должны позволять сбор логов из указанных областей.
      
              * `resource_id` — идентификатор ресурса, для ресурсов которого будут собираться аудитные логи. В зависимости от области сбора аудитных логов укажите в этом параметре [идентификатор](../../organization/operations/organization-get-id.md) организации или [идентификатор](../../resource-manager/operations/cloud/get-id.md) облака.
              * `resource_type` — тип области согласно указанному идентификатору:
      
                  * `organization-manager.organization` — [организация](../../organization/concepts/organization.md);
                  * `resource-manager.cloud` — [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud);
                  * `resource-manager.folder` — [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
          * `data_events_filters` — фильтры событий уровня сервисов. Можно настроить несколько фильтров такого типа — по одному для каждого сервиса. Фильтр для одного сервиса имеет следующую структуру:
      
              * `service` — имя сервиса, в котором трейл будет обрабатывать события.  Его можно получить в [справочнике событий уровня сервисов](../concepts/events-data-plane.md)).
              * `resource_scopes` — места, откуда собирать события уровня сервисов. Этот параметр настраивается аналогично фильтру событий уровня конфигурации.
              * `included_events` — собирать только указанные события. Необязательный параметр. Если не указать, то будут собираться все события. Вместо `included_events` можно указать `excluded_events` — собирать все события, кроме указанных. Эти параметры — взаимоисключающие.
                  Полный перечень событий можно получить в [справочнике событий уровня сервисов](../concepts/events-data-plane.md).

      Подробнее о параметрах ресурса `yandex_audit_trails_trail` в [документации провайдера](../../terraform/resources/audit_trails_trail.md).

  1. Создайте ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Terraform создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

     ```bash
     yc audit-trails trail get <имя_трейла>
     ```

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/Trail/create.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызовом gRPC API [TrailService/Create](../api-ref/grpc/Trail/create.md).

  Чтобы упростить создание спецификации трейла, вы можете получить параметры существующего трейла с помощью метода REST API [get](../api-ref/Trail/get.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызова gRPC API [TrailService/Get](../api-ref/grpc/Trail/get.md).

{% endlist %}

Трейл создастся и начнет загружать аудитные логи в выбранный объект назначения.

При загрузке в Cloud Logging события в [лог-группе](../../logging/concepts/log-group.md) могут дублироваться. Чтобы найти дубли, ориентируйтесь на уникальный идентификатор записи `json_payload.event_id`.

## Примеры {#examples}

### Создание трейла с фильтрами событий уровня конфигурации и уровня сервисов {#example-control-data-planes}

Создайте трейл со следующими параметрами:

* Имя трейла — `sample-trail-all-planes`.
* Каталог, в котором будет размещен трейл — каталог с идентификатором `folder0***`.
* Объект назначения — бакет Object Storage с именем `sample-logs-bucket`.
* Сервисный аккаунт для трейла — аккаунт с идентификатором `service0***`.
* Настройки фильтра событий уровня конфигурации:

    В качестве области сбора логов выбрана организация с идентификатором `org1***`. Логи будут собираться из всех облаков, которые принадлежат этой организации.

* Настройки фильтров событий уровня сервиса:

    * Для сервиса [Managed Service for PostgreSQL](../../managed-postgresql/index.md) логи будут собираться из облака с идентификатором `cloud1***` и каталога с идентификатором `folder1***`.

        Будут собираться все [события сервиса](../concepts/events-data-plane.md#mpg), кроме следующих:

        * `yandex.cloud.audit.mdb.postgresql.CreateDatabase`,
        * `yandex.cloud.audit.mdb.postgresql.UpdateDatabase`.

    * Для сервиса [Object Storage](../../storage/index.md) логи будут собираться из облаков с идентификаторами `cloud2***` и `cloud3***`.

        Будут собираться только следующие [события сервиса](../concepts/events-data-plane.md#objstorage):

        * `yandex.cloud.audit.storage.ObjectCreate`,
        * `yandex.cloud.audit.storage.ObjectUpdate`,
        * `yandex.cloud.audit.storage.ObjectDelete`.

    * Для сервиса [Compute Cloud](../../compute/index.md) логи будут собираться из каталогов с идентификаторами `folder2***` и `folder3***`.

        Будут собираться все [события сервиса](../concepts/events-data-plane.md#compute).

{% list tabs group=instructions %}

- CLI {#cli}

  1. Создайте YAML-файл `sample-trail-all-planes.yaml` с конфигурацией трейла.

      {% cut "sample-trail-all-planes.yaml" %}

      ```yaml
      name: sample-trail-all-planes
      folder_id: folder0***
      destination:
        object_storage:
          bucket_id: sample-logs-bucket
      service_account_id: service0***
      filtering_policy:
        management_events_filter:
          resource_scopes:
            - id: org1***
              type: organization-manager.organization
        data_events_filters:
          - service: mdb.postgresql
            resource_scopes:
              - id: cloud1***
                type: resource-manager.cloud
              - id: folder1***
                type: resource-manager.folder
            excluded_events:
              event_types:
              - yandex.cloud.audit.mdb.postgresql.CreateDatabase
              - yandex.cloud.audit.mdb.postgresql.UpdateDatabase
          - service: storage
            resource_scopes:
              - id: cloud2***
                type: resource-manager.cloud
              - id: cloud3***
                type: resource-manager.cloud
            included_events:
              event_types:
                - yandex.cloud.audit.storage.ObjectCreate
                - yandex.cloud.audit.storage.ObjectUpdate
                - yandex.cloud.audit.storage.ObjectDelete
          - service: compute
            resource_scopes:
              - id: folder2***
                type: resource-manager.folder
              - id: folder3***
                type: resource-manager.folder
      ```

      {% endcut %}

  1. Выполните команду:

      ```bash
      yc audit-trails trail create --file sample-trail-all-planes.yaml
      ```

  Будет создан трейл с указанными параметрами.

- Terraform {#tf}

  1. Опишите в конфигурационном файле Terraform параметры создаваемого трейла:

      ```hcl
      resource "yandex_audit_trails_trail" "basic_trail" {
        name               = "sample-trail-all-planes"
        folder_id          = "folder0***"
        service_account_id = "service0***"

        storage_destination {
          bucket_name  = "sample-logs-bucket"
        }

        filtering_policy {
          management_events_filter {
            resource_scope {
              resource_id   = "org1***"
              resource_type = "resource-manager.organization"
            }
          }  
          data_events_filter {
            service = "mdb.postgresql"
            excluded_events = ["yandex.cloud.audit.mdb.postgresql.CreateDatabase","yandex.cloud.audit.mdb.postgresql.UpdateDatabase"]
            resource_scope {
              resource_id   = "cloud1***"
              resource_type = "resource-manager.cloud"
            }
            resource_scope {
              resource_id   = "folder1***"
              resource_type = "resource-manager.folder"
            }
          }
          data_events_filter {
            service = "storage"
            resource_scope {
              resource_id   = "cloud2***"
              resource_type = "resource-manager.cloud"
            }
            resource_scope {
              resource_id   = "cloud3***"
              resource_type = "resource-manager.cloud"
            }
          }
          data_events_filter {
            service = "compute"
            resource_scope {
              resource_id   = "folder2***"
              resource_type = "resource-manager.folder"
            }
            resource_scope {
              resource_id   = "folder3***"
              resource_type = "resource-manager.folder"
            }
          }
        }
      }
     ```

  1. Создайте ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Будет создан трейл с указанными параметрами. Проверить появление трейла можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

      ```bash
      yc audit-trails trail get sample-trail-all-planes
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/Trail/create.md) для ресурса [Trail](../api-ref/Trail/index.md).

  Чтобы воспользоваться примерами, установите [cURL](https://curl.haxx.se).

  Пример ниже разработан для выполнения в операционных системах MacOS и Linux. Чтобы выполнить его в системе Windows, [ознакомьтесь](../../overview/concepts/console-syntax-guide.md) с особенностями работы с Bash в Microsoft Windows.

  1. [Получите](../../iam/operations/index.md#authentication) IAM-токен, чтобы [аутентифицироваться](../api-ref/authentication.md) в API.

  1. Сохраните полученный IAM-токен в переменную, выполните в терминале:

      ```bash
      export IAM_TOKEN=<IAM-токен>
      ```

  1. Подготовьте файл `body.json` с телом запроса и описанием создаваемого трейла:

      ```json
      {
        "folderId": "folder0**",
        "name": "sample-trail-all-planes",
        "description": "sample-trail",
        "destination": {
          "objectStorage": {
            "bucketId": "sample-logs-bucket"
          }
        },
        "serviceAccountId": "service0***",
        "filteringPolicy": {
          "managementEventsFilter": {
            "resourceScopes": [
              {
                "id": "org1***",
                "type": "resource-manager.organization"
              }
            ]
          },
          "dataEventsFilters": [
            {
              "service": "mdb.postgresql",
              "excludedEvents": {
                "eventTypes": [
                  "yandex.cloud.audit.mdb.postgresql.CreateDatabase"
                  ,"yandex.cloud.audit.mdb.postgresql.UpdateDatabase"
                ]
              },
              "resourceScopes": [
                {
                  "id": "cloud1***",
                  "type": "resource-manager.cloud"
                },
                {
                  "id": "folder1***",
                  "type": "resource-manager.folder"
                }
              ]
            },
            {
              "service": "storage",
              "resourceScopes": [
                {
                  "id": "cloud2**",
                  "type": "resource-manager.cloud"
                },
                {
                  "id": "cloud3**",
                  "type": "resource-manager.cloud"
                }
              ]
            },
            {
              "service": "compute",
              "resourceScopes": [
                {
                  "id": "folder2**",
                  "type": "resource-manager.folder"
                },
                {
                  "id": "folder3**",
                  "type": "resource-manager.folder"
                }
              ]
            }
          ]
        }
      }
      ```

  1. Выполните в терминале запрос:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data "@<файл_с_телом_запроса>" \
        https://audittrails.api.cloud.yandex.net/audit-trails/v1/trails
      ```

      Где:
      * `<файл_с_телом_запроса>` — путь к созданному ранее файлу с телом запроса `body.json`.

      Результат:

      ```json
      {
      "done": true,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.audittrails.v1.CreateTrailMetadata",
        "trailId": "cnpvprd5pa66********"
      },
      "id": "cnp9qb9g8ldb********",
      "description": "operation_create",
      "createdAt": "2025-02-20T07:06:18.547321903Z",
      "createdBy": "ajevfb0tjfts********",
      "modifiedAt": "2025-02-20T07:06:18.547321903Z"
      }
      ```

{% endlist %}


## Что дальше {#whats-next}

* Узнайте о [формате аудитных логов](../concepts/format.md).
* Узнайте о порядке [загрузки аудитных логов в SIEM](../concepts/export-siem.md).
* Узнайте о [поиске событий в аудитных логах](../tutorials/search-events-audit-logs/index.md).