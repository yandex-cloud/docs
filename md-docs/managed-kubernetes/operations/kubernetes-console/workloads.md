[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for Kubernetes](../../index.md) > [Пошаговые инструкции](../index.md) > Работа с объектами Kubernetes из консоли управления > Управление рабочими нагрузками

# Управление рабочими нагрузками

Рабочая нагрузка (workload) — это приложение, которое работает в среде Kubernetes. Консоль управления позволяет управлять рабочими нагрузками в Kubernetes без использования kubectl.

## Создание рабочей нагрузки {#create-workload}

В консоли управления можно создавать рабочие нагрузки так же, как с помощью команды `kubectl apply -f <файл_манифеста.yaml> -n <имя_пространства_имен>`.

Чтобы создать рабочую нагрузку:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](https://console.yandex.cloud/link/managed-kubernetes) в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Выберите кластер Managed Service for Kubernetes и перейдите на вкладку **Рабочая нагрузка**.
  1. Перейдите на вкладку с типом рабочей нагрузки, которую нужно создать:

      * **Pods**;
      * **Deployments**;
      * **DaemonSets**;
      * **StatefulSets**;
      * **HPA**;
      * **Jobs**;
      * **CronJobs**.
  1. Нажмите кнопку создания выбранной рабочей нагрузки.
  1. В выпадающем списке выберите **Пространство имён**, в котором будет создана рабочая нагрузка.
  1. Заполните файл манифеста в соответствии с документацией Kubernetes: [под](https://kubernetes.io/docs/concepts/workloads/pods/), [контроллер Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/), [контроллер DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/), [контроллер StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/), [HPA](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/), [задача](https://kubernetes.io/docs/concepts/workloads/controllers/job/), [cron-задача](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/).
  1. Нажмите кнопку **Создать**.

{% endlist %}

## Редактирование рабочей нагрузки {#edit-workload}

В консоли управления можно редактировать манифесты рабочих нагрузок в визуальном редакторе. Такой подход соответствует выполнению команды `kubectl apply -f <файл_манифеста.yaml>` и позволяет обновить конфигурацию ресурса без повторного создания.

Список полей, которые можно редактировать, зависит от типа рабочей нагрузки и доступен в [документации Kubernetes](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/).

Чтобы редактировать рабочую нагрузку:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](https://console.yandex.cloud/link/managed-kubernetes) в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Выберите кластер Managed Service for Kubernetes и перейдите на вкладку **Рабочая нагрузка**.
  1. Перейдите на вкладку с типом рабочей нагрузки, которую нужно отредактировать:

      * **Pods**;
      * **Deployments**;
      * **DaemonSets**;
      * **StatefulSets**;
      * **HPA**;
      * **Jobs**;
      * **CronJobs**.
  1. В строке рабочей нагрузки нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. Внесите изменения в файл манифеста в правой части экрана. Изменения будут выделены цветом.
  1. В правом верхнем углу нажмите кнопку **Сохранить**.

{% endlist %}

Если манифест корректен, изменения применятся. Если обновленный манифест содержит ошибку или изменяет поля, которые нельзя редактировать, появится сообщение об ошибке.

## Запустить или остановить cron-задачу {#cron-job}

В консоли управления можно запускать и останавливать cron-задачи так же, как с помощью команды `kubectl patch cronjob <имя_cron-задачи> -p '{"spec":{"suspend":<true-или-false>}}'`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](https://console.yandex.cloud/link/managed-kubernetes) в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Выберите кластер Managed Service for Kubernetes и перейдите на вкладку **Рабочая нагрузка**.
  1. Перейдите на вкладку **CronJobs**.
  1. В строке cron-задачи нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите **Запустить** или **Остановить**.
  1. Подтвердите действие.

{% endlist %}

## Удаление рабочей нагрузки {#delete-workload}

Удаление рабочей нагрузки соответствует выполнению команды `kubectl delete -f <файл_манифеста.yaml>`. При удалении контроллера все созданные им поды также будут удалены.

Чтобы удалить рабочую нагрузку:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](https://console.yandex.cloud/link/managed-kubernetes) в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Выберите кластер Managed Service for Kubernetes и перейдите на вкладку **Рабочая нагрузка**.
  1. Перейдите на вкладку с типом рабочей нагрузки, которую нужно удалить:

      * **Pods**;
      * **Deployments**;
      * **DaemonSets**;
      * **StatefulSets**;
      * **HPA**;
      * **Jobs**;
      * **CronJobs**.
  1. В строке рабочей нагрузки нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. Подтвердите действие.

{% endlist %}

#### Полезные ссылки {#see-also}

[Взаимосвязь ресурсов в Managed Service for Kubernetes](../../concepts/index.md)