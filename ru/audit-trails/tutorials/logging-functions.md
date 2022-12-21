# Настройка реагирования в {{ cloud-logging-full-name }} и {{ sf-full-name }}

Вы можете использовать сервис [{{ sf-name }}](../../functions/) для настройки автоматического реагирования на события аудитного лога. Например, отправлять сообщения по удобным каналам оповещения или автоматически изменять настройки ресурсов {{ yandex-cloud }} в качестве компенсационных мер.

## Схема работы {#scheme}

В общем виде для настройки реагирования через {{ sf-name }} понадобятся следующие компоненты:

1. Трейл — загружает [аудитные логи в лог-группу](../operations/export-cloud-logging.md).
2. [Лог-группа](../../logging/concepts/log-group.md) — выступает промежуточным звеном между трейлом и триггером {{ sf-name }}.
3. [Триггер для {{ cloud-logging-full-name }}](../../functions/concepts/trigger/cloud-logging-trigger.md) — вызывает функцию при добавлении записи в лог-группу.
4. [Функция {{ sf-name }}](../../functions/concepts/function.md) — выполняет логику реагирования.  
5. Опциональный вспомогательный компонент, например, Telegram-бот или почтовый сервер.
 
## Пример реализации {#example}

В [Yc-solution-library-for-security](https://github.com/yandex-cloud/yc-solution-library-for-security) содержится пример [решения](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/trails-function-detector), которое использует {{ sf-name }} для оповещения о заданных событиях через Telegram-бота и компенсирующего воздействия на ресурсы {{ yandex-cloud }} через методы [API](../../glossary/rest-api.md).

Оповещение реализовано для следующих событий:
* Группы безопасности: разрешение входящего трафика на все внутренние адреса (0.0.0.0/0).
* {{ objstorage-name }}: включение публичного доступа к бакету.
* {{ lockbox-name }}: назначение прав на секрет. 

Компенсирующее воздействие на ресурсы {{ yandex-cloud }}:
* Группы безопасности: удаление правила.
* {{ lockbox-name }}: удаление назначенных прав на секрет.

{% include [Yc-solution-library-for-security](../../_includes/security-solution-library.md) %}

Решение содержит исходные коды Python-функции и скрипта {{ TF }}, который выполняет настройку всех компонентов {{ yandex-cloud }}, необходимых для выполнение процедуры.  

## Что дальше {#whats-next}

* Узнайте о [формате аудитных логов](../concepts/format.md).
* Узнайте о существующих решениях по [экспорту аудитных логов в SIEM](../concepts/export-siem.md).
