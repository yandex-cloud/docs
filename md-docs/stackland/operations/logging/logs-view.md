[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Логирование > Посмотреть логи

# Посмотреть логи

Чтобы посмотреть логи кластера:

1. Откройте Grafana по адресу `https://grafana.sys.<домен кластера>` и войдите с помощью **Stackland Auth**.
1. Откройте раздел **Explore**.
1. Выберите источник данных:
   * `stackland-logs` — логи платформенных компонентов из пространств имен `stackland-*`;
   * `audit-logs` — аудитные логи Kubernetes API.

   Если одновременно включены режимы `singleBinary` и `simpleScalable`, для просмотра истории из `singleBinary` выберите `stackland-logs-legacy` или `audit-logs-legacy` соответственно.
1. Введите запрос LogQL и нажмите кнопку **Run query**.

Для просмотра системных логов также можно открыть приложение **Logs** в Grafana. Оно использует источник данных `stackland-logs` и позволяет фильтровать записи по уровню, контейнеру, пространству имен и другим меткам.

По умолчанию доступ ко всем источникам логов есть только у участников группы `stackland-cluster-admins`. Администратор может изменить список разрешенных групп в `spec.settings.logStorage.loki.tenantProxy.adminGroups` ресурса `LoggingConfig`.