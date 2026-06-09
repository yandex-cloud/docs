# Разрешить и запретить отключение зоны доступности


Когда в одной из [зон доступности](../../../overview/concepts/geo-scope.md) проводится обслуживание или наблюдаются неполадки, специалисты {{ yandex-cloud }} могут временно отключить эту зону. В этом случае балансировщик автоматически распределит трафик между оставшимися зонами. После восстановления зоны она подключается, и трафик снова распределяется равномерно.

Вы можете разрешить или запретить автоматическое отключение зоны доступности. При этом нельзя выбрать конкретную зону для отключения. Перед разрешением автоматического режима можно протестировать [отключение разных зон доступности](start-and-cancel-shift.md).

По умолчанию отключение зоны доступности не разрешено.

## Разрешить отключение зоны доступности {#allow}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  При [создании](../application-load-balancer-create.md) или [изменении](../application-load-balancer-update.md) L7-балансировщика укажите параметр `--allow-zonal-shift`, например:

  ```bash
  yc application-load-balancer load-balancer update \
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

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. В конфигурационном файле в описании ресурса `yandex_alb_load_balancer` укажите параметр `allow_zonal_shift` со значением `true`:

      ```hcl
      resource "yandex_alb_load_balancer" "my-balancer" {
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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      {{ TF }} изменит все требуемые ресурсы. Проверить изменение ресурсов можно в [консоли управления]({{ link-console-main }}).

      {% note warning "Ограничения по времени" %}
      
      Провайдер {{ TF }} ограничивает время на выполнение операций с балансировщиками {{ alb-name }} 10 минутами.
      
      Операции, которые длятся дольше указанного времени, прерываются.
      
      {% cut "Как изменить эти ограничения?" %}
      
      Добавьте к описанию балансировщика блок `timeouts`, например:
      
      ```hcl
      resource "yandex_alb_load_balancer" "<имя_балансировщика>" {
        ...
        timeouts {
          create = "60m"
          update = "60m"
          delete = "60m"
        }
      }
      ```
      
      {% endcut %}
      
      {% endnote %}

  Более подробную информацию о параметрах ресурса `yandex_alb_load_balancer` см. в [документации провайдера]({{ tf-provider-datasources-link }}/alb_load_balancer).

- API {#api}

  Чтобы разрешить перенос трафика при создании L7-балансировщика, воспользуйтесь методом REST API [create](../../api-ref/LoadBalancer/create.md) для ресурса [LoadBalancer](../../api-ref/LoadBalancer/index.md) и укажите `"allowZonalShift": "true"` или вызовом gRPC API [LoadBalancerService/Create](../../api-ref/grpc/LoadBalancer/create.md) и укажите `"allow_zonal_shift": "true"`.

  Чтобы разрешить перенос трафика при изменении L7-балансировщика, воспользуйтесь методом REST API [update](../../api-ref/LoadBalancer/update.md) для ресурса [LoadBalancer](../../api-ref/LoadBalancer/index.md) и укажите `"allowZonalShift": "true"` или вызовом gRPC API [LoadBalancerService/Update](../../api-ref/grpc/LoadBalancer/update.md) и укажите `"allow_zonal_shift": "true"`.

{% endlist %}


## Запретить отключение зоны доступности {#deny}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  При создании или изменении L7-балансировщика укажите параметр `--allow-zonal-shift=false`, например:

  ```bash
  yc application-load-balancer load-balancer update \
    <имя_или_идентификатор_балансировщика> \
    --allow-zonal-shift=false
  ```

  Результат:

  ```text
  id: ds70q425egoe********
  name: my-balancer
  ...
  ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. В конфигурационном файле в описании ресурса `yandex_alb_load_balancer` укажите параметр `allow_zonal_shift` со значением `false`:

      ```hcl
      resource "yandex_alb_load_balancer" "my-balancer" {
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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      {{ TF }} изменит все требуемые ресурсы. Проверить изменение ресурсов можно в [консоли управления]({{ link-console-main }}).

      {% note warning "Ограничения по времени" %}
      
      Провайдер {{ TF }} ограничивает время на выполнение операций с балансировщиками {{ alb-name }} 10 минутами.
      
      Операции, которые длятся дольше указанного времени, прерываются.
      
      {% cut "Как изменить эти ограничения?" %}
      
      Добавьте к описанию балансировщика блок `timeouts`, например:
      
      ```hcl
      resource "yandex_alb_load_balancer" "<имя_балансировщика>" {
        ...
        timeouts {
          create = "60m"
          update = "60m"
          delete = "60m"
        }
      }
      ```
      
      {% endcut %}
      
      {% endnote %}

  Более подробную информацию о параметрах ресурса `yandex_alb_load_balancer` см. в [документации провайдера]({{ tf-provider-datasources-link }}/alb_load_balancer).

- API {#api}

  Чтобы запретить перенос трафика при создании L7-балансировщика, воспользуйтесь методом REST API [create](../../api-ref/LoadBalancer/create.md) для ресурса [LoadBalancer](../../api-ref/LoadBalancer/index.md) и укажите `"allowZonalShift": "false"` или вызовом gRPC API [LoadBalancerService/Create](../../api-ref/grpc/LoadBalancer/create.md) и укажите `"allow_zonal_shift": "false"`.

  Чтобы запретить перенос трафика при изменении L7-балансировщика, воспользуйтесь методом REST API [update](../../api-ref/LoadBalancer/update.md) для ресурса [LoadBalancer](../../api-ref/LoadBalancer/index.md) и укажите `"allowZonalShift": "false"` или вызовом gRPC API [LoadBalancerService/Update](../../api-ref/grpc/LoadBalancer/update.md) и укажите `"allow_zonal_shift": "false"`.

{% endlist %}


#### Что дальше {whats-next}

* [{#T}](start-and-cancel-shift.md)