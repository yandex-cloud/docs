---
title: Как покинуть организацию в {{ org-full-name }}
description: Следуя данной инструкции, вы узнаете, как можно покинуть организацию.
---

# Покинуть организацию

Если вы не федеративный пользователь, вы можете самостоятельно покинуть организацию. Для этого:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Если вы состоите в нескольких организациях, [выберите](./manage-organizations.md#switch-to-another-org) нужную.

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. На панели слева выберите ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.

  1. Выберите пользователя из списка или воспользуйтесь строкой поиска или фильтром вверху страницы.

  1. В строке с нужным пользователем нажмите значок ![icon-context-menu](../../_assets/console-icons/ellipsis.svg) и выберите ![PersonXmark](../../_assets/console-icons/person-xmark.svg) **{{ ui-key.yacloud_org.entity.user.action.remove }}**.

  1. В открывшемся окне подтвердите исключение из организации.

{% endlist %}

Обратите внимание, вы потеряете доступ ко всем облакам и другим ресурсам, принадлежащим организации. Чтобы этого избежать, вы можете [перенести](../../resource-manager/operations/cloud/change-organization.md) облако в другую организацию. Для этого у вас должна быть [роль](../../resource-manager/security/index.md#resource-manager-clouds-owner) `{{ roles-cloud-owner }}` на переносимое облако и [роль](../security/index.md#organization-manager-organizations-owner) `{{ roles-organization-owner }}` на организацию, в которую вы это облако собираетесь перенести.

Чтобы закрыть доступ к облакам организации, которую вы не собираетесь покидать, обратитесь к администратору соответствующего облака.

Если у вас возникли проблемы с исключением пользователя из организации, обратитесь в [техническую поддержку]({{ link-console-support }}).