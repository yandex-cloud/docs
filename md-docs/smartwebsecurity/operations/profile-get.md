# Получить информацию о профиле безопасности

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль безопасности](../concepts/profiles.md).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Smart Web Security**.
  1. На панели слева выберите ![shield-check](../../_assets/console-icons/shield-check.svg) **Профили безопасности**.
  1. Выберите нужный профиль безопасности.
  1. На странице **Обзор** отобразится подробная информация о профиле.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации о [профиле безопасности](../concepts/profiles.md):

      ```bash
      yc smartwebsecurity security-profile --help
      ```

  1. Получите информацию о профиле безопасности, указав его имя или идентификатор:

      ```bash
      yc smartwebsecurity security-profile get <имя_профиля_безопасности>
      ```

      Результат:

      ```text
      id: fev0mcqgth1q********
      folder_id: b1geoelk7fld********
      name: demo-profile-simple
      default_action: ALLOW
      security_rules:
        - name: smart-protection
          priority: "99999"
          smart_protection:
            mode: API
        - name: rule-condition-2
          priority: "1"
          rule_condition:
            action: ALLOW
            condition:
              authority:
                authorities:
                  - exact_match: example.com
                  - exact_match: example.net
      created_at: "2024-11-20T17:49:53.615527Z"
      cloud_id: b1gia87mbaom********
      captcha_id: bpna2egcj76e********
      advanced_rate_limiter_profile_id: fevihb5krdcp********
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы получить информацию о [профиле безопасности](../concepts/profiles.md) с помощью Terraform:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

     ```hcl
     data "yandex_sws_security_profile" "my-profile" {
       security_profile_id = "<идентификатор_профиля_безопасности>"
     }

     output "profile-created" {
       value = data.yandex_sws_security_profile.my-profile.created_at
     }
     ```

     Где:
     * `data "yandex_sws_security_profile"` — описание профиля безопасности в качестве источника данных:
       * `security_profile_id` — идентификатор профиля безопасности.
     * `output "profile-created"` — выходная переменная, которая содержит информацию о временной метке создания профиля безопасности:
       * `value` — возвращаемое значение.

     Вместо `created_at` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_sws_security_profile` см. в [документации провайдера](../../terraform/data-sources/sws_security_profile.md).

  1. Создайте ресурсы:

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

     Terraform создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

     Результат:

     ```text
     profile-created = "2024-11-20T17:49:53Z"
     ```

- API {#api}

  Чтобы получить подробную информацию о [профиле безопасности](../concepts/profiles.md), воспользуйтесь методом REST API [get](../api-ref/SecurityProfile/get.md) для ресурса [SecurityProfile](../api-ref/SecurityProfile/index.md) или вызовом gRPC API [SecurityProfile/Get](../api-ref/grpc/SecurityProfile/get.md) и передайте в запросе идентификатор нужного профиля безопасности в параметре `securityProfileId`.

{% endlist %}

#### См. также {#see-also}

* [Посмотреть операции с профилями](operation-logs.md)
* [Получить информацию о профиле WAF](waf-profile-get.md)
* [Получить информацию о профиле ARL](arl-profile-get.md)