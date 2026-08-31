[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for Kubernetes](../../index.md) > [Пошаговые инструкции](../index.md) > Работа с объектами Kubernetes из консоли управления > Управление сервисными аккаунтами Kubernetes

# Управление сервисными аккаунтами Kubernetes

Сервисные аккаунты Kubernetes — это учетные записи для приложений и процессов, работающих в подах. Консоль управления позволяет создавать и удалять сервисные аккаунты Kubernetes в Managed Service for Kubernetes без использования kubectl.

## Создание сервисного аккаунта {#create-sa}

В консоли управления можно создавать сервисные аккаунты так же, как с помощью команды `kubectl create serviceaccount <имя_сервисного_аккаунта> -n <имя_пространства_имен>`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](https://console.yandex.cloud/link/managed-kubernetes) в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Выберите кластер Managed Service for Kubernetes.
  1. Перейдите на вкладку **Управление доступом**, затем **ServiceAccounts**.
  3. Нажмите кнопку **Создать сервисный аккаунт**.
  1. В открывшемся окне введите **Имя** сервисного аккаунта.
  1. В выпадающем списке выберите **Пространство имен**, в котором будет создан сервисный аккаунт.
  1. Нажмите кнопку **Добавить**.

{% endlist %}

## Удаление сервисного аккаунта {#delete-sa}

Удаление сервисного аккаунта соответствует выполнению команды `kubectl delete serviceaccount <имя_сервисного_аккаунта> -n <имя_пространства_имен>`.

Чтобы удалить сервисный аккаунт:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](https://console.yandex.cloud/link/managed-kubernetes) в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Выберите кластер Managed Service for Kubernetes.
  1. Перейдите на вкладку **Управление доступом**, затем **ServiceAccounts**.
  1. В строке сервисного аккаунта нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. Подтвердите действие.

{% endlist %}