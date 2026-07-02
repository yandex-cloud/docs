[Документация Yandex Cloud](../../../index.md) > [Yandex Identity Hub](../../index.md) > [Пошаговые инструкции](../index.md) > Аутентификация > Управление MFA > Удалить MFA-фактор и сбросить дату верификации

# Удалить MFA-фактор и сбросить дату верификации

Администратор организации может просматривать дату последней верификации [федеративных](../../../iam/concepts/users/accounts.md#saml-federation) и [локальных](../../../iam/concepts/users/accounts.md#local) аккаунтов пользователей. Кроме того, в некоторых случаях администратору может потребоваться [сбросить](#reset-verification-date) дату верификации пользовательского аккаунта или [удалить](#remove-mfa-factor) имеющийся в нем [фактор аутентификации](../../concepts/mfa.md#mfa-factors).

{% note info %}

Информацию о дате последней верификации пользователя с помощью фактора MFA можно посмотреть на вкладке **Обзор** страницы с информацией о пользователе в интерфейсе Yandex Identity Hub в Cloud Center.

{% endnote %}

## Сбросьте дату верификации учетной записи пользователя {#reset-verification-date}

Сбросить дату верификации пользовательского аккаунта может пользователь, которому назначена [роль](../../security/index.md) `organization-manager.federations.userAdmin` или выше (для федеративного аккаунта) или `organization-manager.userpools.userAdmin` или выше (для локального аккаунта).

Чтобы сбросить дату верификации пользователя:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![icon-users](../../../_assets/console-icons/person.svg) **Пользователи** и выберите нужного федеративного или локального пользователя.
  1. В правом верхнем углу страницы нажмите **Ещё** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите ![arrow-rotate-left](../../../_assets/console-icons/arrow-rotate-left.svg) **Сбросить дату верификации**.
  1. В открывшемся окне подтвердите действие.

{% endlist %}

Дата верификации пользователя будет изменена на текущую дату.

## Удалите фактор аутентификации учетной записи пользователя {#remove-mfa-factor}

Удалить существующий [фактор аутентификации](../../concepts/mfa.md#mfa-factors) пользовательского аккаунта может пользователь, которому назначена [роль](../../security/index.md) `organization-manager.federations.userAdmin` или выше (для федеративного аккаунта) или `organization-manager.userpools.userAdmin` или выше (для локального аккаунта).

Чтобы удалить имеющийся в пользовательском аккаунте фактор аутентификации:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![icon-users](../../../_assets/console-icons/person.svg) **Пользователи** и выберите нужного федеративного или локального пользователя.
  1. Перейдите на вкладку **MFA**.
  1. В строке с имеющимся у пользователя фактором аутентификации нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. Подтвердите удаление.

{% endlist %}

Фактор аутентификации пользователя будет удален, и при следующей аутентификации в Yandex Cloud пользователю придется вновь пройти [верификацию](../../concepts/mfa.md#mfa-factors).

#### Полезные ссылки {#see-also}

* [Создать политику MFA](create-policy.md)
* [Изменить политику MFA](update-policy.md)
* [Применить политику MFA к пользователям](add-users.md)
* [Управлять исключениями политики MFA](excluded-audience.md)
* [Активировать и деактивировать политику MFA](deactivate-reactivate-policy.md)
* [Удалить политику MFA](delete-policy.md)
* [Многофакторная аутентификация в Yandex Identity Hub](../../concepts/mfa.md)