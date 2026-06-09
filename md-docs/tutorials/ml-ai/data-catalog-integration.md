# Интеграция {{ ai-studio-name }} с сервисом {{ data-catalog-full-name }}

# Интеграция с {{ data-catalog-full-name }}

Вы можете использовать AI-ассистента для поиска и анализа закономерностей в [каталогах метаданных](../../metadata-hub/concepts/data-catalog.md), развернутых в сервисе {{ data-catalog-name }}. Для этого подключите MCP-сервер {{ data-catalog-name }} к {{ mcp-hub-name }}. Сервер позволяет запрашивать список каталогов метаданных, выполнять поиск в метаданных, а также получать граф их зависимостей (lineage) на уровне таблиц и колонок для использования в контексте диалога с агентами.

Чтобы в {{ ai-studio-name }} настроить интеграцию с сервисом {{ data-catalog-name }}:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте каталог метаданных к работе](#prepare-data-catalog).
1. [Подключите внешний MCP-сервер](#connect-mcp).
1. [Протестируйте диалог с агентом](#test-dialog).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


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
   1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
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
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-catalog }}**.
    1. В поле **{{ ui-key.yacloud.common.name }}** задайте имя каталога `test-sales`.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

    {% note info %}
    
    При создании каталога метаданных опция **AI-разметка метаданных** включена по умолчанию.
    
    Когда опция включена, AI-ассистент предлагает описания, [домены](../../metadata-hub/concepts/data-catalog.md#domains-and-subdomains), [классификации и теги](../../metadata-hub/concepts/data-catalog.md#classifications-and-tags), [глоссарии и термины](../../metadata-hub/concepts/data-catalog.md#glossaries-and-terms), а также размечает с их помощью ваши метаданные. Предложения ассистента можно подтвердить, отредактировать или отклонить. Для этого наведите курсор на значок **{{ ui-key.yacloud.data-catalog.label_ai-label }}** рядом с предложением ассистента и выберите нужное действие.
    
    После создания каталога AI-разметкой можно управлять на странице **{{ ui-key.yacloud.common.overview }}** или при [изменении](../../metadata-hub/operations/data-catalog/update-catalog.md) каталога.
    
    {% endnote %}

{% endlist %}

### Создайте источник метаданных {#create-source}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. На панели слева выберите ![image](../../_assets/console-icons/cloud-arrow-up-in.svg) **{{ ui-key.yacloud.data-catalog.label_sources }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-source-button }}**.
    1. Задайте имя источника `test-sales-source`.
    1. Выберите тип бэкенда, из которого будут поставляться метаданные для анализа. После создания источника нельзя будет изменить тип базы данных. Доступные бэкенды:

       * {{ PG }};
       * {{ MY }};
       * {{ CH }};
       * {{ SD }}/{{ MG }};
       * {{ OS }};
       * {{ GP }};
       * {{ data-transfer-full-name }};
       * {{ websql-name }};
       * {{ datalens-name }}.

    1. Укажите параметры источника для выбранного типа базы данных:

        * **{{ ui-key.data-catalog.console.form.postgresql_source_create.PostgreSQLSourceCreate.ConnectionType.ManagedConnection.connection_id.title }}** — идентификатор управляемого подключения в [{{ connection-manager-full-name }}](../../metadata-hub/quickstart/connection-manager.md).
        * **{{ ui-key.data-catalog.console.form.postgresql_source_create.PostgreSQLSourceCreate.database_name.title }}** — имя базы данных, из которой будут загружаться метаданные.

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

         * В блоке **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.metadata_types.title }}** выберите, какие типы метаданных необходимо извлекать из источника.
         * (Опционально) В блоке **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.profiling.title }}**:
         
           * Выберите опцию **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.enabled.title }}**, чтобы выполнять профилирование данных, т. е. анализ и сбор статистики об извлекаемых данных.
           * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_profile-table-level-only_7nYxP }}**, чтобы не выполнять профилирование данных в каждом столбце таблицы. Если опция включена, характеристики данных будут собираться только по таблице в целом.
           * В поле **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.max_workers.title }}** укажите количество вычислительных потоков для профилирования.
           * В поле **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.sample_size.title }}** укажите количество строк для выборки при профилировании столбцов. Настройка применяется при включенной опции **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.use_sampling.title }}**.
           * В поле **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_profile-table-size-limit_wgTaU }}** укажите размер таблицы (в ГБ), при превышении которого таблицы исключаются из профилирования.
           * В поле **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_profile-table-row-limit_c8X7A }}** укажите количество строк, при превышении которого таблицы исключаются из профилирования.
           * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-null-count_sAR8k }}**, чтобы получить количество строк со значением `NULL` для каждого столбца.
           * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-distinct-count_73gDL }}**, чтобы получить количество уникальных значений для каждого столбца.
           * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-min-value_24EaF }}**, чтобы получить минимальное значение для каждого числового столбца.
           * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-max-value_4D1zy }}**, чтобы получить максимальное значение для каждого числового столбца.
           * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-mean-value_6qPHU }}**, чтобы получить среднее значение для каждого числового столбца.
           * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-median-value_jPJbY }}**, чтобы получить медианное значение для каждого числового столбца.
           * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-stddev-value_p9Gbi }}**, чтобы получить стандартное отклонение для каждого числового столбца.
           * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-quantiles_14ojH }}**, чтобы получить квантили для каждого числового столбца.
           * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-distinct-value-frequencies_tag9L }}**, чтобы получить частоту уникальных значений для каждого столбца.
           * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-histogram_dsfNW }}**, чтобы получить гистограмму для каждого числового столбца.
           * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-sample-values_msWXw }}**, чтобы получить примеры значений для каждого столбца.
           * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_query-combiner-enabled_mUDtA }}**, чтобы динамически объединять SQL-запросы для ускорения профилирования.
           * В поле **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_limit_nTvrt }}** укажите максимальное количество строк для профилирования. При значении `0` будут профилироваться все строки.
         
         * В блоке **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.metadata_process.title }}** выберите, каким образом обрабатывать метаданные:
           * Чтобы повысить производительность загрузки, включите опцию **{{ ui-key.data-catalog.console.form.ingestion.MetadataProcessSection.use_file_backed_cache.title }}**.

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
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ai-studio }}**.
  1. На панели слева выберите ![logo-mcp](../../_assets/console-icons/logo-mcp.svg) **MCP-серверы** и нажмите кнопку **Создать MCP-сервер**. В открывшемся окне:

      1. В блоке **Способ добавления** выберите опцию ![plug-connection](../../_assets/console-icons/plug-connection.svg) **Подключить**.
      1. В блоке **Инструменты** нажмите кнопку **Добавить инструменты**. В открывшемся окне укажите настройки подключения к MCP-серверу:

         * **Транспорт** — **Streamable HTTP**.

         * **URL** — `https://datacatalog-consumer.mcp.cloud.yandex.net/mcp`.

         * **Тип авторизации** — `Токен доступа`.

         * В блоке **Заголовок авторизации** укажите в поле **Значение** `Bearer <IAM_токен>`. Для этого получите [IAM-токен](../../iam/concepts/authorization/iam-token.md) для [созданного ранее](#create-sa) сервисного аккаунта, скопируйте его и вставьте в поле.

            {% note info %}

            [Время жизни](../../iam/concepts/authorization/iam-token.md#lifetime) IAM-токена — не больше {{ iam-token-lifetime }}, но рекомендуется запрашивать его чаще, например каждый час.
            
            Для автоматического перевыпуска IAM-токена можно использовать скрипт `export IAM_TOKEN=$(yc iam create-token)`.

            {% endnote %}

      1. Нажмите кнопку **Подключиться**.
      1. В открывшемся окне **Добавление инструментов** выберите все инструменты и нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

      1. В блоке **Параметры сервера**:

          1. В поле **{{ ui-key.yacloud.common.name }}** задайте имя создаваемого MCP-сервера. Требования к имени:
             
             * длина — от 3 до 63 символов;
             * может содержать строчные буквы латинского алфавита, цифры и дефисы;
             * первый символ — буква, последний — не дефис.
          1. (Опционально) Добавьте создаваемому серверу описание и метки, воспользовавшись соответствующими кнопками.
          1. В поле **Доступ** выберите **Приватный**.
          1. В поле **Сервисный аккаунт** выберите сервисный аккаунт, созданный ранее.
          1. (Опционально) Включите опцию **Запись логов** и задайте параметры логирования, чтобы вести журнал логов создаваемого MCP-сервера.
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

   [Время жизни](../../iam/concepts/authorization/iam-token.md#lifetime) IAM-токена — не больше {{ iam-token-lifetime }}, но рекомендуется запрашивать его чаще, например каждый час.
   
   Для автоматического перевыпуска IAM-токена можно использовать скрипт `export IAM_TOKEN=$(yc iam create-token)`.

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