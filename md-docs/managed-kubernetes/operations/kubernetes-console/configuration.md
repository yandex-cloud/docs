[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for Kubernetes](../../index.md) > [Пошаговые инструкции](../index.md) > Работа с объектами Kubernetes из консоли управления > Управление ресурсами ConfigMap и Secret

# Управление ресурсами ConfigMap и Secret

Ресурсы `ConfigMap` и `Secret` в Kubernetes позволяют хранить и передавать данные для настройки подов. Консоль управления позволяет управлять этими ресурсами в Managed Service for Kubernetes без использования kubectl.

## Создание ресурса ConfigMap или Secret {#create-configmap-secret}

В консоли управления можно создавать ресурсы `ConfigMap` и `Secret` так же, как с помощью команды `kubectl apply -f <файл_манифеста.yaml> -n <имя_пространства_имен>`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![Configuration](../../../_assets/console-icons/gear.svg) **ConfigMap и секреты**.
  1. В правом верхнем углу нажмите кнопку **Создать** и выберите тип ресурса.
  1. В выпадающем списке выберите **Пространство имён**, в котором будет создан ресурс.
  1. Заполните файл манифеста в соответствии с документацией Kubernetes: [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/), [Secret](https://kubernetes.io/docs/concepts/configuration/secret/).
  1. Нажмите кнопку **Создать**.

{% endlist %}

## Редактирование ресурса ConfigMap или Secret {#edit-configmap-secret}

В консоли управления можно редактировать манифесты ресурсов `ConfigMap` и `Secret` в визуальном редакторе. Такой подход соответствует выполнению команды `kubectl apply -f <файл_манифеста.yaml>` и позволяет обновить конфигурацию ресурса без повторного создания.

Список полей, которые можно редактировать, зависит от типа объекта и доступен в [документации Kubernetes](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![Configuration](../../../_assets/console-icons/gear.svg) **ConfigMap и секреты**.
  1. Выберите вкладку с типом ресурса, который нужно отредактировать.
  1. В строке ресурса нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. Внесите изменения в файл манифеста в правой части экрана. Изменения будут выделены цветом.
  1. В правом верхнем углу нажмите кнопку **Сохранить**.

{% endlist %}

Если манифест корректен, изменения применятся. Если обновленный манифест содержит ошибку или изменяет поля, которые нельзя редактировать, появится сообщение об ошибке. Нажмите **Подробнее**, чтобы узнать подробности.

## Удаление ресурса ConfigMap или Secret {#delete-configmap-secret}

Удаление ресурса `ConfigMap` или `Secret` соответствует выполнению команды `kubectl delete -f <файл_манифеста.yaml>`.

Чтобы удалить ресурс `ConfigMap` или `Secret`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![Configuration](../../../_assets/console-icons/gear.svg) **ConfigMap и секреты**.
  1. Выберите вкладку с типом ресурса, который нужно удалить.
  1. В строке ресурса нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
  1. Подтвердите действие.

{% endlist %}