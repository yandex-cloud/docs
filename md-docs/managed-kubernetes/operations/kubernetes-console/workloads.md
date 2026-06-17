# Управление рабочими нагрузками

Рабочая нагрузка (workload) — это приложение, которое работает в среде Kubernetes. Консоль управления позволяет управлять рабочими нагрузками в Kubernetes без использования kubectl.

## Создание рабочей нагрузки {#create-workload}

В консоли управления можно создавать рабочие нагрузки так же, как с помощью команды `kubectl apply -f <файл_манифеста.yaml> -n <имя_пространства_имен>`.

Чтобы создать рабочую нагрузку:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![PersonWorker](../../../_assets/console-icons/person-worker.svg) **Рабочая нагрузка**.
  1. В правом верхнем углу нажмите кнопку **Создать** и выберите тип рабочей нагрузки.
  1. В выпадающем списке выберите **Пространство имен**, в котором будет создана рабочая нагрузка.
  1. Заполните файл манифеста в соответствии с документацией Kubernetes: [под](https://kubernetes.io/docs/concepts/workloads/pods/), [контроллер Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/), [контроллер DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/), [контроллер StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/), [HPA](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/), [задача](https://kubernetes.io/docs/concepts/workloads/controllers/job/), [cron-задача](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/).
  1. Нажмите кнопку **Создать**.

{% endlist %}

## Редактирование рабочей нагрузки {#edit-workload}

В консоли управления можно редактировать манифесты рабочих нагрузок в визуальном редакторе. Такой подход соответствует выполнению команды `kubectl apply -f <файл_манифеста.yaml>` и позволяет обновить конфигурацию ресурса без повторного создания.

Список полей, которые можно редактировать, зависит от типа рабочей нагрузки и доступен в [документации Kubernetes](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/).

Чтобы редактировать рабочую нагрузку:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![PersonWorker](../../../_assets/console-icons/person-worker.svg) **Рабочая нагрузка**.
  1. Выберите вкладку с типом рабочей нагрузки, которую нужно отредактировать.
  1. В строке рабочей нагрузки нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. Внесите изменения в файл манифеста в правой части экрана. Изменения будут выделены цветом.
  1. В правом верхнем углу нажмите кнопку **Сохранить**.

{% endlist %}

Если манифест корректен, изменения применятся. Если обновленный манифест содержит ошибку или изменяет поля, которые нельзя редактировать, появится сообщение об ошибке.

## Запустить или остановить cron-задачу {#cron-job}

В консоли управления можно запускать и останавливать cron-задачи так же, как с помощью команды `kubectl patch cronjob <имя_cron-задачи> -p '{"spec":{"suspend":<true-или-false>}}'`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![PersonWorker](../../../_assets/console-icons/person-worker.svg) **Рабочая нагрузка**.
  1. Выберите вкладку **Cron-задачи**.
  1. В строке cron-задачи нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Запустить** или **Остановить**.
  1. Подтвердите действие.

{% endlist %}

## Удаление рабочей нагрузки {#delete-workload}

Удаление рабочей нагрузки соответствует выполнению команды `kubectl delete -f <файл_манифеста.yaml>`. При удалении контроллера все созданные им поды также будут удалены.

Чтобы удалить рабочую нагрузку:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![PersonWorker](../../../_assets/console-icons/person-worker.svg) **Рабочая нагрузка**.
  1. Выберите вкладку с типом рабочей нагрузки, которую нужно удалить.
  1. В строке рабочей нагрузки нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
  1. Подтвердите действие.

{% endlist %}

### Полезные ссылки {#see-also}

* [Взаимосвязь ресурсов в Managed Service for Kubernetes](../../concepts/index.md)