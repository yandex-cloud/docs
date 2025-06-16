---
title: Как скрыть информацию о членах организации {{ org-full-name }}
description: Следуя данной инструкции, вы узнаете, как запретить пользователям организации просматривать информацию о других членах этой организации.
---

# Запретить пользователям просматривать информацию о членах организации

По умолчанию все пользователи организации {{ org-name }} могут просматривать информацию о всех остальных пользователях этой же организации. Вы можете ограничить эту возможность, разрешив просмотр информации только отдельным пользователям. Ограничение видимости пользователей будет работать только внутри {{ yandex-cloud }}. Во внешних сервисах это ограничение действовать не будет.

Прежде чем запрещать доступ к информации о членах организации, [выдайте](./add-role.md) такой доступ тем пользователям, которым он необходим.

{% cut "Роли, позволяющие пользователю просматривать информацию о членах организации:" %}

* `auditor`
* `viewer`
* `editor`
* `admin`
* `organization-manager.users.viewer`
* `organization-manager.groups.memberAdmin`
* `organization-manager.federations.userAdmin`
* `organization-manager.viewer`
* `organization-manager.admin`
* `organization-manager.organizations.owner`

{% endcut %}

{% note alert %}

В целях безопасности при назначении пользователям ролей руководствуйтесь [принципом минимальных привилегий](../../security/domains/iam-checklist.md#resources-and-roles): назначайте роли с минимальным набором разрешений, позволяющим выполнять только необходимые операции.

{% endnote %}


Чтобы запретить пользователям просматривать информацию о других членах организации:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.

      При необходимости [переключитесь](./manage-organizations.md#switch-to-another-org) на нужную организацию или федерацию.

  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud_org.layout.organization }}**.

  1. На панели слева выберите ![shield](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.oslogin.title }}**.

  1. В блоке **{{ ui-key.yacloud_org.form.oslogin-settings.title_users-list-visibility }}** включите опцию **{{ ui-key.yacloud_org.form.oslogin-settings.title_hide-users-list }}**.

      Чтобы вернуть пользователям возможность просматривать информацию о других пользователях этой организации, отключите эту опцию.

{% endlist %}
