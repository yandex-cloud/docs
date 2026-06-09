# Получить информацию о профиле ARL

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль ARL](../concepts/arl.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. Выберите нужный профиль.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о профиле.

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию о [профиле ARL](../concepts/arl.md) {{ sws-full-name }} с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

     ```hcl
     data "yandex_sws_advanced_rate_limiter_profile" "arl-profile" {
        name = yandex_sws_advanced_rate_limiter_profile.arl-profile.name
     }

     output "profile-created" {
       value = data.yandex_sws_advanced_rate_limiter_profile.arl-profile.created_at
     }
     ```

     Где:
     * `data "yandex_sws_advanced_rate_limiter_profile"` — описание профиля ARL в качестве источника данных:
       * `name` — имя профиля ARL.
     * `output "profile-created"` — выходная переменная, которая содержит информацию о временной метке создания профиля ARL:
       * `value` — возвращаемое значение.

     Вместо `created_at` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_sws_advanced_rate_limiter_profile` см. в [документации провайдера]({{ tf-provider-datasources-link }}/sws_advanced_rate_limiter_profile).

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
     profile-created = "2024-12-15T12:21:20Z"
     ```

- API {#api}

  Воспользуйтесь методом REST API [get](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/get.md) для ресурса [AdvancedRateLimiterProfile](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/index.md) или вызовом gRPC API [AdvancedRateLimiterProfile/Get](../advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/get.md).

{% endlist %}