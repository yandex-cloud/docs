# Интеграция с {{ data-catalog-full-name }}

Вы можете использовать AI-ассистента для поиска и анализа закономерностей в [каталогах метаданных](../../metadata-hub/concepts/data-catalog.md), развернутых в сервисе {{ data-catalog-name }}. Для этого подключите MCP-сервер {{ data-catalog-name }} к {{ mcp-hub-name }}. Сервер позволяет запрашивать список каталогов метаданных, выполнять поиск в метаданных, а также получать граф их зависимостей (lineage) на уровне таблиц и колонок для использования в контексте диалога с агентами.

Чтобы в {{ ai-studio-name }} настроить интеграцию с сервисом {{ data-catalog-name }}:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте каталог метаданных к работе](#prepare-data-catalog).
1. [Подключите внешний MCP-сервер](#connect-mcp).
1. [Протестируйте диалог с агентом](#test-dialog).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость инфраструктуры для интеграции входит плата за использование {{ agents-atelier-name }}: количество токенов в запросе и ответе (см. [тарифы {{ ai-studio-full-name }}]({{ link-docs-ai }}ai-studio/pricing)). Тарификация за использование агента начинается с момента его включения.


## Подготовьте инфраструктуру {#infra}

### Создайте каталог и сеть {#create-folder}

Создайте каталог ресурсов, в котором будет размещен ваш каталог метаданных.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите облако и нажмите ![create](../../_assets/console-icons/plus.svg)**{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Введите имя каталога, например `data-folder`.
   1. Выберите опцию **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}**. Будет создана [сеть](../../vpc/concepts/network.md#network) с подсетями в каждой [зоне доступности](../../overview/concepts/geo-scope.md).
   1. Нажмите **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Создайте сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Перейдите в каталог `data-folder`.
   1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `sa-for-mcp-server`.
   1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и назначьте сервисному аккаунту [роли](../../iam/concepts/access-control/roles.md):
      * `data-catalog.user` — для доступа к ресурсам каталога метаданных.
      * `serverless.mcpGateways.invoker` — для доступа к MCP-серверу в {{ mcp-hub-name }}.
      * `serverless.mcpGateways.anonymousInvoker` — для доступа к внешнему MCP-серверу.

   1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Подготовьте каталог метаданных к работе {#prepare-data-catalog}

### Создайте каталог метаданных {#create-catalog}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать каталог метаданных.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-catalog }}**.
    1. В поле **{{ ui-key.yacloud.common.name }}** задайте имя каталога `test-sales`.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

    {% include [ai-on](../../_includes/metadata-hub/data-catalog-ai-markup-on.md) %}

{% endlist %}

### Создайте источник метаданных {#create-source}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. На панели слева выберите ![image](../../_assets/console-icons/cloud-arrow-up-in.svg) **{{ ui-key.yacloud.data-catalog.label_sources }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-source-button }}**.
    1. Задайте имя источника `test-sales-source`.
    1. Выберите тип бэкенда, из которого будут поставляться метаданные для анализа. После создания источника нельзя будет изменить тип базы данных. Доступные бэкенды:

       {% include notitle [sources](../../_includes/metadata-hub/data-catalog-sources.md) %}

    1. Укажите параметры источника для выбранного типа базы данных:

        {% include [source-parameters](../../_includes/metadata-hub/data-catalog-source-parameters.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Создайте и запустите загрузку данных {#create-ingestion}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На панели слева выберите ![image](../../_assets/console-icons/arrow-up-from-square.svg) **{{ ui-key.yacloud.data-catalog.label_ingestions }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-ingestion-action }}**.
  1. Задайте параметры загрузки:

      * В поле **{{ ui-key.yacloud.common.name }}** задайте имя загрузки `load-sales`.
      * Выберите [созданный ранее](#create-source) источник метаданных.
      * Задайте конфигурацию загрузки для выбранного источника данных:

         * Выберите расписание запуска загрузки **{{ ui-key.data-catalog.console.form.cron.Cron.none.title }}**.
         * (Опционально) В блоке **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.data_filters.title }}** с помощью регулярных выражений укажите, какие базы данных и объекты баз данных необходимо включить или исключить из загрузки.

         {% include [metadata-profiling](../../_includes/metadata-hub/metadata-profiling.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. В списке загрузок нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке с созданной загрузкой и выберите пункт **{{ ui-key.yacloud.common.start }}**.
  
     При загрузке данные будут автоматически размечены AI-ассистентом. После успешного завершения загрузка примет статус **{{ ui-key.yacloud.data-catalog.label_ingestion-status-Success }}**.

  1. Чтобы посмотреть загруженные и размеченные данные, на панели слева выберите ![image](../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud.data-catalog.title_search-data }}**.

     На странице отображается информация о данных — источник данных, база данных и таблицы.

     {% note info %}

     AI-ассистент создает сущности для разметки метаданных (домены, глоссарии и теги, классификации и термины), а также их описания автоматически. Предложенную ассистентом разметку можно подтвердить, отредактировать или отклонить. Для этого наведите курсор на значок **{{ ui-key.yacloud.data-catalog.label_ai-label }}** рядом с предложением ассистента и выберите нужное действие.

    {% endnote %}

{% endlist %}

## Подключите внешний MCP-сервер {#connect-mcp}

### Подключение в {{ ai-studio-name }} {#mcp-ai-studio}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в каталог `data-folder`.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ai-studio }}**.
  1. На панели слева выберите ![logo-mcp](../../_assets/console-icons/logo-mcp.svg) **MCP-серверы** и нажмите кнопку **Создать MCP-сервер**. В открывшемся окне:

      1. В блоке **Способ добавления** выберите опцию ![plug-connection](../../_assets/console-icons/plug-connection.svg) **Подключить**.
      1. В блоке **Инструменты** нажмите кнопку **Добавить инструменты**. В открывшемся окне укажите настройки подключения к MCP-серверу:

         * **Транспорт** — **Streamable HTTP**.

         * **URL** — `https://datacatalog-consumer.mcp.cloud.yandex.net/mcp`.

         * **Тип авторизации** — `Токен доступа`.

         * В блоке **Заголовок авторизации** укажите в поле **Значение** `Bearer <IAM_токен>`. Для этого получите [IAM-токен](../../iam/concepts/authorization/iam-token.md) для [созданного ранее](#create-sa) сервисного аккаунта, скопируйте его и вставьте в поле.

            {% note info %}

            {% include [iam-token-lifetime](../../_includes/iam-token-lifetime.md) %}

            {% endnote %}

      1. Нажмите кнопку **Подключиться**.
      1. В открывшемся окне **Добавление инструментов** выберите все инструменты и нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

      1. В блоке **Параметры сервера**:

          1. {% include [create-server-console-general-params-ss1](../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss1.md) %}
          1. {% include [create-server-console-general-params-ss2](../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss2.md) %}
          1. В поле **Доступ** выберите **Приватный**.
          1. В поле **Сервисный аккаунт** выберите сервисный аккаунт, созданный ранее.
          1. {% include [create-server-console-general-params-ss5](../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss5.md) %}
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

  1. На панели слева выберите ![logo-agent](../../_assets/console-icons/face-robot.svg) **Агенты** и нажмите кнопку **Создать агента**.
  1. Укажите параметры агента:
     * **{{ ui-key.yacloud.common.name }}** — имя агента.
     * **Модель** — языковая модель.
     * В блоке **Инструкция** выберите готовый шаблон системной инструкции агенту или опишите, как агент должен себя вести и что нужно сделать.
     * В блоке **Инструменты**:
       * Нажмите кнопку **{{ ui-key.yacloud.common.add }}** и выберите **Добавить MCP**.
       * Выберите в списке созданный ранее MCP-сервер и нажмите кнопку **Выбрать**.
       * В поле **Поведение по умолчанию для всех инструментов** выберите **Подтверждение не нужно**.
       * Нажмите кнопку **Создать и продолжить**.

{% endlist %}

### Подключение к внешнему AI-агенту {#mcp-connect-agent}

1. Получите [IAM-токен](../../iam/concepts/authorization/iam-token.md) для [созданного ранее](#create-sa) сервисного аккаунта.
   
   {% note info %}

   {% include [iam-token-lifetime](../../_includes/iam-token-lifetime.md) %}

   {% endnote %}

1. Укажите конфигурацию MCP-сервера {{ data-catalog-name }} для вашего агента:

   ```json
   {
     "mcpServers": {
       "yandex-cloud-datacatalog-consumer": {
         "type": "streamableHttp",
         "url": "https://datacatalog-consumer.mcp.cloud.yandex.net/mcp",
         "headers": {
           "Authorization": "Bearer <IAM_токен>"
         }
       }
     }
   }
   ```

## Протестируйте диалог с агентом {#test-dialog}

{% note tip %}

Если вы используете агента в {{ ai-studio-name }}, тестируйте диалог в правой панели **Тестирование агента**.

{% endnote %}

1. Начните диалог с агентом с указания идентификатора каталога данных, например:

   ```text
   Используй размеченные данные в каталоге данных apah36iavgh5********.
   ```

1. Используйте примеры промптов, для ответа на которые агент будет анализировать размеченные данные из {{ data-catalog-name }}. Предполагается, что данные содержат информацию о продажах:

   * `Составь SQL запрос для построения аналитики продаж YoY`
   * `Найди все таблицы с информацией о платежах пользователей`
   * `Какие таблицы помечены как содержащие чувствительные данные?`
   * `Откуда берутся данные в таблице customer_transactions?`
   * `Помоги найти нужные таблицы для расчета метрики retention пользователей`
   * `Где хранятся данные о поведении пользователей на сайте?`
   * `Какие данные использовать для анализа конверсии воронки продаж?`
   * `Покажи все зависимости таблицы transactions — нужно понять влияние изменений схемы`
