
Роль `organization-manager.osLogins.admin` позволяет управлять настройками {{ oslogin }} организации, а также профилями {{ oslogin }} и SSH-ключами пользователей.

Пользователи с этой ролью могут:
* просматривать информацию о настройках [{{ oslogin }}](../../../organization/concepts/os-login.md) организации и изменять такие настройки;
* просматривать список [профилей](../../../organization/concepts/os-login.md#os-login-profiles) {{ oslogin }} пользователей [организации](../../../organization/concepts/organization.md) и [сервисных аккаунтов](../../../iam/concepts/users/service-accounts.md), а также создавать, изменять и удалять профили {{ oslogin }};
* просматривать список SSH-ключей пользователей организации и информацию об SSH-ключах, а также создавать, изменять и удалять SSH-ключи пользователей.

Включает разрешения, предоставляемые ролью `organization-manager.osLogins.viewer`.