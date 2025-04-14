{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.

      При необходимости [переключитесь](../../organization/operations/manage-organizations.md#switch-to-another-org) на нужную организацию.
  1. На панели слева выберите ![shield](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.oslogin.title }}**.
  1. В блоке **Настройки аутентификации** включите опцию **Разрешить использовать refresh-токены**.
  1. (Опционально) Если вы хотите использовать усиленную [защиту](../../iam/concepts/authorization/refresh-token.md#dpop-verification) refresh-токенов с помощью DPoP-ключей с обязательным их сохранением на [устройстве YubiKey](https://developers.yubico.com/Passkeys/), включите опцию **Разрешить хранение DPoP-ключей только на устройствах YubiKey**.

      Если эта опция отключена, для защиты refresh-токенов можно можно будет использовать DPoP-ключи, сохраненные как на устройстве YubiKey, так и в файловой системе на компьютере пользователя.

{% endlist %}

Чтобы федеративные пользователи могли использовать refresh-токены в {{ yandex-cloud }} CLI, после включения этой функциональности на уровне организации каждый пользователь должен выполнить [инициализацию DPoP-защиты](../../iam/concepts/authorization/refresh-token.md#enabling-dpop).