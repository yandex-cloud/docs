---
title: Как добавить управляемую организацию в {{ org-full-name }}
description: Из статьи вы узнаете, как привязать новый регион к организации.
---

# Создать управляемую организацию

{% note info %}

{% include [kz-region-role](../../_includes/organization/kz-region-role.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. Под названием вашей организации в поле **{{ ui-key.yacloud_org.dashboard.organization.label_regions }}** нажмите на регион, который хотите подключить.
  1. Во всплывающем окне нажмите **{{ ui-key.yacloud_org.dashboard.organization.action_connect-new-region }}**.  
  1. Нажмите **{{ ui-key.yacloud_org.dashboard.organization.action_submit-new-region }}**.  
  1. Введите название и описание организации.  
  1. Нажмите кнопку **{{ ui-key.yacloud_components.organization.action.create }}**.

{% endlist %}

В результате будет создана [управляемая организация](../concepts/controlled-org.md), а к основной организации будет подключен новый [регион](../../overview/concepts/region.md).

Управляемая организация не отображается в списке организаций в консоли управления и в {{ cloud-center }}: переключиться на нее и управлять ею напрямую, как обычной организацией, нельзя. Чтобы начать работу с ресурсами в подключенном регионе, [создайте в этом регионе облако](../../resource-manager/operations/cloud/create-in-another-region.md). Далее работайте с этим облаком в консоли управления нового региона так же, как с облаками основной организации.

{% note info %}

Вы сможете управлять ресурсами в другом регионе только после первичной синхронизации основной и управляемой организаций. Длительность синхронизации зависит от размера основной организации и может составлять несколько часов.

{% endnote %}
