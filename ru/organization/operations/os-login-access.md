# Включить доступ через OS Login

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

Чтобы создавать виртуальные машины с доступом через [OS Login](../concepts/os-login.md), разрешите такую возможность на уровне организации. После этого вы сможете включить доступ через OS Login на ВМ, созданных из подготовленного образа с поддержкой OS Login, или настроить агента OS Login на уже работающей ВМ самостоятельно. Подробнее см. в разделе [{#T}](../../compute/operations/vm-connect/os-login.md).

{% note info %}

Образы с поддержкой OS Login доступны в [{{ marketplace-full-name }}](/marketplace) и содержат `OS Login` в названии.

{% endnote %}

Чтобы включить доступ через OS Login на уровне организации:

{% list tabs %}

- {{ org-name }}

  1. [Войдите в аккаунт]({{ link-passport-login }}) администратора или владельца организации.
  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
  1. На панели слева выберите ![image](../../_assets/vpc/security-group.svg) **Настройки безопасности**.
  1. Включите опцию **Доступ по OS Login при помощи SSH-сертификатов**.

{% endlist %}
