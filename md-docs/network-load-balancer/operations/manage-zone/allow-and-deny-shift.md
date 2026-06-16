# Разрешить и запретить перенос трафика между зонами доступности

Когда в одной из [зон доступности](../../../overview/concepts/geo-scope.md) проводится обслуживание или наблюдаются неполадки, вы можете разрешить Yandex Cloud автоматически запрещать направление трафика в такую зону для вашего балансировщика. Это сохранит работоспособность ваших сервисов. При восстановлении зоны, трафик будет вновь возвращен во все зоны, которые были настроены для балансировщика.

Также вы можете самостоятельно включать и отключать необходимые зоны доступности и [тестировать перенос трафика](disable-enable-zone.md) из какой-либо зоны доступности. А после проверки разрешить перенос трафика только для определенных балансировщиков.

По умолчанию перенос трафика между зонами доступности не разрешен.


## Разрешить перенос трафика {#allow}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  При [создании](../load-balancer-create.md) или [изменении](../load-balancer-update.md) сетевого балансировщика укажите параметр `--allow-zonal-shift`, например:

    ```bash
    yc load-balancer network-load-balancer update \
      <имя_или_идентификатор_балансировщика> \
      --allow-zonal-shift
    ```

    Результат:

    ```text
    id: ds70q425egoe********
    name: my-balancer
    ...
    allow_zonal_shift: true
    ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. В конфигурационном файле в описании ресурса `yandex_lb_network_load_balancer` укажите параметр `allow_zonal_shift` со значением `true`:

      ```hcl
      resource "yandex_lb_network_load_balancer" "my-balancer" {
        ...
        allow_zonal_shift = true
        ...
      }
      ```

  1. Примените изменения:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Terraform изменит все требуемые ресурсы. Проверить изменение ресурсов можно с помощью команды [CLI](../../../cli/quickstart.md):
      
      ```bash
      yc load-balancer network-load-balancer get \
        <имя_или_идентификатор_балансировщика>
      ```

  Подробнее о параметрах ресурса `yandex_lb_network_load_balancer` в [документации провайдера](../../../terraform/data-sources/lb_network_load_balancer.md).

- API {#api}

  Чтобы разрешить перенос трафика при создании сетевого балансировщика, воспользуйтесь методом REST API [create](../../api-ref/NetworkLoadBalancer/create.md) для ресурса [NetworkLoadBalancer](../../api-ref/NetworkLoadBalancer/index.md) и укажите `"allowZonalShift": "true"` или вызовом gRPC API [NetworkLoadBalancerService/Create](../../api-ref/grpc/NetworkLoadBalancer/create.md) и укажите `"allow_zonal_shift": "true"`.

  Чтобы разрешить перенос трафика при изменении сетевого балансировщика, воспользуйтесь методом REST API [update](../../api-ref/NetworkLoadBalancer/update.md) для ресурса [NetworkLoadBalancer](../../api-ref/NetworkLoadBalancer/index.md) и укажите `"allowZonalShift": "true"` или вызовом gRPC API [NetworkLoadBalancerService/Update](../../api-ref/grpc/NetworkLoadBalancer/update.md) и укажите `"allow_zonal_shift": "true"`.

{% endlist %}


## Запретить перенос трафика {#deny}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  При создании или изменении сетевого балансировщика укажите параметр `--allow-zonal-shift=false`, например:

    ```bash
    yc load-balancer network-load-balancer update \
      <имя_или_идентификатор_балансировщика> \
      --allow-zonal-shift=false
    ```

    Результат:

    ```text
    id: ds70q425egoe********
    name: my-balancer
    ...
    ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. В конфигурационном файле в описании ресурса `yandex_lb_network_load_balancer` укажите параметр `allow_zonal_shift` со значением `false`:

      ```hcl
      resource "yandex_lb_network_load_balancer" "my-balancer" {
        ...
        allow_zonal_shift = false
        ...
      }
      ```

  1. Примените изменения:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Terraform изменит все требуемые ресурсы. Проверить изменение ресурсов можно с помощью команды [CLI](../../../cli/quickstart.md):
      
      ```bash
      yc load-balancer network-load-balancer get \
        <имя_или_идентификатор_балансировщика>
      ```

  Подробнее о параметрах ресурса `yandex_lb_network_load_balancer` в [документации провайдера](../../../terraform/data-sources/lb_network_load_balancer.md).

- API {#api}

  Чтобы запретить перенос трафика при создании сетевого балансировщика, воспользуйтесь методом REST API [create](../../api-ref/NetworkLoadBalancer/create.md) для ресурса [NetworkLoadBalancer](../../api-ref/NetworkLoadBalancer/index.md) и укажите `"allowZonalShift": "false"` или вызовом gRPC API [NetworkLoadBalancerService/Create](../../api-ref/grpc/NetworkLoadBalancer/create.md) и укажите `"allow_zonal_shift": "false"`.

  Чтобы запретить перенос трафика при изменении сетевого балансировщика, воспользуйтесь методом REST API [update](../../api-ref/NetworkLoadBalancer/update.md) для ресурса [NetworkLoadBalancer](../../api-ref/NetworkLoadBalancer/index.md) и укажите `"allowZonalShift": "false"` или вызовом gRPC API [NetworkLoadBalancerService/Update](../../api-ref/grpc/NetworkLoadBalancer/update.md) и укажите `"allow_zonal_shift": "false"`.

{% endlist %}


#### Что дальше {whats-next}

* [Отключить и включить зоны доступности](disable-enable-zone.md)