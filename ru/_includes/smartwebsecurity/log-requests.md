1. В [консоли управления]({{ link-console-main }}) выберите каталог с профилем безопасности.
1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
1. На панели слева выберите ![receipt](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.common.logs }}**.

   В запросе уже заданы метки `project` для текущего каталога и `service = __smartwebsecurity__`.

1. В поле **Профиль безопасности** выберите нужный профиль. По умолчанию отображаются логи всех профилей каталога.
1. Задайте период поиска логов.
1. При необходимости добавьте условия фильтрации в строке запроса.

   Для ввода запроса в текстовом режиме нажмите ![code](../../_assets/console-icons/code.svg) и используйте [язык запросов {{ monium-name }}](../../monium/logs/query.md). Сохраните метки `project`, `service` и фильтр выбранного профиля безопасности.

1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**. Чтобы посмотреть содержимое записи, разверните ее.

Подробнее о работе с логами — в разделе [«Поиск и анализ логов»](../../monium/logs/logs-explorer.md).
