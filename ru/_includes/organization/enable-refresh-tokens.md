{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в [{{ cloud-center }}]({{ cloud-center-link }}) с учетной записью администратора или владельца организации.

      При необходимости [переключитесь](../../organization/operations/manage-organizations.md#switch-to-another-org) на нужную организацию.
  1. В верхней части экрана выберите **Security**.
  1. На панели слева выберите **{{ ui-key.yacloud_org.pages.securitySettings }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_other_kJgk8 }}**.
  1. В блоке **Настройки аутентификации** включите опцию **Разрешить использовать refresh-токены**.
  1. (Опционально) Если вы хотите использовать усиленную [защиту](../../iam/concepts/authorization/refresh-token.md#dpop-verification) refresh-токенов с помощью DPoP-ключей с обязательным их сохранением на [устройстве YubiKey](https://developers.yubico.com/Passkeys/), включите опцию **Разрешить хранение DPoP-ключей только на устройствах YubiKey**.

      Если эта опция отключена, для защиты refresh-токенов можно будет использовать DPoP-ключи, сохраненные как на устройстве YubiKey, так и в файловой системе на компьютере пользователя.

      {% note warning %}

      Для пользователей с [аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport) в нескольких организациях всегда действует самая строгая настройка refresh-токенов. Если одна организация разрешает хранить DPoP-ключи в файловой системе, а другая требует только YubiKey, пользователь сможет использовать только YubiKey при входе в любую из этих организаций.

      {% endnote %}

{% endlist %}

Чтобы пользователи могли использовать refresh-токены в {{ yandex-cloud }} CLI, после включения этой функциональности на уровне организации каждый пользователь должен выполнить [инициализацию DPoP-защиты](../../iam/concepts/authorization/refresh-token.md#enabling-dpop).
