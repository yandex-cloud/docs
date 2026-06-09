# Создать внутренний сетевой балансировщик

{% note info %}

Чтобы создать [внутренний сетевой балансировщик](../concepts/nlb-types.md), необходима [роль](../security/index.md#load-balancer-private-admin) `load-balancer.privateAdmin`.

Задать тип балансировщика (внешний или внутренний) можно только при его создании. В дальнейшем изменить тип балансировщика нельзя.

{% endnote %}

Чтобы создать внутренний сетевой балансировщик:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где нужно создать балансировщик.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_create }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя балансировщика. Требования к имени:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

  1. В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_network-load-balancer-type }}** выберите `{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_internal }}`. 
  1. (Опционально) В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_advanced }}** включите защиту балансировщика от удаления.

      {% note warning %}

      Включенная защита от удаления не запрещает удалять обработчики и целевые группы балансировщика. 

      {% endnote %}

  1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_listeners }}** добавьте [обработчик](../concepts/listener.md):
      1. Нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-listener }}**.
      1. В открывшемся окне задайте параметры обработчика:
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-name }}**.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-subnet-id }}**, в которой балансировщик будет перенаправлять трафик.
          * В поле **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** выберите способ назначения обработчику IP-адреса, на котором балансировщик будет принимать трафик:

              * `{{ ui-key.yacloud.common.label_auto }}` — чтобы обработчику был автоматически назначен свободный IP-адрес из диапазона выбранной подсети.
              * `{{ ui-key.yacloud.common.label_list }}` — чтобы вручную зарезервировать в выбранной подсети нужный IP-адрес для обработчика.

                  В появившемся поле **{{ ui-key.yacloud.component.internal-v4-address-field.label_internal-address-title }}** выберите зарезервированный ранее IP-адрес или нажмите кнопку **{{ ui-key.yacloud.component.internal-v4-address-field.button_internal-address-reserve }}**, чтобы зарезервировать новый. В открывшемся окне задайте параметры резервируемого IP-адреса:

                  * **{{ ui-key.yacloud.common.name }}**.
                  * **{{ ui-key.yacloud.vpc.addresses.popup-create_field_internal-v4-address }}** — укажите свободный IP-адрес в диапазоне подсети, выбранной для обработчика.
                  * (Опционально) В поле **{{ ui-key.yacloud.vpc.addresses.popup-create_field_advanced }}** включите защиту резервируемого IP-адреса от удаления.
                  * Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
          * В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-protocol }}** выберите `{{ ui-key.yacloud.common.label_tcp }}` или `{{ ui-key.yacloud.common.label_udp }}`.

              {% note info %}

              По умолчанию обработчик работает по протоколу TCP. Чтобы использовать протокол UDP, [запросите в технической поддержке]({{ link-console-support }}) эту возможность.

              {% endnote %}

          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}**, на котором обработчик будет принимать входящий трафик. Возможные значения: от `1` до `32767`.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}**, куда балансировщик будет направлять трафик. Возможные значения: от `1` до `32767`.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
  1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}** добавьте [целевую группу](../concepts/target-resources.md):
      1. Нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-target-group }}**.
      1. Выберите целевую группу или [создайте новую](target-group-create.md):
          * В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_target-group-id }}** выберите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.button_create-target-group }}**.
          * В открывшемся окне введите имя целевой группы.
          * Добавьте в целевую группу [виртуальные машины](../../glossary/vm.md).
          * Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
      1. (Опционально) Под блоком **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check }}** нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_edit-health-check }}**. В открывшемся окне задайте параметры [проверки состояния ресурсов](../concepts/health-check.md):
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-name }}**.
          * В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}** выберите один из вариантов:

              * `{{ ui-key.yacloud.common.label_http }}`. Дополнительно в поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** укажите путь, по которому будут выполняться проверки.
              * `{{ ui-key.yacloud.common.label_tcp }}`.
              * `{{ ui-key.yacloud.common.label_http2 }}`. Дополнительно в полях **{{ ui-key.yacloud.compute.group.overview.label_host }}** и **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** укажите адрес хоста и путь, по которому будут выполняться проверки.
              * `{{ ui-key.yacloud.common.label_https }}`. Дополнительно в полях **{{ ui-key.yacloud.compute.group.overview.label_host }}** и **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** укажите адрес хоста и путь, по которому будут выполняться проверки.
              * `{{ ui-key.yacloud.common.label_grpc }}`. Дополнительно в полях **{{ ui-key.yacloud.compute.group.overview.label_service-name }}** и **{{ ui-key.yacloud.compute.group.overview.label_authority }}** укажите данные вашего gRPC-сервиса.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}** — номер порта для проверок. Возможные значения: от `1` до `32767`.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-timeout }}** — время ожидания ответа в секундах.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-interval }}** — интервал выполнения проверок состояния в секундах.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-healthy-threshold }}** — количество успешных проверок, после которого виртуальная машина будет считаться готовой к приему трафика.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-unhealthy-threshold }}** — количество проваленных проверок, после которого на виртуальную машину перестанет подаваться трафик.
	    1. Нажмите кнопку **{{ ui-key.yacloud.common.apply }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}
  
  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
  
  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  1. Перед созданием балансировщика [создайте целевую группу](target-group-create.md), чтобы подключить ее к балансировщику.

  1. Посмотрите описание команды CLI для создания сетевого балансировщика:

     ```bash
     yc load-balancer network-load-balancer create --help
     ```

  1. Чтобы создать внутренний балансировщик с [обработчиком](../concepts/listener.md) и [целевой группой](../concepts/target-resources.md), выполните команду:

     ```bash
     yc load-balancer network-load-balancer create <имя_балансировщика> \
        --type=internal \
        --deletion-protection \
        --listener name=<имя_обработчика>,`
                   `port=<порт>,`
                   `target-port=<целевой_порт>,`
                   `protocol=<протокол>,`
                   `internal-subnet-id=<идентификатор_подсети>,`
                   `internal-ip-version=<версия_IP-адреса>,`
                   `internal-address=<IP-адрес_обработчика> \
        --target-group target-group-id=<идентификатор_целевой_группы>,`
                       `healthcheck-name=<имя_проверки_состояния>,`
                       `healthcheck-interval=<интервал_между_проверками>s,`
                       `healthcheck-timeout=<таймаут_проверки_состояния>s,`
                       `healthcheck-unhealthythreshold=<количество_проваленных_проверок_для_статуса_Unhealthy>,`
                       `healthcheck-healthythreshold=<количество_успешных_проверок_для_статуса_Healthy>,`
                       `healthcheck-tcp-port=<TCP-порт>,`
                       `healthcheck-http-port=<HTTP-порт>,`
                       `healthcheck-http-path=<адрес_URL>
     ```

     Где:

     * `--type` — тип балансировщика.
     * `--deletion-protection` — защита сетевого балансировщика от удаления. Пока опция включена, удалить балансировщик невозможно.

         {% note warning %}

         Включенная защита от удаления не запрещает удалять обработчики и целевые группы балансировщика. 

         {% endnote %}

     * `--listener` — параметры обработчика:
         * `name` — имя обработчика.
         * `port` — порт, на котором сетевой балансировщик будет принимать входящий трафик. Возможные значения: от `1` до `32767`.
         * `target-port` — целевой порт, куда балансировщик будет направлять трафик. Возможные значения: от `1` до `32767`.
         * `protocol` — протокол, по которому будет работать обработчик: `tcp` или `udp`.
         * `internal-subnet-id` — идентификатор подсети.
         * `internal-ip-version` — версия внутреннего IP-адреса: `ipv4` или `ipv6`.
         * `internal-address` — IP-адрес обработчика, не занятый другими ресурсами и относящийся к диапазону подсети, которая указана в свойстве `internal-subnet-id`.

             Если свойство `internal-address` не задано, обработчику внутреннего сетевого балансировщика назначается случайный IP-адрес из диапазона адресов выбранной [подсети](../../vpc/concepts/network.md#subnet).

     * `--target-group` — параметры целевой группы и настройки [проверки состояния её ресурсов](../concepts/health-check.md):
         * `target-group-id` — идентификатор целевой группы.
     
           Чтобы узнать идентификатор, [получите](target-group-list.md#list) список целевых групп в каталоге.
     
         * `healthcheck-name` — имя проверки состояния ресурсов.
         * `healthcheck-interval` — интервал выполнения проверок состояния в секундах. Возможные значения: от `1s` до `60s`. Интервал должен быть больше времени ожидания минимум на 1 секунду. 
         * `healthcheck-timeout` — время ожидания ответа в секундах. Возможные значения: от `1s` до `60s`.
         * `healthcheck-unhealthythreshold` — количество проваленных проверок, после которого на виртуальную машину перестанет подаваться трафик. Возможные значения: от `2` до `10`.
         * `healthcheck-healthythreshold` — количество успешных проверок, после которого виртуальная машина будет считаться готовой к приему трафика. Возможные значения: от `2` до `10`.
         * `healthcheck-tcp-port` — порт для проверок по протоколу TCP. Возможные значения: от `1` до `32767`.
         * `healthcheck-http-port` — порт для проверок по протоколу HTTP. Возможные значения: от `1` до `32767`.
         * `healthcheck-http-path` — адрес URL, по которому будут выполняться проверки по протоколу HTTP.
     
         Указывать одновременно `healthcheck-tcp-port` и `healthcheck-http-port` нельзя.
     
         {% note warning %}
         
         Для параметров `healthcheck-interval` и `healthcheck-timeout` необходимо указывать значение в формате `<время_в_секундах>s`, например `20s`.
         
         {% endnote %}

     Подробнее о команде `yc load-balancer network-load-balancer create` читайте в [справочнике {{ yandex-cloud }} CLI](../../cli/cli-ref/load-balancer/cli-ref/network-load-balancer/create.md).

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы создать внутренний сетевой балансировщик с [обработчиком](../concepts/listener.md) и [целевой группой](../concepts/target-resources.md):

  1. Опишите в конфигурационном файле параметры ресурса сетевого балансировщика:

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "<имя_балансировщика>"
       type = "internal"
       deletion_protection = <защитить_балансировщик_от_удаления>
       listener {
         name = "<имя_обработчика>"
         port = <номер_порта>
         internal_address_spec {
           subnet_id  = "<идентификатор_подсети>"
           ip_version = "<версия_IP-адреса>"
           address    = "<IP-адрес_обработчика>"
         }
       }
       attached_target_group {
         target_group_id = "<идентификатор_целевой_группы>"
         healthcheck {
           name = "<имя_проверки_состояния>"
             http_options {
               port = <номер_порта>
               path = "<адрес_URL>"
             }
         }
       }
     }
     ```

     Где:

     * `name` — имя сетевого балансировщика.
     * `type` — тип сетевого балансировщика. Используйте `internal`, чтобы создать внутренний балансировщик.
     * `deletion_protection` — защита внутреннего сетевого балансировщика от удаления. Пока опция включена, удалить балансировщик невозможно. Значение по умолчанию `false`.

       {% note warning %}

       Включенная защита от удаления не запрещает удалять обработчики и целевые группы балансировщика. 

       {% endnote %}

     * `listener` — параметры обработчика:
       * `name` — имя обработчика.
       * `port` — порт, на котором сетевой балансировщик будет принимать входящий трафик, из диапазона от `1` до `32767`.
       * `internal_address_spec` — спецификация обработчика для внутреннего балансировщика:
         * `subnet_id` — идентификатор подсети.
         * `ip_version` — описание внешнего IP-адреса. Укажите версию IP-адреса: `ipv4` или `ipv6`. По умолчанию `ipv4`.
         * `address` — IP-адрес обработчика, не занятый другими ресурсами и относящийся к диапазону подсети, которая указана в поле `subnet_id`.

             Если значение поля `address` не задано, обработчику внутреннего сетевого балансировщика назначается случайный IP-адрес из диапазона адресов выбранной [подсети](../../vpc/concepts/network.md#subnet).
     * `attached_target_group` — описание параметров целевой группы для сетевого балансировщика:
        * `target_group_id` — идентификатор целевой группы.

          Чтобы узнать идентификатор, [получите](target-group-list.md#list) список целевых групп в каталоге.

        * `healthcheck` — описание параметров проверки состояния. Укажите имя, порт из диапазона от `1` до `32767` и путь, по которому будут выполняться проверки.

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/resources/lb_network_load_balancer).

  1. Создайте сетевой балансировщик:

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

      После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы создать внутренний сетевой балансировщик, воспользуйтесь методом REST API [create](../api-ref/NetworkLoadBalancer/create.md) для ресурса [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/Create](../api-ref/grpc/NetworkLoadBalancer/create.md).

{% endlist %}

## Примеры

### Создание внутреннего сетевого балансировщика без обработчика {#without-listener}

Создайте внутренний сетевой балансировщик без обработчика и целевой группы с именем `internal-lb-test-1`.

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы создать внутренний балансировщик без обработчика, выполните команду:

  ```bash
  yc load-balancer network-load-balancer create internal-lb-test-1 \
     --type=internal
  ```

- {{ TF }} {#tf}

  1. Опишите в конфигурационном файле параметры ресурса без блока `listener` и `attached_target_group`:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "internal-lb-test-1"
       type = "internal"
       deletion_protection = "true"
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/lb_network_load_balancer).

  1. Проверьте корректность настроек.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Создайте сетевой балансировщик.

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

- API {#api}

  Воспользуйтесь методом API [create](../api-ref/NetworkLoadBalancer/create.md) и передайте в теле запроса:

  ```api
  {
    "folderId": "<идентификатор_каталога>",
    "name": "internal-lb-test-1",
    "type": "INTERNAL"
  }
  ```

{% endlist %}

### Создание внутреннего сетевого балансировщика с обработчиком и подключенной целевой группой {#with-listener-and-target-group}

Создайте внутренний сетевой балансировщик с обработчиком и подключенной целевой группой с тестовыми характеристиками:

* Имя `internal-lb-test-2`.
* Параметры обработчика:
    * Имя `test-listener`.
    * Порт `80`.
    * Целевой порт `81`.
    * Протокол `TCP`.
    * Идентификатор подсети `b0cp4drld130********`.
    * Версия IP-адреса `ipv4`.
    * IP-адрес обработчика `192.168.1.25`.
* Идентификатор целевой группы `enpu2l7q9kth********`.
* Параметры проверки состояния целевой группы:
    * Имя `http`.
    * Интервал выполнения проверок состояния `2` секунды.
    * Время ожидания ответа `1` секунда.
    * Порог неработоспособности `2`.
    * Порог работоспособности `2`.
    * Порт для проверок по протоколу HTTP `80`.
    * Адрес URL, по которому будут выполняться проверки `/`.

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните следующую команду:

  ```bash
  yc load-balancer network-load-balancer create internal-lb-test-2 \
     --type=internal \
     --listener name=test-listener,`
                `port=80,`
                `target-port=81,`
                `protocol=tcp,`
                `internal-subnet-id=b0cp4drld130********,`
                `internal-ip-version=ipv4,`
                `internal-address=192.168.1.25 \
     --target-group target-group-id=enpu2l7q9kth********,`
                    `healthcheck-name=http,`
                    `healthcheck-interval=2s,`
                    `healthcheck-timeout=1s,`
                    `healthcheck-unhealthythreshold=2,`
                    `healthcheck-healthythreshold=2,`
                    `healthcheck-http-port=80,`
                    `healthcheck-http-path=/
  ```

- {{ TF }} {#tf}

  1. Опишите в конфигурационном файле параметры ресурса с блоками `listener` и `attached_target_group`:

     ```hcl
     resource "yandex_lb_network_load_balancer" "internal-lb-test" {
       name = "internal-lb-test-2"
       type = "internal"
       deletion_protection = "true"
       listener {
         name        = "test-listener"
         port        = 80
         target_port = 81
         protocol    = "tcp"
         internal_address_spec {
           subnet_id  = "b0cp4drld130********"
           ip_version = "ipv4"
           address    = "192.168.1.25"
         }
       }
       attached_target_group {
         target_group_id = "enpu2l7q9kth********"
         healthcheck {
           name                = "http"
           interval            = 2
           timeout             = 1
           unhealthy_threshold = 2
           healthy_threshold   = 2
           http_options {
             port = 80
             path = "/"
           }
         }
       }
     }
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/lb_network_load_balancer).

  1. Проверьте корректность настроек.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Создайте сетевой балансировщик.

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

- API {#api}

  Воспользуйтесь методом API [create](../api-ref/NetworkLoadBalancer/create.md) и передайте в теле запроса:

  ```api
  {
    "folderId": "<идентификатор_каталога>",
    "name": "internal-lb-test-2",
    "type": "INTERNAL",
    "listenerSpecs": [
      {
        "name": "test-listener",
        "port": "80",
        "protocol": "TCP",
        "targetPort": "81",
        "internalAddressSpec": {
          "subnetId": "b0cp4drld130********",
          "ipVersion": "IPV4",
          "address": "192.168.1.25"
        }
      }
    ],
    "attachedTargetGroups": [
      {
        "targetGroupId": "enpu2l7q9kth********",
        "healthChecks": [
          {
            "name": "http",
            "interval": "2s",
            "timeout": "1s",
            "unhealthyThreshold": "2",
            "healthyThreshold": "2",
            "httpOptions": {
              "port": "80",
              "path": "/"
            }
          }
        ]
      }
    ]
  }
  ```

{% endlist %}