Информация о статусе подключения ВМ к {{ backup-name }} отображается в [консоли управления]({{ link-console-main }}) в сервисе **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** на странице со списком ВМ. Доступны следующие статусы:

* `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-ok }}` — сервис {{ backup-name }} подключен к ВМ, резервные копии создаются в рамках указанных политик, агент {{ backup-name }} онлайн.
* `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-no-applications }}` — сервис подключен, но не привязана ни одна политика, резервные копии не создаются.
* `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-failed }}` — агент не онлайн или произошла ошибка регистрации агента.
* `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-not-connected }}` — сервис не подключен к ВМ.

Вы можете [посмотреть](../../backup/operations/get-connection-status.md) статус подключения ВМ и [узнать](../../backup/operations/get-journal.md) подробности о резервном копировании ВМ в журнале резервирования.