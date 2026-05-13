# Начало работы со Schema Registry

Управляйте версиями схем со Schema Registry.



{% note info %}

Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}




## Создайте пространство имен {#create-namespace}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/layout-cells.svg) **Schema Registry**.
  1. Нажмите кнопку **Создать пространство имён**.
  1. В поле **Имя** задайте уникальное имя пространства имен.
  1. (Опционально) Добавьте описание пространства имен.
  1. В блоке **Параметры совместимости**:
      1. Задайте **Уровень проверки совместимости**
          * `BACKWARD`: (значение по умолчанию) потребители, использующие новую схему, могут читать данные, написанные производителями с использованием последней зарегистрированной схемы;
          * `BACKWARD_TRANSITIVE`: потребители, использующие новую схему, могут читать данные, записанные производителями с использованием всех ранее зарегистрированных схем;
          * `FORWARD`: потребители, использующие последнюю зарегистрированную схему, могут читать данные, написанные производителями, использующими новую схему;
          * `FORWARD_TRANSITIVE`: потребители, использующие все ранее зарегистрированные схемы, могут читать данные, написанные производителями с использованием новой схемы;
          * `FULL`: новая схема совместима вперед и назад с последней зарегистрированной схемой;
          * `FULL_TRANSITIVE`: новая схема совместима вперед и назад со всеми ранее зарегистрированными схемами;
          * `NONE`: проверки совместимости схемы отключены.
            Подробнее о типах совместимости схем см. в [документации Confluent](https://docs.confluent.io/platform/current/schema-registry/fundamentals/schema-evolution.html#compatibility-types).
      1. Выберите [политику проверки совместимости](../concepts/compatibility-check-policy.md) для JSON-схем:
          * `optional-friendly` — основывается на [решении](#optional-parameters-compatibility-solution) с использованием разных контентных моделей для производителя и потребителя. Поддерживает добавление и удаление опциональных параметров с сохранением полной транзитивной совместимости.
          * `Confluent` — основывается на стандартах [Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/fundamentals/schema-evolution.html#compatibility-types) и не обеспечивает полную совместимость при добавлении и удалении опциональных параметров.
      1. Выберите политику проверки совместимости для Protobuf-схем:
          * Confluent — основывается на стандартах [Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/fundamentals/schema-evolution.html#compatibility-types).
          * buf — основывается на стандартах [Buf](https://buf-build-git-psachs-docs-and-search-bufbuild.vercel.app/docs/build/usage/).
  1. Нажмите кнопку **Создать**.


{% endlist %}

## Загрузите схему в субъект {#add-schema}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На панели слева выберите ![image](../../_assets/console-icons/branches-down.svg) **Схемы**.
  1. Нажмите кнопку **Загрузить схему**.
  1. Выберите способ загрузки схемы в новый субъект и укажите следующие параметры:
      * **Имя** — уникальное имя субъекта;
      * Опционально добавьте **Уровень проверки совместимости**, если необходимо изменить уровень, наследуемый от пространства имен:
          * `BACKWARD`: (значение по умолчанию) потребители, использующие новую схему, могут читать данные, написанные производителями с использованием последней зарегистрированной схемы;
          * `BACKWARD_TRANSITIVE`: потребители, использующие новую схему, могут читать данные, записанные производителями с использованием всех ранее зарегистрированных схем;
          * `FORWARD`: потребители, использующие последнюю зарегистрированную схему, могут читать данные, написанные производителями, использующими новую схему;
          * `FORWARD_TRANSITIVE`: потребители, использующие все ранее зарегистрированные схемы, могут читать данные, написанные производителями с использованием новой схемы;
          * `FULL`: новая схема совместима вперед и назад с последней зарегистрированной схемой;
          * `FULL_TRANSITIVE`: новая схема совместима вперед и назад со всеми ранее зарегистрированными схемами;
          * `NONE`: проверки совместимости схемы отключены.
            Подробнее о типах совместимости схем см. в [документации Confluent](https://docs.confluent.io/platform/current/schema-registry/fundamentals/schema-evolution.html#compatibility-types).
  1. Задайте формат данных [Protobuf](https://protobuf.dev/), [Avro](https://avro.apache.org/) или [JSON Schema](https://json-schema.org/) и прикрепите файл.
  1. Если схема ссылается на другую схему, то в разделе **Референсы** нажмите ![add](../../_assets/console-icons/plus.svg) и введите имя [референса](../concepts/schema-registry.md#reference), имя субъекта, под которым зарегистрирована схема для ссылки, и версию схемы зарегистрированного субъекта.
  1. Чтобы применить [нормализацию схемы данных](https://docs.confluent.io/platform/current/schema-registry/fundamentals/serdes-develop/index.html#schema-normalization), включите настройку **Нормализация**.
  1. Если вы хотите пропустить проверку совместимости схем, включите соответствующую настройку.
  1. Нажмите кнопку **Загрузить схему**.

- API {#api}

  
  1. Установите [cURL](https://curl.haxx.se).
  1. [Авторизуйтесь](../api-ref/authentication.md) для выполнения операций в API.
  1. [В настройках созданного пространства имен](../operations/update-name-space.md) скопируйте его идентификатор.
  1. Воспользуйтесь методом API POST, чтобы загрузить и зарегистрировать схему для субъекта. Передайте в запросе: 
     
      * `schemaType` — формат данных: [PROTOBUF](https://protobuf.dev/), [AVRO](https://avro.apache.org/) или [JSON](https://json-schema.org/). Если параметр `schemaType` не указан, по умолчанию используется `AVRO`.
      * `schema.type` — тип данных. Например, `record`.
      * `schema.name` — имя схемы, которая будет загружена в субъект.
      * `schema.fields` — поля схемы. Пример: `[{\"name\": \"age\", \"type\": \"int\"}]`.
      * Идентификатор пространства имен.
      * Имя субъекта, в который будет загружена схема.

      Формат запроса:

            
      ```bash
      curl \
        --request POST \
        --header "accept: application/json" \
        --header "Authorization: <токен>" \
        --header "Content-Type: application/json" \
        --data '{
           "schemaType": "<формат данных>",
           "schema": '{
             \"type\": \"<тип данных>\", 
             \"name\": \"<имя_схемы>\", 
             \"fields\":[поля_схемы]}
            }' \
        https://<идентификатор_пространства_имен>.schema-registry.yandexcloud.net/subjects/<имя_субъекта>/versions
      ```

      В ответ на успешный запрос придет уникальный идентификатор схемы. Пример: `{"id":1}`.

      Примеры запросов см. в [документации Confluent](https://docs.confluent.io/platform/current/schema-registry/develop/api.html#post--subjects-(string-%20subject)-versions).

{% endlist %}

## Что дальше {what-is-next}

После создания пространства имен и регистрации схемы:
1. [Подключитесь к пространству имен](../operations/connect-to-namespace.md).
1. [Добавляйте схемы в субъект](../operations/add-schema.md).
1. [Сравнивайте версии схем](../operations/compare-schemas.md).