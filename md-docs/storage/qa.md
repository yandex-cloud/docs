# Вопросы и ответы про Object Storage

* [Что такое Yandex Object Storage?](#qa-what-is)
* [Что я могу делать с Yandex Object Storage?](#qa-usecases)
* [Как начать пользоваться Yandex Object Storage?](#qa-quickstart)
* [Какие форматы данных я могу хранить?](#qa-data-types)
* [Как мне оставить отзыв на Yandex Object Storage?](#qa-feedback)
* [Как обратиться в службу технической поддержки?](#qa-support-channels)
* [Сколько я могу хранить данных?](#qa-storage-volume)
* [Как удалить несколько объектов за один раз?](#qa-delete-multiple-objects)
* [Почему сервисный аккаунт не может получить доступ в бакет?](#sa-bucket-access)
* [Что Yandex Cloud делает с данными, которые я храню в Yandex Object Storage?](#qa-data-use-by-platform)
* [Использует ли Яндекс Object Storage для размещения своих данных?](#qa-usage-by-yandex)
* [Какую модель консистентности данных использует Yandex Object Storage?](#qa-consistency)
* [Какие возможности AWS S3 поддерживаются в Yandex Object Storage?](#qa-s3-support)
* [Где хранятся мои данные?](#qa-where)
* [Как защищены мои данные в Yandex Object Storage?](#qa-data-security)
* [Какие есть гарантии скорости работы Yandex Object Storage?](#qa-timings)
* [Как подключить собственный домен к бакету Object Storage?](#domain-bucket)
* [Почему после создания/изменения политики доступа пропал доступ к бакету?](#qa-lost-access)
* [Как получить доступ к Object Storage из облачной сети Virtual Private Cloud?](#qa-from-vpc)
* [Проверяются ли объекты, загружаемые в бакет, на наличие чувствительных данных и вредоносного кода?](#anti-malware)
* [Как исправить некорректный MIME-тип объектов при их загрузке в бакет?](#qa-mime-type)

#### Что такое Yandex Object Storage? {#qa-what-is}

Yandex Object Storage — это универсальное масштабируемое решение для хранения данных. Оно подходит как для высоконагруженных сервисов, которым требуется надежный и быстрый доступ к данным, так и для проектов с невысокими требованиями к инфраструктуре хранения.

#### Что я могу делать с Yandex Object Storage? {#qa-usecases}

С Object Storage вы можете:
* Разместить в Object Storage файлы своего проекта (сайта или серверного приложения) для публичного или закрытого доступа. Файлы могут быть любого формата.
* Хранить архивные данные большого объема (до 5 ТБ на один файл), которые будут доступны только тем, кому вы разрешите.
* Обеспечить совместную работу с данными внутри распределенной организации.
* Обеспечить доступ к своим данным из любого места Земли, где есть интернет.

#### Как начать пользоваться Yandex Object Storage? {#qa-quickstart}

Чтобы начать работать с Object Storage:
1. Зарегистрируйтесь в Yandex Cloud.
1. Создайте каталог.
   На этом шаге уже можно пользоваться Object Storage с помощью консоли управления Yandex Cloud. Можно создавать и удалять бакеты, загружать объекты в бакеты и скачивать их оттуда.
1. Получите статические ключи, чтобы использовать HTTP API Object Storage или готовые SDK и приложения.

Более подробные инструкции вы найдете в разделах [Как начать работать с Yandex Object Storage](quickstart.md) и [Как пользоваться S3 API](s3/index.md).

#### Какие форматы данных я могу хранить? {#qa-data-types}

Вы можете хранить данные в любом формате. Yandex Object Storage сохраняет данные в изначальном виде, никаким образом их не преобразовывая.

#### Как мне оставить отзыв на Yandex Object Storage? {#qa-feedback}



Воспользуйтесь формой обратной связи в [центре поддержки](https://center.yandex.cloud/support).



#### Как обратиться в службу технической поддержки? {#qa-support-channels}



Вы можете обратиться в службу технической поддержки в разделе [Поддержка](https://center.yandex.cloud/support) в консоли управления.



#### Сколько я могу хранить данных? {#qa-storage-volume}

Ознакомьтесь с разделом [Квоты и лимиты в Object Storage](concepts/limits.md).

#### Как удалить несколько объектов за один раз? {#qa-delete-multiple-objects}

Вы можете удалить несколько объектов через консоль управления Yandex Cloud или через [API](../glossary/rest-api.md) с помощью метода [deleteMultipleObjects](s3/api-ref/object/deletemultipleobjects.md).

#### Почему сервисный аккаунт не может получить доступ в бакет? {#sa-bucket-access}


Проверьте, что сервисному аккаунту назначена [роль](security/index.md#roles-list) для доступа в бакет.


Если у бакета включено [шифрование](concepts/encryption.md), назначьте сервисному аккаунту [роль](../kms/security/index.md#service) `kms.keys.encrypterDecrypter` на [ключ KMS](../kms/concepts/key.md), которым зашифрован бакет. Это можно сделать, например, с помощью команды CLI:

```bash
yc kms symmetric-key add-access-binding \
  --id <идентификатор_ключа> \
  --service-account-id <идентификатор_сервисного_аккаунта> \
  --role kms.keys.encrypterDecrypter
```

Где:
* `--id` — идентификатор ключа KMS.
* `--service-account-id` — идентификатор сервисного аккаунта.


#### Что Yandex Cloud делает с данными, которые я храню в Yandex Object Storage? {#qa-data-use-by-platform}

Данные сохраняются в том виде, в котором их передал пользователь.


#### Использует ли Яндекс Object Storage для размещения своих данных? {#qa-usage-by-yandex}

Да. Object Storage используется в инфраструктуре Яндекса. Несколько сервисов Яндекса держат в хранилище статические данные для своих сайтов.


#### Какую модель консистентности данных использует Yandex Object Storage? {#qa-consistency}

Для перезаписываемых (PUT) или удаляемых (DELETE) объектов используется режим строгой консистентности (strong consistency).

#### Какие возможности AWS S3 поддерживаются в Yandex Object Storage? {#qa-s3-support}

В Object Storage поддерживаются:
* Авторизация статическими токенами.
* Некоторые методы HTTP API. Полный список поддерживаемых методов смотрите в [Справочнике API](s3/api-ref/index.md).


#### Где хранятся мои данные? {#qa-where}


Данные хранятся в нескольких географически распределенных дата-центрах на территории России. Подробнее в разделе [Зоны доступности](../overview/concepts/geo-scope.md).




#### Как защищены мои данные в Yandex Object Storage? {#qa-data-security}

Физические носители расположены в дата-центрах Yandex Cloud, которые являются режимными объектами.

Данные хранятся в зашифрованном виде, и никто из тех, кто имеет доступ к физическому носителю, не сможет прочитать данные.

По умолчанию доступ к хранилищу осуществляется по протоколу HTTPS.

#### Какие есть гарантии скорости работы Yandex Object Storage? {#qa-timings}

Object Storage имеет внутренние [SLA](../glossary/sla.md) и SLO на обеспечение скорости отправки данных клиенту, которые в том числе зависят от класса хранения.

Время ответа Object Storage зависит от многих факторов:
* Производительности клиентской стороны (скорости сети, загрузки CPU или дисковой подсистемы).
* Скорости магистральных соединений, соединений между дата-центрами или соединения между клиентом и сервером.
* Производительности самого сервиса Object Storage.

Из-за этого мы не можем указать конкретное значение времени ответа. При этом мы не считаем нормой резкое увеличение времени ответа или заметное снижение скорости отправки данных и постоянно работаем над улучшением технических характеристик Object Storage.


#### Соответствует ли сервис требованиям Федерального закона Российской Федерации № 152-ФЗ <q>О персональных данных</q>? {#fz-152}

Да, вы можете ознакомиться с полным [заключением](https://storage.yandexcloud.net/yc-compliance/conformance_ru_pdp.pdf) по результатам аудита системы защиты.


#### Я могу получить логи моей работы в сервисах? {#logs}

Да, вы можете запросить информацию о работе с вашими ресурсами из логов сервисов Yandex Cloud. Для этого обратитесь в [техническую поддержку](https://center.yandex.cloud/support).


#### Как подключить собственный домен к бакету Object Storage? {#domain-bucket}

Чтобы подключить свой [домен](operations/hosting/own-domain.md) к [бакету](concepts/bucket.md):

1. [Создайте](operations/buckets/create.md) бакет с именем домена.

1. [Настройте](operations/hosting/setup.md) бакет в качестве хостинга.

1. [Создайте](operations/hosting/own-domain.md#domain-support) на своем DNS-сервере CNAME-запись, чтобы привязать ваш домен к бакету.

1. (опционально) [Добавьте](../certificate-manager/operations/index.md) свой сертификат в Certificate Manager или [выпустите](../certificate-manager/operations/managed/cert-create.md) бесплатный сертификат от Let's Encrypt.

1. [Настройте HTTPS](operations/hosting/certificate.md#cert-manager): привяжите к бакету сертификат из Certificate Manager или загрузите свой.

После успешного выполнения всех шагов доступ к объектам будет работать по ссылкам вида `<имя_домена>/<ключ_объекта>`.


#### Почему после создания/изменения политики доступа пропал доступ к бакету? {#qa-lost-access}

Возможно несколько причин:

* Для [политики доступа](concepts/policy.md) объекты в бакете и сам бакет — это разные ресурсы. Чтобы правило в политике доступа относилось и к бакету, и к объектам в нем, укажите их как отдельные ресурсы. Например, `samplebucket` и `samplebucket/*`.

* Если к бакету применена политика доступа без правил, то доступ будет запрещен всем пользователям. Чтобы отключить проверки запросов по политике доступа, [удалите](operations/buckets/policy.md#delete-policy) ее.


* Если с бакетом взаимодействует кластер [Apache Hive™ Metastore](../metadata-hub/concepts/metastore.md) или [Yandex Managed Service for Apache Airflow™](../managed-airflow/concepts/index.md) и для бакета настроена политика доступа, кластер не сможет записывать данные в бакет или читать данные из бакета без сервисного аккаунта с соответствующей ролью. Подробнее в инструкциях для [Apache Hive™ Metastore](../metadata-hub/operations/metastore/s3-policy-connect.md) и [Managed Service for Apache Airflow™](../managed-airflow/operations/s3-policy-connect.md).


#### Как получить доступ к Object Storage из облачной сети Virtual Private Cloud? {#qa-from-vpc}

Для ресурсов, которые размещены в облачной сети VPC и не имеют публичных IP-адресов или выхода в интернет, можно [организовать подключение](../tutorials/routing/storage-vpc-access.md) к Object Storage через [API Endpoint](../api-design-guide/concepts/endpoints.md). [FQDN](../glossary/fqdn.md) эндпоинта с помощью службы DNS будет преобразован в публичный IP-адрес.


#### Проверяются ли объекты, загружаемые в бакет, на наличие чувствительных данных и вредоносного кода? {#anti-malware}

В Object Storage объекты, загружаемые в бакет, не проверяются на наличие чувствительных данных или вредоносного кода.

Реализуйте проверку на наличие вредоносного кода самостоятельно перед загрузкой объектов в бакет.

Для выявления чувствительных данных в бакете воспользуйтесь [модулем контроля данных (DSPM) Yandex Security Deck](../security-deck/concepts/dspm.md).


#### Как исправить некорректный MIME-тип объектов при их загрузке в бакет? {#qa-mime-type}

Если бакет используется для [хостинга сайта](concepts/hosting.md), некорректный [MIME-тип](https://ru.wikipedia.org/wiki/Список_MIME-типов) объектов может приводить к возникновению ошибок на сайте, например могут не открываться изображения или не работать скрипты.

В таком случае в браузере в консоли разработчика отображаются ошибки о некорректных MIME-типах объектов, загружаемых из бакета.

В зависимости от способа загрузки объектов в бакет заголовок [Content-Type](s3/api-ref/common-request-headers.md) может подбираться автоматически, при этом не всегда корректно, например `text/plain` вместо `text/css`, либо выставляться по умолчанию — `binary/octet-stream`.

Чтобы избежать ошибок, явно укажите заголовок `Content-Type` при загрузке объектов в бакет:

{% list tabs %}

- AWS CLI

  ```bash
  aws s3 cp \
    <путь_к_локальному_файлу> \
    s3://<имя_бакета>/ \
    --no-guess-mime-type \
    --content-type "application/javascript" \
    --endpoint-url=https://storage.yandexcloud.net
  ```

- s3cmd

  ```bash
  s3cmd put \
    --no-guess-mime-type \
    --no-mime-magic \
    --mime-type="application/javascript" \
    <путь_к_локальному_файлу> \
    s3://<имя_бакета>/
  ```

{% endlist %}

Также вы можете изменить заголовок `Content-Type` для уже загруженных объектов, например:

{% list tabs %}

- AWS CLI

  ```bash
  aws s3 cp \
    s3://<имя_бакета>/ \
    s3://<имя_бакета>/ \
    --exclude '*' \
    --include '*.js' \
    --no-guess-mime-type \
    --content-type="application/javascript" \
    --metadata-directive="REPLACE" \
    --recursive \
    --endpoint-url=https://storage.yandexcloud.net
    ```

- s3cmd

  ```bash
  s3cmd modify \
    --recursive \
    --exclude '*' \
    --include '*.js' \
    --no-guess-mime-type \
    --no-mime-magic \
    --mime-type="application/javascript" \
    s3://<имя_бакета>/
  ```

{% endlist %}