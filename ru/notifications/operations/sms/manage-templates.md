---
title: Управлять шаблонами SMS в {{ cns-full-name }}
description: Следуя этой инструкции, вы сможете создавать и удалять шаблоны SMS-уведомлений в {{ cns-full-name }}.
---

# Управлять шаблонами SMS

{% include [sms-template-creation-intro](../../../_includes/notifications/sms-template-creation-intro.md) %}

## Создать шаблон SMS {#create}

{% include [sms-template-create](../../../_includes/notifications/sms-template-create.md) %}

## Удалить шаблон {#delete}

Прежде чем удалять действующий шаблон SMS на стороне {{ cns-name }}, необходимо [дерегистрировать](#deregister) этот шаблон на стороне операторов связи. Удалять можно только шаблоны в [статусе](../../concepts/sms.md#template-status) `Deregistered`.

### Дерегистрировать шаблон {#deregister}

Чтобы дерегистрировать шаблон SMS в статусе `Active`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится шаблон.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. На панели слева выберите ![route](../../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.cns.label_channels }}** и выберите канал с [индивидуальным отправителем](../../concepts/sms.md#individual-sender), в котором вы хотите удалить шаблон.
  1. В меню слева выберите ![square-chart-bar](../../../_assets/console-icons/square-chart-bar.svg) **{{ ui-key.yacloud.cns.local.label_templates_26VqM }}**.
  1. В строке с нужным шаблоном нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите **Дерегистрировать**.
  1. В открывшемся окне подтвердите дерегистрацию.

{% endlist %}

В результате шаблон SMS перейдет в [статус](../../concepts/sms.md#template-status) `Deregistering` и будет отправлен на дерегистрацию у операторов связи. При этом будет создано обращение в [службу поддержки]({{ link-console-support }}). По завершении дерегистрации шаблона всеми операторами связи шаблон перейдет в статус `Deregistered`, и вы сможете удалить его из {{ cns-name }}.

### Удалить дерегистрированный шаблон {#delete-deregistered}

Чтобы удалить шаблон SMS в статусе `Deregistered`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится шаблон.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. На панели слева выберите ![route](../../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.cns.label_channels }}** и выберите канал с [индивидуальным отправителем](../../concepts/sms.md#individual-sender), в котором вы хотите удалить шаблон.
  1. В меню слева выберите ![square-chart-bar](../../../_assets/console-icons/square-chart-bar.svg) **{{ ui-key.yacloud.cns.local.label_templates_26VqM }}**.
  1. В строке с нужным шаблоном нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите удаление.

{% endlist %}

{% include [sms-template-delete-registering](../../../_includes/notifications/sms-template-delete-registering.md) %}

#### См. также {#see-also}

* [{#T}](../../concepts/sms.md#templates)