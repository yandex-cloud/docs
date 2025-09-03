# Работа с диалогами

В [диалоге](../../concepts/dialogs.md) вы можете получить подробную информацию о диалоге, прослушать аудиозапись разговора и посмотреть переписку клиента с оператором или ботом.

## Посмотреть список диалогов {#list-dialogs}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите нужный проект.

По умолчанию на вкладке **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** отображаются 100 последних диалогов. Чтобы увидеть предыдущие, нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.show-more }}** в конце списка.

## Найти диалоги {#search-dialogs}

Для поиска диалогов вы можете использовать:
* [фильтры](#filters-dialogs),
* [полнотекстовый поиск](#full-text-search),
* [словарный поиск](#dictionary-search),
* [смысловой поиск](#sense-search).

Чтобы получить больше информации о каждом диалоге, [настройте отображение колонок](#set-columns).

### Фильтры {#filters-dialogs}

Чтобы применить фильтр к диалогам:

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите нужный проект.
1. На вкладке **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.common.add-filter }}**.
1. Выберите нужный фильтр и введите его значение.
1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.apply }}**.

Вы можете добавить несколько фильтров. Они будут объединены логической операцией «И». В результате будут найдены диалоги, которые удовлетворяют всем заданным условиям.

### Полнотекстовый поиск {#full-text-search}

Полнотекстовый поиск позволяет найти диалоги, содержащие определенное слово или фразу. Чем больше текст диалога соответствует поисковому запросу и чем чаще этот текст встречается, тем выше располагается диалог в результатах поиска.

Чтобы выполнить поиск:

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите нужный проект.
1. Перейдите на вкладку **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}**.
1. В выпадающем списке над поисковой строкой выберите ![image](../../../_assets/console-icons/square-dashed-text.svg) **{{ ui-key.yc-ui-talkanalytics.dialogs.search.text.title }}**.
1. Введите в поисковой строке искомый фрагмент текста.
1. (Опционально) Чтобы уточнить результаты поиска, под поисковой строкой выберите из выпадающего списка  канал, в котором нужно выполнить поиск: **{{ ui-key.yc-ui-talkanalytics.dialogs.all-participants }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}** или **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.common.search }}**.

### Словарный поиск {#dictionary-search}

Словарный поиск позволяет найти диалоги, содержащие одну или несколько заданных ключевых фраз.

Чтобы выполнить поиск:

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите нужный проект.
1. Перейдите на вкладку **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}**.
1. В выпадающем списке над поисковой строкой выберите ![image](../../../_assets/console-icons/square-dashed-letter-t.svg) **{{ ui-key.yc-ui-talkanalytics.dialogs.search.dictionary.title }}**.
1. Введите в поисковой строке ключевую фразу или фразы. Каждая фраза вводится с новой строки.

   {% include [key-phrases-restrictions](../../../_includes/speechsense/data/key-phrases-restrictions.md) %}

1. (Опционально) Чтобы уточнить результаты поиска:

   * Выберите из выпадающего списка канал, в котором нужно выполнить поиск: **{{ ui-key.yc-ui-talkanalytics.dialogs.all-participants }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}** или **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**.
   * Выберите допустимую дистанцию между словами в ключевой фразе.
   * Включите опцию **{{ ui-key.yc-ui-talkanalytics.dialogs.exact-match-by-key-phrases }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.common.search }}**.

### Смысловой поиск {#sense-search}

Смысловой поиск позволяет найти диалоги, которые соответствуют по смыслу поисковому запросу в контексте выбранного [смыслового атрибута](../../concepts/reports/sense-attributes.md). В поисковой выдаче будут только соответствующие поисковому запросу диалоги, расположенные в порядке убывания вероятности соответствия.

