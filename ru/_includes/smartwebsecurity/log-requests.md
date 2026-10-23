1. В [консоли управления]({{ link-console-main }}) выберите каталог с профилем безопасности.
1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
1. На панели слева выберите ![receipt](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.common.logs }}**.
1. Задайте период поиска логов.
1. В строке запроса выберите поля для фильтрации. Чтобы найти логи конкретного профиля, добавьте условие `security_profile_id = "<идентификатор_профиля>"`.

   Для ввода запроса в текстовом режиме нажмите ![code](../../_assets/console-icons/code.svg) и используйте [язык запросов {{ monium-name }}](../../monium/logs/query.md). Сохраните метки `project`, `cluster` и `service`, выбранные по умолчанию.

1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**. Чтобы посмотреть содержимое записи, разверните ее.
