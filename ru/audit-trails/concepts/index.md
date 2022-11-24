---
title: "{{ at-full-name }}. Обзор сервиса"
description: "{{ at-full-name }} позволяет собирать аудитные логи о происходящих с ресурсами {{ yandex-cloud }} событиях и выгружать эти логи для дальнейшего анализа или экспорта."
---

# Обзор сервиса {{ at-full-name }}

{{ at-full-name }} позволяет собирать аудитные логи ресурсов {{ yandex-cloud }} и загружать их в бакет {{ objstorage-name }}{% if product == "yandex-cloud" %} или в лог-группу {{ cloud-logging-name }}{% endif %}:

* [Загрузка аудитных логов в бакет](../operations/index.md#bucket).
{% if product == "yandex-cloud" %}
* [Загрузка аудитных логов в Cloud Logging](../operations/index.md#logging).
* [Загрузка аудитных логов в поток данных](../operations/index.md#data-streams).
{% endif %}

Сбор аудитных логов позволяет применять инструменты анализа и оперативного реагирования на события уровня сервисов {{ yandex-cloud }}:

* [Поиск по аудитным логам в бакете](../tutorials/search-bucket.md)
{% if product == "yandex-cloud" %}
* [Поиск по аудитным логам в лог-группе](../tutorials/search-cloud-logging.md)
{% endif %}
* [Загрузка аудитных логов в SIEM](./export-siem.md)
* [Настройка алертов в {{ monitoring-full-name }}](../tutorials/alerts-monitoring.md)

Сервисы {{ yandex-cloud }}, аудитные логи которых собирает {{ at-name }}:

* {{ alb-full-name }}
* {{ at-full-name }}
* {{ certificate-manager-full-name }}
* {{ dns-full-name }}
{% if product == "yandex-cloud" %}
* {{ cloud-logging-full-name }}
{% endif %}
* {{ compute-full-name }}
* {{ iam-full-name }}
* {{ kms-full-name }}
* {{ lockbox-full-name }}
* {{ mch-full-name }}
{% if product == "yandex-cloud" %}
* {{ mgl-full-name }}
* {{ mmg-full-name }}
{% endif %}
* {{ mmy-full-name }}
* {{ mpg-full-name }}
{% if product == "yandex-cloud" %}
* {{ mrd-full-name }}
{% endif %}
* {{ network-load-balancer-full-name }}
* {{ objstorage-full-name }}
* {{ org-full-name }}
* {{ resmgr-full-name }}
* {{ vpc-full-name }}
{% if product == "yandex-cloud" %}
* {{ ydb-full-name }}
{% endif %}

Логируются следующие события:

* Входы федеративных пользователей.
* Создание/удаление сервисных аккаунтов.
* Создание/удаление ключей сервисных аккаунтов.
* Изменение ролей пользователей и сервисных аккаунтов.
* Создание/удаление ресурсов.
* Изменение настроек ресурсов.
* Остановка/перезагрузка ресурса.
* Изменение политик доступа.
* Создание/изменение групп безопасности.
* Действия с ключами шифрования и секретами.

## Существующие ограничения сервиса {#known-restrictions}

В аудитный лог не попадают ошибки аутентификации. Например, если пользователь отправит к API запрос без IAM-токена, информации об этом не будет в аудитных логах.

Ошибки авторизации в аудитный лог попадают. Например, в логе будет сообщение об ошибке, если пользователь попытался создать ресурс, но у него не хватило разрешений.

Так же в сервисе действуют [квоты и лимиты](limits.md).
