Роль | Разрешения
----- | -----
`resource-manager.clouds.owner` | Дает полный доступ к облаку и ресурсам в нем. Можно назначить только на облако.
{% if audience != "internal" %}`resource-manager.clouds.member` | Роль, необходимая для доступа к ресурсам в облаке всем, кроме [владельцев облака](../resource-manager/concepts/resources-hierarchy.md#owner) и [сервисных аккаунтов](../iam/concepts/users/service-accounts.md).{% endif %}