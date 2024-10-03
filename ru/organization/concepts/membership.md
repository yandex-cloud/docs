---
title: Членство в организации
description: Членство в организации позволяет получить доступ к сервисам внутри организации.
---

# Членство в организации

Члены [организации](../quickstart.md) — [пользователи](../../overview/roles-and-resources.md#users), которые состоят в организации и могут получать доступ к сервисам внутри организации:

* [сервисы {{ yandex-cloud }}]({{ link-cloud-services }});
* сервисы для совместной работы и бизнес-аналитики: [{{ tracker-full-name }}]({{ link-tracker }}), [{{ wiki-full-name }}]({{ link-wiki }}), [{{ forms-full-name }}]({{ link-forms-b2b }}), [{{ datalens-full-name }}]({{ link-datalens-main }}) и [{{ ml-platform-full-name }}]({{ link-datasphere-main }}).

Пользователи, не являющиеся членами организации, не могут получать доступ к ресурсам внутри организации. Исключение составляют ресурсы, доступ к которым выдан для [публичных групп](../../iam/concepts/access-control/public-group.md) `All users` и `All authenticated users`.

Членами организации могут быть:

* Пользователи, которые были приглашены в организацию и приняли такое приглашение.
* Пользователи [федерации удостоверений](./add-federation.md), которая создана внутри организации (автоматически являются членами организации).

Чтобы вступить в организацию, попросите [владельца](../security/index.md#organization-manager-organizations-owner) или [администратора](../security/index.md#organization-manager-admin) этой организации [добавить](../operations/add-account.md) вас. Вы также можете [создать](../operations/manage-organizations.md#create-additional-org) собственную организацию и стать ее владельцем.

Пользователь может быть владельцем или членом одновременно нескольких организаций. [Переключаться](../operations/manage-organizations.md#switch-to-another-org) между организациями можно в [консоли управления]({{ link-console-main }}).