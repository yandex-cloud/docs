# Получить информацию о капче

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [капча](../concepts/validation.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha_ru }}**.
  1. Выберите капчу. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о капче.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для просмотра информации о [капче](../concepts/validation.md):

     ```bash
     yc smartcaptcha captcha get --help
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

  1. Получите подробную информацию о капче, указав ее имя или идентификатор:

     ```bash
     yc smartcaptcha captcha get <идентификатор_капчи>
     ```

     Результат:

      ```text
     id: bpne29ifsca8********
     folder_id: b1geoelk7fld********
     cloud_id: b1gia87mbaom********
     client_key: ysc1_MtyvvAUieCSUfHb6tugqFAbTyesgGzXWU50sZq0E********
     created_at: "2025-02-24T17:16:13.034742Z"
     name: test
     allowed_sites:
       - example.com
     complexity: MEDIUM
     pre_check_type: CHECKBOX
     challenge_type: IMAGE_TEXT
     ```

- {{ TF }}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию о [капче](../concepts/validation.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

      ```hcl
      data "yandex_smartcaptcha_captcha" "my-captcha" {
        captcha_id = "<идентификатор_капчи>"
      }

      output "my-сlient-key" {
        value = data.yandex_smartcaptcha_captcha.my-captcha.client_key
      }
      ```

      Где:

      * `data "yandex_smartcaptcha_captcha"` — описание капчи в качестве источника данных:
         * `resource_id` — идентификатор ресурса.
      * `output "ref_description"` — выходная переменная, которая содержит информацию о [клиентском ключе](../concepts/keys.md) (`client_key`):
         * `value` — возвращаемое значение.

     Вместо `client_key` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_smartcaptcha_captcha` см. в [документации провайдера]({{ tf-provider-datasources-link }}/smartcaptcha_captcha).

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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      my-сlient-key = ysc1_MtyvvAUieCSUfHb6tugqFAbTyesgGzXWU50sZq0E********
      ...
      ```

- API {#api}

  Чтобы получить подробную информацию о [капче](../concepts/validation.md), воспользуйтесь методом REST API [get](../api-ref/Captcha/get.md) для ресурса [Captcha](../api-ref/Captcha/index.md) или вызовом gRPC API [CaptchaService/Get](../api-ref/grpc/Captcha/get.md).

{% endlist %}