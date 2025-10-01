# Миграция сервисов с внешнего балансировщика NLB на L7-балансировщик ALB с целевым ресурсом — внутренним сетевым балансировщиком NLB с помощью консоли управления


Чтобы мигрировать сервис с внешнего сетевого балансировщика на L7-балансировщик:

1. [Ознакомьтесь с рекомендациями по миграции сервисов](#recommendations).
1. [Создайте инфраструктуру для миграции](#before-you-begin).
1. [Создайте профиль безопасности {{ sws-name }}](#create-profile-sws).
1. [Создайте внутренний сетевой балансировщик для Ingress-контроллера NGINX](#create-internal-nlb).
1. [Создайте L7-балансировщик](#create-alb). На этом этапе вы подключите профиль безопасности {{ sws-name }} к виртуальному хосту L7-балансировщика.
1. [Проверьте работу L7-балансировщика](#test).
1. [Мигрируйте пользовательскую нагрузку с внешнего сетевого балансировщика на L7-балансировщик](#migration-nlb-to-alb).

## Рекомендации по миграции сервисов {#recommendations}

{% include [recommendations](../_tutorials_includes/migration-from-nlb-to-alb/recommendations.md) %}

## Создайте инфраструктуру {#before-you-begin}

1. [Создайте подсети](../../vpc/operations/subnet-create.md) в трех зонах доступности. Эти подсети будут использоваться для L7-балансировщика.

1. Создайте [группы безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups), которые разрешают L7-балансировщику получать входящий трафик и отправлять его на целевые ресурсы, а также разрешают целевым ресурсам получать входящий трафик от балансировщика.

1. При использовании протокола HTTPS [добавьте TLS-сертификат](../../certificate-manager/operations/import/cert-create.md#create-certificate) вашего сервиса в [{{ certificate-manager-full-name }}](../../certificate-manager/).

1. (Опционально) [Зарезервируйте публичный статический IP-адрес с защитой от DDoS](../../vpc/operations/get-static-ip.md) на уровне L3-L4 для L7-балансировщика.

## Создайте профиль безопасности {{ sws-name }} {#create-profile-sws}

{% include [create-profile-sws](../_tutorials_includes/migration-from-nlb-to-alb/create-profile-sws.md) %}

## Создайте внутренний сетевой балансировщик для Ingress-контроллера NGINX {#create-internal-nlb}

{% include [create-internal-nlb](../_tutorials_includes/migration-from-nlb-to-alb/create-internal-nlb.md) %}

## Создайте L7-балансировщик {#create-alb}

1. [Создайте целевую группу](../../application-load-balancer/operations/target-group-create.md) L7-балансировщика. В блоке **{{ ui-key.yacloud.alb.label_targets }}** выберите опцию **{{ ui-key.yacloud.alb.label_target-private-ip }}** и укажите внутренний IP-адрес внутреннего сетевого балансировщика. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-target }}** и далее кнопку **{{ ui-key.yacloud.common.create }}**.

1. [Создайте группу бэкендов](../../application-load-balancer/operations/backend-group-create.md) со следующими параметрами:

    1. Выберите тип группы бэкендов `{{ ui-key.yacloud.alb.label_proto-http }}`.
    1. В блоке **{{ ui-key.yacloud.alb.label_backends }}** нажмите кнопку **{{ ui-key.yacloud.common.add }}** и задайте настройки бэкенда:

        * **{{ ui-key.yacloud.common.type }}** — `{{ ui-key.yacloud.alb.label_target-group }}`.
        * **{{ ui-key.yacloud.alb.label_target-groups }}** — созданная ранее целевая группа.
        * **{{ ui-key.yacloud.alb.label_port }}** — TCP-порт, который настроен на обработчике внутреннего сетевого балансировщика. Обычно это порт `80` для HTTP и `443` для HTTPS.
        * В блоке **{{ ui-key.yacloud.alb.label_protocol-settings }}** в зависимости от используемого вашим сервисом протокола выберите `{{ ui-key.yacloud.alb.label_proto-http-plain }}` или `{{ ui-key.yacloud.alb.label_proto-http-tls }}`.
        * В блоке **HTTP проверка состояния** удалите проверку состояния. Не добавляйте ее, так как в качестве целевого ресурса используется сетевой балансировщик, который является отказоустойчивым сервисом.

1. [Создайте HTTP-роутер](../../application-load-balancer/operations/http-router-create.md).

    В блоке **{{ ui-key.yacloud.alb.label_virtual-hosts }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_virtual-host-add }}** и задайте настройки виртуального хоста:

    * **{{ ui-key.yacloud.alb.label_authority }}** — имя домена вашего сервиса.
    * **{{ ui-key.yacloud.alb.label_security-profile-id }}** — созданный ранее профиль безопасности {{ sws-name }}.

        {% note warning %}

        Подключение сервиса {{ sws-name }} невозможно без привязки профиля безопасности к виртуальному хосту L7-балансировщика.

        {% endnote %}

    * Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-route }}** и задайте настройки маршрута:

        * **{{ ui-key.yacloud.alb.label_path }}** — `Начинается с` `/`.
        * **{{ ui-key.yacloud.alb.label_route-action }}** — `{{ ui-key.yacloud.alb.label_route-action-route }}`.
        * **{{ ui-key.yacloud.alb.label_backend-group }}** — созданная ранее группа бэкендов.

    Вы можете добавить несколько доменов с помощью кнопки **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.

1. [Создайте L7-балансировщик](../../application-load-balancer/operations/application-load-balancer-create.md), выбрав способ создания **{{ ui-key.yacloud.alb.label_alb-create-form }}**:

    1. Укажите группу безопасности, созданную ранее.

        {% note warning %}

        Группы узлов в кластере {{ managed-k8s-name }} должны иметь разрешающие правила в группах безопасности для входящих соединений от L7-балансировщика на диапазон портов 30000-32767 из подсетей, в которых размещается L7-балансировщик, или из его группы безопасности.

        {% endnote %}

    1. В блоке **{{ ui-key.yacloud.alb.section_allocation-settings }}** выберите для узлов балансировщика подсети в трех зонах доступности. Включите прием трафика в этих подсетях.
    1. В блоке **{{ ui-key.yacloud.alb.section_autoscale-settings }}** укажите [минимальное количество ресурсных единиц](../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling-settings) в каждой зоне в соответствии с ожидаемой нагрузкой на ваш сервис.
    1. В блоке **{{ ui-key.yacloud.alb.label_listeners }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_add-listener }}** и задайте настройки обработчика:

        1. В блоке **{{ ui-key.yacloud.alb.section_external-address-specs }}** укажите:

            * **{{ ui-key.yacloud.alb.label_port }}** — TCP-порт, который настроен на обработчике внутреннего сетевого балансировщика. Обычно это порт `80` для HTTP и `443` для HTTPS.
            * **{{ ui-key.yacloud.common.type }}** — `{{ ui-key.yacloud.alb.label_address-list }}`. Выберите из списка публичный IP-адрес. Если вы планируете подключить защиту от DDoS-атак на уровне L3-L4, выберите статический публичный IP-адрес с установленной защитой от DDoS-атак.
        1. В блоке **{{ ui-key.yacloud.alb.section_common-address-specs }}** укажите:

            * **{{ ui-key.yacloud.alb.label_listener-type }}** — `{{ ui-key.yacloud.alb.label_listener-type-http }}`.
            * **{{ ui-key.yacloud.alb.label_protocol-type }}** — в зависимости от используемого вашим сервисом протокола выберите `{{ ui-key.yacloud.alb.label_proto-http-plain }}` или `{{ ui-key.yacloud.alb.label_proto-http-tls }}`.
            * Если выбран протокол `{{ ui-key.yacloud.alb.label_proto-http-tls }}`, в поле **{{ ui-key.yacloud.alb.label_certificate }}** укажите TLS-сертификат, добавленный ранее в {{ certificate-manager-name }}.
            * **{{ ui-key.yacloud.alb.label_http-router }}** — выберите созданный ранее HTTP-роутер.

## Проверьте работу L7-балансировщика {#test}

1. Дождитесь, когда L7-балансировщик перейдет в статус `Active`.

1. Перейдите в созданный L7-балансировщик и слева выберите **{{ ui-key.yacloud.alb.label_healthchecks }}**. Убедитесь, что все проверки показывают состояние `HEALTHY`.

1. {% include [test](../_tutorials_includes/migration-from-nlb-to-alb/test.md) %}

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

    После этого ваш сервис не будет доступен через внешний сетевой балансировщик.

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

    {% endlist %}

1. После изменения IP-адреса восстановится доступность вашего сервиса через L7-балансировщик. Наблюдайте за пользовательской нагрузкой, поступающей на L7-балансировщик, на графиках [статистики работы балансировщика](../../application-load-balancer/operations/application-load-balancer-get-stats.md).

1. Удалите освободившийся статический публичный IP-адрес, который был выбран при создании L7-балансировщика.

### Не сохранять публичный IP-адрес для вашего сервиса {#not-save-public-ip}

{% include [nlb-alb-not-save-public-ip](../_tutorials_includes/migration-from-nlb-to-alb/nlb-alb-not-save-public-ip.md) %}
