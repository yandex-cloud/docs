Роль `organization-manager.federations.viewer` позволяет просматривать информацию об организации и ее настройках, о федерациях удостоверений и пользователях организации.

Пользователи с этой ролью могут:
* просматривать информацию об [организации](../../../organization/concepts/organization.md) Identity Hub и ее настройках;
* просматривать информацию о [федерациях удостоверений](../../../organization/concepts/add-federation.md);
* просматривать информацию о [сертификатах](../../../organization/concepts/add-federation.md#build-trust);
* просматривать списки [сопоставлений](../../../organization/concepts/add-federation.md#group-mapping) групп пользователей и информацию о таких сопоставлениях;
* просматривать список [пользователей](../../../overview/roles-and-resources.md#users) организации, информацию о них (включая номер телефона), дату их последней аутентификации, а также дату последней верификации федеративных и локальных аккаунтов с помощью [двухфакторной аутентификации](../../../organization/concepts/mfa.md);
* просматривать список [групп](../../../organization/concepts/groups.md), в которые входят пользователи;
* просматривать [атрибуты](../../../organization/operations/setup-federation.md#claims-mapping) федеративных и локальных пользователей.

Включает разрешения, предоставляемые ролью `organization-manager.federations.auditor`.