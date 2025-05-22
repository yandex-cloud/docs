Роль `organization-manager.federations.admin` позволяет управлять федерациями удостоверений, федеративными пользователями и сертификатами, а также просматривать информацию об организации, ее настройках и пользователях.

Пользователи с этой ролью могут:
* просматривать информацию об [организации](../../../organization/concepts/organization.md) и ее настройках;
* просматривать информацию о [федерациях удостоверений](../../../organization/concepts/add-federation.md), а также создавать, изменять и удалять такие федерации;
* просматривать информацию о [сертификатах](../../../organization/concepts/add-federation.md#build-trust), а также создавать, изменять и удалять их;
* просматривать списки [сопоставлений](../../../organization/concepts/add-federation.md#group-mapping) групп пользователей и информацию о таких сопоставлениях;
* добавлять [федеративных пользователей](../../../organization/concepts/add-federation.md#saml-authentication) и удалять их;
* отзывать [refresh-токены](../../../iam/concepts/authorization/refresh-token.md) федеративных пользователей;
* просматривать список [пользователей](../../../overview/roles-and-resources.md#users) организации и информацию о пользователях;
* просматривать список [групп](../../../organization/concepts/groups.md), в которые входят пользователи организации;
* просматривать [атрибуты](../../../organization/operations/setup-federation.md#claims-mapping) федеративных пользователей.

Включает разрешения, предоставляемые ролью `organization-manager.federations.editor`.