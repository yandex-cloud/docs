# Настройка HTTPS

Если для [хостинга статического сайта](../../concepts/hosting.md) вы используете бакет без точки в имени, сайт будет по умолчанию доступен по протоколам HTTP и [HTTPS](../../../glossary/ssl-certificate.md) по следующим адресам:

* `http(s)://example.website.yandexcloud.net`
* `http(s)://website.yandexcloud.net/example`

Для такого бакета загружать собственный сертификат безопасности не требуется, но для него недоступна поддержка собственного домена.

Если для хостинга статического сайта вы используете бакет с точкой в имени, сайт будет по умолчанию доступен по протоколам HTTP и HTTPS по следующим адресам:

* `http://example.com.website.yandexcloud.net`
* `http(s)://website.yandexcloud.net/example.com`

Для такого бакета доступна [поддержка собственного домена](own-domain.md). По умолчанию по доменному имени сайт будет доступен только по протоколу HTTP, например `http://example.com`. Чтобы обеспечить доступ по доменному имени по протоколу HTTPS, загрузите собственный сертификат безопасности и соответствующий ему секретный ключ.


{% note alert %}

Поддержка протокола TLS версий 1.0 и 1.1 в {{ objstorage-name }} прекращена с 1 августа 2025 года.

Подробнее см. на странице [{#T}](../../concepts/tls.md).

{% endnote %}


{{ objstorage-name }} поддерживает только [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded сертификаты.

{% note info %}

Доступ к бакету по HTTPS открывается в течение получаса после загрузки сертификата.

Переадресация запросов с HTTP на HTTPS включается автоматически после настройки доступа к бакету по HTTPS. Дополнительных настроек для такой переадресации не требуется.

{% endnote %}

## Выбор сертификата из {{ certificate-manager-name }} {#cert-manager}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
    1. Выберите нужный бакет из списка.
    1. На панели слева выберите ![image](../../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
    1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_https }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.https.button_empty-action }}**.
    1. В поле **{{ ui-key.yacloud.storage.bucket.https.field_source }}** выберите **{{ ui-key.yacloud.storage.bucket.https.value_method-certificate-manager }}**.
    1. В поле **{{ ui-key.yacloud.storage.bucket.https.field_certificate }}** выберите сертификат в появившемся списке. 
    
        {% note info %}
        
        Если у вас еще нет ни одного сертификата в {{ certificate-manager-full-name }}, нажмите кнопку **Перейти в {{ certificate-manager-name }}** и воспользуйтесь [инструкцией](../../../certificate-manager/quickstart/index.md), чтобы создать свой первый сертификат.  
        
        {% endnote %}

    1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.https.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для редактирования ACL бакета:

     ```bash
     yc storage bucket update --help
     ```  

  1. Выполните следующую команду:

     ```bash
     yc storage bucket set-https --name <имя_бакета> --certificate-id <идентификатор_сертификата> 
     ```  

     Где:
     * `--name` — имя бакета, для которого настраивается HTTPS;
     * `--certificate-id` — идентификатор сертификата в {{ certificate-manager-name }}.

     Результат:

     ```text
     source_type: SOURCE_TYPE_MANAGED_BY_CERTIFICATE_MANAGER
     certificate_id: fpqe2g0hfr0e********
     ```

- {{ TF }} {#tf}

  {% note info %}
  
  Если вы работаете с {{ objstorage-name }} через {{ TF }} от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../../security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.
  
  {% endnote %}
 
  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  
  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.



  Чтобы выбрать сертификат из {{ certificate-manager-name }}:

  1. Откройте файл конфигурации {{ TF }} и добавьте блок `https` в описание бакета:

     ```hcl
     ...
     resource "yandex_storage_bucket" "b" {
       bucket = "my-policy-bucket"

       https {
         certificate_id = "<идентификатор_сертификата>"
       }
     }
     ...
     ```

     Где:
     * `certificate_id` — идентификатор сертификата в {{ certificate-manager-name }}, который будет использован для бакета.

     Более подробную информацию о параметрах ресурса `yandex_storage_bucket` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket#bucket-https-certificate).

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

     Проверить выбранный сертификат можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы выбрать сертификат из {{ certificate-manager-name }}, воспользуйтесь методом REST API [setHTTPSConfig](../../api-ref/Bucket/setHTTPSConfig.md) для ресурса [Bucket](../../api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/SetHTTPSConfig](../../api-ref/grpc/Bucket/setHTTPSConfig.md).

{% endlist %}

## Загрузка собственного сертификата безопасности {#own}

Собственный сертификат лучше [загружать](../../../certificate-manager/operations/import/cert-create.md) с помощью сервиса {{ certificate-manager-name }}.

Если вы загружаете цепочку сертификатов, она должна начинаться с доменного и заканчиваться корневым сертификатом. Можно создать файл с цепочкой с помощью команды:

```bash
cat domain.pem intermediate.pem rootca.pem > bundle.pem
```

Здесь `domain.pem` — доменный сертификат, `intermediate.pem` — промежуточный сертификат, `rootca.pem` — корневой сертификат, `bundle.pem` — итоговая цепочка.

Чтобы загрузить сертификат:

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог.
   1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. Выберите нужный бакет из списка.
   1. На панели слева выберите ![image](../../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
   1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_https }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.https.button_empty-action }}**.
   1. В поле **{{ ui-key.yacloud.storage.bucket.https.field_source }}** выберите **{{ ui-key.yacloud.storage.bucket.https.value_method-custom }}**.
   1. Добавьте **{{ ui-key.yacloud.storage.bucket.https.field_certificate }}** и **{{ ui-key.yacloud.storage.bucket.https.field_private-key }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.https.button_save }}**.

- API {#api}

  Чтобы загрузить собственный сертификат безопасности, воспользуйтесь методом REST API [setHTTPSConfig](../../api-ref/Bucket/setHTTPSConfig.md) для ресурса [Bucket](../../api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/SetHTTPSConfig](../../api-ref/grpc/Bucket/setHTTPSConfig.md).

{% endlist %}

{% note info %}

Из бакета с публичным доступом файлы можно получить по публичной ссылке как по протоколу HTTP, так и по протоколу HTTPS, даже если для бакета не [настроен](setup.md) хостинг сайта. В этом случае для доступа по протоколу HTTPS будет использован сертификат от [GlobalSign](https://www.globalsign.com/ru-ru) на уровне облака.

{% endnote %}

### См. также {#see-also}

* [{#T}](../../qa.md#qa-mime-type)
* [{#T}](setup.md)
* [{#T}](own-domain.md)
* [{#T}](multiple-domains/index.md)