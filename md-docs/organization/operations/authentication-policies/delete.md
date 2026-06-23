# Удалить политику аутентификации

{% note info %}

Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

[Политики аутентификации](../../concepts/authentication-policy.md) — это инструмент Yandex Identity Hub, позволяющий гибко настраивать доступ [пользователей](*user_accounts) и [групп пользователей](*user_groups) к [приложениям](*applications) Yandex Identity Hub, запрещая или разрешая аутентификацию в зависимости от условий, заданных в области применения политики.

[*user_groups]: Пользователей Yandex Identity Hub можно объединять в группы, что упрощает управление доступом в Yandex Cloud. Подробнее читайте в разделе [Группы пользователей](../../concepts/groups.md).

[*applications]: SAML- и OIDC-приложения Yandex Identity Hub позволяют пользователям Yandex Cloud аутентифицироваться в сервисах сторонних поставщиков услуг. Подробнее читайте в разделе [Приложения в Yandex Identity Hub](../../concepts/applications/index.md).

[*user_accounts]: В Yandex Cloud используются аккаунты пользователей на Яндексе, а также федеративные и локальные пользовательские аккаунты. Подробнее читайте в разделе [Аккаунты в Yandex Cloud](../../../iam/concepts/users/accounts.md).

[*organization]: Организация — это высший ресурс в иерархии ресурсной модели Yandex Cloud, который объединяет ресурсы всех остальных сервисов, а также используется для управления пользователями и параметрами их аутентификации и авторизации. Подробнее читайте в разделе [Организация](../../concepts/organization.md).

Управлять политиками аутентификации может пользователь, которому назначена [роль](*org_manager_admin) `organization-manager.admin` или выше.

[*org_manager_admin]: Роль `organization-manager.admin` позволяет управлять настройками организации, федерациями удостоверений, пулами пользователей, SAML-приложениями, OIDC-приложениями, пользователями и их группами, а также правами доступа пользователей к организации и ресурсам в ней. Подробнее читайте в разделе [Управление доступом в Yandex Identity Hub](../../security/index.md#organization-manager-admin).

Чтобы удалить политику аутентификации:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **Настройки безопасности** и перейдите на вкладку **Политики аутентификации**.
  1. В строке с нужной политикой аутентификации нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. В открывшемся окне подтвердите удаление.

{% endlist %}

#### Полезные ссылки {#see-also}

* [Приложения в Yandex Identity Hub](../../concepts/applications/index.md)
* [Политики аутентификации в Yandex Identity Hub](../../concepts/authentication-policy.md)
* [Создать политику аутентификации](create.md)
* [Активировать и деактивировать политику аутентификации](activate-deactivate.md)
* [Изменить политику аутентификации](update.md)