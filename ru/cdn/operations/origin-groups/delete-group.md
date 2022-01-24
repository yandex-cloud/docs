# Удаление группы источников

## Удаление одной группы источников {#deletion-group-single}

Чтобы удалить [группу источников](../../concepts/origins.md):

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать группу ресурсов.
  1. Выберите сервис **Cloud CDN**.
  1. На вкладке **Группы источников** выберите группу, которую хотите удалить.
  1. В правом верхнем углу нажмите кнопку **Удалить**.
  1. Подтвердите удаление.

- CLI

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления группы источников:

     ```
     yc cdn origin-group delete --help
     ```

  1. Получите список всех групп источников в каталоге по умолчанию:

     ```
     yc cdn origin-group list --format yaml
     ```

     Результат:

     ```
     - id: "90209"
       folder_id: b1g86q4m5vej8lkljme5
       name: test-group-1
       use_next: true
       origins:
       - id: "561547"
         origin_group_id: "90209"
         source: www.example2.com
         enabled: true
         backup: true
       - id: "561546"
         origin_group_id: "90209"
         source: www.example1.com
         enabled: true
     - id: "90208"
       folder_id: b1g86q4m5vej8lkljme5
       name: test-group
       use_next: true
       origins:
       - id: "561545"
         origin_group_id: "90208"
         source: www.a2.com
         enabled: true
         backup: true
       - id: "561544"
         origin_group_id: "90208"
         source: www.a1.com
         enabled: true
     ```
  
  1. Удалите группу источников в каталоге по умолчанию:

     ```
     yc cdn origin-group delete --id <идентификатор группы источников>
     ```

     Подробнее о команде `yc cdn origin-group delete` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/cdn/origin-group/delete.md).

- Terraform

  Подробнее о Terraform [читайте в документации](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  Если вы создавали группу источников с помощью Terraform, вы можете удалить ее:

  1. В командной строке перейдите в папку, где расположен конфигурационный файл Terraform.

  1. Удалите из конфигурационного файла описание нужной группы.

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Удалите группу источников.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

## Удаление нескольких групп источников {#summ-deletion-groups}

Чтобы удалить несколько групп источников:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать группу ресурсов.
  1. Выберите сервис **Cloud CDN**.
  1. На вкладке **Группы источников** выберите группы, которые хотите удалить.

     Чтобы удалить все группы, выберите опцию в шапке таблицы рядом с полем **Название**.
  1. Внизу экрана нажмите кнопку **Удалить**.
  1. Подтвердите удаление.

{% endlist %}
