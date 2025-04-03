# Миграция сервисов с балансировщика NLB с целевыми ресурсами из кластера {{ managed-k8s-full-name }} на L7-балансировщик ALB с помощью {{ TF }}


Чтобы мигрировать сервис с сетевого балансировщика на L7-балансировщик:

1. [Ознакомьтесь с рекомендациями по миграции сервисов](#recommendations).
1. [Создайте инфраструктуру](#deploy). На этом этапе вы подключите профиль безопасности {{ sws-name }} к виртуальному хосту L7-балансировщика.
1. [Установите Ingress-контроллер {{ alb-name }} и создайте ресурсы в кластере {{ managed-k8s-name }}](#install-ingress-nginx). На этом этапе вы подключите профиль безопасности {{ sws-name }} к L7-балансировщику.
1. [Проверьте работу L7-балансировщика](#test).
1. [Мигрируйте пользовательскую нагрузку с сетевого балансировщика на L7-балансировщик](#migration-nlb-to-alb).

## Рекомендации по миграции сервисов {#recommendations}

{% include [k8s-recommendations](../_tutorials_includes/migration-from-nlb-to-alb/k8s-recommendations.md) %}

## Создайте инфраструктуру {#deploy}

1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

1. Скачайте в ту же рабочую директорию файл конфигурации в зависимости от используемого протокола:
    * `HTTP` — файл конфигурации [alb-k8s-http.tf](https://github.com/yandex-cloud-examples/yc-nlb-alb-k8s-migration/blob/main/alb-k8s-http.tf).
    * `HTTPS` — файл конфигурации [alb-k8s-https.tf](https://github.com/yandex-cloud-examples/yc-nlb-alb-k8s-migration/blob/main/alb-k8s-https.tf).

    В этих файлах описаны:

    * [подсети](../../vpc/concepts/network.md#subnet) для L7-балансировщика;
    * [группа безопасности](../../vpc/concepts/security-groups.md) для L7-балансировщика;
    * статический адрес для L7-балансировщика;
    * импорт TLS-сертификата в {{ certificate-manager-name }} (если используется протокол `HTTPS`);
    * профиль безопасности {{ sws-name }}.

1. В конфигурационном файле укажите значения переменных:

    * `domain_name` — имя домена вашего сервиса.
    * `network_id` — идентификатор сети, в которой находятся виртуальные машины из целевой группы сетевого балансировщика нагрузки.
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

## Установите Ingress-контроллер {{ alb-name }} и создайте ресурсы в кластере {{ managed-k8s-name }} {#install-ingress-nginx}

{% include [k8s-install-ingress-nginx](../_tutorials_includes/migration-from-nlb-to-alb/k8s-install-ingress-nginx.md) %}

## Проверьте работу L7-балансировщика {#test}

{% include [test](../_tutorials_includes/migration-from-nlb-to-alb/test.md) %}

## Мигрируйте пользовательскую нагрузку с сетевого балансировщика на L7-балансировщик {#migration-nlb-to-alb}

Выберите один из вариантов миграции:

* [Сохранить публичный IP-адрес для вашего сервиса](#save-public-ip).
* [Не сохранять публичный IP-адрес для вашего сервиса](#not-save-public-ip).

### Сохранить публичный IP-адрес для вашего сервиса {#save-public-ip}

1. Если у сетевого балансировщика используется динамический публичный IP-адрес, [сделайте его статическим](../../vpc/operations/set-static-ip.md).

1. В сетевом балансировщике [удалите все обработчики](../../network-load-balancer/operations/listener-remove.md) для освобождения статического публичного IP-адреса. После этого ваш сервис не будет доступен через сетевой балансировщик.

1. В L7-балансировщике назначьте обработчику публичный IP-адрес, который ранее был у сетевого балансировщика:

    1. Откройте YAML-файл с описанием ресурса `Ingress`.
    1. В разделе `annotations` для поля `ingress.alb.yc.io/external-ipv4-address` укажите публичный IP-адрес, который ранее был у сетевого балансировщика.
    1. Примените изменения с помощью команды:

        ```bash
        kubectl apply -f <файл_с_ресурсом_Ingress>
        ```

1. Дождитесь завершения изменения публичного IP-адреса у ресурса `Ingress`. Посмотреть информацию о ресурсе вы можете с помощью команды:

    ```bash
    kubectl get ingress <имя_ресурса_Ingress> -w
    ```

    После изменения IP-адреса восстановится доступность вашего сервиса через L7-балансировщик.

1. Перейдите в L7-балансировщик:

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится кластер {{ managed-k8s-name }}.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
    1. Выберите нужный кластер.
    1. Слева выберите ![image](../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.k8s.cluster.switch_network }}**, а в правой части — вкладку **{{ ui-key.yacloud.k8s.network.label_ingress }}**. Для вашего `Ingress`-ресурса в столбце **Балансировщик** перейдите по ссылке на L7-балансировщик.
    1. Наблюдайте за пользовательской нагрузкой, поступающей на L7-балансировщик, на графиках [статистики работы балансировщика](../../application-load-balancer/operations/application-load-balancer-get-stats.md).

1. Удалите освободившийся статический публичный IP-адрес, который был зарезервирован для L7-балансировщика:

    1. Откройте конфигурационный файл, который вы использовали для создания L7-балансировщика (`alb-k8s-http.tf` или `alb-k8s-https.tf`).

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

1. (Опционально) После переноса пользовательской нагрузки на L7-балансировщик [удалите сетевой балансировщик](../../network-load-balancer/operations/load-balancer-delete.md).

### Не сохранять публичный IP-адрес для вашего сервиса {#not-save-public-ip}

1. Чтобы мигрировать пользовательскую нагрузку с сетевого балансировщика на L7-балансировщик, в DNS-сервисе, обслуживающем публичную зону вашего домена, измените значение А-записи для доменного имени сервиса на публичный IP-адрес L7-балансировщика. Если публичная зона домена была создана в [{{ dns-full-name }}](../../dns/), то измените запись [по инструкции](../../dns/operations/resource-record-update.md).

    {% note info %}

    Распространение изменений в записи DNS зависит от значения времени жизни записи (TTL) и количества звеньев цепочки DNS-запросов. Это может занять продолжительное время.

    {% endnote %}

1. По мере распространения изменений в записи DNS наблюдайте за ростом запросов, поступающих на L7-балансировщик:

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится кластер {{ managed-k8s-name }}.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
    1. Выберите нужный кластер.
    1. Слева выберите ![image](../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.k8s.cluster.switch_network }}**, а в правой части — вкладку **{{ ui-key.yacloud.k8s.network.label_ingress }}**. Для вашего `Ingress`-ресурса в столбце **Балансировщик** перейдите по ссылке на L7-балансировщик.
    1. Наблюдайте за пользовательской нагрузкой, поступающей на L7-балансировщик, на графиках [статистики работы балансировщика](../../application-load-balancer/operations/application-load-balancer-get-stats.md).

1. Наблюдайте за снижением нагрузки на сетевой балансировщик с помощью [метрик балансировщика](../../monitoring/metrics-ref/network-load-balancer-ref.md) `processed_bytes` и `processed_packets`. Для визуализации этих метрик можно [создать дашборд](../../monitoring/operations/dashboard/create.md). Отсутствие нагрузки на сетевом балансировщике в течение продолжительного времени свидетельствует о том, что перенос пользовательской нагрузки на L7-балансировщик завершен.

1. (Опционально) После переноса пользовательской нагрузки на L7-балансировщик [удалите сетевой балансировщик](../../network-load-balancer/operations/load-balancer-delete.md).
