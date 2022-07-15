---
title: {{ at-full-name }}. Обзор сервиса
description: '{{ at-full-name }} позволяет собирать аудитные логи о происходящих с ресурсами {{ yandex-cloud }} событиях и выгружать эти логи для дальнейшего анализа или экспорта.'
---

# Обзор сервиса {{ at-full-name }}

{{ at-full-name }} позволяет собирать аудитные логи ресурсов {{ yandex-cloud }} и загружать их в бакет {{ objstorage-name }} или в лог-группу {{ cloud-logging-name }}:

* [Загрузка аудитных логов в бакет](../operations/index.md#bucket).
* [Загрузка аудитных логов в Cloud Logging](../operations/index.md#logging).
* [Загрузка аудитных логов в поток данных](../operations/index.md#data-streams).

Сбор аудитных логов позволяет применять инструменты анализа и оперативного реагирования на события уровня сервисов {{ yandex-cloud }}:

* [Поиск по аудитным логам в бакете](../tutorials/search-bucket.md)
* [Поиск по аудитным логам в лог-группе](../tutorials/search-cloud-logging.md)
* [Загрузка аудитных логов в SIEM](./export-siem.md)
* [Настройка алертов в {{ monitoring-full-name }}](../tutorials/alerts-monitoring.md)

Сервисы {{ yandex-cloud }}, аудитные логи которых собирает {{ at-name }}:

* {{ at-full-name }}
* {{ certificate-manager-full-name }}
* {{ cloud-logging-full-name }}
* {{ compute-full-name }}
* {{ iam-full-name }}
* {{ kms-full-name }}
* {{ lockbox-full-name }}
* {{ mch-full-name }}
* {{ mmg-full-name }}
* {{ mmy-full-name }}
* {{ mpg-full-name }}
* {{ mrd-full-name }}
* {{ network-load-balancer-full-name }}
* {{ objstorage-full-name }}
* {{ org-full-name }}
* {{ resmgr-full-name }}
* {{ vpc-full-name }}
* {{ ydb-full-name }}

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
