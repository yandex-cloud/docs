# Настройка реагирования в Yandex Cloud Logging и Yandex Cloud Functions


Вы можете использовать сервис [Cloud Functions](../../../functions/index.md) для настройки автоматического реагирования на события аудитного лога. Например, отправлять сообщения по удобным каналам оповещения или автоматически изменять настройки ресурсов Yandex Cloud в качестве компенсационных мер.

## Схема работы {#scheme}

В общем виде для настройки реагирования через Cloud Functions понадобятся следующие компоненты:

1. Трейл — [загружает аудитные логи в лог-группу](../../../audit-trails/operations/create-trail.md).
2. [Лог-группа](../../../logging/concepts/log-group.md) — выступает промежуточным звеном между трейлом и триггером Cloud Functions.
3. [Триггер для Yandex Cloud Logging](../../../functions/concepts/trigger/cloud-logging-trigger.md) — вызывает функцию при добавлении записи в лог-группу.
4. [Функция Cloud Functions](../../../functions/concepts/function.md) — выполняет логику реагирования.
5. Опциональный вспомогательный компонент, например, Telegram-бот или почтовый сервер.
 
## Пример реализации {#example}

В [Yc-security-solutions-library](https://github.com/yandex-cloud-examples/yc-security-solutions-library) содержится пример [решения](https://github.com/yandex-cloud-examples/yc-audit-trails-automatic-response), которое использует Cloud Functions для оповещения о заданных событиях через Telegram-бота и компенсирующего воздействия на ресурсы Yandex Cloud через методы [API](../../../glossary/rest-api.md).

Оповещение реализовано для следующих событий:

* Группы безопасности: разрешение входящего трафика на все внутренние адреса (`0.0.0.0/0`).
* Object Storage: включение публичного доступа к бакету.
* Yandex Lockbox: назначение прав на секрет. 

Компенсирующее воздействие на ресурсы Yandex Cloud:

* Группы безопасности: удаление правила.
* Yandex Lockbox: удаление назначенных прав на секрет.

{% note info %}

[Yandex Cloud Security Solution Library](https://github.com/yandex-cloud-examples/yc-security-solutions-library) — это набор примеров и рекомендаций по построению безопасной инфраструктуры в Yandex Cloud, собранных в публичном репозитории на GitHub.

{% endnote %}

Решение содержит исходные коды Python-функции и скрипта Terraform, который выполняет настройку всех компонентов Yandex Cloud, необходимых для выполнение процедуры.

## Что дальше {#whats-next}

* Узнайте о [формате аудитных логов](../../../audit-trails/concepts/format.md).
* Узнайте о существующих решениях по [экспорту аудитных логов в SIEM](../../../audit-trails/concepts/export-siem.md).