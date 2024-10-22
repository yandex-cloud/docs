Чтобы в интерактивном режиме познакомиться с принципом формирования поискового запроса к API v1 сервиса {{ search-api-name }}, воспользуйтесь специальной формой тестирования запроса:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете работать с {{ search-api-name }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_search-api }}**.
  1. На панели слева выберите ![SquareChartColumn](../../_assets/console-icons/square-chart-column.svg) **{{ ui-key.yacloud.search-api.test-query.label_title }}**. 
  1. Выберите **{{ ui-key.yacloud.search-api.test-query.label_field-method }}** (поддерживаются методы [GET](../../search-api/concepts/get-request.md) и [POST](../../search-api/concepts/post-request.md)) и заполните поля формы.

      {% note info %}

      В тестовом запросе нельзя изменить **{{ ui-key.yacloud.search-api.test-query.label_field-query }}**. Запросы отправляются с IP-адреса Яндекса от имени сервиса.

      {% endnote %}

      По мере изменения значений в полях формы в поле **{{ ui-key.yacloud.search-api.test-query.label_section-url }}** будет формироваться URL поискового запроса, соответствующего заданным значениям. Если выбран метод запроса `POST`, в поле **{{ ui-key.yacloud.search-api.test-query.label_field-body }}** также будет формироваться соответствующее [тело запроса](../../search-api/concepts/post-request.md#post-request-body).

  1. Нажмите **{{ ui-key.yacloud.search-api.test-query.label_button-run-test }}**. [Результат](../../search-api/concepts/response.md) выполнения запроса появится ниже.
  1. При необходимости измените параметры, чтобы скорректировать результаты выдачи, и повторите отправку запроса.

{% endlist %}