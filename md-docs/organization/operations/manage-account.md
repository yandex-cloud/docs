# Управление аккаунтом на портале «Мой аккаунт»

Доступность функциональности портала [Мой аккаунт](../concepts/my-account.md) зависит от типа аккаунта:

| | [Аккаунт на Яндексе](../../iam/concepts/users/accounts.md#passport) | [Федеративный аккаунт](../../iam/concepts/users/accounts.md#saml-federation) | [Локальный аккаунт](../../iam/concepts/users/accounts.md#local) |
---|---|---|---
[Просмотр атрибутов](#view-profile) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) |
[Изменение атрибутов](#edit-profile) | ![alt](../../_assets/common/no.svg) | ![alt](../../_assets/common/no.svg) | ![alt](../../_assets/common/yes.svg) |
[Изменение пароля](#edit-password) | ![alt](../../_assets/common/no.svg) | ![alt](../../_assets/common/no.svg) | ![alt](../../_assets/common/yes.svg) |
[Управление способами подтверждения входа](#manage-mfa) | ![alt](../../_assets/common/no.svg) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) |
[Просмотр сессий](#view-sessions) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) |
[Завершение сессий](#end-sessions) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) |
[Удаление refresh-токенов](#delete-refresh-token) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) |
[Просмотр групп](#view-groups) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg)
[Просмотр логов](#view-logs) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg)

## Посмотреть атрибуты {#view-profile}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Перейдите в портал [Мой аккаунт](https://myaccount.yandex.cloud/).
  1. На панели слева выберите ![alt](../../_assets/console-icons/passport.svg) **Профиль**.
  1. В блоке **Данные профиля** отобразятся атрибуты вашего аккаунта.

{% endlist %}

## Изменить атрибуты {#edit-profile}

{% note info %}

Изменение атрибутов доступно, если это разрешено администратором пула.

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Перейдите в портал [Мой аккаунт](https://myaccount.yandex.cloud/).
  1. На панели слева выберите ![alt](../../_assets/console-icons/passport.svg) **Профиль**.
  1. Нажмите ![alt](../../_assets/console-icons/person-pencil.svg) **Редактировать**.
  1. Отредактируйте имя, фамилию, контактную и организационную информацию.
  1. Нажмите **Сохранить**.

{% endlist %}

## Изменить пароль {#edit-password}

{% note info %}

Изменение пароля доступно, если это разрешено администратором пула.

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Перейдите в портал [Мой аккаунт](https://myaccount.yandex.cloud/).
  1. На панели слева выберите ![alt](../../_assets/console-icons/shield.svg) **Вход и безопасность**.
  1. В блоке **Способы входа** нажмите ![alt](../../_assets/console-icons/pencil.svg) **Изменить**.
  1. Введите текущий пароль и дважды введите новый.
  1. Нажмите **Сохранить пароль**.

{% endlist %}

## Управление способами подтверждения входа {#manage-mfa}

Для управления способами подтверждения входа пользователь должен быть добавлен в [политику MFA](../concepts/mfa.md).

### Добавить способ подтверждения входа {#mfa-add}

{% note warning %}

Перед использованием функции подтверждения входа через WebAuthn убедитесь, что ваш браузер и операционная система поддерживаются. Проверьте совместимость в [таблице поддерживаемых конфигураций](../concepts/mfa.md#webauthn-support).

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Перейдите в портал [Мой аккаунт](https://myaccount.yandex.cloud/).
  1. На панели слева выберите ![alt](../../_assets/console-icons/shield.svg) **Вход и безопасность**.
  1. В блоке **Подтверждение входа** нажмите **Добавить способ подтверждения**.
  1. Выберите нужный способ подтверждения входа.

{% endlist %}

### Удалить способ подтверждения входа {#mfa-delete}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Перейдите в портал [Мой аккаунт](https://myaccount.yandex.cloud/).
  1. На панели слева выберите ![alt](../../_assets/console-icons/shield.svg) **Вход и безопасность**.
  1. В блоке **Подтверждение входа** отобразятся ваши способы подтверждения входа и дата последнего использования.
  1. Нажмите ![alt](../../_assets/console-icons/trash-bin.svg) **Удалить** рядом с нужным способом подтверждения входа.

{% endlist %}

## Посмотреть сессии {#view-sessions}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Перейдите в портал [Мой аккаунт](https://myaccount.yandex.cloud/).
  1. На панели слева выберите ![alt](../../_assets/console-icons/shield.svg) **Вход и безопасность**.
  1. Перейдите на вкладку **Ваши устройства**.

      В результате откроется список [сессий](../concepts/sessions.md), содержащих следующую информацию о приложениях и устройствах, с которых выполнен вход в аккаунт Yandex Identity Hub:

      * идентификатор [User-Agent](https://ru.wikipedia.org/wiki/User_agent) устройства, на котором выполнен вход в аккаунт;
      * время последнего входа в аккаунт;
      * IP-адрес, с которого осуществлялся последний вход в аккаунт.

{% endlist %}

## Завершить сессии {#end-sessions}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Перейдите в портал [Мой аккаунт](https://myaccount.yandex.cloud/).
  1. На панели слева выберите ![alt](../../_assets/console-icons/shield.svg) **Вход и безопасность**.
  1. Перейдите на вкладку **Ваши устройства**.

      В результате откроется список [сессий](../concepts/sessions.md), содержащих информацию о приложениях и устройствах, с которых выполнен вход в аккаунт Yandex Identity Hub.
  1. Чтобы завершить сессию:

      В строке с сессией, которую вы хотите завершить, нажмите кнопку ![arrow-right-from-square](../../_assets/console-icons/arrow-right-from-square.svg) **Выйти** и в открывшемся окне подтвердите действие.

      В результате на выбранном устройстве доступ пользователя к сервисам, использующим Yandex Identity Hub в качестве поставщика удостоверений, прекратится. Чтобы возобновить доступ, пользователю придется повторно выполнить аутентификацию в Yandex Identity Hub.
  1. Чтобы завершить все сессии:

      1. В правом верхнем углу экрана нажмите кнопку ![arrow-right-from-square](../../_assets/console-icons/arrow-right-from-square.svg) **Выйти везде**.
      1. В открывшемся окне:

          * Выберите `Не выходить на этом устройстве` и нажмите **Выйти**, чтобы завершить все сессии, кроме текущей.

              В результате доступ пользователя к сервисам, использующим Yandex Identity Hub в качестве поставщика удостоверений, прекратится на всех устройствах, за исключением текущего.
          * Выберите `Выйти на всех устройствах` и нажмите **Выйти**, чтобы завершить все сессии, включая текущую.

              В результате доступ пользователя к сервисам, использующим Yandex Identity Hub в качестве поставщика удостоверений, прекратится на всех устройствах, включая текущее.

      Чтобы возобновить доступ, пользователю придется повторно выполнить аутентификацию в Yandex Identity Hub.

{% endlist %}

## Удалить refresh-токены {#delete-refresh-token}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Перейдите в портал [Мой аккаунт](https://myaccount.yandex.cloud/).
  1. На панели слева выберите ![alt](../../_assets/console-icons/shield.svg) **Вход и безопасность**.
  1. Перейдите на вкладку **Refresh-токены**.
  1. Отобразятся все приложения, для которых вы добавили [refresh-токены](../../iam/concepts/authorization/refresh-token.md).
  1. Нажмите ![alt](../../_assets/console-icons/trash-bin.svg) в строке с приложением, для которого вы хотите удалить refresh-токен.
  1. Чтобы удалить все refresh-токены, нажмите ![alt](../../_assets/console-icons/trash-bin.svg) **Удалить все токены**. 

{% endlist %}

## Посмотреть группы {#view-groups}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Перейдите в портал [Мой аккаунт](https://myaccount.yandex.cloud/).
  1. На панели слева выберите ![alt](../../_assets/console-icons/persons.svg) **Группы**.
  1. На странице **Мои группы** отобразятся все ваши группы и их идентификаторы.

{% endlist %}

## Посмотреть логи {#view-logs}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Перейдите в портал [Мой аккаунт](https://myaccount.yandex.cloud/).
  1. На панели слева выберите ![alt](../../_assets/console-icons/clock.svg) **Активность**.
  1. На открывшейся странице отобразятся ваши аудитные [логи](../concepts/logs.md).
  1. Чтобы увидеть более подробную информацию о событии, нажмите на нужную запись.

     Вы также можете воспользоваться фильтрами вверху страницы, чтобы найти нужные логи.

  Чтобы посмотреть логи всех пользователей [организации](../concepts/organization.md) или [пула](../concepts/user-pools.md), в которых вы являетесь администратором, смотрите страницу [Посмотреть логи пользователя](user-pools/user-get-logs.md).

{% endlist %}