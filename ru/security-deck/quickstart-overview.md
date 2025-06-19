---
title: Начало работы с {{ sd-full-name }}
description: В данном разделе описано, как начать работу с сервисом {{ sd-name }} и использовать входящие в него инструменты.
---

# Начало работы с {{ sd-full-name }}

Сервис {{ sd-name }} предлагает инструменты для обеспечения безопасности данных и соответствия нормативным требованиям и отраслевым стандартам.

{% include [note-preview-by-request](../_includes/note-preview-by-request.md) %}

## Перед началом работы {#before-begin}

Чтобы начать работать c {{ sd-name }} в {{ yandex-cloud }}:

1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. В [сервисе {{ billing-name }}]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в [статусе](../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет [каталога](../resource-manager/concepts/resources-hierarchy.md#folder), [создайте его](../resource-manager/operations/folder/create.md).

В сервис {{ sd-name }} входят модули {{ atr-name }}, Контроль данных (Data Security Posture Management), Диагностика доступов (Cloud Infrastructure Entitlement Management) и Портал соответствия требованиям.

Чтобы подключить любой из модулей, перейдите в [интерфейс {{ sd-name }}]({{ link-sd-main }}) и нажмите кнопку **Подключить** рядом с описанием нужного модуля. После этого вы сможете подробнее ознакомиться с возможностями инструмента и условиями его использования.

## Настройка {{ sd-name }} {#configure-sd}

Собранные данные и ресурсы модулей {{ sd-full-name }} по умолчанию располагаются в выбранном каталоге. Чтобы начать работу с сервисом, из списка доступных вам каталогов выберите каталог, в котором будут храниться эти данные:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![sliders](../_assets/console-icons/sliders.svg) **Настройки {{ sd-name }}**.
  1. В блоке **Хранилище по умолчанию** выберите каталог, в котором по умолчанию будут сохраняться данные сервиса.

{% endlist %}

Чтобы начать работу, назначьте [роли](./security/index.md) для работы с {{ sd-name }}.

## {{ atr-name }} {#access-transparency}

[{{ atr-name }}]({{ link-sd-main }}transparency/) — это автоматизированный инструмент, предназначенный для просмотра аналитической информации о действиях, которые инженеры {{ yandex-cloud }} производили с ресурсами организации. Такие действия могли выполняться в ходе технического обслуживания, работы с [обращениями](../support/overview.md) или решения задач безопасности.

Этот инструмент позволяет обеспечить прозрачность работы и контроль над действиями инженеров {{ yandex-cloud }}: логи их работы автоматически анализирует специально обученная модель на базе {{ yagpt-name }} и при необходимости создает эскалацию для проверки сессии специалистом по информационной безопасности {{ yandex-cloud }}.

{% include [access-transparency-attach-ba-notice](../_includes/security-deck/access-transparency-attach-ba-notice.md) %}

Подробнее см. в разделе [{#T}](./concepts/access-transparency.md).

## Контроль данных ({{ dspm-name }}) {#dspm}

[Контроль данных или {{ dspm-name }}]({{ link-sd-main }}dspm/) (Data Security Posture Management) — это инструмент, помогающий оперативно обнаруживать чувствительную информацию, сохраненную в [бакетах](../storage/concepts/bucket.md) {{ objstorage-full-name }}, с тем чтобы своевременно принимать необходимые меры для ее защиты от несанкционированного доступа или утечки. Подробнее см. в разделе [{#T}](./concepts/dspm.md).

Чтобы начать работать с модулем {{ dspm-name }}, воспользуйтесь инструкциями по [созданию источника данных](./operations/dspm/create-data-source.md) и [созданию сканирования](./operations/dspm/create-scan.md) информации в бакете.

## Диагностика доступов ({{ ciem-name }}) {#ciem}

[Диагностика доступов]({{ link-sd-main }}iam-diagnostics/) {{ sd-name }} — это инструмент, позволяющий централизованно [просматривать](./operations/ciem/view-permissions.md) полный список доступов [субъектов](../iam/concepts/access-control/index.md#subject): [пользователей](../overview/roles-and-resources.md#users), [сервисных аккаунтов](../iam/concepts/users/service-accounts.md), [групп пользователей](../organization/concepts/groups.md), [системных групп](../iam/concepts/access-control/system-group.md) и [публичных групп](../iam/concepts/access-control/public-group.md) к [ресурсам](../iam/concepts/access-control/resources-with-access-control.md) организации. Этот инструмент также позволяет легко [отзывать](./operations/ciem/revoke-permissions.md) у субъектов лишние доступы. Подробнее см. в разделе [{#T}](./concepts/ciem.md).

Чтобы начать работать с модулем {{ ciem-name }}, воспользуйтесь инструкциями по [просмотру](./operations/ciem/view-permissions.md) и [отзыву](./operations/ciem/revoke-permissions.md) доступов.

## {{ ycdr-full-name }}

{{ ycdr-full-name }} ({{ ycdr-name }}) — это модуль для мониторинга и реагирования на инциденты в инфраструктуре {{ yandex-cloud }}. {{ ycdr-name }} разработан на базе собственного центра мониторинга безопасности (SOC) {{ yandex-cloud }}. За обнаружение угроз в сервисе будет отвечать команда специалистов по информационной безопасности. Для анализа используются SIEM-система собственной разработки, а также алгоритмы и инструменты анализа больших данных Security Data Lake.


## Портал соответствия требованиям {#compliance}

[Портал соответствия требованиям](https://yandex.cloud/ru/security/compliance-portal) {{ sd-name }} содержит все необходимые документы, отчеты, инструкции и дополнительные сведения о системе безопасности {{ yandex-cloud }}.

Здесь вы можете как скачать публичные документы, так и запросить документы, содержащие конфиденциальные данные и доступные по запросу.

Подробнее см. в разделе [{#T}](./concepts/compliance.md).


## Что дальше {#whats-next}

* Узнайте, [как сканировать данные в бакетах на наличие чувствительной информации](./operations/dspm/create-scan.md) в {{ sd-name }}.
* Узнайте, [как просмотреть список доступов субъекта](./operations/ciem/view-permissions.md) в {{ sd-name }}.
* Узнайте о [необходимых правах доступа](./security/index.md) для работы с {{ sd-name }}.