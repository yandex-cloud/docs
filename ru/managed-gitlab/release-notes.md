---
title: История изменений в {{ mgl-full-name }}
description: В разделе представлена история изменений сервиса {{ mgl-name }}.
---

# История изменений в {{ mgl-full-name }}

## I квартал 2025 {#q1-2025}

### Новые возможности {#q1-2025-new-features}

* Добавлена возможность выпуска TLS-сертификатов Let's Encrypt через сервис [{{ certificate-manager-full-name }}](../certificate-manager/). Чтобы переключиться на выпуск сертификатов через {{ certificate-manager-name }}, обратитесь в [техническую поддержку]({{ link-console-support }}).
* Поддержана функциональность [{{ GL }} Pages](https://docs.gitlab.com/user/project/pages/) на стадии [Preview](../overview/concepts/launch-stages.md). 

### Исправления и улучшения {#q1-2025-problems-solved}

* Улучшена генерация основного файла конфигурации {{ GL }}, что уменьшает вероятность расхождения конфигураций.
* Улучшен механизм автоматического обновления инстансов {{ GL }}.

## Октябрь 2024 {#oct-2024}

Добавлена возможность мониторинга состояния инстанса {{ GL }} в консоли управления {{ yandex-cloud }}. Графики состояния можно посмотреть на вкладке **{{ ui-key.yacloud.common.monitoring }}** или в сервисе [{{ monitoring-full-name }}](../monitoring/concepts/index.md). Функциональность находится на стадии [Preview](../overview/concepts/launch-stages.md).

## Сентябрь 2024 {#sep-2024}

Добавлена возможность управлять агентами {{ GLR }} с помощью консоли управления {{ yandex-cloud }}. Функциональность находится на стадии [Preview](../overview/concepts/launch-stages.md). Чтобы получить к ней доступ, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

## Июль 2024 {#jul-2024}

1 июля 2024 года функциональность [правил ревью кода](concepts/approval-rules.md) перешла на стадию [General Availability](../overview/concepts/launch-stages.md), и за ее использование теперь взимается плата в соответствии с [правилами тарификации](pricing.md#prices-instance).


## Март 2024 {#mar-2024}

Для инстансов, находящихся в зоне доступности `ru-central1-c`, добавлена возможность [миграции в другую зону](operations/instance/zone-migration.md).


## Январь 2024 {#jan-2024}

* Добавлен провайдер аутентификации [Yandex ID](operations/omniauth.md#yandex-id).
* Добавлена услуга по [миграции инстанса](concepts/migration.md) из {{ GL }} в {{ mgl-name }}. Функциональность находится на стадии [Preview](../overview/concepts/launch-stages.md).