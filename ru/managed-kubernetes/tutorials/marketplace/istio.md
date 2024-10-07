# Использование Istio


[Istio](https://istio.io/latest/about/service-mesh/) предназначен для организации _service mesh_ — инфраструктурного уровня с низкой задержкой, который нужен для обработки большого объема сетевых коммуникаций между сервисами в кластере {{ managed-k8s-name }}.

Чтобы посмотреть варианты использования Istio:

1. [{#T}](#istio-install).
1. [{#T}](#test-application).
1. [{#T}](#visualization-service-network).
1. [{#T}](#request-routing).
1. [{#T}](#injection-failures).
1. [{#T}](#traffic-redistribution).
1. [{#T}](#mutual-tls).
1. [{#T}](#viewing-metrics-prometheus).
1. [{#T}](#viewing-metrics-grafana).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. Создайте кластер и [группу узлов](../../../managed-kubernetes/concepts/index.md#node-group) {{ k8s }}.

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. Если у вас еще нет [сети](../../../vpc/concepts/network.md#network), [создайте ее](../../../vpc/operations/network-create.md).
        1. Если у вас еще нет [подсетей](../../../vpc/concepts/network.md#subnet), [создайте их](../../../vpc/operations/subnet-create.md) в [зонах доступности](../../../overview/concepts/geo-scope.md), где будут созданы кластер {{ k8s }} и группа узлов.
        1. [Создайте сервисные аккаунты](../../../iam/operations/sa/create.md):

            * Сервисный аккаунт с [ролями](../../security/index.md#yc-api) `k8s.clusters.agent` и `vpc.publicAdmin` на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается кластер {{ k8s }}. От его имени будут создаваться ресурсы, необходимые кластеру {{ k8s }}.
            * Сервисный аккаунт с [ролью](../../../iam/concepts/access-control/roles.md) [{{ roles-cr-puller }}](../../../container-registry/security/index.md#container-registry-images-puller). От его имени узлы будут скачивать из [реестра](../../../container-registry/concepts/registry.md) необходимые [Docker-образы](../../../container-registry/concepts/docker-image.md).

            {% note tip %}

            Вы можете использовать один и тот же [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для управления кластером {{ k8s }} и его группами узлов.

            {% endnote %}

        1. {% include [configure-sg-manual](../../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

            {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

        1. [Создайте кластер {{ k8s }}](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../../managed-kubernetes/operations/node-group/node-group-create.md) с оперативной памятью не менее 6 ГБ и с группами безопасности, созданными ранее.

    - {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

        1. Скачайте в ту же рабочую директорию файл конфигурации кластера [k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-infrastructure/blob/main/k8s-cluster.tf). В файле описаны:

            * [Сеть](../../../vpc/concepts/network.md#network).
            * [Подсеть](../../../vpc/concepts/network.md#subnet).
            * Кластер {{ k8s }}.
            * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), необходимый для работы кластера и группы узлов {{ managed-k8s-name }}.
            * {% include [configure-sg-terraform](../../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

                {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

        1. Укажите в файле `k8s-cluster.tf`:

            * [Идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
            * Версию {{ k8s }} для кластера и групп узлов {{ k8s }}.
            * Оперативную память для группы узлов не менее 6 ГБ. Значение должно быть кратно количеству vCPU.
            * CIDR кластера {{ k8s }}.
            * Имя сервисного аккаунта кластера {{ managed-k8s-name }}.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

## Установите Istio {#istio-install}

1. [Установите](../../operations/applications/istio.md#marketplace-install) продукт [Istio](/marketplace/products/yc/istio) из каталога приложений {{ marketplace-full-name }}. При установке приложения:

    1. Создайте новое [пространство имен](../../concepts/index.md#namespace) `istio-system`.
    1. Установите дополнения для Istio (Kiali, Prometheus, Grafana, Loki, Jaeger).

1. Убедитесь, что все [поды](../../concepts/index.md#pod) Istio и его дополнений перешли в статус `Running`:

    ```bash
    kubectl get pods -n istio-system
    ```

    Результат:

    ```text
    NAME                                    READY   STATUS    RESTARTS   AGE
    grafana-75c6d4fcf7-v4sfp                1/1     Running   0          2h
    istio-ingressgateway-6496999d57-hdbnf   1/1     Running   0          2h
    istiod-665dbb97c9-s6xxk                 1/1     Running   0          2h
    jaeger-5468d9c886-x2bq8                 1/1     Running   0          2h
    kiali-6854cc8574-26t65                  1/1     Running   0          2h
    loki-0                                  1/1     Running   0          2h
    prometheus-54f86f6676-vmqqr             2/2     Running   0          2h
    ```

## Установите тестовое приложение {#test-application}

1. Создайте новое пространство имен `todoapp`:

    ```bash
    kubectl create namespace todoapp
    ```

1. Добавьте пространству имен `todoapp` метку `istio-injection`:

    ```bash
    kubectl label namespace todoapp istio-injection=enabled
    ```

1. Установите тестовое приложение `todoapp`:

    ```bash
    kubectl apply -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/todoapp.yaml -n todoapp
    ```

    Результат:

    ```text
    deployment.apps/todoapp-v1 created
    deployment.apps/todoapp-v2 created
    deployment.apps/recommender-v1 created
    deployment.apps/todoapp-redis-v1 created
    service/todoapp created
    service/recommender created
    service/todoapp-redis created
    ```

1. Проверьте состояние подов:

    ```bash
    kubectl get pods -n todoapp
    ```

    Результат:

    ```text
    NAME                                READY   STATUS    RESTARTS   AGE
    recommender-v1-7865c4cfbb-hsp2k     2/2     Running   0          60s
    recommender-v1-7865c4cfbb-vqt68     2/2     Running   0          59s
    todoapp-redis-v1-dbdf4d44-48952     2/2     Running   0          59s
    todoapp-v1-6d4b78b6c9-gfkxd         2/2     Running   0          60s
    todoapp-v1-6d4b78b6c9-jc962         2/2     Running   0          60s
    todoapp-v2-7dd69b445f-2rznm         2/2     Running   0          60s
    todoapp-v2-7dd69b445f-gr4vn         2/2     Running   0          60s
    ```

    Убедитесь, что все поды перешли в статус `Running` и `READY=2/2`.

1. Проверьте состояние сервисов:

    ```bash
    kubectl get services -n todoapp
    ```

    Результат:

    ```text
    NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
    recommender     ClusterIP   10.96.255.93    <none>        80/TCP     80s
    todoapp         ClusterIP   10.96.232.143   <none>        80/TCP     80s
    todoapp-redis   ClusterIP   10.96.174.100   <none>        6379/TCP   80s
    ```

1. Проверьте, что веб-приложение работает:

    ```bash
    kubectl exec "$(kubectl get pod -l app=recommender -n todoapp -o jsonpath='{.items[0].metadata.name}')" -n todoapp \
       -- curl --silent --show-error todoapp:80 | grep -o "<title>.*</title>"
    ```

    Результат:

    ```text
    <title>Тудуапп</title>
    ```

1. Опубликуйте приложение:

    ```bash
    kubectl apply -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/todoapp-gateway.yaml -n todoapp
    ```

    Результат:

    ```text
    gateway.networking.istio.io/todoapp-gateway created
    virtualservice.networking.istio.io/todoapp-vs created
    ```

1. Получите IP-адрес Ingress-шлюза для доступа к приложению:

    ```bash
    kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
    ```

1. Чтобы запустить веб-приложение, вставьте в адресную строку браузера полученный IP-адрес.

    {% include [Настройка групп безопасности при недоступности ресурса](../../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

    При обновлении страницы ее содержимое будет меняться. В зависимости от версии пода, который обслуживает ваш запрос, вы увидите:

    * версия пода `v1` — блок со списком дел;
    * версия пода `v2` — блок со списком дел и блок с рекомендациями.

## Посмотрите схему сервисной сети на дашборде Kiali {#visualization-service-network}

1. Убедитесь, что сервис `kiali` установлен и доступен в кластере {{ managed-k8s-name }}:

    ```bash
    kubectl get service kiali -n istio-system
    ```

    Результат:

    ```text
    NAME    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)              AGE
    kiali   ClusterIP   10.96.207.108   <none>        20001/TCP,9090/TCP   15d
    ```

1. Настройте переадресацию порта сервиса `kiali` на локальный компьютер:

    ```bash
    kubectl port-forward service/kiali 8080:20001 -n istio-system
    ```

1. Чтобы открыть дашборд Kiali, вставьте в адресную строку браузера `http://localhost:8080`.

    Дашборд Kiali содержит различную информацию, например: схему сервисной сети, конфигурацию Istio, конфигурацию сервисов и их состояние, метрики, трейсы и логи из подов.

1. Чтобы сгенерировать трафик к [тестовому приложению](#test-application), поработайте с ним. Например, добавьте список дел.

1. На дашборде Kiali перейдите в раздел **Graph** и выберите пространство имен **todoapp**. На схеме вы увидите компоненты тестового приложения, работающие в сервисной сети Istio.

    {% note tip %}

    Используйте дашборд Kiali, чтобы отслеживать изменения в следующих пунктах этого руководства. Например, вы можете увидеть, как меняется отображение сервисов или распределение трафика.

    {% endnote %}

## Маршрутизируйте запросы {#request-routing}

Поды сервиса `todoapp` развернуты в версиях `v1` и `v2` параллельно. При обновлении страницы [тестового приложения](#test-application) панель с рекомендациями отображается не всегда, т. к. только поды `todoapp` версии `v2` делают запрос к сервису рекомендаций и отображают результат.

С помощью маршрутизации направьте пользователей к конкретной версии сервиса:

1. Направьте все запросы к версии `v1`:

    ```bash
    kubectl apply -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/virtualservice-route-v1.yaml -n todoapp
    ```

    Результат:

    ```text
    destinationrule.networking.istio.io/todoapp-dr created
    virtualservice.networking.istio.io/todoapp-vs configured
    ```

1. Обновите страницу тестового приложения несколько раз. Теперь все запросы обрабатываются подами версии `v1`. На странице отображается только блок со списком дел.

1. Направьте все запросы к версии `v2`:

    ```bash
    kubectl apply -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/virtualservice-route-v2.yaml -n todoapp
    ```

    Результат:

    ```text
    destinationrule.networking.istio.io/todoapp-dr unchanged
    virtualservice.networking.istio.io/todoapp-vs configured
    ```

1. Обновите страницу тестового приложения несколько раз. Теперь все запросы обрабатываются подами версии `v2`. На странице отображаются блок со списком дел и блок с рекомендациями.

Чтобы отменить маршрутизацию, выполните команду:

```bash
kubectl apply -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/todoapp-gateway.yaml -n todoapp
```

Результат:

```text
gateway.networking.istio.io/todoapp-gateway unchanged
virtualservice.networking.istio.io/todoapp-vs configured
```

## Внедрите сбой в работу сервиса {#injection-failures}

Istio позволяет тестировать надежность приложения с помощью внедрения сбоев в работу сервисов.
Обращения к сервису `recommender` имеют тайм-аут в три секунды. Если за это время сервис не отвечает, блок с рекомендациями не отображается.

Смоделировать сбой можно, указав в конфигурации ресурса `VirtualService` задержку более трех секунд. Например, этот блок реализует 50% вероятность возникновения задержки в пять секунд:

```yaml
fault:
  delay:
    percentage:
      value: 50.0
    fixedDelay: 5s
```

Чтобы внедрить сбой в [тестовое приложение](#test-application):

1. Примените конфигурацию `VirtualService`:

    ```bash
    kubectl apply -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/virtualservice-delay.yaml -n todoapp
    ```

    Результат:

    ```text
    destinationrule.networking.istio.io/recommender-dr created
    virtualservice.networking.istio.io/recommender-vs created
    ```

1. Обновите страницу тестового приложения несколько раз. Когда возникает задержка в ответе, блок с рекомендациями не отображается, хотя запрос обрабатывается подом версии `v2`. Приложение корректно обрабатывает сбой сервиса `recommender`.

Чтобы откатить конфигурацию `VirtualService`, выполните команду:

```bash
kubectl delete -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/virtualservice-delay.yaml -n todoapp
```

Результат:

```text
destinationrule.networking.istio.io "recommender-dr" deleted
virtualservice.networking.istio.io "recommender-vs" deleted
```

## Перераспределите трафик {#traffic-redistribution}

При обновлении версии микросервиса вы можете перераспределить трафик с одной версии микросервиса на другую, не влияя на количество подов приложений. Управлять маршрутами можно с помощью параметра `weight` для ресурса `VirtualService`.

Чтобы перераспределить трафик в [тестовом приложении](#test-application):

1. Установите вес 50% для версий `v1` и `v2`:

    ```bash
    kubectl apply -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/virtualservice-weight-v2-50.yaml -n todoapp
    ```

    Результат:

    ```text
    destinationrule.networking.istio.io/todoapp-dr unchanged
    virtualservice.networking.istio.io/todoapp-vs configured
    ```

1. Обновите страницу тестового приложения несколько раз. Приложение обрабатывается версиями подов `v1` и `v2` примерно в равной пропорции.

1. Увеличьте вес до 100% для версии `v2`:

    ```bash
    kubectl apply -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/virtualservice-weight-v2-100.yaml -n todoapp
    ```

    Результат:

    ```text
    destinationrule.networking.istio.io/todoapp-dr unchanged
    virtualservice.networking.istio.io/todoapp-vs configured
    ```

1. Обновите страницу тестового приложения несколько раз. Приложение обрабатывается только подами версии `v2`.

## Установите режим аутентификации с помощью mutual TLS {#mutual-tls}

Приложения с сайдкарами-прокси Istio по умолчанию обмениваются между собой трафиком с mutual TLS шифрованием.

Вы можете настроить политику со строгим режимом аутентификации, запретив незашифрованный трафик от приложений без сайдкаров-прокси Istio.

Чтобы проверить работу [тестового приложения](#test-application) в разных режимах:

1. Создайте политику аутентификации:

    ```bash
    kubectl apply -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/peerauthentication.yaml -n todoapp
    ```

    Результат:

    ```text
    peerauthentication.security.istio.io/default created
    ```

1. Попробуйте создать под в пространстве имен `default`, чтобы проверить соединение с сервисом `todoapp`:

    ```bash
    kubectl run -i -n default \
       --rm \
       --restart=Never curl \
       --image=curlimages/curl \
       --command \
       -- sh -c 'curl --insecure http://todoapp.todoapp.svc.cluster.local'
    ```

    Результат:

    ```text
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
      0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
    curl: (56) Recv failure: Connection reset by peer
    pod "curl" deleted
    pod default/curl terminated (Error)
    ```

1. Удалите политику аутентификации:

    ```bash
    kubectl delete -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/peerauthentication.yaml -n todoapp
    ```

    Результат:

    ```text
    peerauthentication.security.istio.io "default" deleted
    ```

1. Попробуйте снова создать под:

    ```bash
    kubectl run -i -n default \
       --rm \
       --restart=Never curl \
       --image=curlimages/curl \
       --command \
       -- sh -c 'curl --insecure http://todoapp.todoapp.svc.cluster.local'
    ```

    Результат:

    ```text
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    100  2658  100  2658    0     0   147k      0 --:--:-- --:--:-- --:--:--  152k
    <!DOCTYPE html>
    <html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Тудуапп</title>
    ...
    ```

## Посмотрите метрики Istio на дашборде Prometheus {#viewing-metrics-prometheus}

1. Убедитесь, что сервис `prometheus` установлен и доступен в кластере {{ managed-k8s-name }}:

    ```bash
    kubectl get service prometheus -n istio-system
    ```

    Результат:

    ```text
    NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
    prometheus   ClusterIP   10.96.147.249   <none>        9090/TCP   15d
    ```

1. Настройте переадресацию порта сервиса `prometheus` на локальный компьютер:

    ```bash
    kubectl port-forward service/prometheus 9090:9090 -n istio-system
    ```

1. Чтобы открыть дашборд Prometheus, вставьте в адресную строку браузера `http://localhost:9090`.

1. Введите в поле **Expression** запрос:

    ```bash
    istio_requests_total{destination_service="recommender.todoapp.svc.cluster.local"}
    ```

1. Перейдите на вкладку **Graph**. Она показывает метрики Istio.

## Посмотрите метрики Istio на дашборде Grafana {#viewing-metrics-grafana}

1. Убедитесь, что сервис `grafana` установлен и доступен в кластере {{ managed-k8s-name }}:

    ```bash
    kubectl get service grafana -n istio-system
    ```

    Результат:

    ```text
    NAME      TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
    grafana   ClusterIP   10.96.205.86   <none>        3000/TCP   15d
    ```

1. Настройте переадресацию порта сервиса `grafana` на локальный компьютер:

    ```bash
    kubectl port-forward service/grafana 3000:3000 -n istio-system
    ```

1. Чтобы открыть дашборд Grafana, вставьте в адресную строку браузера `http://localhost:3000`.

1. В списке дашбордов найдите и откройте **Istio Mesh Dashboard**. Он показывает метрики запросов к сервисам тестового приложения.

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите кластер {{ k8s }}](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
    1. [Удалите созданные подсети](../../../vpc/operations/subnet-delete.md) и [сети](../../../vpc/operations/network-delete.md).
    1. [Удалите созданные сервисные аккаунты](../../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

    1. В командной строке перейдите в директорию, в которой расположен актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
    1. Удалите конфигурационный файл `k8s-cluster.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `k8s-cluster.tf`, будут удалены.

{% endlist %}
