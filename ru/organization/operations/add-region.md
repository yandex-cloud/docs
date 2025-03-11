---
title: Как добавить управляемую организацию в {{ org-full-name }}
description: Из статьи вы узнаете, как привязать новый регион к организации.
---

# Подключить управляемую организацию

{% include [note-preview-by-request](../../_includes/note-preview-by-request.md) %}

1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

1. Во всплывающем окне нажмите **{{ ui-key.yacloud_org.dashboard.organization.action_connect-new-region }}**.

1. Нажмите **{{ ui-key.yacloud_org.dashboard.organization.action_submit-new-region }}**.

1. Введите название и описание организации.

1. Нажмите кнопку **{{ ui-key.yacloud_components.organization.action.create }}**.

После этого будет создана [управляемая организация](../concepts/controlled-org.md), и вы сможете [создать](../../resource-manager/operations/cloud/create-in-another-region.md) облако в другом [регионе](../../overview/concepts/region.md).
