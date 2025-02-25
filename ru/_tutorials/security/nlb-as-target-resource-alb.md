# Миграция сервисов с внешнего балансировщика NLB на L7-балансировщик ALB с целевым ресурсом — внутренним сетевым балансировщиком NLB


Сетевой балансировщик [{{ network-load-balancer-full-name }}](../../network-load-balancer/) может распределять трафик на поды вашего балансировщика, развернутые в кластере [{{ managed-k8s-full-name }}](../../managed-kubernetes/). Если функциональность, настроенная в вашем балансировщике, не поддерживается в [{{ alb-full-name }}](../../application-load-balancer/), то вы можете добавить [внутренний сетевой балансировщик](../../network-load-balancer/concepts/nlb-types.md) для распределения трафика на поды вашего балансировщика и подключить внутренний сетевой балансировщик в качестве целевого ресурса для L7-балансировщика {{ alb-name }} с профилем безопасности [{{ sws-full-name }}](../../smartwebsecurity/).

В этом практическом руководстве рассмотрен вариант, при котором создается внутренний сетевой балансировщик для балансировки трафика на поды [Ingress-контроллера NGINX](../../managed-kubernetes/operations/applications/ingress-nginx.md), развернутые в кластере {{ managed-k8s-name }}, и в целевой группе L7-балансировщика указывается IP-адрес внутреннего сетевого балансировщика.

Схема работы L7-балансировщика с подключенным профилем безопасности {{ sws-name }}:

![image](../../_assets/tutorials/security/nlb-as-target-resource-alb.svg)

Чтобы мигрировать сервис с внешнего сетевого балансировщика на L7-балансировщик:

