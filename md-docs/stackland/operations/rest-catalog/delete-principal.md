[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Базы данных > Iceberg REST Catalog > Удалить пользователя каталога

# Удалить пользователя каталога

Если у вас есть пользователь каталога [Iceberg REST Catalog](../../concepts/components/rest-catalog.md) в [проекте](../projects/create-project.md), вы можете удалить его.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Найдите название нужного пользователя в списке пользователей проекта: `kubectl get RestCatalogPrincipal -n <название проекта>`.
  1. Удалите ресурс пользователя: `kubectl delete RestCatalogPrincipal <название пользователя> -n <название проекта>`.


- Консоль управления {#console}

  1. Если вы еще не открыли проект, выберите проект.
  1. В левом меню выберите **Iceberg REST Catalog**.
  1. На вкладке **Каталоги** выберите каталог.
  1. Перейдите на вкладку **Пользователи**.
  1. Выберите пользователя.
  1. Нажмите **Удалить**.
  1. Подтвердите удаление.

{% endlist %}