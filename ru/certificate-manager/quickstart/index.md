# Как начать работать с {{ certificate-manager-name }}

В этой инструкции вы добавите в {{ certificate-manager-name }} свой первый [сертификат от Let's Encrypt](../concepts/managed-certificate.md) и используете его для [настройки доступа по HTTPS](../../storage/operations/hosting/certificate.md) к статическому сайту, размещенному в {{ objstorage-full-name }}.

## Подготовка к работе {#before-you-begin}

Чтобы начать работать с {{ certificate-manager-name }} вам понадобится:

1. Каталог в {{ yandex-cloud }}. Если каталога еще нет, создайте новый каталог:

    {% include [create-folder](../../_includes/create-folder.md) %}

1. Домен не ниже третьего уровня, для которого будет выпущен сертификат от Let's Encrypt.

    {% note info %}

    Чтобы пройти процедуру проверки прав на домен, он должен находиться под вашим управлением.

    {% endnote %}

1. Публичный бакет в Object Storage с точно таким же именем, что и домен. Если бакета еще нет, создайте его:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать [бакет](../../storage/concepts/bucket.md).
        1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
        1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
        1. Введите имя бакета в точности совпадающее с именем домена.
        1. Выберите тип [доступа](../../storage/concepts/bucket.md#bucket-access) `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`.
        1. Выберите [класс хранилища](../../storage/concepts/storage-class.md) по умолчанию.
        1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}** для завершения операции.

    {% endlist %}

1. Настройте [хостинг](../../storage/operations/hosting/setup.md) в бакете:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
        1. На вкладке **{{ ui-key.yacloud.storage.switch_buckets }}** нажмите на бакет с именем домена.
        1. В панели слева выберите пункт **{{ ui-key.yacloud.storage.bucket.switch_website }}**.
        1. Выберите раздел **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}** и укажите главную страницу сайта.
        1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.website.button_save }}** для завершения операции.

    {% endlist %}

1. Настройте [алиас](../../storage/operations/hosting/own-domain.md) для бакета у своего провайдера [DNS](../../glossary/dns.md) или на собственном DNS-сервере.

    Например, для домена `www.example.com` необходимо добавить запись:

    ```text
    www.example.com CNAME www.example.com.{{ s3-web-host }}
    ```

1. Установите и настройте AWS CLI по [инструкции](../../storage/tools/aws-cli.md#before-you-begin).

## Создание запроса на получение сертификата от Let's Encrypt {#request-certificate}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите в [консоль управления]({{ link-console-main }}).
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.certificate-manager.button_empty-action }}**.
    1. В открывшемся меню выберите **{{ ui-key.yacloud.certificate-manager.action_request }}**.
    1. В открывшемся окне задайте имя сертификата.
    1. (Опционально) Добавьте описание сертификату.
    1. В поле **{{ ui-key.yacloud.certificate-manager.request.field_domains }}** укажите домены, для которых нужно выпустить сертификат.
    1. Выберите [тип проверки](../concepts/challenges.md) прав на домен `{{ ui-key.yacloud.certificate-manager.request.challenge-type_label_http }}`. 
    1. Нажмите кнопку **{{ ui-key.yacloud.certificate-manager.request.button_request }}**.

{% endlist %}

## Прохождение проверки прав на домен {#validate}

### Создание файла для проверки {#create-file}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
  1. Выберите в списке нужный сертификат со статусом `Validating` и нажмите на него.
  1. В блоке **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}**:
      1. Скопируйте ссылку из поля **{{ ui-key.yacloud.certificate-manager.overview.challenge_label_http-url }}**:
          * Часть ссылки вида `http://example.com/.well-known/acme-challenge/` — это путь для размещения файла.
          * Вторая часть ссылки `rG1Mm1bJ...` — это имя файла, которое вам необходимо использовать.
      1. Скопируйте поле **{{ ui-key.yacloud.certificate-manager.overview.challenge_label_http-content }}** в файл.

{% endlist %}

### Загрузка файла и проверка {#upload-and-check}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. На вкладке **{{ ui-key.yacloud.storage.switch_buckets }}** нажмите на бакет с именем домена.
  1. Справа сверху нажмите **{{ ui-key.yacloud.storage.bucket.button_create }}** и создайте папку `.well-known`.
  1. В `.well-known` создайте папку `acme-challenge`.
  1. В `acme-challenge` нажмите **{{ ui-key.yacloud.storage.button_upload }}**.
  1. В открывшемся окне выберите файл с записью и нажмите **Открыть**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.button_upload }}**.
  1. Дождитесь изменения статуса сертификата на `Issued`.
  1. Перейдите в папку `acme-challenge`.
  1. Нажмите ![image](../../_assets/options.svg) справа от файла и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

- AWS CLI {#cli}

  1. Загрузите файл в бакет так, чтобы он располагался в папке `.well-known/acme-challenge`:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }} \
        s3 cp <имя_файла> s3://<имя_бакета>/.well-known/acme-challenge/<имя_файла>
      ```

  1. Дождитесь изменения статуса сертификата на `Issued`.
  1. Удалите созданный файл из бакета:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }} \
         s3 rm s3://<имя_бакета>/.well-known/acme-challenge/<имя_файла>
      ```

{% endlist %}

{% note warning %}

Обновление сертификата требует от вас участия. Внимательно следите за временем жизни созданных сертификатов, чтобы своевременно обновлять их. Подробнее в разделе [Обновление сертификата](../concepts/managed-certificate.md#renew).

{% endnote %}

## Настройка доступа по HTTPS к статическому сайту {#hosting-certificate}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Войдите в [консоль управления]({{ link-console-main }}).
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
    1. На вкладке **{{ ui-key.yacloud.storage.switch_buckets }}** нажмите на бакет с именем домена.
    1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_https }}**.
    1. В отобразившейся панели справа нажмите кнопку **{{ ui-key.yacloud.storage.bucket.https.button_action-configure }}**.
    1. В поле **{{ ui-key.yacloud.storage.bucket.https.field_source }}** выберите `{{ ui-key.yacloud.storage.bucket.https.value_method-certificate-manager }}`.
    1. В поле **{{ ui-key.yacloud.storage.bucket.https.field_certificate-manager }}** выберите сертификат в появившемся списке.
    1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.https.button_save }}**.

{% endlist %}


#### См. также {#see-also}

- [{#T}](../concepts/managed-certificate.md)
- [{#T}](../concepts/challenges.md)
- [Настройка HTTPS в бакете](../../storage/operations/hosting/certificate.md)
