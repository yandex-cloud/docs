# Миграция групп хостов в кластере {{ mos-name }} в другую зону доступности

[Группы хостов](../concepts/host-groups.md) в кластере {{ mos-name }} располагаются в [зонах доступности](../../overview/concepts/geo-scope.md) {{ yandex-cloud }}. Чтобы перенести группы хостов из одной зоны в другую:

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Нажмите на имя нужного кластера, затем выберите вкладку ![host-groups.svg](../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}**.
   1. В строке с группой хостов нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **Изменить**.
   1. В поле **Размещение хостов** выберите зону доступности, куда вы переносите кластеры, и уберите первоначальную зону.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

Перенесите таким образом каждую группу хостов.

## Особенности миграции в сервисе {{ data-transfer-full-name }} {#data-transfer}

Если кластер выступает в роли [эндпоинта](../../data-transfer/concepts/index.md#endpoint) при передаче данных с помощью сервиса {{ data-transfer-name }}:

1. Убедитесь, что все группы хостов кластера располагаются не только в зоне `{{ region-id }}-d`, иначе трансфер не будет работать корректно. Если вы переносите группы хостов в зону `{{ region-id }}-d`, расположите хотя бы одну группу в зоне `{{ region-id }}-a` или `{{ region-id }}-b`. Трансфер автоматически выберет подходящую зону. Если в кластере одна группа хостов, разместите ее в зоне `{{ region-id }}-a` или `{{ region-id }}-b`.

1. Если [тип трансфера](../../data-transfer/concepts/transfer-lifecycle.md#transfer-types) — {{ dt-type-repl }} или {{ dt-type-copy-repl }}, перезапустите трансфер после добавления новых групп хостов и удаления старых. Так он получит сведения о новой топологии кластера. Трансферы типа {{ dt-type-copy }} перезапускать не нужно, так как во время их активации информация о новой топологии передается автоматически.

   {% include [reactivate-a-transfer](../../_includes/data-transfer/reactivate-a-transfer.md) %}

Подробнее см. в разделе [{#T}](../../data-transfer/operations/endpoint/migration-to-an-availability-zone.md).
