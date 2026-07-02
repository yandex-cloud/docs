[Документация Yandex Cloud](../../index.md) > [Yandex Object Storage](../index.md) > Справочник API > AWS S3 REST > Как пользоваться API

# Как пользоваться S3 API

## Подготовка к работе {#before-you-start}

Для аутентификации в [AWS S3 API](api-ref/index.md) вы можете использовать:
* [IAM-токен](../../iam/concepts/authorization/iam-token.md);
* [статический ключ доступа](../../iam/concepts/authorization/access-key.md);
* [временные ключи Security Token Service](../../iam/concepts/authorization/sts.md);
* [эфемерные ключи доступа](../../iam/concepts/authorization/ephemeral-keys.md).

{% note warning %}

Рекомендованным способом аутентификации в AWS S3 API является аутентификация с помощью IAM-токена: этот способ более безопасен и, в отличие от аутентификации с помощью статического ключа, не требует создания [подписи запроса](signing-requests.md).

{% endnote %}

Чтобы воспользоваться API:

{% list tabs group=auth_keys %}


- Аутентификация с помощью IAM-токена {#iam-token}

  1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md).
  1. [Назначьте сервисному аккаунту роли](../../iam/operations/sa/assign-role-for-sa.md), которые нужны для вашего проекта, например [storage.editor](../security/index.md#storage-editor) на бакет — для работы с конкретным бакетом, или на каталог — для работы со всеми бакетами в каталоге. Подробнее о ролях смотрите на странице [Управление доступом с помощью Yandex Identity and Access Management](../security/index.md).
      
      Чтобы работать с объектами в [зашифрованном](../concepts/encryption.md) бакете, у пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) вместе с [ролью](../security/index.md#storage-configurer) `storage.configurer` должны быть следующие [роли на ключ шифрования](../../kms/operations/key-access.md):
      
      * `kms.keys.encrypter` — для чтения ключа, [шифрования](../../kms/security/index.md#kms-keys-encrypter) и загрузки объектов;
      * `kms.keys.decrypter` — для чтения ключа, [расшифровки](../../kms/security/index.md#kms-keys-decrypter) и скачивания объектов;
      * `kms.keys.encrypterDecrypter` — включает [разрешения](../../kms/security/index.md#kms-keys-encrypterDecrypter), предоставляемые ролями `kms.keys.encrypter` и `kms.keys.decrypter`.
      
      Подробнее смотрите [Сервисные роли Key Management Service](../../kms/security/index.md#service-roles).

  1. Получите IAM-токен для созданного сервисного аккаунта. Подробнее читайте в инструкции [Получение IAM-токена для сервисного аккаунта](../../iam/operations/iam-token/create-for-sa.md).

      {% note tip %}
      
      Чтобы быстро получить IAM-токен сервисного аккаунта с помощью [Yandex Cloud CLI](../../cli/index.md), вы можете [воспользоваться имперсонацией](../../iam/operations/sa/impersonate-sa.md).
      
      {% endnote %}


- Аутентификация с помощью статического ключа {#static-key}

  1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md).
  1. [Назначьте сервисному аккаунту роли](../../iam/operations/sa/assign-role-for-sa.md), которые нужны для вашего проекта, например [storage.editor](../security/index.md#storage-editor) на бакет — для работы с конкретным бакетом, или на каталог — для работы со всеми бакетами в каталоге. Подробнее о ролях смотрите на странице [Управление доступом с помощью Yandex Identity and Access Management](../security/index.md).
  
            
      Чтобы работать с объектами в [зашифрованном](../concepts/encryption.md) бакете, у пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) вместе с [ролью](../security/index.md#storage-configurer) `storage.configurer` должны быть следующие [роли на ключ шифрования](../../kms/operations/key-access.md):
      
      * `kms.keys.encrypter` — для чтения ключа, [шифрования](../../kms/security/index.md#kms-keys-encrypter) и загрузки объектов;
      * `kms.keys.decrypter` — для чтения ключа, [расшифровки](../../kms/security/index.md#kms-keys-decrypter) и скачивания объектов;
      * `kms.keys.encrypterDecrypter` — включает [разрешения](../../kms/security/index.md#kms-keys-encrypterDecrypter), предоставляемые ролями `kms.keys.encrypter` и `kms.keys.decrypter`.
      
      Подробнее смотрите [Сервисные роли Key Management Service](../../kms/security/index.md#service-roles).
  
  
  1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key).
  
      
      В результате вы получите данные статического ключа доступа. Для аутентификации в Object Storage вам понадобятся:
      
      * `key_id` — идентификатор статического ключа доступа;
      * `secret` — секретный ключ.
      
      Сохраните `key_id` и `secret`, так как повторное получение значения ключа будет невозможно.
  
  
  
  Авторизация статическими ключами необходима для обращения напрямую к HTTP API и поддерживается инструментами, перечисленными в разделе [Поддерживаемые инструменты](../tools/index.md).
    
  {% note info %}
  
  Вы можете [запретить доступ в бакет с помощью статических ключей](../operations/buckets/disable-statickey-auth.md). После запрета доступ будет прекращен для всех инструментов, которые их используют: AWS CLI, SDK и сторонние приложения. Это также отключит доступ с помощью [эфемерных ключей](../security/ephemeral-keys.md), [временных ключей доступа Security Token Service](../security/sts.md) и [подписанных (pre-signed) URL](../security/overview.md#pre-signed). Останется доступ только через [IAM-токен](../../iam/concepts/authorization/iam-token.md) или [анонимный доступ](../security/public-access.md) (если он включен).
  
  {% endnote %}
  
  
  Статический ключ для доступа к Object Storage можно безопасно хранить в сервисе Yandex Lockbox. Подробнее смотрите [Использование секрета Yandex Lockbox для хранения статического ключа доступа](../tutorials/static-key-in-lockbox/index.md).

{% endlist %}

Перечень поддерживаемых методов Amazon S3 HTTP API смотрите в [Справочнике API](api-ref/index.md).

## Общий вид запроса к API {#common-request-form}

Общий вид запроса к Object Storage API:

```
{GET|HEAD|PUT|DELETE} /<имя_бакета>/<ключ_объекта> HTTP/2
Host: storage.yandexcloud.net
Content-Length: length
Date: date
Authorization: authorization string

Request_body
```

Запрос содержит HTTP-метод, имя бакета и [ключ объекта](../concepts/object.md).

Имя бакета можно указать как часть имени хоста. В этом случае запрос примет вид:

```
{GET|HEAD|PUT|DELETE} /<ключ_объекта> HTTP/2
Host: <имя_бакета>.storage.yandexcloud.net
...
```

Набор заголовков зависит от конкретного запроса и описан в документации на соответствующий запрос.

### Подписывание запросов {#signing-requests}

{% list tabs group=auth_keys %}


- Аутентификация с помощью IAM-токена {#iam-token}

  Если для аутентификации в [API](../../glossary/rest-api.md) вы используете IAM-токен, то дополнительно подписывать HTTP-запросы не требуется.


- Аутентификация с помощью статического ключа {#static-key}

  Если для аутентификации в [API](../../glossary/rest-api.md) вы используете статический ключ доступа и обращаетесь к API напрямую (без SDK и приложений), то для подписи запросов вам придется самостоятельно генерировать заголовок `Authorization`. О том, как это сделать, читайте в разделе [Authenticating Requests (AWS Signature Version 4)](https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html) документации Amazon S3.

  При использовании аутентификации с помощью статического ключа доступа для работы с S3 API в Object Storage лучше использовать [AWS CLI](../tools/aws-cli.md) или [AWS SDK](../tools/sdk/index.md), подходящий для вашей среды разработки.

  Отрабатывать процесс формирования запроса и подписи вы можете с помощью AWS CLI в [режиме отладки](signing-requests.md#debugging).
  
  Чтобы отправить [подписанный запрос](../api-ref/authentication.md#s3-api-example) к S3 API, вы можете использовать утилиту [curl](https://curl.se/).

{% endlist %}

### URL для запроса {#request-url}

URL может иметь одну из следующих форм:

* `http(s)://storage.yandexcloud.net/<имя_бакета>/<ключ_объекта>?<query-параметры>`
* `http(s)://<имя_бакета>.storage.yandexcloud.net/<ключ_объекта>?<query-параметры>`

{% note info %}

Для бакетов с точками в имени, например `example.ru`, протокол HTTPS доступен только с URL в формате `https://storage.yandexcloud.net/<имя_бакета>/<ключ_объекта>?<query-параметры>`. Подробнее в [Обращение к бакету по HTTPS](../concepts/bucket.md#bucket-https).

{% endnote %}

URL содержит имя бакета, ключ объекта и query-параметры. Пример возможных query-параметров приведен в [описании метода для получения объекта](api-ref/object/get.md).

{% note info %}

Если вы используете [AWS SDK для .NET](../tools/aws-sdk-net.md), обращайтесь к хосту `s3.yandexcloud.net`.

{% endnote %}

## CORS запросы {#cors-requests}

[Кросс-доменные запросы](../concepts/cors.md) доступны для всех методов API, которые управляют объектами.

Для проверки разрешений CORS подразумевает предварительный запрос [options](api-ref/object/options.md) к ресурсу. Object Storage позволяет отправлять кросс-доменные запросы к ресурсам без предварительного запроса, при этом в запросе должны быть те же [заголовки](api-ref/object/options.md#request-headers), что и у предварительного запроса.

#### Полезные ссылки {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../concepts/pre-signed-urls.md#code-examples)