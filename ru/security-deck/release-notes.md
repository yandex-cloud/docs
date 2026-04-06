---
title: История изменений в {{ sd-full-name }}
description: В разделе представлена история изменений сервиса {{ sd-name }}.
---

# История изменений в {{ sd-full-name }}

## Февраль 2026 {#february-2026}

* Модули [{{ dspm-name }}](./concepts/dspm.md), [{{ cspm-name }}](./concepts/cspm.md), [{{ kspm-name }}](./concepts/kspm.md) и [AI-ассистент](concepts/ai-assistant.md) стали доступны на стадии [Preview](../overview/concepts/launch-stages.md).
* С 2 февраля 2025 года использование модуля [{{ kspm-name }}](./concepts/kspm.md) тарифицируется в соответствии с [правилами тарификации](pricing.md#kspm-rules).
* В модуле [{{ cspm-name }}](./concepts/cspm.md) поддержаны новые [стандарты безопасности](./concepts/cspm.md#standards) — PCI DSS (Payment Card Industry Data Security Standard) и Требования ФСТЭК (Приказ № 21) для защиты персональных данных. 
* В модуле [{{ cspm-name }}](./concepts/cspm.md) реализованы новые правила соответствия всем поддержанным в модуле стандартам безопасности.

## Январь 2026 {#january-2026}

* В модуле [{{ dspm-name }}](./concepts/dspm.md) появилась механика подписок c фиксированной стоимостью. Подписку можно оформить вместо оплаты фактического потребления ресурсов. Стоимость подписки будет опубликована позднее в разделе [Правила тарификации](pricing.md).
* Реализован [API](./api-ref/Alert/index.md) для работы с алертами.

## IV квартал 2025 {#q4-2025}

* Добавлена поддержка дисков [{{ yandex-360 }}](https://360.yandex.ru/) как [источника сканирования](./operations/dspm/create-scan.md#yandex-360) в {{ dspm-name }}.
* Сканирование изображений в модуле [{{ dspm-name }}](./concepts/dspm.md) теперь тарифицируется в соответствии с [правилами тарификации](pricing.md#dspm-rules).
* Добавлен [интерфейс проверки соответствия требованиям](./concepts/standard-compliance/index.md).

## III квартал 2025 {#q3-2025}

* Запущены модули [{{ kspm-name }}](./concepts/kspm.md) и [{{ cspm-name }}](./concepts/cspm.md).
* Модули {{ kspm-name }} и {{ cspm-name }} теперь доступны в качестве источников данных для [алертов](./concepts/alerts.md).
* Добавлена возможность [создать окружение {{ sd-name }}](./operations/workspaces/index.md) — контейнер, который содержит настройки и ресурсы модулей, перечень контролируемых ресурсов, параметры контроля и другие настройки.
* Добавлен [AI-ассистент](concepts/ai-assistant.md).
* Для модуля [{{ dspm-name }}](./concepts/dspm.md) появились возможности [частичного сканирования](./operations/dspm/create-scan.md) и [сканирования по изображениям](./operations/dspm/create-scan.md).
