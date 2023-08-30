1. В рабочем каталоге откройте сервис {{ search-api }}.
1. Перейдите на вкладку **{{ ui-key.yacloud.search-api.test-query.label_title }}**. 
1. Выберите **{{ ui-key.yacloud.search-api.test-query.label_field-method }}** (поддерживаются методы [GET](../../search-api/concepts/get-request.md) и [POST](../../search-api/concepts/post-request.md)) и заполните поля формы.

   {% note info %}

   В тестовом запросе нельзя изменить **{{ ui-key.yacloud.search-api.test-query.label_field-query }}**. Запросы отправляются с IP-адреса Яндекса от имени сервиса.

   {% endnote %}
1. Нажмите **{{ ui-key.yacloud.search-api.test-query.label_button-run-test }}**. Результат выполнения запроса появится ниже.
1. При необходимости измените параметры, чтобы скорректировать результаты выдачи, и повторите отправку запроса. 