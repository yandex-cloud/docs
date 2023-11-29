# Получение информации об инстансах

Вы можете получить детальную информацию о каждом созданном [инстансе {{ GL }}](../../concepts/index.md#instance) в {{ yandex-cloud }}.

## Получить список инстансов в каталоге {#list}

{% list tabs %}

- Консоль управления

  Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.

{% endlist %}

## Получить детальную информацию о инстансе {#get}

Детальная информация об инстансе:
* Домен.
* Статус.
* Ресурсы — RAM, vCPU, размер хранилища.
* Логин и электронная почта администратора.

{% list tabs %}

- Консоль управления

  1. В консоли управления выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится инстанс {{ GL }}.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Нажмите на имя нужного инстанса.

{% endlist %}

## Посмотреть список операций в инстансе {#list-operations}

В списке операций отображаются операции с инстансами и связанными ресурсами.

{% list tabs %}

- Консоль управления

  1. В консоли управления выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится инстанс {{ GL }}.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Нажмите на имя нужного инстанса и выберите вкладку ![image](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}**.

{% endlist %}