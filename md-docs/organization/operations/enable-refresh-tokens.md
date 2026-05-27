# Включить возможность использования refresh-токенов в Yandex Cloud CLI

[Refresh-токен](../../iam/concepts/authorization/refresh-token.md) — это тип учетных данных, позволяющий OAuth-приложению по истечении срока действия [IAM-токена](../../iam/concepts/authorization/iam-token.md) пользователя автоматически получать новый IAM-токен.

Чтобы пользователи могли использовать refresh-токены в [Yandex Cloud CLI](../../cli/index.md), включите эту функциональность на уровне организации Yandex Identity Hub:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.

      При необходимости [переключитесь](manage-organizations.md#switch-to-another-org) на нужную организацию.
  1. На панели слева выберите ![shield](../../_assets/console-icons/shield.svg) **Настройки безопасности**.
  1. В блоке **Настройки аутентификации** включите опцию **Разрешить использовать refresh-токены**.
  1. (Опционально) Если вы хотите использовать усиленную [защиту](../../iam/concepts/authorization/refresh-token.md#dpop-verification) refresh-токенов с помощью DPoP-ключей с обязательным их сохранением на [устройстве YubiKey](https://developers.yubico.com/Passkeys/), включите опцию **Разрешить хранение DPoP-ключей только на устройствах YubiKey**.

      Если эта опция отключена, для защиты refresh-токенов можно можно будет использовать DPoP-ключи, сохраненные как на устройстве YubiKey, так и в файловой системе на компьютере пользователя.

{% endlist %}

Чтобы пользователи могли использовать refresh-токены в Yandex Cloud CLI, после включения этой функциональности на уровне организации каждый пользователь должен выполнить [инициализацию DPoP-защиты](../../iam/concepts/authorization/refresh-token.md#enabling-dpop).