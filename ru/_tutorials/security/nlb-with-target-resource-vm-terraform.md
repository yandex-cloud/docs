# Миграция сервисов с балансировщика NLB с целевыми ресурсами из виртуальных машин на L7-балансировщик ALB с помощью {{ TF }}


Чтобы мигрировать сервис с сетевого балансировщика на L7-балансировщик с помощью {{ TF }}:

1. [Ознакомьтесь с рекомендациями по миграции сервисов](#recommendations).
1. [Создайте инфраструктуру](#deploy). На этом этапе вы подключите профиль безопасности {{ sws-name }} к виртуальному хосту L7-балансировщика.
1. [Проверьте работу L7-балансировщика](#test).
1. [Мигрируйте пользовательскую нагрузку с сетевого балансировщика на L7-балансировщик](#migration-nlb-to-alb).

## Рекомендации по миграции сервисов {#recommendations}

{% include [recommendations](../_tutorials_includes/migration-from-nlb-to-alb/recommendations.md) %}

## Создайте инфраструктуру {#deploy}

1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

1. Скачайте в ту же рабочую директорию файл конфигурации в зависимости от используемого протокола:
    * `HTTP` — файл конфигурации [alb-vm-http.tf](https://github.com/yandex-cloud-examples/yc-nlb-alb-vm-migration/blob/main/alb-vm-http.tf).
    * `HTTPS` — файл конфигурации [alb-vm-https.tf](https://github.com/yandex-cloud-examples/yc-nlb-alb-vm-migration/blob/main/alb-vm-https.tf).

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
        * `certificate` (если используется протокол `HTTPS`) — путь к файлу самоподписанного пользовательского сертификата.
        * `private_key` (если используется протокол `HTTPS`) — путь к файлу с закрытым ключом.

    1. Для ресурса `yandex_alb_target_group` добавьте столько блоков `target`, сколько виртуальных машин находится в целевой группе вашего сетевого балансировщика нагрузки:

        ```hcl
        resource "yandex_alb_target_group" "alb-target-group" {
          ...
          target {
            subnet_id    = "<идентификатор_подсети>"
            ip_address   = "<внутренний_IP-адрес_ВМ_1>"
          }
          target {
            subnet_id    = "<идентификатор_подсети>"
            ip_address   = "<внутренний_IP-адрес_ВМ_2>"
          }
          ...
          target {
            subnet_id    = "<идентификатор_подсети>"
            ip_address   = "<внутренний_IP-адрес_ВМ_N>"
          }
        }
        ```

        Где:

        * `subnet_id` — идентификатор подсети, в которой расположена виртуальная машина.
        * `ip_address` — внутренний IP-адрес виртуальной машины, указанной в целевой группе вашего сетевого балансировщика нагрузки.

    1. Если для вашего сервиса требуется, чтобы запросы в рамках одной пользовательской сессии обрабатывал один и тот же ресурс бэкенда, включите для группы бэкендов [привязку сессий](../../application-load-balancer/concepts/backend-group.md#session-affinity) (session affinity) — для ресурса `yandex_alb_backend_group` раскомментируйте блок:

        ```hcl
        session_affinity {
          connection {
            source_ip = true
          }
        }
        ```

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

## Мигрируйте пользовательскую нагрузку с сетевого балансировщика на L7-балансировщик {#migration-nlb-to-alb}

Выберите один из вариантов миграции:

* [Сохранить публичный IP-адрес для вашего сервиса](#save-public-ip).
* [Не сохранять публичный IP-адрес для вашего сервиса](#not-save-public-ip).

### Сохранить публичный IP-адрес для вашего сервиса {#save-public-ip}

1. Если у сетевого балансировщика используется динамический публичный IP-адрес, [сделайте его статическим](../../vpc/operations/set-static-ip.md).

1. В сетевом балансировщике [удалите обработчик](../../network-load-balancer/operations/listener-remove.md) для освобождения статического публичного IP-адреса. После этого ваш сервис не будет доступен через сетевой балансировщик.

1. В L7-балансировщике назначьте обработчику публичный IP-адрес, который ранее был у сетевого балансировщика:

    1. Откройте конфигурационный файл, который вы использовали для создания L7-балансировщика (`alb-vm-http.tf` или `alb-vm-https.tf`).

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

1. Удалите освободившийся статический публичный IP-адрес, который был выбран при создании L7-балансировщика:

    1. Откройте конфигурационный файл, который вы использовали для создания L7-балансировщика (`alb-vm-http.tf` или `alb-vm-https.tf`).

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

{% include [vm-not-save-public-ip](../_tutorials_includes/migration-from-nlb-to-alb/vm-not-save-public-ip.md) %}
