# Создать квоту

После создания [проекта](../projects/create-project.md) администратор может ограничить ресурсы с помощью [объекта](https://kubernetes.io/docs/concepts/policy/resource-quotas/) `ResourceQuota`.

## Через CLI

1. Создайте файл ресурса `ResourceQuota`. Например, с помощью команды `touch resourcequota.yaml`.
1. Откройте файл и вставьте конфигурацию ниже:

      {% list tabs %}

      - Квота без скоупа

          {% include notitle [YAML-файл](../../_includes/yamls/operations/quotas/quota-without-scope.md) %}

      - Квота со скоупом

          {% note info %}

          Квота будет применена только к подам с параметром `priorityClassName: middle`.

          {% endnote %}

          {% include notitle [YAML-файл](../../_includes/yamls/operations/quotas/quota-with-scope.md) %}

      {% endlist %}

1. Примените манифест: `kubectl apply -f resourcequota.yaml -n <название проекта>`. При необходимости можно прописать название проекта в параметр ресурса `metadata.namespace` и не использовать в команде.

## Через консоль управления

1. Если вы еще не открыли проект, выберите проект.
1. Перейдите на вкладку **Квоты** на странице с описанием проекта.
1. Нажмите **Добавить квоту**.
1. Введите название квоты.
1. Задайте значения для полей `limits.cpu` и `requests.cpu` или выберите другие ресурсы.
1. Чтобы применить квоту ко всему проекту, удалите текст из поля **Scope**. Иначе квота будет применена только к подам с параметром `priorityClassName: middle`. При желании можно не удалять текст, а поменять скоуп на необходимый для применения квоты.
1. Нажмите **Сохранить**.
