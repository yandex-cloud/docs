# Как начать работать с Certificate Manager

В этой инструкции вы добавите в Certificate Manager свой первый [сертификат от Let's Encrypt](../concepts/managed-certificate.md) и используете его для [настройки доступа по HTTPS](../../storage/operations/hosting/certificate.md) к статическому сайту, размещенному в Yandex Object Storage.

## Подготовка к работе {#before-you-begin}

Чтобы начать работать с Certificate Manager вам понадобится:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Каталог в Yandex Cloud. Если каталога еще нет, создайте новый каталог:

         1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../_assets/console-icons/chevron-down.svg) и выберите нужное [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud).
         1. Справа от названия облака нажмите ![image](../../_assets/console-icons/ellipsis.svg).
         1. Выберите ![image](../../_assets/console-icons/plus.svg) **Создать каталог**.
         
            ![create-folder1](../../_assets/resource-manager/create-folder-1.png)
         
         1. Введите имя [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder). Требования к имени:
         
             * длина — от 3 до 63 символов;
             * может содержать строчные буквы латинского алфавита, цифры и дефисы;
             * первый символ — буква, последний — не дефис.
         
         1. (Опционально) Введите описание каталога.
         1. Выберите опцию **Создать сеть по умолчанию**. Будет создана [сеть](../../vpc/concepts/network.md#network) с подсетями в каждой зоне доступности. Также в этой сети будет создана [группа безопасности по умолчанию](../../vpc/concepts/security-groups.md#default-security-group), внутри которой весь сетевой трафик разрешен.
         1. Нажмите кнопку **Создать**.
         
            ![create-folder2](../../_assets/resource-manager/create-folder-2.png)

    1. Домен не ниже третьего уровня, для которого будет выпущен сертификат от Let's Encrypt.

         {% note info %}

         Чтобы пройти процедуру проверки прав на домен, он должен находиться под вашим управлением.

         {% endnote %}

    1. Публичный бакет в Object Storage с точно таким же именем, что и домен. Если бакета еще нет, создайте его:

        1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать [бакет](../../storage/concepts/bucket.md).
        1. Перейдите в сервис **Object Storage**.
        1. Нажмите кнопку **Создать бакет**.
        1. Введите имя бакета в точности совпадающее с именем домена.
        1. Выберите тип [доступа](../../storage/concepts/bucket.md#bucket-access) `Для всех`.
        1. Выберите [класс хранилища](../../storage/concepts/storage-class.md) по умолчанию.
        1. Нажмите кнопку **Создать бакет** для завершения операции.

    1. Настройте [хостинг](../../storage/operations/hosting/setup.md) в бакете:

        1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится бакет.
        1. Перейдите в сервис **Object Storage**.
        1. На вкладке ![box](../../_assets/console-icons/box.svg) **Бакеты** нажмите на бакет с именем домена.
        1. На панели слева выберите ![wrench](../../_assets/console-icons/wrench.svg) **Настройки**.
        1. Откройте вкладку **Веб-сайт**.
        1. Выберите `Хостинг` и укажите главную страницу сайта.
        1. Нажмите кнопку **Сохранить** для завершения операции.

    1. Настройте [алиас](../../storage/operations/hosting/own-domain.md) для бакета у своего провайдера [DNS](../../glossary/dns.md) или на собственном DNS-сервере.

        Например, для домена `www.example.com` необходимо добавить запись:

        ```text
        www.example.com CNAME www.example.com.website.yandexcloud.net
        ```

{% endlist %}

## Создание запроса на получение сертификата от Let's Encrypt {#request-certificate}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите в [консоль управления](https://console.yandex.cloud).
    1. Перейдите в сервис **Certificate Manager**.
    1. Нажмите кнопку **Добавить сертификат**.
    1. В открывшемся меню выберите **Сертификат от Let's Encrypt**.
    1. В открывшемся окне задайте имя сертификата.
    1. (Опционально) Добавьте описание сертификату.
    1. В поле **Домены** укажите домены, для которых нужно выпустить сертификат.
    1. Выберите [тип проверки](../concepts/challenges.md) прав на домен `HTTP`. 
    1. Нажмите кнопку **Создать**.

{% endlist %}

## Прохождение проверки прав на домен {#validate}

### Создание файла для проверки {#create-file}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Certificate Manager**.
  1. Выберите в списке нужный сертификат со статусом `Validating` и нажмите на него.
  1. В блоке **Проверка прав на домены**:
      1. Скопируйте ссылку из поля **Ссылка для размещения файла**:
          * Часть ссылки вида `http://example.com/.well-known/acme-challenge/` — это путь для размещения файла.
          * Вторая часть ссылки `rG1Mm1bJ...` — это имя файла, которое вам необходимо использовать.
      1. Скопируйте поле **Содержимое** в файл.

{% endlist %}

### Загрузка файла и проверка {#upload-and-check}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Object Storage**.
  1. На вкладке ![box](../../_assets/console-icons/box.svg) **Бакеты** нажмите на бакет с именем домена.
  1. Справа сверху нажмите ![folder](../../_assets/console-icons/folder.svg) **Создать папку** и создайте папку `.well-known`.
  1. В `.well-known` создайте папку `acme-challenge`.
  1. В `acme-challenge` нажмите ![arrow](../../_assets/console-icons/arrow-up-from-line.svg) **Загрузить**.
  1. В открывшемся окне выберите файл с записью и нажмите **Открыть**.
  1. Нажмите кнопку **Загрузить**.
  1. Дождитесь изменения статуса сертификата на `Issued`.
     
     Подробнее о статусе можно посмотреть на странице сертификата. Для этого напротив поля **ui-key.yacloud.certificate-manager.overview.general_label_validation** нажмите ![receipt](../../_assets/console-icons/receipt.svg) **ui-key.yacloud.certificate-manager.overview.button_validation_show-logs**. 
  1. Перейдите в папку `acme-challenge`.
  1. Нажмите ![image](../../_assets/options.svg) справа от файла и выберите ![trash](../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. Подтвердите удаление.

- AWS CLI {#cli}

  1. Установите и настройте AWS CLI по [инструкции](../../storage/tools/aws-cli.md#before-you-begin).
  1. Загрузите файл в бакет так, чтобы он располагался в папке `.well-known/acme-challenge`:

      ```bash
      aws --endpoint-url=https://storage.yandexcloud.net \
        s3 cp <имя_файла> s3://<имя_бакета>/.well-known/acme-challenge/<имя_файла>
      ```

  1. Дождитесь изменения статуса сертификата на `Issued`.
  1. Удалите созданный файл из бакета:

      ```bash
      aws --endpoint-url=https://storage.yandexcloud.net \
         s3 rm s3://<имя_бакета>/.well-known/acme-challenge/<имя_файла>
      ```

{% endlist %}

{% note warning %}

Обновление сертификата требует от вас участия. Внимательно следите за временем жизни созданных сертификатов, чтобы своевременно обновлять их. Подробнее в разделе [Обновление сертификата](../concepts/managed-certificate.md#renew).

{% endnote %}

## Настройка доступа по HTTPS к статическому сайту {#hosting-certificate}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите в [консоль управления](https://console.yandex.cloud).
    1. Перейдите в сервис **Object Storage**.
    1. На вкладке ![box](../../_assets/console-icons/box.svg) **Бакеты** нажмите на бакет с именем домена.
    1. На панели слева выберите ![persons-lock](../../_assets/console-icons/persons-lock.svg) **Безопасность**.
    1. Перейдите на вкладку **HTTPS**.
    1. Справа вверху нажмите **Настроить**.
    1. В поле **Источник** выберите `Certificate Manager`.
    1. В поле **Сертификат** выберите сертификат в появившемся списке.
    1. Нажмите кнопку **Сохранить**.

{% endlist %}


#### Полезные ссылки {#see-also}

* [Сертификат от Let's Encrypt](../concepts/managed-certificate.md)
* [Проверка прав на домен](../concepts/challenges.md)
* [Настройка HTTPS в бакете](../../storage/operations/hosting/certificate.md)