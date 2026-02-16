1. Создайте внутренний сетевой балансировщик для Ingress-контроллера NGINX. Выберите вариант, который соответствует способу первоначального развертывания вашего Ingress-контроллера NGINX:

    {% list tabs %}

    * С помощью Helm-чарта

        1. В файле `values.yaml`, который вы использовали для первоначальной конфигурации Ingress-контроллера NGINX, добавьте параметры конфигурации для внутреннего сетевого балансировщика. Остальные параметры в файле оставьте без изменений.

            ```bash
            controller:
              service:
                external:
                  enabled: true
                internal:
                  enabled: true
                  annotations:
                    yandex.cloud/load-balancer-type: internal
                    yandex.cloud/subnet-id: <идентификатор_подсети_для_IP-адреса_внутреннего_сетевого_балансировщика>
                  loadBalancerIP: <IP-адрес_обработчика_внутреннего_сетевого_балансировщика>
                  externalTrafficPolicy: Local
            ```

        1. Примените изменения конфигурации Ingress-контроллера NGINX с помощью команды:

            ```bash
            helm upgrade <имя_Ingress-контроллера_NGINX> -f values.yaml <чарт_для_Ingress-контроллера_NGINX> -n <пространство_имен>
            ```

    * С помощью манифеста

        1. Создайте YAML-файл, в котором опишите ресурс `Service`:

            ```bash
            apiVersion: v1
            kind: Service
            metadata:
              name: <имя_ресурса>
              namespace: <пространство_имен>
              annotations:
                yandex.cloud/load-balancer-type: internal
                yandex.cloud/subnet-id: <идентификатор_подсети_для_IP-адреса_внутреннего_сетевого_балансировщика>
            spec:
              type: LoadBalancer
              externalTrafficPolicy: Local
              loadBalancerIP: <IP-адрес_обработчика_внутреннего_сетевого_балансировщика>
              ports:
              - port: <80_или_другой_номер_порта_для_HTTP>
                targetPort: <80_или_другой_номер_порта_пода_Ingress-контроллера_NGINX_для_HTTP>
                protocol: TCP
                name: http
              - port: <443_или_другой_номер_порта_для_HTTPS>
                targetPort: <443_или_другой_номер_порта_пода_Ingress-контроллера_NGINX_для_HTTPS>
                protocol: TCP
                name: https
              selector:
                <селекторы_подов_Ingress-контроллера_NGINX>
            ```

        1. Примените изменения с помощью команды:

        ```bash
        kubectl apply -f <файл_с_ресурсом_Service>
        ```

    {% endlist %}

1. Дождитесь создания внутреннего сетевого балансировщика и появления соответствующего ему объекта `Service`. Посмотреть информацию о сервисах вы можете с помощью команды:

    ```bash
    kubectl get service
    ```
