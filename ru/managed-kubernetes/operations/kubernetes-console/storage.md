---
title: Управление хранилищами в {{ managed-k8s-full-name }}
description: Из статьи вы узнаете, как в {{ yandex-cloud }} управлять хранилищами в {{ k8s }} с помощью консоли управления без использования kubectl.
---

# Управление хранилищами

Хранилища в {{ k8s }} предоставляют контейнерам в поде общую файловую систему для хранения и обмена данными. Консоль управления позволяет управлять хранением в {{ k8s }} без использования kubectl.

## Создание ресурса хранилища {#create-storage}

В консоли управления можно создавать ресурсы хранилищ так же, как с помощью команды `kubectl apply -f <файл_манифеста.yaml> -n <имя_пространства_имен>`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![Storage](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.k8s.cluster.switch_storage }}**.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.common.create }}** и выберите тип ресурса.
  1. В выпадающем списке выберите **{{ ui-key.yacloud.k8s.cluster.field_namespace }}**, в котором будет создан ресурс.
  1. Заполните файл манифеста в соответствии с документацией Kubernetes: [Persistent Volume Claim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims), [Persistent Volume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/), [класс хранилища](https://kubernetes.io/docs/concepts/storage/storage-classes/).
  1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.button_create-resource }}**.

{% endlist %}

## Редактирование ресурса хранилища {#edit-storage}

В консоли управления можно редактировать манифесты ресурсов хранилищ в визуальном редакторе. Такой подход соответствует выполнению команды `kubectl apply -f <файл_манифеста.yaml>` и позволяет обновить конфигурацию ресурса без повторного создания.

Список полей, которые можно редактировать, зависит от типа объекта и доступен в [документации Kubernetes](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![Storage](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.k8s.cluster.switch_storage }}**.
  1. Выберите вкладку с типом ресурса, который нужно отредактировать.
  1. В строке ресурса нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Внесите изменения в файл манифеста в правой части экрана. Изменения будут выделены цветом.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

Если манифест корректен, изменения применятся. Если обновленный манифест содержит ошибку или изменяет поля, которые нельзя редактировать, появится сообщение об ошибке. Нажмите **{{ ui-key.yacloud.common.more }}**, чтобы узнать подробности.

## Установить или снять класс хранилища по умолчанию {#default-storage-class}

Класс хранилища по умолчанию используется при создании Persistent Volume Claim, если в его манифесте не указан `spec.storageClassName`. Несколько классов хранилищ можно назначить классами по умолчанию одновременно. В этом случае при создании Persistent Volume Claim используется последний созданный класс хранилища.

Такой подход соответствует выполнению команды `kubectl patch storageclass <имя_класса_хранилища> -p '{"metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"<true-или-false>"}}}'`.

Чтобы установить или снять класс хранилища по умолчанию:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![Storage](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.k8s.cluster.switch_storage }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.k8s.storage.label_storage-classes }}**.
  1. В строке класса хранилища нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.k8s.storage.button_action-add-default }}** или **{{ ui-key.yacloud.k8s.storage.button_action-remove-default }}**.
  1. Подтвердите действие.

{% endlist %}

## Удаление ресурса хранилища {#delete-storage}

Удаление ресурса хранилища соответствует выполнению команды `kubectl delete -f <файл_манифеста.yaml>`.

Чтобы удалить ресурс хранилища:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![Storage](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.k8s.cluster.switch_storage }}**.
  1. Выберите вкладку с типом ресурса, который нужно удалить.
  1. В строке ресурса нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите действие.

{% endlist %}
