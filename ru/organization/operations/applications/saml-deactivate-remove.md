---
title: Как деактивировать или удалить SAML-приложение в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете деактивировать, повторно активировать и удалить SAML-приложение в {{ org-name }}.
---

# Деактивировать и удалить SAML-приложение в {{ org-full-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

## Деактивируйте приложение {#deactivate}

Если вам требуется временно отключить возможность аутентификации пользователей вашей [организации](../../concepts/organization.md) во внешнем приложении с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), деактивируйте соответствующее [SAML-приложение](../../concepts/applications.md#saml) в {{ org-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. В строке с SAML-приложением, которое вы хотите деактивировать, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pause](../../../_assets/console-icons/pause.svg) **{{ ui-key.yacloud_org.action.applications.components.action_deactivate }}**.
  1. В открывшемся окне подтвердите действие.

{% endlist %}

В результате SAML-приложение будет деактивировано и перейдет в статус `Suspended`, а пользователи потеряют возможность аутентификации с его помощью в соответствующем внешнем приложении.

## Активируйте приложение {#reactivate}

Если вам требуется восстановить возможность аутентификации пользователей вашей организации во внешнем приложении с помощью SAML-стандарта единого входа, активируйте соответствующее SAML-приложение в {{ org-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. В строке с SAML-приложением, которое вы хотите активировать, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![arrows-rotate-right](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud_org.action.applications.components.action_activate }}**.
  1. В открывшемся окне подтвердите действие.

{% endlist %}

В результате SAML-приложение будет активировано и перейдет в статус `Active`, а пользователи, добавленные в приложение, вновь получат возможность аутентификации с его помощью во внешнем приложении.

## Удалите приложение {#delete}

Чтобы удалить SAML-приложение:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. В строке с SAML-приложением, которое вы хотите удалить, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите действие.

{% endlist %}

В результате SAML-приложение будет удалено, а пользователи навсегда потеряют возможность аутентификации с его помощью во внешнем приложении.

#### См. также {#see-also}

* [{#T}](./saml-create.md)
* [{#T}](./saml-update.md)
* [{#T}](../add-account.md)
* [{#T}](../../concepts/applications.md)
* [{#T}](../manage-groups.md)