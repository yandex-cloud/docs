* `SubjectClaims.sub`: [User ID](../../organization/operations/users-get.md). The field value is the same as the one displayed in the **{{ ui-key.yacloud_org.entity.group.label_id }}** field in the organization's user list in the {{ cloud-center }}'s {{ org-name }} interface, e.g., `aje0fapf84ofj57q1r0b`.
* `SubjectClaims.preferred_username`: Unique login for the user. The field value is the same as the one displayed in the **{{ ui-key.yacloud_org.entity.user.caption.username }}** field in the organization's user list in the {{ cloud-center }}'s {{ org-name }} interface, e.g., `ivanov@example-federation.ru`.
* `SubjectClaims.name`: User’s full name. The field value is the same as the one displayed in the **{{ ui-key.yacloud_org.entity.group.label_user }}** field in the organization's user list in the {{ cloud-center }}'s {{ org-name }} interface, e.g., `Ivan Ivanov`.
* `SubjectClaims.given_name`: Name. The field value is the same as the one displayed in the **{{ ui-key.yacloud_org.page.user.field_user-givenname }}** field under **{{ ui-key.yacloud_org.page.user.title_personal-info }}** on the user info page in the {{ cloud-center }}'s {{ org-name }} interface, e.g., `Ivan`.
* `SubjectClaims.family_name`: Last name. The field value is the same as the one displayed in the **{{ ui-key.yacloud_org.page.user.field_user-familyname }}** field under **{{ ui-key.yacloud_org.page.user.title_personal-info }}** on the user info page in the {{ cloud-center }}'s {{ org-name }} interface, e.g., `Ivanov`.
* `SubjectClaims.email`: Email address. The field value is the same as the one displayed in the **{{ ui-key.yacloud_org.page.user.field_user-email }}** field on the user info page in the {{ cloud-center }}'s {{ org-name }} interface, e.g., `ivanov@example-company.ru`.
* `SubjectClaims.phone_number`: Phone number. The field value is the same as the one displayed in the **{{ ui-key.yacloud_org.page.user.field_user-phone }}** field under **{{ ui-key.yacloud_org.page.user.title_personal-info }}** on the user info page in the {{ cloud-center }}'s {{ org-name }} interface, e.g., `+74951234567`.

{% note info %}

You can add any of these attribute values more than once under different names.

{% endnote %}