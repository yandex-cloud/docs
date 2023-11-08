# Миграция групп хостов в кластере {{ mos-name }} в другую зону доступности

[Группы хостов](../concepts/host-groups.md) в кластере {{ mos-name }} располагаются в [зонах доступности](../../overview/concepts/geo-scope.md) {{ yandex-cloud }}. Группы хостов можно перенести из одной зоны в другую. Для этого:

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) перейдите на страницу вашего каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Нажмите на имя нужного кластера, затем выберите вкладку ![host-groups.svg](../../_assets/mdb/host-groups.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}**.
   1. В строке с группой хостов нажмите на значок ![image](../../_assets/horizontal-ellipsis.svg), затем выберите **Изменить**.
   1. В поле **Размещение хостов** выберите зону доступности, куда вы переносите кластеры, и уберите первоначальную зону.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

Перенесите таким образом каждую группу хостов.
