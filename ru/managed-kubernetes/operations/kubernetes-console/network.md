---
title: Управление ресурсами Service и Ingress в {{ managed-k8s-full-name }}
description: Из статьи вы узнаете, как в {{ yandex-cloud }} управлять ресурсами Service и Ingress в {{ k8s }} с помощью консоли управления без использования kubectl.
---

# Управление ресурсами Service и Ingress

Ресурсы `Service` и `Ingress` в {{ k8s }} обеспечивают взаимодействие между подами и доступ к приложениям снаружи кластера. Консоль управления позволяет управлять этими ресурсами в {{ k8s }} без использования kubectl.

## Создание ресурса Service или Ingress {#create-service-ingress}

В консоли управления можно создавать ресурсы `Service` и `Ingress` так же, как с помощью команды `kubectl apply -f <файл_манифеста.yaml> -n <имя_пространства_имен>`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![Network](../../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.k8s.cluster.switch_network }}**.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.common.create }}** и выберите тип ресурса.
  1. В выпадающем списке выберите **{{ ui-key.yacloud.k8s.cluster.field_namespace }}**, в котором будет создан ресурс.
  1. Заполните файл манифеста в соответствии с документацией {{ k8s }}: [Service](https://kubernetes.io/docs/concepts/services-networking/service/), [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/).
  1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.button_create-resource }}**.

{% endlist %}

## Редактирование ресурса Service или Ingress {#edit-service-ingress}

В консоли управления можно редактировать манифесты ресурсов `Service` и `Ingress` в визуальном редакторе. Такой подход соответствует выполнению команды `kubectl apply -f <файл_манифеста.yaml>` и позволяет обновить конфигурацию ресурса без повторного создания.

Список полей, которые можно редактировать, зависит от типа объекта и доступен в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![Network](../../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.k8s.cluster.switch_network }}**.
  1. Выберите вкладку с типом ресурса, который нужно отредактировать.
  1. В строке ресурса нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Внесите изменения в файл манифеста в правой части экрана. Изменения будут выделены цветом.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

Если манифест корректен, изменения применятся. Если обновленный манифест содержит ошибку или изменяет поля, которые нельзя редактировать, появится сообщение об ошибке. Нажмите **{{ ui-key.yacloud.common.more }}**, чтобы узнать подробности.

## Удаление ресурса Service или Ingress {#delete-service-ingress}

Удаление ресурса `Service` или `Ingress` соответствует выполнению команды `kubectl delete -f <файл_манифеста.yaml>`.

Чтобы удалить ресурс `Service` или `Ingress`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![Network](../../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.k8s.cluster.switch_network }}**.
  1. Выберите вкладку с типом ресурса, который нужно удалить.
  1. В строке ресурса нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите действие.

{% endlist %}
