# Изменение группы источников

## Редактирование группы {#editing-groups}

Чтобы изменить [группу источников](../../concepts/origins.md):

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать группу ресурсов.
  1. Выберите сервис **{{ cdn-short-name }}**.
  1. На панели слева выберите ![image](../../../_assets/cdn/origin-groups.svg) **Группы источников**.
  1. Выберите группу, которую хотите отредактировать.
  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/pencil.svg) **Редактировать**.
  1. Внесите необходимые изменения.
  1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для редактирования группы источников:

     ```bash
     yc cdn origin-group update --help
     ```

  1. Получите список всех групп источников в каталоге по умолчанию:

     ```bash
     yc cdn origin-group list --format yaml
     ```

     Результат:

     ```bash
     - id: "90209"
       folder_id: b1g86q4m5vej8lkljme5
       name: test-group-1
     ...
         origin_group_id: "90208"
         source: www.a1.com
         enabled: true
     ```

  1. Измените параметры группы источников, указав ее идентификатор:

     ```bash
     yc cdn origin-group update --id <идентификатор группы источников> \
       --name <новое имя группы> \
       --origin source=<IP-адрес или доменное имя нового источника>,enabled=true \
       --origin source=<IP-адрес или доменное имя нового источника>,enabled=true,backup=true
     ```

     Где `origin` — спецификация источника:
     * `source` — IP-адрес или доменное имя нового источника.
     * `enabled` — флаг, указывающий, включен ли источник.
     * `backup` — флаг, указывающий, является ли источник резервным.

     Результат:

     ```bash
     id: "90209"
     folder_id: b1g86q4m5vej8lkljme5
     name: test-group-22
     ...
       origin_group_id: "90209"
       source: www.site1.com
       enabled: true
     ```

     Подробнее о команде `yc cdn origin-group update` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/cdn/origin-group/update.md).

- API

  Чтобы изменить группу источников, воспользуйтесь методом REST API [update](../../api-ref/OriginGroup/update.md) для ресурса [OriginGroup](../../api-ref/OriginGroup/index.md) или вызовом gRPC API [OriginGroupService/Update](../../api-ref/grpc/origin_group_service.md#Update).

{% endlist %}

## Удаление одного источника из группы {#group-source-deletion}

{% note info %}

Удалить можно только резервные источники.

{% endnote %}

Чтобы удалить источник из группы источников:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать группу ресурсов.
  1. Выберите сервис **{{ cdn-short-name }}**.
  1. На панели слева выберите ![image](../../../_assets/cdn/origin-groups.svg) **Группы источников** и нажмите на имя группы, из которой хотите удалить источник.
  1. Выберите нужный источник и нажмите кнопку **Удалить** на панели внизу.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- API

  Воспользуйтесь методом REST API [delete](../../api-ref/Origin/delete.md) для ресурса [Origin](../../api-ref/Origin/index.md) или вызовом gRPC API [OriginService/Delete](../../api-ref/grpc/origin_service.md#Delete).

{% endlist %}

## Удаление нескольких источников из группы {#summ-group-source-deletion}

{% note info %}

Удалить можно только резервные источники.

{% endnote %}

Чтобы удалить несколько источников из группы:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать группу ресурсов.
  1. Выберите сервис **{{ cdn-short-name }}**.
  1. На панели слева выберите ![image](../../../_assets/cdn/origin-groups.svg) **Группы источников** и нажмите на имя группы, из которой хотите удалить источники.
  1. Выберите нужные источники и нажмите кнопку **Удалить** на панели внизу.
  1. В открывшемся окне нажмите кнопку **Удалить**.

{% endlist %}