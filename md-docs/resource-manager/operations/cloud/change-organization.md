# Изменение организации для облака

Если в вашем аккаунте зарегистрировано несколько организаций, вы можете переносить облака из одной организации в другую.

{% note info %}

В новую организацию необходимо [добавить](../../../organization/operations/add-account.md) всех пользователей, для которых в исходной организации назначены роли на переносимое облако, каталоги или ресурсы.

{% endnote %}

{% note warning %}

При переносе облака из одной организации в другую, роли аккаунтов на Яндексе будут перенесены и назначены автоматически. Роли федеративных пользователей необходимо будет заново назначить вручную. 

{% endnote %}

Чтобы перенести облако в другую организацию, у вас должна быть [роль](../../security/index.md#resource-manager-clouds-owner) `resource-manager.clouds.owner` на переносимое облако и [роль](../../../organization/security/index.md#organization-manager-organizations-owner) `organization-manager.organizations.owner` на организацию, в которую вы собираетесь перенести это облако. Подробнее о назначении ролей читайте в разделах [Назначить роль на облако](set-access-bindings.md#access-to-user) и [Назначить роль на организацию](../../../organization/security/index.md#add-role).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите нужное облако.
  1. В правом верхнем углу нажмите кнопку ![***](../../../_assets/console-icons/ellipsis.svg) и выберите **Изменить организацию**.
  1. Выберите новую организацию из списка и нажмите **Изменить**.

- API {#api}

  Сейчас нет возможности изменить назначенную облаку организацию с помощью API.

{% endlist %}

## Полезные ссылки {#see-also}

* [Покинуть организацию](../../../organization/operations/leave-organization.md)