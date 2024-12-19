---
title: Как добавить управляемую организацию в {{ org-full-name }}
description: Из статьи вы узнаете, как привязать новый регион к организации.
---

# Подключить управляемую организацию

{% include [note-preview-by-request](../../_includes/note-preview-by-request.md) %}

1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

1. Во всплывающем окне нажмите **{{ ui-key.yacloud_org.entity.organization.other-regions_attach-region_action }}**.

1. Нажмите **{{ ui-key.yacloud_org.entity.organization.other-regions_confirm-dialog_submit }}**.

1. Введите название и описание организации.

1. Нажмите кнопку **{{ ui-key.yacloud_org.form.organization.select.action.create }}**.

После этого будет создана [управляемая организация](../concepts/controlled-org.md), и вы сможете [создать](../../resource-manager/operations/cloud/create-in-another-region.md) облако в другом [регионе](../../overview/concepts/region.md).
