1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
1. На панели слева выберите ![icon-users](../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**. На странице отобразится список пользователей организации, содержащий следующие поля:

    * **{{ ui-key.yacloud_org.entity.user.caption.user }}** — полное имя пользователя.
    * **{{ ui-key.yacloud_org.entity.user.caption.username }}** — логин пользователя.
    * **{{ ui-key.yacloud_org.entity.user.caption.status }}** — текущий статус пользователя:

        * `Active` — пользователь активен.
        * `Inactive` — пользователь неактивен.
    * **{{ ui-key.yacloud_org.entity.user.caption.provider }}** — информация о провайдере удостоверений пользователя:

        * для федеративных пользователей — имя [федерации удостоверений](../organization/concepts/add-federation.md);
        * для локальных пользователей — имя [пула пользователей](../organization/concepts/user-pools.md);
        * для пользователей с аккаунтом на Яндексе — `Yandex ID`.
    * **{{ ui-key.yacloud_org.entity.user.column_last-auth }}** — дата и время, когда федеративный или локальный пользователь в последний раз [аутентифицировался](../iam/concepts/authorization/index.md) в {{ yandex-cloud }}.
    * **{{ ui-key.yacloud.common.id }}** — идентификатор пользователя.
    * **{{ ui-key.yacloud_org.entity.user.caption.email }}** — адрес электронной почты пользователя.

    {% note info %}

    Некоторые поля могут не отображаться. Чтобы настроить отображение полей, в правом верхнем углу списка пользователей нажмите значок ![gear](../_assets/console-icons/gear.svg), выберите нужные поля и нажмите **{{ ui-key.yacloud.common.apply }}**.

    Вы также можете изменить порядок отображения полей, перетаскивая их с помощью мыши.

    {% endnote %}
 
1. Найдите в списке нужного вам пользователя. При необходимости воспользуйтесь фильтром или поиском в верхней части экрана.
1. Нажмите на строку с именем пользователя, чтобы просмотреть подробную информацию о нем, а также о [группах](../organization/concepts/groups.md), в которые он входит, его [факторах MFA](../organization/concepts/mfa.md#mfa-factors) (для федеративных и локальных пользователей), [профилях {{ oslogin }}](../organization/concepts/os-login.md#os-login-profiles) и [SSH-ключах](../organization/concepts/os-login.md#ssh-keys).