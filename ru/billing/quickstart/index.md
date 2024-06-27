---
title: "Регистрация аккаунта в облаке"
description: "Чтобы пользоваться сервисами облака {{ yandex-cloud }}, зарегистрируйте и создайте платежный аккаунт. Аккаунт необходим, даже если вы планируете пользоваться только бесплатными сервисами."
keywords:
  - как зарегистрироваться в облаке
  - "как зарегистрироваться в облаке {{ yandex-cloud }}"
  - регистрация в облаке
  - создание аккаунта в облаке
---

# Регистрация аккаунта в {{ yandex-cloud }}

Для работы с большинством сервисов {{ yandex-cloud }} требуется платежный аккаунт. В аккаунте хранятся сведения о плательщике и реквизиты для оплаты. {{ yandex-cloud }} списывает деньги с карты и выставляет счета, только если вы используете [платную версию](../operations/activate-commercial.md). Несмотря на то, что для работы с некоторыми сервисами, например, {{ tracker-name }} или {{ datalens-short-name }} необязательно заводить платежный аккаунт, если вы создадите его, то получите [стартовый грант](../concepts/bonus-account.md#start), который сможете использовать для оплаты ресурсов.

В рамках одного пользовательского аккаунта все плательщики должны заключить договор с одним и тем же юридическим лицом и осуществлять оплату в одной и той же валюте.

Для новых клиентов, являющихся юридическими лицами, доступен пробный период. [Пробный период](../concepts/trial-period.md) позволяет бесплатно исследовать возможности облачной инфраструктуры с некоторыми ограничениями. Чтобы продолжить пользоваться ресурсами в полном объеме, после завершения пробного периода необходимо перейти на платную версию.

{% include [individual-nonresident](../../_includes/billing/individual-nonresidents.md) %}

{% list tabs group=customers %}

- Физические лица {#individuals}

   {% include [start-for-individuals](../../_includes/billing/billing-account-create-individual.md) %}

- Юридические лица, ИП или нерезидент Российской Федерации и Республики Казахстан {#businesses-entrepreneurs}

   {% include [start-for-legal-entities](../../_includes/billing/billing-account-create-legal-entities.md) %}

{% endlist %}

{% include [account-resources-note](../_includes/account-resources-note.md) %}

{% include [account-roles](../_includes/account-roles.md) %}

### Узнайте больше

- [Платежный аккаунт](../concepts/billing-account.md)
- [Пробный период](../../getting-started/free-trial/concepts/quickstart.md)

### Начните знакомство с {{ yandex-cloud }} {#start}

{% include [quickstart-all-no-billing](../../_includes/quickstart-all-no-billing.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
