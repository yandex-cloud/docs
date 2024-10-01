# Получение информации об инстансах

Вы можете получить детальную информацию о каждом созданном [инстансе {{ GL }}](../../concepts/index.md#instance) в {{ yandex-cloud }}.

## Получить список инстансов в каталоге {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.

{% endlist %}

## Получить детальную информацию о инстансе {#get}

Детальная информация об инстансе:
* Домен.
* Статус.
* Ресурсы — RAM, vCPU, размер хранилища.
* Логин и электронная почта администратора.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В консоли управления выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится инстанс {{ GL }}.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Нажмите на имя нужного инстанса.

{% endlist %}

## Посмотреть список операций в инстансе {#list-operations}

В списке операций отображаются операции с инстансами и связанными ресурсами.

Все действия с инстансами {{ mgl-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы получить список операций для конкретного инстанса:

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.gitlab.switch_instances }}**.
  1. Выберите нужный инстанс.
  1. Перейдите на панель ![image](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** для выбранного кластера.

     В открывшемся списке отображаются операции с выбранным инстансом.

{% endlist %}


#### См. также {#see-also}

* [{#T}](../../../api-design-guide/concepts/about-async.md)