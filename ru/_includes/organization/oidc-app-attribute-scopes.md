* `{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.oauth-scope-openid_o99tx }}` — идентификатор пользователя. Обязательный параметр.
* `{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.oauth-scope-email_vYNmM }}` — адрес электронной почты пользователя.
* `{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.oauth-scope-profile_sgdKX }}` — дополнительная информация о пользователе.
* `{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.oauth-scope-groups_iZoa5 }}` — [группы пользователей](../../organization/concepts/groups.md) организации, участником которых является аутентифицирующийся пользователь. Возможные значения:

    * `{{ ui-key.yacloud_org.field-data.attributes.update_dialog.field_group_all }}` — поставщику услуг будут переданы все группы, в которые входит пользователь.

        Максимальное количество передаваемых групп — 1&nbsp;000. Если количество групп, в которые входит пользователь, превышает это число, на сторону поставщика услуг будет передана только первая тысяча групп. 
    * `{{ ui-key.yacloud_org.field-data.attributes.update_dialog.field_group_assigned }}` — из всех групп, в которые входит пользователь, поставщику услуг будут переданы только те группы, которые явно заданы на вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** OIDC-приложения.