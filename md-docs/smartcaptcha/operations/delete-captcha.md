# Удалить капчу

В этом разделе вы узнаете, как удалить [капчу](../concepts/validation.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex SmartCaptcha**.
    1. Выберите капчу и нажмите ![image](../../_assets/console-icons/ellipsis.svg) → **Удалить**.
    1. Подтвердите удаление.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления капчи:

      ```bash
      yc smartcaptcha captcha delete --help
      ```

  1. Получите список капч:
     
     ```bash
     yc smartcaptcha captcha list
     ```
     
     Результат:
     
     ```text
     +----------------------+---------+---------------------+------------+----------------+----------------+-------------+
     |          ID          |  NAME   |       CREATED       | COMPLEXITY | PRE-CHECK TYPE | CHALLENGE TYPE | RULES COUNT |
     +----------------------+---------+---------------------+------------+----------------+----------------+-------------+
     | bpne29ifsca8******** | test    | 2025-02-24 17:16:13 | MEDIUM     | CHECKBOX       | IMAGE_TEXT     |           0 |
     | bpnm7lhokq2t******** | prod    | 2025-02-26 09:12:02 | MEDIUM     | CHECKBOX       | IMAGE_TEXT     |           0 |
     | bpn43btuo4g9******** | website | 2025-02-26 09:12:42 | MEDIUM     | CHECKBOX       | IMAGE_TEXT     |           0 |
     +----------------------+---------+---------------------+------------+----------------+----------------+-------------+
     ```
  1. Удалите капчу, указав ее имя или идентификатор:

      ```bash
      yc smartcaptcha captcha delete <имя_или_идентификатор_капчи>
      ```

      Результат:
      
      ```text
      id: bpnd6cm6qpr5********
      folder_id: b1g0ijbfaqsn********
      cloud_id: b1gia87mbaom********
      client_key: ysc1_2lla0Yn6dhlnEaTv2QNg2BhuA8Nqlyk4L7pZk3dz********
      created_at: "2025-03-02T21:38:48.830498Z"
      name: my-first-captcha
      allowed_sites:
        - exmaple.ru
        - exmaple.kz
      complexity: MEDIUM
      style_json: '{"focus-color":"rgb(250, 192, 0)","base-background-color":"#fff"}'
      turn_off_hostname_check: true
      pre_check_type: CHECKBOX
      challenge_type: IMAGE_TEXT
      security_rules:
        - name: rule1
          priority: "11"
          description: My first security rule.
          condition:
            host:
              hosts:
                - exact_match: example.com
                - exact_match: example.net
          override_variant_uuid: variant-1
        - name: rule2
          priority: "12"
          condition:
            source_ip:
            geo_ip_match:
              locations:
                - ru
                - kz
          override_variant_uuid: variant-2
      override_variants:
        - uuid: variant-1
          description: override variant 1
          complexity: EASY
          pre_check_type: CHECKBOX
          challenge_type: SILHOUETTES
        - uuid: variant-2
          description: override variant 2
          complexity: HARD
          pre_check_type: SLIDER
          challenge_type: KALEIDOSCOPE
      ```

- Terraform {#tf}

   [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
   
   Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
   
   Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

   Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   Чтобы удалить капчу, созданную с помощью Terraform:

   1. Откройте файл конфигураций Terraform и удалите фрагмент с описанием ресурса `yandex_smartcaptcha_captcha`:

      {% cut "Пример описания капчи в конфигурации Terraform" %}

      ```hcl
      resource "yandex_smartcaptcha_captcha" "<имя_капчи>" {
        name                    = "<имя_капчи>"
        turn_off_hostname_check = True  
        complexity              = "<сложность_задания>"
        pre_check_type          = "<тип_основного_задания>"
        challenge_type          = "<тип_дополнительного_задания>"
      
        style_json = jsonencode({
          light    = jsonencode(<объект_json>)
          dark = jsonencode(<объект_json>)
        })
      
        allowed_sites = [
          "<первый_хост>",
          "<второй_хост>"
        ]
      
        # Первый вариант задания
        override_variant {
          uuid        = "<идентификатор_варианта_1>"
          description = "<описание_варианта_1>"
      
          complexity     = "<сложность_задания>"
          pre_check_type = "<основное_задание>"
          challenge_type = "<дополнительное_задание>"
        }
      
        # Второй вариант задания 
        override_variant {
          uuid        = "<идентификатор_варианта_2"
          description = "<описание_варианта_2>"
      
          complexity     = "<сложность_задания>"
          pre_check_type = "<основное_задание>"
          challenge_type = "<дополнительное_задание>"
        }
      
        # Первое правило
        security_rule {
          name                  = "<название_правила_1>"
          priority              = <приоритет_правила_1>
          description           = "<описание_правила_1>"
          override_variant_uuid = "<идентификатор_варианта_задания>"
      
          condition {
            host {
              hosts {
                exact_match = "example.com"
              }
              hosts {
                exact_match = "example.net"
              }
            }
          }
        }
      
        # Второе правило
        security_rule {
          name                  = "<название_правила_2>"
          priority              = <приоритет_правила_2>
          description           = "<описание_правила_2>"
          override_variant_uuid = "<идентификатор_варианта_задания>"
      
          condition {
            source_ip {
              geo_ip_match {
                locations = ["ru", "kz"]
              }
            }
          }
        }
      }
      ```

      {% endcut %}

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
      
      Проверить удаление ресурсов можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

      ```bash
      yc smartcaptcha captcha list
      ```

- API {#api}

   Чтобы удалить капчу, воспользуйтесь методом REST API [delete](../api-ref/Captcha/delete.md) для ресурса [Captcha](../api-ref/Captcha/index.md) или вызовом gRPC API [Captcha/Delete](../api-ref/grpc/Captcha/delete.md).

{% endlist %}

[Ключи](../concepts/keys.md) удаленной капчи прекратят действовать. Сервис вернет сообщения об ошибке в ответ на все запросы с этими ключами.