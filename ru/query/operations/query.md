# Управление запросами

[Запросы](../concepts/glossary.md#query) содержат набор операторов YQL для обработки данных, а также параметры подключения к ним.

## Создать запрос {#create}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать запрос.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.queries.tab-text }}**.
1. На панели сверху нажмите кнопку **{{ ui-key.yql.yq-ide-header.new-analytics-query.button-text }}** или **{{ ui-key.yql.yq-ide-header.new-streaming-query.button-text }}**.
1. Поле ввода введите текст запроса.

## Проверить запрос {#parse}

Чтобы проверить текст запроса без его исполнения, нажмите кнопку **Валидировать**.

## Выполнить запрос {#run}

{% list tabs %}

- Аналитический запрос

  Аналитические запросы поддерживают только сценарий запуска запросов на исполнение. Чтобы запустить запрос, введите текст запроса и нажмите кнопку ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.

- Потоковый запрос

  Потоковые запросы поддерживают сценарий запуска нового или продолжение выполнения текущего запроса:

  * Чтобы запустить новый запрос, нажмите кнопку ![run](../../_assets/console-icons/play-fill.svg) **Выполнить начиная с текущих**.
  * Чтобы продолжить выполнять потоковый запрос с последней [контрольной точки](../concepts/glossary.md#checkpoint), нажмите кнопку ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.continue-query.button-text }}**. Если нужно продолжить выполнять запрос после смены источника данных, нажмите кнопку ![option](../../_assets/console-icons/chevron-down.svg) и выберите **{{ ui-key.yql.yq-query-actions.continue-force-query.button-text }}**.

  {% note info %}

  Потоковые запросы выполняются к потокам данных, которые не ограничены. В отличие от аналитического запроса, потоковый запрос может выполняться бесконечно.

  {% endnote %}

{% endlist %}

## Остановить запрос {#stop}

Чтобы остановить запрос:

{% list tabs %}

- Аналитический запрос

  Нажмите кнопку ![stop](../../_assets/console-icons/stop-fill.svg) **{{ ui-key.yql.yq-job-query-actions.stop-query.button-text }}**.

- Потоковый запрос

  * Нажмите кнопку ![stop](../../_assets/console-icons/stop-fill.svg) **{{ ui-key.yql.yq-job-query-actions.stop-query.button-text }}**, чтобы создать [контрольную точку](../concepts/glossary.md#checkpoint) и остановить запрос.
  * Нажмите кнопку ![stop](../../_assets/console-icons/stop-fill.svg) **{{ ui-key.yql.yq-job-query-actions.force-stop-query.button-text }}**, чтобы остановить запрос без создания контрольной точки.

{% endlist %}

## Посмотреть информацию о выполнении запроса {#view-result}

Информация о выполнении запроса доступна на следующих вкладках:

* **{{ ui-key.yql.yq-query-results.result.tab-text }}** - результат выполнения запроса в виде таблицы или схемы. Просмотр результатов доступен только для последнего исполнения запроса в течение 24 часов.
* **{{ ui-key.yql.yq-query-results.issues.tab-text }}** — информация об ошибках, которые возникли при выполнении запроса.
* **{{ ui-key.yql.yq-query-results.plan.tab-text }}** — информация об [этапах выполнения запроса](../concepts/request-processing.md).
* **{{ ui-key.yql.yq-query-results.statistics.tab-text }}** — метрики выполнения запроса со следующими данными:
  * входящие потоки данных;
  * используемые для выполнения запроса мощности;
  * объем использованной памяти;
  * объем выходных данных.
* **{{ ui-key.yql.yq-query-results.meta.tab-text }}** — метаданные запроса:
  * идентификатор запроса;
  * статус выполнения запроса;
  * дата создания, изменения, последнего выполнения запроса.

## Посмотреть историю запусков запроса {#log}

{{yq-full-name}} сохраняет [историю запусков](../concepts/glossary.md#jobs) для каждого запроса.

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно посмотреть историю выполнения запроса.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.queries.tab-text }}**.
1. Выберите запрос и на панели сверху нажмите кнопку ![pencil](../../_assets/console-icons/rocket.svg) **{{ ui-key.yql.yq-show-query-launches.show-launches.button-text }}**.

## Переименовать запрос {#update-query-name}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно переименовать запрос.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.queries.tab-text }}**.
1. Выберите запрос и на панели нажмите кнопку ![pencil](../../_assets/console-icons/pencil.svg) рядом с именем запроса.
1. Введите новое имя запроса и нажмите кнопку ![check](../../_assets/console-icons/check.svg).

## Изменить запрос {#update}

Чтобы изменить запрос, введите новый текст запроса и нажмите кнопку **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**. Если запрос уже запущен, [остановите](#stop) его для изменения текста запроса.

## Клонировать запрос {#clone}

Для удобства разработки можно клонировать запросы с сохранением текста:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно клонировать запрос.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.queries.tab-text }}**.
1. Выберите запрос и нажмите кнопку **{{ ui-key.yql.yq-query-actions.clone.link-text }}**. Чтобы клонировать запрос с другим типом, нажмите кнопку ![option](../../_assets/console-icons/chevron-down.svg) и выберите **Клонировать как…**.

## Удалить запрос {#delete}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно удалить запрос.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.queries.tab-text }}**.
1. Нажмите кнопку ![delete](../../_assets/console-icons/trash-bin.svg) напротив имени запроса, который вы хотите удалить.
1. Подтвердите удаление запроса.
