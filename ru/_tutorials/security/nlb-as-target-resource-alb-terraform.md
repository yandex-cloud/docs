# Миграция сервисов с внешнего балансировщика NLB на L7-балансировщик ALB с целевым ресурсом — внутренним сетевым балансировщиком NLB с помощью {{ TF }}


Чтобы мигрировать сервис с сетевого балансировщика на L7-балансировщик:

1. [Ознакомьтесь с рекомендациями по миграции сервисов](#recommendations).
1. [Создайте инфраструктуру](#deploy). На этом этапе вы подключите профиль безопасности {{ sws-name }} к виртуальному хосту L7-балансировщика.
1. [Создайте внутренний сетевой балансировщик для Ingress-контроллера NGINX](#create-internal-nlb).
1. [Проверьте работу L7-балансировщика](#test).
1. [Мигрируйте пользовательскую нагрузку с сетевого балансировщика на L7-балансировщик](#migration-nlb-to-alb).

## Рекомендации по миграции сервисов {#recommendations}

{% include [recommendations](../_tutorials_includes/migration-from-nlb-to-alb/recommendations.md) %}

## Создайте внутренний сетевой балансировщик для Ingress-контроллера NGINX {#create-internal-nlb}

{% include [create-internal-nlb](../_tutorials_includes/migration-from-nlb-to-alb/create-internal-nlb.md) %}

## Создайте инфраструктуру для L7-балансировщика {#deploy}

1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

1. Скачайте в ту же рабочую директорию файл конфигурации в зависимости от используемого протокола:
    * `HTTP` — файл конфигурации [alb-int-nlb-http.tf](https://github.com/yandex-cloud-examples/yc-nlb-alb-internal-lb-migration/blob/main/alb-int-nlb-http.tf).
    * `HTTPS` — файл конфигурации [alb-int-nlb-https.tf](https://github.com/yandex-cloud-examples/yc-nlb-alb-internal-lb-migration/blob/main/alb-int-nlb-https.tf).

    В этих файлах описаны:

    * [подсети](../../vpc/concepts/network.md#subnet) для L7-балансировщика;
    * [группа безопасности](../../vpc/concepts/security-groups.md) для L7-балансировщика;
    * статический адрес для L7-балансировщика;
    * импорт TLS-сертификата в {{ certificate-manager-name }} (если используется протокол `HTTPS`);
    * профиль безопасности {{ sws-name }};
    * целевая группа, группа бэкендов и HTTP-роутер для L7-балансировщика;
    * L7-балансировщик.

1. В конфигурационном файле задайте пользовательские параметры:

    1. Укажите значения переменных:

        * `domain_name` — имя домена вашего сервиса.
        * `network_id` — идентификатор сети, в которой находятся виртуальные машины из целевой группы сетевого балансировщика нагрузки.
        * `ip_address_int_nlb` — внутренний IP-адрес [созданного ранее](#create-internal-nlb) внутреннего сетевого балансировщика.
        * `certificate` (если используется протокол `HTTPS`) — путь к файлу самоподписанного пользовательского сертификата.
        * `private_key` (если используется протокол `HTTPS`) — путь к файлу с закрытым ключом.

1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

    ```bash
    terraform validate
    ```

    Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

1. Создайте необходимую инфраструктуру:

    {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

1. Укажите настройки автомасштабирования в L7-балансировщике:

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором создан L7-балансировщик.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
    1. Нажмите на имя нужного балансировщика.
    1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
    1. В блоке **{{ ui-key.yacloud.alb.section_autoscale-settings }}** укажите ограничения на количество [ресурсных единиц](../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling).

## Проверьте работу L7-балансировщика {#test}

1. Дождитесь, когда L7-балансировщик перейдет в статус `Active`.

1. Перейдите в созданный L7-балансировщик и слева выберите **{{ ui-key.yacloud.alb.label_healthchecks }}**. Убедитесь, что все проверки состояния L7-балансировщика показывают состояние `HEALTHY`.

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

    1. Откройте конфигурационный файл, который вы использовали для создания L7-балансировщика (`alb-int-nlb-http.tf` или `alb-int-nlb-https.tf`).

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

        Где `address` — это публичный IP-адрес, который ранее был у сетевого балансировщика.

    1. Примените изменения:

        {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

1. После изменения IP-адреса восстановится доступность вашего сервиса через L7-балансировщик. Наблюдайте за пользовательской нагрузкой, поступающей на L7-балансировщик, на графиках [статистики работы балансировщика](../../application-load-balancer/operations/application-load-balancer-get-stats.md).

1. Удалите освободившийся статический публичный IP-адрес, который был выбран при создании L7-балансировщика.

    1. Откройте конфигурационный файл, который вы использовали для создания L7-балансировщика (`alb-int-nlb-http.tf` или `alb-int-nlb-https.tf`).

    1. Удалите из файла описание ресурса `yandex_vpc_address`:

        ```hcl
        resource "yandex_vpc_address" "static-address" {
          description = "Static public IP address for the Application Load Balancer"
          name        = "alb-static-address"
          external_ipv4_address {
            zone_id                  = "ru-central1-a"
            ddos_protection_provider = "qrator"
          }
        }
        ```

    1. Примените изменения:

        {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

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
