{% note info %}

{{ TF }} взаимодействует с {{ objstorage-name }} от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md). [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../../storage/security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.

{% endnote %}