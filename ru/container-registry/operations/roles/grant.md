# Назначить роль на ресурс

Чтобы предоставить доступ к [ресурсу](../../../iam/concepts/access-control/resources-with-access-control.md), назначьте субъекту [роль](../../../iam/concepts/access-control/roles.md) на сам ресурс или на ресурс, от которого наследуются права доступа, например, на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) или [облако](../../../resource-manager/concepts/resources-hierarchy.md#cloud). Подробнее читайте в разделе [{#T}](../../../iam/concepts/access-control/index.md).

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно назначить роль на ресурс.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Назначьте роль на ресурс.
     * Назначить на [реестр](../../concepts/registry.md):
       1. Справа от имени нужного реестра нажмите значок ![horizontal-ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.cr.registry.overview.button_registry-acl }}**.
       1. В открывшемся окне выберите группу, пользователя или [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) и нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
       1. В выпадающем списке **{{ ui-key.yacloud.component.acl-dialog.column_permissions }}** отметьте нужные роли.
       1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
     * Назначить на [репозиторий](../../concepts/repository.md):
       1. Выберите нужный репозиторий.
       1. Справа от имени нужного репозитория нажмите значок ![horizontal-ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.cr.registry.overview.button_repository-acl }}**.
       1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт и нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
       1. В выпадающем списке **{{ ui-key.yacloud.component.acl-dialog.column_permissions }}** отметьте нужные роли.
       1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Выберите роль из [списка](../../security/index.md#service-roles).
  1. Назначьте роль:
     * Чтобы добавить роль к имеющимся разрешениям, выполните команду:

       
       ```bash
       yc <имя_сервиса> <ресурс> add-access-binding <имя_или_идентификатор_ресурса> \
         --role <идентификатор_роли> \
         --subject userAccount:<идентификатор_пользователя>
       ```



     * Чтобы установить роль, удалив все имеющиеся разрешения, выполните команду:

       
       ```bash
       yc <имя_сервиса> <ресурс> set-access-bindings <имя_или_идентификатор_ресурса> \
         --role <идентификатор_роли> \
         --subject userAccount:<идентификатор_пользователя>
       ```



     Где:
     * `<имя_сервиса>` — имя сервиса `container`.
     * `<ресурс>` — категория ресурса `registry` или `repository`.
     * `<имя_или_идентификатор_ресурса>` — имя или идентификатор ресурса, на который назначается роль.
     * `--role` — идентификатор роли.
     * `--subject` — идентификатор группы, пользователя или сервисного аккаунта, которому назначается роль.

     >Пример. Добавьте роль `container-registry.admin` на реестр с идентификатором `crp0pmf1n68d********` для пользователя с идентификатором `kolhpriseeio********`:
     >

     
     >```bash
     >yc container registry add-access-binding crp0pmf1n68d******** \
     >  --role container-registry.admin \
     >  --subject userAccount:kolhpriseeio********
     >```



- {{ TF }}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}
  1. Опишите в конфигурационном файле:
     * Параметры ресурса `yandex_container_registry_iam_binding`, чтобы назначить роль на реестр:
       * `registry_id` — идентификатор реестра, на который назначается роль. Вы можете получить идентификатор реестра из [списка реестров в каталоге](../registry/registry-list.md#registry-list).
       * `role` — идентификатор роли.
       * `members` — идентификатор пользователя, группы или сервисного аккаунта, которому назначается роль.

       >Пример структуры конфигурационного файла:
       >

       
       >```
       >resource "yandex_container_registry_iam_binding" "puller" {
       >  registry_id = "<идентификатор_реестра>"
       >  role        = "<идентификатор_роли>"
       >
       >  members = [
       >    "userAccount:<идентификатор_пользователя>",
       >  ]
       >}
       >```



       Более подробную информацию о ресурсе `yandex_container_registry_iam_binding`, см. в [документации провайдера]({{ tf-provider-resources-link }}/container_registry_iam_binding).
     * Параметры ресурса `yandex_container_repository_iam_binding`, чтобы назначить роль на репозиторий:
       * `repository_id` — идентификатор репозитория, на который назначается роль.
       * `role` — идентификатор роли.
       * `members` — идентификатор пользователя, группы или сервисного аккаунта, которому назначается роль.

       >Пример структуры конфигурационного файла:
       >

       
       >```
       >resource "yandex_container_repository_iam_binding" "pusher" {
       >  repository_id = "<идентификатор_репозитория>"
       >  role          = "<идентификатор_роли>"
       >
       >  members = [
       >    "userAccount:<идентификатор_пользователя>",
       >  ]
       >}
       >```



       Более подробную информацию о ресурсе `yandex_container_repository_iam_binding`, см. в [документации провайдера]({{ tf-provider-resources-link }}/container_repository_iam_binding).
  1. Выполните проверку с помощью команды:

     ```
     terraform plan
     ```

     В терминале будет выведен список ресурсов с параметрами. Это проверочный этап: ресурсы не будут созданы. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

     {% note alert %}

     Все созданные с помощью {{ TF }} ресурсы тарифицируются. Внимательно проверьте план.

     {% endnote %}

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```

  1. Подтвердите изменения ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить назначение роли можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):
     * Для реестра:

       ```bash
       yc container registry list-access-bindings <имя_или_идентификатор_реестра>
       ```

     * Для репозитория:

       ```
       yc container repository list-access-bindings <имя_или_идентификатор_репозитория>
       ```

- API

  Чтобы назначить роль пользователю, сервисному аккаунту или группе для доступа к ресурсу, воспользуйтесь методом `updateAccessBindings` для ресурсов `registry` и `repository`.

{% endlist %}

Подробнее об управлении ролями читайте в [документации](../../../iam/concepts/index.md) {{ iam-full-name }}.