Чтобы выполнить поиск:

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите нужный проект.
1. Перейдите на вкладку **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}**.
1. В выпадающем списке над поисковой строкой выберите ![image](../../../_assets/console-icons/neuro-tag.svg) **{{ ui-key.yc-ui-talkanalytics.dialogs.search.neuro.title }}**.
1. Выберите из выпадающего списка один из смысловых атрибутов.
1. В поисковой строке выберите поисковый запрос из автоматически сгенерированных [подсказок](../../concepts/tags.md#suggestions) или введите его вручную.

   Если в проекте более 1000 диалогов, при подготовке подсказок {{ speechsense-name }} проанализирует только 1000 диалогов случайным образом. Если автоматически сгенерированные подсказки вам не подходят, вы можете нажать кнопку **{{ ui-key.yacloud.common.update }}**. {{ speechsense-name }} снова выберет 1000 диалогов случайным образом, проанализирует их и сгенерирует новые подсказки.

1. Нажмите кнопку **{{ ui-key.yacloud.common.search }}**.

## Настроить отображение колонок {#set-columns}

По умолчанию в списке диалогов отображаются не все колонки. Вы можете отобразить дополнительные колонки, скрыть ненужные, а также изменить их порядок.

Чтобы настроить отображение колонок:

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите нужный проект.
1. В строке заголовков для списка диалогов нажмите ![image](../../../_assets/console-icons/gear.svg). Откроется список всех колонок.
1. Выполните в списке колонок нужные действия:

    * Чтобы отобразить дополнительные колонки, отметьте их.
    * Чтобы скрыть ненужные колонки, снимите для них отметки. Некоторые колонки нельзя скрыть, в них снятие отметки недоступно.
    * Чтобы изменить порядок колонок, слева от названия колонки нажмите ![image](../../../_assets/console-icons/grip.svg) и перетяните колонку на нужную позицию в списке.

1. Нажмите кнопку **Применить**.

## Просмотреть диалог {#view-dialog}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите нужный проект.
1. [Найдите нужный диалог](#search-dialogs).
1. Откройте диалог одним из способов:

    * Чтобы открыть превью диалога, нажмите на строку диалога.
    * Чтобы открыть диалог в новом окне, нажмите в строке диалога справа ![image](../../../_assets/console-icons/arrow-up-right-from-square.svg).

На странице диалога отображается следующая информация:

* Метаданные, например, имена оператора и клиента, дата звонка или сообщения, язык диалога.
* Аудиозапись разговора (только для аудио).
* Содержимое разговора на вкладке **{{ ui-key.yc-ui-talkanalytics.dialogs.dialog }}**.
* Смысловой анализ разговора на вкладке **{{ ui-key.yc-ui-talkanalytics.projects.sumarization }}**.
* Присвоенные диалогу [теги](../../concepts/tags.md).

Подробнее см. в разделе [{#T}](../../concepts/dialogs.md#details).

## Изменить метаданные диалога {#edit-dialog-metadata}

Обновление метаданных диалога может быть полезным в разных ситуациях. Например, можно добавить оценку уже загруженному диалогу после того, как клиент оценил его.

Значения метаданных можно обновлять для ключей, которые были добавлены [при создании подключения](../connection/create.md). Если в настройках подключения нет метаданных, то их нельзя добавить.

Изменить метаданные диалога можно с помощью gRPC API {{ yandex-cloud }}. Для этого:

1. [Получите идентификатор диалога](#get-dialog-id).
1. [Подготовьте инфраструктуру для работы с gRPC API {{ yandex-cloud }}](#prepare-grpc-api).
1. [Получите информацию о диалоге](#get-dialog-info).
1. [Измените метаданные диалога](#edit-metadata).

### Получите идентификатор диалога {#get-dialog-id}

Найдите нужный диалог и скопируйте его идентификатор:

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите нужный проект.
1. На вкладке **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** [найдите нужный диалог](#search-dialogs) и перейдите в него.
1. Скопируйте идентификатор диалога, находящийся в левом верхнем углу.

### Подготовьте инфраструктуру для работы с gRPC API {{ yandex-cloud }} {#prepare-grpc-api}

{% include [software](../../../_includes/speechsense/data/software.md) %}

1. {% include [create-sa](../../../_includes/speechsense/data/create-sa.md) %}
1. {% include [role-sa](../../../_includes/speechsense/data/role-sa.md) %}
1. {% include [create-api-key](../../../_includes/speechsense/data/create-api-key.md) %}
1. {% include [clone-cloudapi](../../../_includes/speechsense/data/clone-cloudapi.md) %}
1. {% include [install-grpcio-tools](../../../_includes/speechsense/data/install-grpcio-tools.md) %}

### Получите информацию о диалоге {#get-dialog-info}

Воспользуйтесь вызовом [TalkService/Get](../../api-ref/grpc/Talk/get.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}.

В примерах используются демонстрационные данные.

**Запрос:**

```bash
grpcurl \
    -format json \
    -import-path ~/cloudapi/ \
    -import-path ~/cloudapi/third_party/googleapis/ \
    -proto ~/yandex/cloud/speechsense/v1/talk_service.proto \
    -rpc-header "Authorization: Bearer $IAM_TOKEN" \
    -d '{
          "space_id": "f3fuc***************",
          "project_id": "eagpe***************",
          "talk_ids": [
            "aud78***************"
          ]
        }' \
    api.speechsense.yandexcloud.net:443 \
    yandex.cloud.api.speechsense.v1.TalkService.Get
```

**Ответ:**

```json
{
  "talk": [
    {
      "id": "aud78***************",
      "organizationId": "yc.organization-manager.example",
      "spaceId": "f3fuc***************",
      "connectionId": "eagjj***************",
      "projectIds": [
        "eagpe***************"
      ],
      "createdBy": "ajegr***************",
      "createdAt": "2025-04-24T14:35:19.882Z",
      "modifiedBy": "CLASSIFIER",
      "modifiedAt": "2025-04-24T14:35:24.470980Z",
      "talkFields": [
        {
          "name": "operator_name",
          "value": "Иван",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "operator_id",
          "value": "11111",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "client_name",
          "value": "Александр",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "client_id",
          "value": "22222",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "date",
          "value": "2025-04-24T14:34:19Z",
          "type": "FIELD_TYPE_DATE"
        },
        {
          "name": "direction_outgoing",
          "value": "true",
          "type": "FIELD_TYPE_BOOLEAN"
        },
        {
          "name": "language",
          "value": "ru-ru",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "score_main",
          "type": "FIELD_TYPE_STRING"
        }
      ],
    // ...
    }
  ]
}
```

В ответе, в поле `talkFields`, содержатся метаданные диалога:

* `operator_name` — имя оператора.
* `operator_id` — идентификатор оператора.
* `client_name` — имя клиента.
* `client_id` — идентификатор клиента.
* `date` — дата и время начала диалога в формате `YYYY-MM-DDTHH:MM:SSSZ`.

   {% include [data-format](../../../_includes/speechsense/data/data-format.md) %}

* `direction_outgoing` — направление диалога (входящий или исходящий).
* `language` — язык диалога.
* `score_main` — оценка диалога. Дополнительный ключ, значение будет добавлено при изменении метаданных.

### Измените метаданные диалога {#edit-metadata}

{% note info %}

При изменении метаданных диалога необходимо передавать все ключи, иначе их значения будут удалены.

{% endnote %}

Для изменения метаданных аудио воспользуйтесь вызовом [TalkService/Upload](../../api-ref/grpc/Talk/upload.md). Для изменения метаданных чата используйте вызов [TalkService/UploadText](../../api-ref/grpc/Talk/uploadText.md). Выполните запрос, например, с помощью {{ api-examples.grpc.tool }}.

В примере используются демонстрационные данные.

**Запрос:**

В запросе добавляется новое значение ключа `score_main`, остальные значения ключей передаются без изменений.

```bash
grpcurl \
    -format json \
    -import-path ~/cloudapi/ \
    -import-path ~/cloudapi/third_party/googleapis/ \
    -proto ~/cloudapi/yandex/cloud/speechsense/v1/talk_service.proto \
    -rpc-header "Authorization: Bearer $IAM_TOKEN" \
    -d '{
          "talkId": "aud78***************",
          "metadata": {
            "connectionId": "eagjj***************",
            "fields": {
              "date": "2025-04-24T14:34:19Z",
              "direction_outgoing": "true",
              "language": "ru-ru",
              "operator_name": "Иван",
              "operator_id": "11111",
              "client_name": "Александр",
              "client_id": "22222",
              "score_main": "4"
            }
          }
        }' \
    api.speechsense.yandexcloud.net:443 \
    yandex.cloud.speechsense.v1.TalkService.Upload
```

## Пример поиска диалогов по периоду и фрагменту текста {#example-find-dialogs-by-period-and-text}

Условия поиска:

* За период `10.11.2023 - 16.11.2023`.
* Содержит фразу клиента `хорошее обслуживание`.

Выполните действия:

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите нужный проект.
1. На вкладке **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** в строке поиска введите `хорошее обслуживание`.
1. Справа от строки поиска выберите из выпадающего списка канал **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**.
1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.common.add-filter }}**.
1. В группе **{{ ui-key.yc-ui-talkanalytics.dialogs.common-metadata }}** выберите фильтр **Дата начала**. В качестве значения фильтра укажите диапазон дат `10.11.2023 - 16.11.2023`.
1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.apply }}**.

В результате отобразятся отфильтрованные диалоги.

Пример ранжирования диалогов в зависимости от найденных фрагментов текста:

#|
|| **№ п/п** | **Дата диалога** | **Фрагмент диалога** ||
|| 1 | 16.11.2023 | спасибо за `хорошее обслуживание` ||
|| 2 | 13.11.2023 | `хорошее` оборудование и сервисное `обслуживание` ||
|| 3 | 15.11.2023 | полное `обслуживание` системы ||
|#

#### См. также {#see-also}

* [Как {{ speechsense-full-name }} заменяет ручную проверку диалогов с клиентами](https://yandex.cloud/ru/blog/posts/2025/05/speechsense-and-dialogues)
* [Как использовать {{ speechsense-full-name }} для оценки разговоров в офисах продаж, магазинах или кафе](https://yandex.cloud/ru/blog/yandex-speechsense-update)