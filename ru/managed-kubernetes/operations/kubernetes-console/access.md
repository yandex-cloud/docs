---
title: Управление сервисными аккаунтами {{ k8s }} в {{ managed-k8s-full-name }}
description: Из статьи вы узнаете, как в {{ yandex-cloud }} создать и удалить сервисный аккаунт {{ k8s }} с помощью консоли управления без использования kubectl.
---

# Управление сервисными аккаунтами {{ k8s }}

Сервисные аккаунты {{ k8s }} — это учетные записи для приложений и процессов, работающих в подах. Консоль управления позволяет создавать и удалять сервисные аккаунты {{ k8s }} в {{ managed-k8s-name }} без использования kubectl.

## Создание сервисного аккаунта {#create-sa}

В консоли управления можно создавать сервисные аккаунты так же, как с помощью команды `kubectl create serviceaccount <имя_сервисного_аккаунта> -n <имя_пространства_имен>`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![Access](../../../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.k8s.cluster.switch_access }}**.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.common.create }}** и выберите **{{ ui-key.yacloud.k8s.access.button_create-sa }}**.
  1. В открывшемся окне введите **{{ ui-key.yacloud.k8s.access.popup-add-sa_field_name }}** сервисного аккаунта.
  1. В выпадающем списке выберите **{{ ui-key.yacloud.k8s.access.popup-add-sa_field_namespace }}**, в котором будет создан сервисный аккаунт.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

## Удаление сервисного аккаунта {#delete-sa}

Удаление сервисного аккаунта соответствует выполнению команды `kubectl delete serviceaccount <имя_сервисного_аккаунта> -n <имя_пространства_имен>`.

Чтобы удалить сервисный аккаунт:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![Access](../../../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.k8s.cluster.switch_access }}**.
  1. В строке сервисного аккаунта нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите действие.

{% endlist %}
