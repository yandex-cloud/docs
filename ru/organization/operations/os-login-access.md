---
title: "Как включить доступ через OS Login в организации"
description: "Следуя данной инструкции, вы сможете включить в организации доступ к виртуальным машинам через OS Login."
---

# Включить доступ через OS Login

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

Чтобы создавать виртуальные машины с доступом через [OS Login](../concepts/os-login.md), разрешите такую возможность на уровне организации. После этого вы сможете [включить](../../compute/operations/vm-control/vm-update.md#enable-oslogin-access) доступ через OS Login на ВМ, созданных из подготовленного образа с поддержкой OS Login, или [настроить](../../compute/operations/vm-connect/enable-os-login.md) агента OS Login на уже работающей ВМ самостоятельно. Подробнее про подключение через OS Login см. в разделе [{#T}](../../compute/operations/vm-connect/os-login.md).

{% note info %}

Образы с поддержкой OS Login доступны в [{{ marketplace-full-name }}](/marketplace) и содержат `OS Login` в названии.

{% endnote %}

Чтобы включить доступ через OS Login на уровне организации:

{% list tabs group=instructions %}

- Интерфейс {{ org-name }} {#cloud-org}

  1. [Войдите в аккаунт]({{ link-passport-login }}) администратора или владельца организации.
  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
  1. При необходимости [переключитесь](./manage-organizations.md#switch-to-another-org) на нужную организацию или федерацию.
  1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.oslogin.title }}**.
  1. Включите опцию **{{ ui-key.yacloud_org.form.oslogin-settings.title_ssh-certificate-settings }}**.

{% endlist %}