1. [Ознакомьтесь с рекомендациями по миграции сервисов](#recommendations).
1. [Выполните подготовительные действия](#before-you-begin).
1. [Создайте профиль безопасности {{ sws-name }}](#create-profile-sws).
1. [Создайте внутренний сетевой балансировщик для Ingress-контроллера NGINX](#create-internal-nlb).
1. [Создайте L7-балансировщик](#create-alb). На этом этапе вы подключите профиль безопасности {{ sws-name }} к виртуальному хосту L7-балансировщика.
1. [Мигрируйте пользовательскую нагрузку с внешнего сетевого балансировщика на L7-балансировщик](#migration-nlb-to-alb).

## Рекомендации по миграции сервисов {#recommendations}

1. Дополнительно к защите от DDoS-атак на уровне L7 модели OSI с помощью [{{ sws-full-name }}](../../smartwebsecurity/) рекомендуется подключить защиту от DDoS-атак на уровне L3-L4. Для этого заранее [зарезервируйте статический публичный IP-адрес с защитой от DDoS-атак](../../vpc/operations/enable-ddos-protection.md#enable-on-reservation) и используйте этот адрес для обработчика L7-балансировщика.

    Если у обработчика сетевого балансировщика уже используется публичный IP-адрес с защитой от DDoS, то вы сможете сохранить его и перенести в L7-балансировщик.

    Если у обработчика сетевого балансировщика используется публичный IP-адрес без защиты от DDoS, то для защиты от DDoS-атак на уровне L3-L4 миграция на L7-балансировщик возможна только со сменой публичного IP-адреса для вашего сервиса.

    При использовании защиты от DDoS-атак на уровне L3-L4 настройте порог для срабатывания механизмов защиты на уровне L3-L4, который будет соответствовать объему легитимного трафика на защищаемый ресурс. Для настройки такого порога обратитесь в [техническую поддержку]({{ link-console-support }}).

    Также задайте значение MTU равным `1450` на целевых ресурсах за балансировщиком. Подробнее см. в разделе [Настроить MTU при включении защиты от DDoS-атак](../../vpc/operations/adjust-mtu-ddos-protection.md).

1. Работы по миграции рекомендуется проводить в часы наименьшей пользовательской нагрузки. Если вы планируете сохранить публичный IP-адрес, то учитывайте, что при миграции этот IP-адрес будет переноситься с сетевого балансировщика на L7-балансировщик. В это время ваш сервис будет недоступен. Время недоступности сервиса в штатном режиме может занимать несколько минут.

1. При использовании L7-балансировщика запросы на бэкенды приходят с IP-адресом источника из диапазона внутренних IP-адресов подсетей, указанных при создании L7-балансировщика. Исходный IP-адрес источника запроса (пользователя) фигурирует в заголовке `X-Forwarded-For`. Если необходимо журналировать публичные IP-адреса пользователей на веб-сервере, [измените его конфигурацию](../../troubleshooting/application-load-balancer/how-to/getting-external-src-ip-in-x-forwarded-for-headers.md).

1. Ознакомьтесь с [автомасштабированием и ресурсными единицами](../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling) в L7-балансировщике.

## Перед началом работы {#before-you-begin}

1. [Создайте подсети](../../vpc/operations/subnet-create.md) в трех зонах доступности. Эти подсети будут использоваться для L7-балансировщика.

1. Создайте [группы безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups), которые разрешают L7-балансировщику получать входящий трафик и отправлять его на целевые ресурсы, а также разрешают целевым ресурсам получать входящий трафик от балансировщика.

1. При использовании протокола HTTPS [добавьте TLS-сертификат](../../certificate-manager/operations/import/cert-create.md#create-certificate) вашего сервиса в [{{ certificate-manager-full-name }}](../../certificate-manager/).

1. [Зарезервируйте публичный статический IP-адрес с защитой от DDoS](../../vpc/operations/get-static-ip.md) на уровне L3-L4 для L7-балансировщика. См. [рекомендации по миграции сервисов](#recommendations).

## Создайте профиль безопасности {{ sws-name }} {#create-profile-sws}

[Создайте профиль безопасности](../../smartwebsecurity/operations/profile-create.md) {{ sws-name }}, выбрав вариант создания **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.

При создании профиля задайте настройки:

* В поле **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** выберите `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
* Для правила **{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}** включите опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)**.

С этими настройками будет выполняться только логирование информации о трафике без применения к нему каких-либо действий. Это позволит снизить риск отключения пользователей из-за проблем в настройке профиля. Постепенно вы сможете отключить опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)** и настроить правила с запрещающими действиями в профиле безопасности для вашего сценария.

## Создайте внутренний сетевой балансировщик для Ingress-контроллера NGINX {#create-internal-nlb}

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
              - port: <номер_порта_для_HTTP,_например_80>
                targetPort: <номер_порта_пода_Ingress-контроллера_NGINX_для_HTTP,_например_80>
                protocol: TCP
                name: http
              - port: <номер_порта_для_HTTPS,_например_443>
                targetPort: <номер_порта_пода_Ingress-контроллера_NGINX_для_HTTPS,_например_443>
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

## Создайте L7-балансировщик {#create-alb}

1. [Создайте целевую группу](../../application-load-balancer/operations/target-group-create.md) L7-балансировщика. В блоке **{{ ui-key.yacloud.alb.label_targets }}** выберите опцию **{{ ui-key.yacloud.alb.label_target-private-ip }}** и укажите внутренний IP-адрес внутреннего сетевого балансировщика. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-target }}** и далее кнопку **{{ ui-key.yacloud.common.create }}**.

1. [Создайте группу бэкендов](../../application-load-balancer/operations/backend-group-create.md) со следующими параметрами:

    1. Выберите тип группы бэкендов `{{ ui-key.yacloud.alb.label_proto-http }}`.
    1. В блоке **{{ ui-key.yacloud.alb.label_backends }}** нажмите кнопку **{{ ui-key.yacloud.common.add }}** и задайте настройки бэкенда:

        * **{{ ui-key.yacloud.common.type }}** — `{{ ui-key.yacloud.alb.label_target-group }}`.
        * **{{ ui-key.yacloud.alb.label_target-groups }}** — созданная ранее целевая группа.
        * **{{ ui-key.yacloud.alb.label_port }}** — TCP-порт, который настроен на обработчике внутреннего сетевого балансировщика. Обычно это порт `80` для HTTP и `443` для HTTPS.
        * В блоке **{{ ui-key.yacloud.alb.label_protocol-settings }}** в зависимости от вашего сервиса выберите протокол `{{ ui-key.yacloud.alb.label_proto-http-plain }}` или `{{ ui-key.yacloud.alb.label_proto-http-tls }}`.
        * В блоке **HTTP проверка состояния** удалите проверку состояния. Не добавляйте ее, так как в качестве целевого ресурса используется сетевой балансировщик, который является отказоустойчивым сервисом.

1. [Создайте HTTP-роутер](../../application-load-balancer/operations/http-router-create.md).

    В блоке **{{ ui-key.yacloud.alb.label_virtual-hosts }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_virtual-host-add }}** и задайте настройки виртуального хоста:

    * **{{ ui-key.yacloud.alb.label_authority }}** — имя домена вашего сервиса.
    * **{{ ui-key.yacloud.alb.label_security-profile-id }}** — созданный ранее профиль безопасности {{ sws-name }}.

        {% note warning %}

        Привязка профиля безопасности к виртуальному хосту L7-балансировщика является ключевым шагом для подключения сервиса {{ sws-name }}.

        {% endnote %}

    * Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-route }}** и задайте настройки маршрута:

        * **{{ ui-key.yacloud.alb.label_path }}** — `Начинается с` `/`.
        * **{{ ui-key.yacloud.alb.label_route-action }}** — `{{ ui-key.yacloud.alb.label_route-action-route }}`.
        * **{{ ui-key.yacloud.alb.label_backend-group }}** — созданная ранее группа бэкендов.

    Вы можете добавить несколько доменов с помощью кнопки **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.

1. [Создайте L7-балансировщик](../../application-load-balancer/operations/application-load-balancer-create.md), выбрав способ создания **{{ ui-key.yacloud.alb.label_alb-create-form }}**:

    * Укажите группу безопасности, созданную ранее.

        {% note warning %}

        Группы узлов в кластере {{ managed-k8s-name }} должны иметь разрешающие правила в группах безопасности для входящих соединений от L7-балансировщика на диапазон портов 30000-32767 из подсетей, в которых размещается L7-балансировщик, или из его группы безопасности.

        {% endnote %}

    * В блоке **{{ ui-key.yacloud.alb.section_allocation-settings }}** выберите для узлов балансировщика подсети в трех зонах доступности. Включите прием трафика в этих подсетях.
    * В блоке **{{ ui-key.yacloud.alb.section_autoscale-settings }}** укажите [минимальное количество ресурсных единиц](../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling-settings) в каждой зоне в соответствии с ожидаемой нагрузкой на ваш сервис.

        Количество ресурсных единиц рекомендуется выбрать на основе нагрузки на ваш сервис в следующих величинах:

        * количество запросов в секунду (RPS);
        * количество одновременных активных соединений;
        * количество новых соединений в секунду;
        * объем трафика в секунду.

    * В блоке **{{ ui-key.yacloud.alb.label_listeners }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_add-listener }}** и задайте настройки обработчика:

        * В блоке **{{ ui-key.yacloud.alb.section_external-address-specs }}** укажите:

            * **{{ ui-key.yacloud.alb.label_port }}** — TCP-порт, который настроен на обработчике внутреннего сетевого балансировщика. Обычно это порт `80` для HTTP и `443` для HTTPS.
            * **{{ ui-key.yacloud.common.type }}** — `{{ ui-key.yacloud.alb.label_address-list }}`. Выберите из списка публичный IP-адрес с защитой от DDoS на уровне L3-L4. Подробнее см. [рекомендации по миграции сервисов](#recommendations).
        * В блоке **{{ ui-key.yacloud.alb.section_common-address-specs }}** укажите:

            * **{{ ui-key.yacloud.alb.label_listener-type }}** — `{{ ui-key.yacloud.alb.label_listener-type-http }}`.
            * **{{ ui-key.yacloud.alb.label_protocol-type }}** — в зависимости от вашего сервиса выберите протокол `{{ ui-key.yacloud.alb.label_proto-http-plain }}` или `{{ ui-key.yacloud.alb.label_proto-http-tls }}`.
            * Если выбран протокол `{{ ui-key.yacloud.alb.label_proto-http-tls }}`, в поле **{{ ui-key.yacloud.alb.label_certificate }}** укажите ваш TLS-сертификат, добавленный ранее в {{ certificate-manager-name }}.
            * **{{ ui-key.yacloud.alb.label_http-router }}** — созданный ранее HTTP-роутер.

1. Дождитесь, когда L7-балансировщик перейдет в статус `Active`.

1. Перейдите в созданный L7-балансировщик и слева выберите **{{ ui-key.yacloud.alb.label_healthchecks }}**. Убедитесь, что все проверки состояния L7-балансировщика показывают состояние `HEALTHY`.

1. Протестируйте запрос к сервису через L7-балансировщик. Например, одним из способов:

    * В файле `hosts` на рабочей станции добавьте запись `<публичный_IP-адрес_L7-балансировщика> <имя_домена_сервиса>`. Удалите запись после тестирования.
    * Выполните запрос с помощью {{ api-examples.rest.tool }} в зависимости от типа протокола:

        ```bash
        curl http://<имя_домена_сервиса> \
            --resolve <имя_домена_сервиса>:<порт_сервиса>:<публичный_IP-адрес_L7-балансировщика>
        ```

        ```bash
        curl https://<имя_домена_сервиса> \
            --resolve <имя_домена_сервиса>:<порт_сервиса>:<публичный_IP-адрес_L7-балансировщика>
        ```

## Мигрируйте пользовательскую нагрузку с внешнего сетевого балансировщика на L7-балансировщик {#migration-nlb-to-alb}

Выберите один из вариантов миграции:

* [Сохранить публичный IP-адрес для вашего сервиса](#save-public-ip).
* [Не сохранять публичный IP-адрес для вашего сервиса](#not-save-public-ip).

### Сохранить публичный IP-адрес для вашего сервиса {#save-public-ip}

1. Если у внешнего сетевого балансировщика используется динамический публичный IP-адрес, [сделайте его статическим](../../vpc/operations/set-static-ip.md).

1. Удалите внешний сетевой балансировщик. Выберите вариант, который соответствует способу первоначального развертывания вашего Ingress-контроллера NGINX:

    {% list tabs %}

    * С помощью Helm-чарта

        1. В файле `values.yaml`, который вы использовали для конфигурации Ingress-контроллера NGINX, в секции `controller.service.external` установите значение параметра `enabled: false`. Остальные параметры в файле оставьте без изменений.

            ```bash
            controller:
              service:
                external:
                  enabled: false
                ...
            ```

        1. Примените изменения конфигурации Ingress-контроллера NGINX с помощью команды:

            ```bash
            helm upgrade <имя_Ingress-контроллера_NGINX> -f values.yaml <чарт_для_Ingress-контроллера_NGINX> -n <пространство_имен>
            ```

    * С помощью манифеста

        Удалите ресурс `Service` для внешнего сетевого балансировщика с помощью команды:

        ```bash
        kubectl delete service <имя_ресурса_Service_для_внешнего_сетевого_балансировщика>
        ```

    {% endlist %}

1. Дождитесь удаления внешнего сетевого балансировщика для Ingress-контроллера NGINX и удаления соответствующего ему объекта `Service`. Посмотреть информацию о сервисах вы можете с помощью команды:

    ```bash
    kubectl get service
    ```

    После этого ваш сервис не будет доступен через внешний сетевой балансировщик

1. В L7-балансировщике назначьте обработчику публичный IP-адрес, который ранее был у внешнего сетевого балансировщика:

    {% list tabs group=instructions %}

    * CLI {#cli}

        {% include [include](../../_includes/cli-install.md) %}

        {% include [default-catalogue](../../_includes/default-catalogue.md) %}

        Чтобы изменить публичный IP-адрес, выполните команду:

        ```bash
        yc application-load-balancer load-balancer update-listener <имя_балансировщика> \
           --listener-name <имя_обработчика> \
           --external-ipv4-endpoint address=<публичный_IP-адрес_сервиса>,port=<порт_сервиса>
        ```

        Где `address` — это публичный IP-адрес, который ранее был у внешнего сетевого балансировщика.

    * {{ TF }} {#tf}

        1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

            Как создать такой файл, см. в разделе [Создать L7-балансировщик](../../application-load-balancer/operations/application-load-balancer-create.md).

            Более подробную информацию о параметрах ресурса `yandex_alb_load_balancer` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/alb_load_balancer).

        1. Измените в описании балансировщика значение параметра `address` в блоке `listener.endpoint.address.external_ipv4_address`:

            ```hcl
            resource "yandex_alb_load_balancer" "<имя_балансировщика>" {
              ...
              listener {
                ...
                endpoint {
                  address {
                    external_ipv4_address {
                      address = <публичный_IP-адрес_сервиса>
                    }
                  }
                  ports = [ <порт_сервиса> ]
                }
              }
            }
            ```

            Где `address` — это публичный IP-адрес, который ранее был у внешнего сетевого балансировщика.

        1. Примените изменения:

            {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

    {% endlist %}

1. После изменения IP-адреса восстановится доступность вашего сервиса через L7-балансировщик. Наблюдайте за пользовательской нагрузкой, поступающей на L7-балансировщик, на графиках [статистики работы балансировщика](../../application-load-balancer/operations/application-load-balancer-get-stats.md).

1. Удалите освободившийся статический публичный IP-адрес, который был выбран при создании L7-балансировщика.

### Не сохранять публичный IP-адрес для вашего сервиса {#not-save-public-ip}

1. Чтобы мигрировать пользовательскую нагрузку с внешнего сетевого балансировщика на L7-балансировщик, в DNS-сервисе, обслуживающем публичную зону вашего домена, измените значение А-записи для доменного имени сервиса на публичный IP-адрес L7-балансировщика. Если публичная зона домена была создана в [{{ dns-full-name }}](../../dns/), то измените запись [по инструкции](../../dns/operations/resource-record-update.md).

    {% note info %}

    Распространение изменений в записи DNS зависит от значения времени жизни записи (TTL) и количества звеньев цепочки DNS-запросов. Это может занять продолжительное время.

    {% endnote %}

1. По мере распространения изменений в записи DNS наблюдайте за ростом запросов, поступающих на L7-балансировщик, на графиках [статистики работы балансировщика](../../application-load-balancer/operations/application-load-balancer-get-stats.md).

1. Наблюдайте за снижением нагрузки на внешний сетевой балансировщик с помощью [метрик балансировщика](../../monitoring/metrics-ref/network-load-balancer-ref.md) `processed_bytes` и `processed_packets`. Для визуализации этих метрик можно [создать дашборд](../../monitoring/operations/dashboard/create.md). Отсутствие нагрузки на внешнем сетевом балансировщике в течение продолжительного времени свидетельствует о том, что перенос пользовательской нагрузки на L7-балансировщик завершен.

1. (Опционально) После переноса пользовательской нагрузки на L7-балансировщик [удалите внешний сетевой балансировщик](../../network-load-balancer/operations/load-balancer-delete.md). Выберите вариант, который соответствует способу первоначального развертывания вашего Ingress-контроллера NGINX:

    {% list tabs %}

    * С помощью Helm-чарта

        1. В файле `values.yaml`, который вы использовали для конфигурации Ingress-контроллера NGINX, в секции `controller.service.external` установите значение параметра `enabled: false`. Остальные параметры в файле оставьте без изменений.

            ```bash
            controller:
              service:
                external:
                  enabled: false
                ...
            ```

        1. Примените изменения конфигурации Ingress-контроллера NGINX с помощью команды:

            ```bash
            helm upgrade <имя_Ingress-контроллера_NGINX> -f values.yaml <чарт_для_Ingress-контроллера_NGINX> -n <пространство_имен>
            ```

        {% note warning %}

        При изменении конфигурации Ingress-контроллера NGINX ваш сервис временно будет недоступен.

        {% endnote %}

    * С помощью манифеста

        Удалите ресурс `Service` для внешнего сетевого балансировщика с помощью команды:

        ```bash
        kubectl delete service <имя_ресурса_Service_для_внешнего_сетевого_балансировщика>
        ```

    {% endlist %}

1. Дождитесь удаления внешнего сетевого балансировщика для Ingress-контроллера NGINX и удаления соответствующего ему объекта `Service`. Посмотреть информацию о сервисах вы можете с помощью команды:

    ```bash
    kubectl get service
    ```
