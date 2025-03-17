1. [Установите Ingress-контроллер {{ alb-full-name }}](../../../managed-kubernetes/operations/applications/alb-ingress-controller.md).

1. Создайте ресурс [IngressClass](../../../application-load-balancer/k8s-ref/ingress-class.md) для Ingress-контроллера L7-балансировщика:

    1. Создайте YAML-файл, в котором опишите ресурс `IngressClass`.

        Пример ресурса `IngressClass`:

        ```yaml
        apiVersion: networking.k8s.io/v1
        kind: IngressClass
        metadata:
          labels:
            app.kubernetes.io/component: controller
          name: ingress-alb
        spec:
          controller: ingress.alb.yc.io/yc-alb-ingress-controller
        ```

    1. Создайте ресурс `IngressClass` с помощью команды:

        ```bash
        kubectl apply -f <файл_с_ресурсом_IngressClass>
        ```

1. Создайте ресурс `Ingress`:

    1. Ознакомьтесь с описанием [полей и аннотаций ресурса `Ingress`](../../../managed-kubernetes/alb-ref/ingress.md) и [примером](../../../managed-kubernetes/tutorials/alb-ingress-controller.md#create-ingress-and-apps).

    1. Создайте YAML-файл, в котором опишите ресурс `Ingress`:

        * Заполните раздел [annotations](../../../managed-kubernetes/alb-ref/ingress.md#annotations) для настроек L7-балансировщика:

            * `ingress.alb.yc.io/subnets` — идентификаторы подсетей в трех зонах доступности для узлов L7-балансировщика. Идентификаторы перечисляются через запятую без пробелов.
            * `ingress.alb.yc.io/security-groups` — идентификатор одной или нескольких групп безопасности для L7-балансировщика. Идентификаторы нескольких групп перечисляются через запятую без пробелов.
            * `ingress.alb.yc.io/external-ipv4-address` — зарезервированный ранее статический публичный IP-адрес.
            * `ingress.alb.yc.io/group-name` — имя группы ресурсов `Ingress`. Ресурсы `Ingress` объединяются в группы, каждая из которых обслуживается отдельным экземпляром {{ alb-name }} с отдельным публичным IP-адресом.
            * `ingress.alb.yc.io/security-profile-id` — идентификатор созданного ранее профиля безопасности {{ sws-name }}.

                {% note warning %}

                Профиль безопасности будет привязан к виртуальному хосту L7-балансировщика. Указание профиля безопасности является ключевым шагом для подключения сервиса {{ sws-name }}.

                {% endnote %}

            * `ingress.alb.yc.io/autoscale-min-zone-size` — [минимальное количество ресурсных единиц](../../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling-settings) в каждой зоне доступности в соответствии с ожидаемой нагрузкой на ваш сервис.

                Количество ресурсных единиц рекомендуется выбирать на основе нагрузки на ваш сервис, измеряемой в следующих величинах:

                * количество запросов в секунду (RPS);
                * количество одновременных активных соединений;
                * количество новых соединений в секунду;
                * объем трафика в секунду.

        * Для поля `ingressClassName` укажите имя созданного ранее ресурса `IngressClass`.

        * При использовании протокола HTTPS заполните раздел [tls](../../../managed-kubernetes/alb-ref/ingress#tls):

            * `hosts` — доменное имя вашего сервиса, которому соответствует TLS-сертификат.
            * `secretName` — TLS-сертификат вашего сервиса в {{ certificate-manager-full-name }} в формате `yc-certmgr-cert-id-<идентификатор_сертификата>`.

        * Заполните раздел [rules](../../../managed-kubernetes/alb-ref/ingress.md#rule) в соответствии с правилами распределения входящего трафика по бэкендам в зависимости от доменного имени (поле `host`) и запрашиваемого ресурса (поле `http.paths`):

            * `host` — имя домена вашего сервиса.
            * `pathType` — тип указания на запрашиваемый ресурс:

                * `Exact` — путь в URI запроса должен совпадать со значением поля `path`.
                * `Prefix` — путь в URI запроса должен начинаться со значения поля `path`.

            * `path` — путь в URI входящего запроса (если тип `Exact`) или его начало (если тип `Prefix`).
            * `backend` — указание на [бэкенд или группу бэкендов](../../../managed-kubernetes/alb-ref/ingress.md#backend), которые должны обрабатывать запросы с указанным доменным именем и путем в URI. Укажите либо сервис-бэкенд (`service`), либо группу бэкендов (`resource`), но не оба одновременно:

                * `service` —  сервис {{ managed-k8s-name }}, который должен обрабатывать запросы в качестве бэкенда:

                    * `name` — имя сервиса {{ managed-k8s-name }}. Ресурс `Service`, на который указывает это поле, должен быть описан по [конфигурации](../../../application-load-balancer/k8s-ref/service-for-ingress.md).
                    * `port` — порт сервиса, к которому будет обращаться `Ingress`. Для порта сервиса укажите либо номер (`number`), либо имя (`name`), но не оба одновременно.

                    {% note warning %}

                    Сервисы {{ managed-k8s-name }}, используемые в качестве бэкендов, должны иметь тип `NodePort`.

                    {% endnote %}

                * `resource` — указание на группу бэкендов `HttpBackendGroup`, которые должны обрабатывать запросы. Бэкендами в такой группе могут быть сервисы {{ managed-k8s-name }} и [бакеты {{ objstorage-full-name }}](../../../storage/concepts/bucket.md). При использовании группы бэкендов доступна расширенная функциональность {{ alb-name }}. Также можно указывать относительные веса бэкендов для пропорционального распределения трафика между ними.

                    * `kind` — `HttpBackendGroup`.
                    * `name` — имя группы бэкендов. Оно должно совпадать с именем, указанным в поле `metadata.name` ресурса `HttpBackendGroup`. Ресурс `HttpBackendGroup`, на который указывает это поле, должен быть описан по [конфигурации](../../../application-load-balancer/k8s-ref/http-backend-group.md).
                    * `apiGroup` — `alb.yc.io`.

        Пример ресурса `Ingress`:

        ```yaml
        apiVersion: networking.k8s.io/v1
        kind: Ingress
        metadata:
          name: <имя_ресурса>
          annotations:
            ingress.alb.yc.io/subnets: <идентификатор_подсети_ru-central1-a,идентификатор_подсети_ru-central1-b,идентификатор_подсети_ru-central1-d>
            ingress.alb.yc.io/security-groups: <идентификатор_группы_безопасности_L7-балансировщика>
            ingress.alb.yc.io/external-ipv4-address: <статический_публичный_IP-адрес>
            ingress.alb.yc.io/group-name: <имя_группы_ресурсов>
            ingress.alb.yc.io/security-profile-id: <идентификатор_профиля_безопасности_Smart_Web_Security>
            ingress.alb.yc.io/autoscale-min-zone-size: <минимальное_количество_ресурсных_единиц_L7-балансировщика_в_каждой_зоне>
        spec:
          ingressClassName: <имя_ресурса_IngressClass>
          tls:
            - hosts:
                - <имя_домена_сервиса>
              secretName: yc-certmgr-cert-id-<идентификатор_сертификата>
          rules:
            - host: <имя_домена_сервиса>
              http:
                paths:
                - path: /
                  pathType: Prefix
                  backend:
                    service:
                      name: <имя_сервиса_Kubernetes>
                      port:
                        number: <номер_порта,_например_443>
        ```

    1. Создайте ресурс `Ingress` с помощью команды:

        ```bash
        kubectl apply -f <файл_с_ресурсом_Ingress>
        ```

1. По конфигурации ресурса `Ingress` будет развернут L7-балансировщик. Дождитесь завершения его создания и привязки к `Ingress` публичного IP-адреса. Этот IP-адрес понадобится для проверки запросов. Посмотреть информацию о ресурсе вы можете с помощью команды:

    ```bash
    kubectl get ingress <имя_ресурса_Ingress> -w
    ```
