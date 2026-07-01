# Управление ресурсами Service и Ingress

Ресурсы `Service` и `Ingress` в Kubernetes обеспечивают взаимодействие между подами и доступ к приложениям снаружи кластера. Консоль управления позволяет управлять этими ресурсами в Kubernetes без использования kubectl.

{% note info %}

Для просмотра ресурсов кластера в разделе Ingresses нужна [роль](../../../application-load-balancer/security/index.md#alb-auditor) `alb.auditor` или выше.

{% endnote %}

## Создание ресурса Service или Ingress {#create-service-ingress}

В консоли управления можно создавать ресурсы `Service` и `Ingress` так же, как с помощью команды `kubectl apply -f <файл_манифеста.yaml> -n <имя_пространства_имен>`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![Network](../../../_assets/console-icons/timestamps.svg) **Сервисы и Ingress**.
  1. В правом верхнем углу нажмите кнопку **Создать** и выберите тип ресурса.
  1. В выпадающем списке выберите **Пространство имён**, в котором будет создан ресурс.
  1. Заполните файл манифеста в соответствии с документацией Kubernetes: [Service](https://kubernetes.io/docs/concepts/services-networking/service/), [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/).
  1. Нажмите кнопку **Создать**.

{% endlist %}

## Редактирование ресурса Service или Ingress {#edit-service-ingress}

В консоли управления можно редактировать манифесты ресурсов `Service` и `Ingress` в визуальном редакторе. Такой подход соответствует выполнению команды `kubectl apply -f <файл_манифеста.yaml>` и позволяет обновить конфигурацию ресурса без повторного создания.

Список полей, которые можно редактировать, зависит от типа объекта и доступен в [документации Kubernetes](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![Network](../../../_assets/console-icons/timestamps.svg) **Сервисы и Ingress**.
  1. Выберите вкладку с типом ресурса, который нужно отредактировать.
  1. В строке ресурса нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. Внесите изменения в файл манифеста в правой части экрана. Изменения будут выделены цветом.
  1. В правом верхнем углу нажмите кнопку **Сохранить**.

{% endlist %}

Если манифест корректен, изменения применятся. Если обновленный манифест содержит ошибку или изменяет поля, которые нельзя редактировать, появится сообщение об ошибке. Нажмите **Подробнее**, чтобы узнать подробности.

## Удаление ресурса Service или Ingress {#delete-service-ingress}

Удаление ресурса `Service` или `Ingress` соответствует выполнению команды `kubectl delete -f <файл_манифеста.yaml>`.

Чтобы удалить ресурс `Service` или `Ingress`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога и выберите сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![Network](../../../_assets/console-icons/timestamps.svg) **Сервисы и Ingress**.
  1. Выберите вкладку с типом ресурса, который нужно удалить.
  1. В строке ресурса нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
  1. Подтвердите действие.

{% endlist %}