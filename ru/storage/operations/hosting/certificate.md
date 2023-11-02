# Настройка HTTPS

Если бакет используется для [хостинга статического сайта](../../concepts/hosting.md), то для доступа к сайту по протоколу [HTTPS](../../../glossary/ssl-certificate.md) необходимо загрузить собственный сертификат безопасности и соответствующий ему секретный ключ.

{{ objstorage-name }} поддерживает только [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded сертификаты.

{% note info %}

Доступ к бакету по HTTPS открывается в течение получаса после загрузки сертификата.

{% include [redirect-https](../../../_includes/storage/redirect-https.md) %}

{% endnote %}

## Выбор сертификата из {{ certificate-manager-name }} {#cert-manager}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. Выберите сервис **{{ objstorage-name }}**.
    1. Нажмите на имя необходимого бакета.
    1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_https }}**.
    1. В отобразившейся панели справа нажмите кнопку **{{ ui-key.yacloud.storage.bucket.https.button_empty-action }}**.
    1. В поле **{{ ui-key.yacloud.storage.bucket.https.field_source }}** выберите **{{ ui-key.yacloud.storage.bucket.https.value_method-certificate-manager }}**.
    1. В поле **{{ ui-key.yacloud.storage.bucket.https.field_certificate }}** выберите сертификат в появившемся списке. 
    
        {% note info %}
        
        Если у вас еще нет ни одного сертификата в {{ certificate-manager-full-name }}, нажмите кнопку **Перейти в {{ certificate-manager-name }}** и воспользуйтесь [инструкцией](../../../certificate-manager/quickstart/index.md), чтобы создать свой первый сертификат.  
        
        {% endnote %}

    1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.https.button_save }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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

- {{ TF }}
 
  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}


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

  1. Проверьте конфигурацию командой:

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
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить выбранный сертификат можно в [консоли управления]({{ link-console-main }}).

- API

  Чтобы выбрать сертификат из {{ certificate-manager-name }}, воспользуйтесь методом REST API [setHTTPSConfig](../../api-ref/Bucket/setHTTPSConfig.md) для ресурса [Bucket](../../api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/SetHTTPSConfig](../../api-ref/grpc/bucket_service.md#SetHTTPSConfig).

{% endlist %}

## Загрузка собственного сертификата безопасности {#own}

Собственный сертификат лучше [загружать](../../../certificate-manager/operations/import/cert-create.md) с помощью сервиса {{ certificate-manager-name }}.

Если вы загружаете цепочку сертификатов, она должна начинаться с доменного и заканчиваться корневым сертификатом. Можно создать файл с цепочкой с помощью команды:

```bash
cat domain.pem intermediate.pem rootca.pem > bundle.pem
```

Здесь `domain.pem` — доменный сертификат, `intermediate.pem` — промежуточный сертификат, `rootca.pem` — корневой сертификат, `bundle.pem` — итоговая цепочка.

Чтобы загрузить сертификат:

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. Нажмите на имя необходимого бакета.
   1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_https }}**.
   1. В отобразившейся панели справа нажмите кнопку **{{ ui-key.yacloud.storage.bucket.https.button_action-configure }}**.
   1. В поле **{{ ui-key.yacloud.storage.bucket.https.field_source }}** выберите `{{ ui-key.yacloud.storage.bucket.https.value_method-custom }}`.
   1. Добавьте сертификат и секретный ключ.
   1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.https.button_save }}**.

- API

  Чтобы загрузить собственный сертификат безопасности, воспользуйтесь методом REST API [setHTTPSConfig](../../api-ref/Bucket/setHTTPSConfig.md) для ресурса [Bucket](../../api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/SetHTTPSConfig](../../api-ref/grpc/bucket_service.md#SetHTTPSConfig).

{% endlist %}

{% note info %}

{% include [public-link](../../../_includes/storage/public-link.md) %}

{% endnote %}