* `SubjectClaims.sub` — [идентификатор](../../organization/operations/users-get.md) пользователя. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.entity.group.label_id }}** в списке пользователей организации в интерфейсе {{ org-name }} в {{ cloud-center }}. Например: `aje0fapf84ofj57q1r0b`.
* `SubjectClaims.preferred_username` — уникальный логин пользователя. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.entity.user.caption.username }}** в списке пользователей организации в интерфейсе {{ org-name }} в {{ cloud-center }}. Например: `ivanov@example-federation.ru`.
* `SubjectClaims.name` — полное имя пользователя. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.entity.group.label_user }}** в списке пользователей организации в интерфейсе {{ org-name }} в {{ cloud-center }}. Например: `Иванов Иван`.
* `SubjectClaims.given_name` — имя. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.page.user.field_user-givenname }}** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-name }} в {{ cloud-center }}. Например: `Иван`.
* `SubjectClaims.family_name` — фамилия. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.page.user.field_user-familyname }}** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-name }} в {{ cloud-center }}. Например: `Иванов`.
* `SubjectClaims.email` — адрес электронной почты. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.page.user.field_user-email }}** на странице с информацией о пользователе в интерфейсе {{ org-name }} в {{ cloud-center }}. Например: `ivanov@example-company.ru`.
* `SubjectClaims.phone_number` — номер телефона. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.page.user.field_user-phone }}** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-name }} в {{ cloud-center }}. Например: `+74951234567`.

{% note info %}

Любое из этих значений атрибутов вы можете добавлять более одного раза под разными именами.

{% endnote %}