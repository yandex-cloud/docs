# Изменить основные параметры профиля ARL

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль ARL](../concepts/arl.md).
  1. Перейдите в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/arl.svg) **Профили ARL**.
  1. В строке с нужным профилем нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. В открывшемся окне измените параметры:
      * **Имя**.
      * **Описание**.
      * [**Метки**](../../resource-manager/concepts/labels.md). Чтобы добавить новую метку, нажмите кнопку **Добавить метку**.
      * Выберите или [создайте](template-create.md) шаблон ответа, который будет возвращаться клиенту при срабатывании любого правила в профиле. По умолчанию используется стандартный шаблон Yandex Cloud.
  1. Нажмите кнопку **Сохранить**.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы изменить основные параметры [профиля ARL](../concepts/arl.md):

  1. Откройте файл конфигурации Terraform и измените фрагмент с описанием ресурса `yandex_sws_advanced_rate_limiter_profile`:

      ```hcl
      # Профиль ARL

      resource "yandex_sws_advanced_rate_limiter_profile" "arl-profile" {
        name        = "<новое_имя_профиля>"
        description = "<новое_описание_профиля>"

        # Правило 1

        advanced_rate_limiter_rule {
          name        = "<имя_правила>"
          priority    = <приоритет_правила>
          description = "<описание_правила>"
          dry_run     = true

          static_quota {
            action = "DENY"
            limit  = <лимит_правила>
            period = <период_правила>
            condition {
              request_uri {
                path {
                  exact_match = "/api"
                }
              }
            }
          }
        }
      }
      ```

      Подробнее о параметрах ресурса `yandex_sws_advanced_rate_limiter_profile` в [документации провайдера](../../terraform/resources/sws_advanced_rate_limiter_profile.md).

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

       Проверить изменение ресурсов можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Воспользуйтесь методом REST API [update](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/update.md) для ресурса [AdvancedRateLimiterProfile](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/index.md) или вызовом gRPC API [AdvancedRateLimiterProfile/Update](../advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/update.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [Удалить профиль ARL](arl-profile-delete.md)
* [Добавить правило в профиль ARL](arl-rule-add.md)
* [Изменить правило в профиле ARL](arl-rule-update.md)