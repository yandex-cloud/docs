---
title: {{ at-full-name }}. Обзор сервиса
description: '{{ at-full-name }} позволяет собирать аудитные логи о происходящих с ресурсами {{ yandex-cloud }} событиях и выгружать эти логи для дальнейшего анализа или экспорта.'
---

# Обзор сервиса {{ at-full-name }}

{{ at-full-name }} позволяет собирать аудитные логи ресурсов {{ yandex-cloud }} и загружать их в бакет {{ objstorage-name }}{% if product == "yandex-cloud" %} или в лог-группу {{ cloud-logging-name }}{% endif %}:

* [Загрузка аудитных логов в бакет](../operations/export-bucket.md).
{% if product == "yandex-cloud" %}
* [Загрузка аудитных логов в Cloud Logging](../operations/export-cloud-logging.md).
* [Загрузка аудитных логов в поток данных](../operations/export-data-streams.md)
{% endif %}

Сбор аудитных логов позволяет применять инструменты анализа и оперативного реагирования на события уровня сервисов {{ yandex-cloud }}:

* [Поиск по аудитным логам в бакете](../tutorials/search-bucket.md)
{% if product == "yandex-cloud" %}
* [Поиск по аудитным логам в лог-группе](../tutorials/search-cloud-logging.md)
{% endif %}
* [Загрузка аудитных логов в SIEM](./export-siem.md)
* [Настройка алертов в {{ monitoring-full-name }}](../tutorials/alerts-monitoring.md)

Сервисы {{ yandex-cloud }}, аудитные логи которых собирает {{ at-name }}:

* {{ at-full-name }}
* {{ certificate-manager-full-name }}
{% if product == "yandex-cloud" %}
* {{ cloud-logging-full-name }}
{% endif %}
* {{ compute-full-name }}
* {{ iam-full-name }}
* {{ kms-full-name }}
* {{ lockbox-full-name }}
* {{ mch-full-name }}
{% if product == "yandex-cloud" %}
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

Подробнее об ограничениях сервиса читайте в разделе [Квоты и лимиты](limits.md).
