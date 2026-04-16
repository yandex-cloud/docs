---
title: Управление рабочими нагрузками в {{ managed-k8s-full-name }}
description: Из статьи вы узнаете, как в {{ yandex-cloud }} управлять рабочими нагрузками в {{ k8s }} с помощью консоли управления без использования kubectl.
---

# Управление рабочими нагрузками

Рабочая нагрузка (workload) — это приложение, которое работает в среде {{ k8s }}. Консоль управления позволяет управлять рабочими нагрузками в {{ k8s }} без использования kubectl.

## Создание рабочей нагрузки {#create-workload}

В консоли управления можно создавать рабочие нагрузки так же, как с помощью команды `kubectl apply -f <файл_манифеста.yaml> -n <имя_пространства_имен>`.

Чтобы создать рабочую нагрузку:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![PersonWorker](../../../_assets/console-icons/person-worker.svg) **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}**.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.common.create }}** и выберите тип рабочей нагрузки.
  1. В выпадающем списке выберите **{{ ui-key.yacloud.k8s.cluster.field_namespace }}**, в котором будет создана рабочая нагрузка.
  1. Заполните файл манифеста в соответствии с документацией Kubernetes: [под](https://kubernetes.io/docs/concepts/workloads/pods/), [контроллер Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/), [контроллер DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/), [контроллер StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/), [HPA](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/), [задача](https://kubernetes.io/docs/concepts/workloads/controllers/job/), [cron-задача](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/).
  1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.button_create-resource }}**.

{% endlist %}

## Редактирование рабочей нагрузки {#edit-workload}

В консоли управления можно редактировать манифесты рабочих нагрузок в визуальном редакторе. Такой подход соответствует выполнению команды `kubectl apply -f <файл_манифеста.yaml>` и позволяет обновить конфигурацию ресурса без повторного создания.

Список полей, которые можно редактировать, зависит от типа рабочей нагрузки и доступен в [документации Kubernetes](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/).

Чтобы редактировать рабочую нагрузку:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![PersonWorker](../../../_assets/console-icons/person-worker.svg) **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}**.
  1. Выберите вкладку с типом рабочей нагрузки, которую нужно отредактировать.
  1. В строке рабочей нагрузки нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Внесите изменения в файл манифеста в правой части экрана. Изменения будут выделены цветом.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

Если манифест корректен, изменения применятся. Если обновленный манифест содержит ошибку или изменяет поля, которые нельзя редактировать, появится сообщение об ошибке.

## Запустить или остановить cron-задачу {#cron-job}

В консоли управления можно запускать и останавливать cron-задачи так же, как с помощью команды `kubectl patch cronjob <имя_cron-задачи> -p '{"spec":{"suspend":<true-или-false>}}'`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![PersonWorker](../../../_assets/console-icons/person-worker.svg) **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.k8s.workloads.label_cron-jobs }}**.
  1. В строке cron-задачи нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.start }}** или **{{ ui-key.yacloud.common.stop }}**.
  1. Подтвердите действие.

{% endlist %}

## Удаление рабочей нагрузки {#delete-workload}

Удаление рабочей нагрузки соответствует выполнению команды `kubectl delete -f <файл_манифеста.yaml>`. При удалении контроллера все созданные им поды также будут удалены.

Чтобы удалить рабочую нагрузку:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![PersonWorker](../../../_assets/console-icons/person-worker.svg) **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}**.
  1. Выберите вкладку с типом рабочей нагрузки, которую нужно удалить.
  1. В строке рабочей нагрузки нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите действие.

{% endlist %}

### См. также {#see-also}

* [{#T}](../../concepts/index.md)
