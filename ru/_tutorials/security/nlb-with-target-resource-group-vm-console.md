# Миграция сервисов с балансировщика NLB с целевыми ресурсами из группы виртуальных машин (Instance Groups) на L7-балансировщик ALB с помощью консоли управления


Чтобы мигрировать сервис с сетевого балансировщика на L7-балансировщик:

1. [Ознакомьтесь с рекомендациями по миграции сервисов](#recommendations).
1. [Создайте инфраструктуру для миграции](#before-you-begin).
1. [Создайте профиль безопасности {{ sws-full-name }}](#create-profile-sws).
1. [Создайте L7-балансировщик](#create-alb). На этом этапе вы подключите профиль безопасности {{ sws-name }} к виртуальному хосту L7-балансировщика.
1. [Проверьте работу L7-балансировщика](#test).
1. [Мигрируйте пользовательскую нагрузку с сетевого балансировщика на L7-балансировщик](#migration-nlb-to-alb).

## Рекомендации по миграции сервисов {#recommendations}

{% include [group-vm-recommendations](../_tutorials_includes/migration-from-nlb-to-alb/group-vm-recommendations.md) %}

## Создайте инфраструктуру {#before-you-begin}

1. [Создайте подсети](../../vpc/operations/subnet-create.md) в трех зонах доступности. Эти подсети будут использоваться для L7-балансировщика.

1. Создайте [группы безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups), которые разрешают L7-балансировщику получать входящий трафик и отправлять его на целевые ресурсы, а также разрешают целевым ресурсам получать входящий трафик от балансировщика.

1. При использовании протокола HTTPS [добавьте TLS-сертификат](../../certificate-manager/operations/import/cert-create.md#create-certificate) вашего сервиса в [{{ certificate-manager-full-name }}](../../certificate-manager/).

1. (Опционально) [Зарезервируйте публичный статический IP-адрес с защитой от DDoS](../../vpc/operations/get-static-ip.md) на уровне L3-L4 для L7-балансировщика.

## Создайте профиль безопасности {{ sws-name }} {#create-profile-sws}

{% include [create-profile-sws](../_tutorials_includes/migration-from-nlb-to-alb/create-profile-sws.md) %}

## Создайте L7-балансировщик {#create-alb}

1. [Создайте целевую группу](../../application-load-balancer/operations/target-group-create.md) L7-балансировщика. В блоке **{{ ui-key.yacloud.alb.label_targets }}** выберите виртуальные машины из целевой группы вашего сетевого балансировщика нагрузки.

1. [Создайте группу бэкендов](../../application-load-balancer/operations/backend-group-create.md) со следующими параметрами:

    1. Выберите тип группы бэкендов `{{ ui-key.yacloud.alb.label_proto-http }}`.
    1. Если для вашего сервиса требуется, чтобы запросы в рамках одной пользовательской сессии обрабатывал один и тот же ресурс бэкенда, включите для группы бэкендов [привязку сессий](../../application-load-balancer/concepts/backend-group.md#session-affinity) (session affinity).
    1. В блоке **{{ ui-key.yacloud.alb.label_backends }}** нажмите кнопку **{{ ui-key.yacloud.common.add }}** и задайте настройки бэкенда:

        * **{{ ui-key.yacloud.common.type }}** — `{{ ui-key.yacloud.alb.label_target-group }}`.
        * **{{ ui-key.yacloud.alb.label_target-groups }}** — созданная ранее целевая группа.
        * **{{ ui-key.yacloud.alb.label_port }}** — TCP-порт вашего сервиса, на котором виртуальные машины принимают входящий трафик.
        * В блоке **{{ ui-key.yacloud.alb.label_protocol-settings }}** укажите настройки соединения L7-балансировщика с бэкендом. В зависимости от типа протокола на вашем бэкенде выберите протокол `{{ ui-key.yacloud.alb.label_proto-http-plain }}` или `{{ ui-key.yacloud.alb.label_proto-http-tls }}`.
        * В блоке **HTTP проверка состояния** настройте проверку в соответствии с [практическими рекомендациями](../../application-load-balancer/concepts/best-practices.md#health-checks-recommendations).
        * (Опционально) Задайте прочие настройки в соответствии с [инструкцией](../../application-load-balancer/operations/backend-group-create.md).

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

1. [Создайте L7-балансировщик](../../application-load-balancer/operations/application-load-balancer-create.md), выбрав способ создания **{{ ui-key.yacloud.alb.label_alb-create-form }}**:

    1. Укажите группу безопасности, созданную ранее.
    1. В блоке **{{ ui-key.yacloud.alb.section_allocation-settings }}** выберите для узлов балансировщика подсети в трех зонах доступности. Включите прием трафика в этих подсетях.
    1. В блоке **{{ ui-key.yacloud.alb.section_autoscale-settings }}** укажите [минимальное количество ресурсных единиц](../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling-settings) в каждой зоне в соответствии с ожидаемой нагрузкой на ваш сервис.
    1. В блоке **{{ ui-key.yacloud.alb.label_listeners }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_add-listener }}** и задайте настройки обработчика:

        1. В блоке **{{ ui-key.yacloud.alb.section_external-address-specs }}** укажите:

            * **{{ ui-key.yacloud.alb.label_port }}** — TCP-порт вашего сервиса, на котором виртуальные машины принимают входящий трафик.
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

## Мигрируйте пользовательскую нагрузку с сетевого балансировщика на L7-балансировщик {#migration-nlb-to-alb}

{% note warning %}

В процессе миграции будут пересозданы ВМ бэкенда.

{% endnote %}

Если обработчик сетевого балансировщика использует публичный IP-адрес без защиты от DDoS, запомните текущие настройки [проверок состояния](../../network-load-balancer/concepts/health-check.md) для целевой группы в сетевом балансировщике, прежде чем приступать к миграции. Эти настройки понадобятся при подключении новой целевой группы к балансировщику.

Чтобы мигрировать нагрузку:

1. Измените для группы ВМ интеграцию с целевой группой:

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится группа ВМ.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
    1. Выберите группу, которую хотите изменить.
    1. В правом верхнем углу страницы нажмите **{{ ui-key.yacloud.common.edit }}**.
    1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_alb }}** включите опцию **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}**.
    1. Укажите имя целевой группы L7-балансировщика и опционально другие [настройки целевой группы](../../compute/concepts/instance-groups/balancers.md#settings-alb).
    1. Нажмите **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.

    В процессе изменения группы ВМ происходит следующее:

    * [Пересоздаются ВМ в группе](../../compute/concepts/instance-groups/deploy/instance.md#ch-gr-affect).
    * Удаляются целевые ресурсы из целевой группы сетевого балансировщика, на оставшиеся целевые ресурсы распределяется пользовательская нагрузка. У пользователей в это время наблюдается частичная недоступность сервиса через сетевой балансировщик.
    * После удаления всех целевых ресурсов удаляется целевая группа. Сервис становится недоступным через сетевой балансировщик.

    Вы можете перейти к следующему шагу, не дожидаясь, пока завершится изменение группы ВМ.

1. В группе бэкендов L7-балансировщика [измените у бэкенда](../../application-load-balancer/operations/backend-group-update.md#update-backend) целевую группу. Укажите только целевую группу, созданную на предыдущем шаге.

    В целевую группу L7-балансировщика автоматически будут добавляться ВМ из группы ВМ.

1. Выберите один из вариантов дальнейшей миграции пользовательской нагрузки с сетевого балансировщика на L7-балансировщик. Выбор зависит от наличия у обработчика сетевого балансировщика публичного IP-адреса с защитой или без защиты от DDoS:

    * Если [используется IP-адрес с защитой от DDoS](#ip-with-ddos-protection), при миграции публичный IP-адрес для вашего сервиса сохранится.
    * Если [используется IP-адрес без защиты от DDoS](#ip-without-ddos-protection), при миграции публичный IP-адрес для вашего сервиса изменится.

### Обработчик сетевого балансировщика использует публичный IP-адрес с защитой от DDoS {#ip-with-ddos-protection}

1. Наблюдайте за [состоянием целевых ресурсов](../../network-load-balancer/operations/check-resource-health.md) сетевого балансировщика. Дождитесь автоматического удаления целевых ресурсов из целевой группы.

1. [Удалите обработчик](../../network-load-balancer/operations/listener-remove.md) в сетевом балансировщике для освобождения статического публичного IP-адреса.

1. В L7-балансировщике назначьте обработчику публичный IP-адрес, который ранее был у сетевого балансировщика:

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

        Где `address` — это публичный IP-адрес, который ранее был у сетевого балансировщика.

    {% endlist %}

1. После изменения IP-адреса восстановится доступность вашего сервиса через L7-балансировщик. Наблюдайте за пользовательской нагрузкой, поступающей на L7-балансировщик, на графиках [статистики работы балансировщика](../../application-load-balancer/operations/application-load-balancer-get-stats.md).

1. Удалите освободившийся статический публичный IP-адрес, который был выбран при создании L7-балансировщика.

1. (Опционально) После переноса пользовательской нагрузки на L7-балансировщик [удалите сетевой балансировщик](../../network-load-balancer/operations/load-balancer-delete.md).

### Обработчик сетевого балансировщика использует публичный IP-адрес без защиты от DDoS {#ip-without-ddos-protection}

{% include [group-vm-not-save-public-ip](../_tutorials_includes/migration-from-nlb-to-alb/group-vm-not-save-public-ip.md) %}
