---
title: История изменений в {{ sd-full-name }}
description: В разделе представлена история изменений сервиса {{ sd-name }}.
---

# История изменений в {{ sd-full-name }}

## Март 2026 {#march-2026}
* Запущен [модуль управления уязвимостями (VM)](./concepts/vulnerability-management.md). Модуль находится на стадии [Preview](../overview/concepts/launch-stages.md) и доступен только по запросу.
* В модуле [DSPM](./concepts/dspm.md) появилась возможность предварительного [анализа данных](./concepts/dspm.md#discovery-mode), хранящихся в бакетах {{ objstorage-name }} в пределах окружения.
* Алерты теперь можно [группировать](./operations/alerts/view.md#search) по типу и фильтровать по новым атрибутам.
* В модуле [KSPM](./concepts/kspm.md) в [исключениях](./operations/kspm/manage-exceptions.md) теперь можно указать объекты через поиск по пространству имен.
* В модуле [CSPM](./concepts/cspm.md) появились новые правила проверки инфраструктуры на соответствие стандартам безопасности. Новые правила регламентируют [назначение](./rules-reference/cspm.md#check-privileged-roles) привилегированных ролей, [защиту](./rules-reference/cspm.md#appsec-ddos-protection-l3) от DDoS-атак на сетевом уровне, [доступ](./rules-reference/cspm.md#access) сервисных аккаунтов к кластерам {{ k8s }}® и избыточные роли сервисных аккаунтов на уровне [организации](./rules-reference/cspm.md#sa-privileges-org-roles) и [сервиса](./rules-reference/cspm.md#sa-privileges-service-roles). 

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
