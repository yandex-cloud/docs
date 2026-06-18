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

Поддержка протокола TLS версий 1.0 и 1.1 в Object Storage прекращена с 1 августа 2025 года.

Подробнее на странице [Протокол TLS](../../concepts/tls.md).

{% endnote %}


Object Storage поддерживает только [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded сертификаты.

{% note info %}

Доступ к бакету по HTTPS открывается в течение получаса после загрузки сертификата.

Переадресация запросов с HTTP на HTTPS включается автоматически после настройки доступа к бакету по HTTPS. Дополнительных настроек для такой переадресации не требуется.

{% endnote %}

## Выбор сертификата из Certificate Manager {#cert-manager}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. Перейдите в сервис **Object Storage**.
    1. Выберите нужный бакет из списка.
    1. На панели слева выберите ![image](../../../_assets/console-icons/persons-lock.svg) **Безопасность**.
    1. Выберите вкладку **HTTPS**.
    1. Нажмите кнопку **Настроить**.
    1. В поле **Источник** выберите **Certificate Manager**.
    1. В поле **Сертификат** выберите сертификат в появившемся списке. 
    
        {% note info %}
        
        Если у вас еще нет ни одного сертификата в Yandex Certificate Manager, нажмите кнопку **Перейти в Certificate Manager** и воспользуйтесь [инструкцией](../../../certificate-manager/quickstart/index.md), чтобы создать свой первый сертификат.  
        
        {% endnote %}

    1. Нажмите кнопку **Сохранить**.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

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
     * `--certificate-id` — идентификатор сертификата в Certificate Manager.

     Результат:

     ```text
     source_type: SOURCE_TYPE_MANAGED_BY_CERTIFICATE_MANAGER
     certificate_id: fpqe2g0hfr0e********
     ```

- Terraform {#tf}

  {% note info %}
  
  Если вы работаете с Object Storage через Terraform от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../../security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.
  
  {% endnote %}
 
  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.



  Чтобы выбрать сертификат из Certificate Manager:

  1. Откройте файл конфигурации Terraform и добавьте блок `https` в описание бакета:

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
     * `certificate_id` — идентификатор сертификата в Certificate Manager, который будет использован для бакета.

     Более подробная информация о параметрах ресурса `yandex_storage_bucket` в Terraform приведена в [документации провайдера](../../../terraform/resources/storage_bucket.md#bucket-https-certificate).

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

     Проверить выбранный сертификат можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Чтобы выбрать сертификат из Certificate Manager, воспользуйтесь методом REST API [setHTTPSConfig](../../api-ref/Bucket/setHTTPSConfig.md) для ресурса [Bucket](../../api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/SetHTTPSConfig](../../api-ref/grpc/Bucket/setHTTPSConfig.md).

{% endlist %}

## Загрузка собственного сертификата безопасности {#own}

Собственный сертификат лучше [загружать](../../../certificate-manager/operations/import/cert-create.md) с помощью сервиса Certificate Manager.

Если вы загружаете цепочку сертификатов, она должна начинаться с доменного и заканчиваться корневым сертификатом. Можно создать файл с цепочкой с помощью команды:

```bash
cat domain.pem intermediate.pem rootca.pem > bundle.pem
```

Здесь `domain.pem` — доменный сертификат, `intermediate.pem` — промежуточный сертификат, `rootca.pem` — корневой сертификат, `bundle.pem` — итоговая цепочка.

Чтобы загрузить сертификат:

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
   1. Перейдите в сервис **Object Storage**.
   1. Выберите нужный бакет из списка.
   1. На панели слева выберите ![image](../../../_assets/console-icons/persons-lock.svg) **Безопасность**.
   1. Выберите вкладку **HTTPS**.
   1. Нажмите кнопку **Настроить**.
   1. В поле **Источник** выберите **Свой сертификат**.
   1. Добавьте **Сертификат** и **Секретный ключ**.
   1. Нажмите кнопку **Сохранить**.

- API {#api}

  Чтобы загрузить собственный сертификат безопасности, воспользуйтесь методом REST API [setHTTPSConfig](../../api-ref/Bucket/setHTTPSConfig.md) для ресурса [Bucket](../../api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/SetHTTPSConfig](../../api-ref/grpc/Bucket/setHTTPSConfig.md).

{% endlist %}

{% note info %}

Из бакета с публичным доступом файлы можно получить по публичной ссылке как по протоколу HTTP, так и по протоколу HTTPS, даже если для бакета не [настроен](setup.md) хостинг сайта. В этом случае для доступа по протоколу HTTPS будет использован сертификат от [GlobalSign](https://www.globalsign.com/ru-ru) на уровне облака.

{% endnote %}

### Полезные ссылки {#see-also}

* [Как исправить некорректный MIME-тип объектов при их загрузке в бакет?](../../qa.md#qa-mime-type)
* [Настройка хостинга](setup.md)
* [Собственный домен](own-domain.md)
* [Поддержка нескольких доменных имен](multiple-domains/index.md)