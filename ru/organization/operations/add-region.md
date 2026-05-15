---
title: Как добавить управляемую организацию в {{ org-full-name }}
description: Из статьи вы узнаете, как привязать новый регион к организации в {{ org-full-name }}.
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

После этого будет создана [управляемая организация](../concepts/controlled-org.md), и вы сможете [создать](../../resource-manager/operations/cloud/create-in-another-region.md) облако в другом [регионе](../../overview/concepts/region.md).

{% note info %}

Вы сможете управлять ресурсами в другом регионе только после первичной синхронизации основной и управляемой организаций. Длительность синхронизации зависит от размера основной организации и может составлять несколько часов.

{% endnote %}
