{% note info %}

Для доступа пользователя к [консоли управления]({{ link-console-main }}), назначьте ему роль на [облако](../../organization/security/index.md#access-binding-cloud) или [организацию](../../organization/security/index.md#access-binding-organization). Для безопасности вы можете назначить одну из ролей с минимальными привилегиями, например `resource-manager.clouds.member`, но также можно назначить и другие роли, если вы знаете, какие права вы хотите предоставить приглашенным пользователям.

Чтобы дать эти права сразу всем пользователям в организации, назначьте роль [системной группе](../../iam/concepts/access-control/system-group.md#allOrganizationUsers) `All users in organization X`. При работе с CLI или API назначение дополнительных ролей не требуется.

{% endnote %}