# Просмотреть роли на ресурс

Чтобы просмотреть назначенные [роли](../../../iam/concepts/access-control/roles.md):

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно просмотреть роли на ресурс.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Просмотрите роли, которые назначены на ресурс.
     * Посмотреть роли на [реестр](../../concepts/registry.md):
       1. Справа от имени нужного реестра нажмите значок ![horizontal-ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.cr.registry.overview.button_registry-acl }}**.
       1. В открывшемся окне отобразится список пользователей и их разрешений на реестр.
     * Посмотреть роли на репозиторий:
       1. Выберите нужный реестр.
       1. Справа от имени нужного репозитория нажмите значок ![horizontal-ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.cr.registry.overview.button_repository-acl }}**.
       1. В открывшемся окне отобразится список пользователей и их разрешений на репозиторий.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Выполните команду:

  ```bash
  yc <имя сервиса> <ресурс> list-access-bindings <имя ресурса>|<id ресурса>
  ```

  Где:
  * `<имя сервиса>` — имя сервиса `container`.
  * `<ресурс>` — категория ресурса `registry` или `repository`.
  * `<имя ресурса>` — имя ресурса, на который назначается роль. Вы можете указать ресурс по имени или идентификатору.
  * `<id ресурса>` — идентификатор ресурса, на который назначается роль.

  >Пример. Просмотрите роли на реестр с идентификатором `crp0pmf1n68dh715tf02`:
  >
  >```bash
  >yc container registry list-access-bindings crp0pmf1n68dh715tf02
  >```
  >
  >Результат выполнения команды:
  >
  >```bash
  >+--------------------------+------------------+----------------------+
  >|         ROLE ID          |   SUBJECT TYPE   |      SUBJECT ID      |
  >+--------------------------+------------------+----------------------+
  >| container-registry.admin | federatedAccount | kolhpriseeioo9dc3v24 |
  >+--------------------------+------------------+----------------------+
  >```

- API

  Воспользуйтесь методом `listAccessBindings` для ресурсов `registry` и `repository`.

{% endlist %}

Подробнее об управлении ролями читайте в [документации](../../../iam/concepts/index.md) {{ iam-full-name }}.