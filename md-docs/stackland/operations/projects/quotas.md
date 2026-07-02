[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > [Проекты](index.md) > Создать квоту для проекта

# Создать квоту

После создания [проекта](create-project.md)) администратор может ограничить ресурсы с помощью [объекта](https://kubernetes.io/docs/concepts/policy/resource-quotas/) `ResourceQuota`.

## Через CLI

1. Создайте файл ресурса `ResourceQuota`. Например, с помощью команды `touch resourcequota.yaml`.
1. Откройте файл и вставьте конфигурацию ниже:

      {% list tabs %}

      - Квота без скоупа

          ```yaml
          apiVersion: v1
          kind: ResourceQuota
          metadata:
            name: example-quota
          spec:
            hard:
              requests.cpu: '2' # Запрашиваемые CPU (2 CPU)
              limits.cpu: '4'    # Ограничение на CPU (4 CPU)
              requests.memory: '1' # Запрашиваемая RAM (1 Гб)
              limits.memory: '10'   # Ограничение на RAM (10 Гб)
              requests.nvidia.com/gpu: 1 # Запрашиваемые видеокарты (1 видеокарта)
          ```

      - Квота со скоупом

          {% note info %}

          Квота будет применена только к подам с параметром `priorityClassName: middle`.

          {% endnote %}

          ```yaml
          apiVersion: v1
          kind: ResourceQuota
          metadata:
            name: priority-class-quota
          spec:
            hard:
              limits.cpu: '10' # Ограничение на CPU (10 CPU)
              limits.memory: '20' # Ограничение на RAM (20 Гб)
              requests.cpu: '5' # Запрашиваемые CPU (5 CPU)
              requests.memory: '10' # Запрашиваемая RAM (10 Гб)
            scopeSelector:
              matchExpressions:
                - scopeName: PriorityClass
                  operator: In
                  values:
                    - middle
          ```

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