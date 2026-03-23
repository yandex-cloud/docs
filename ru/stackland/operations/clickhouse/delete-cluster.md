# Удалить кластер {{ mch-name }}

Если у вас есть кластер [{{ CH }}](../../concepts/components/clickhouse.md) в [проекте](../projects/create-project.md), вы можете удалить его.

{% note info %}

Если включена [защита от удаления](../../concepts/components/clickhouse.md#deletion-protection) (`spec.deletionProtection: true`), оператор отклонит удаление ресурса. Сначала отключите защиту в [настройках кластера](edit-cluster.md), задав `spec.deletionProtection: false`, примените манифест и затем выполните удаление.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Найдите название нужного кластера в списке кластеров проекта: `kubectl get ClickhouseCluster -n <название проекта>`.
  1. Удалите ресурс кластера: `kubectl delete ClickhouseCluster <название кластера> -n <название проекта>`.


- Консоль управления {#console}

  1. Откройте ваш проект.
  1. В левом меню выберите **{{ CH }} Clusters**.
  1. Выберите кластер.
  1. Нажмите **Удалить**.
  1. Подтвердите удаление.

{% endlist %}

Готово, кластер успешно удален.
