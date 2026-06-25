# AWS SDK для Go


[AWS SDK для Go](https://docs.aws.amazon.com/sdk-for-go/) — это комплект средств разработки для работы с сервисами AWS на языке программирования Go.

## Подготовка к работе {#before-you-begin}

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



Авторизация статическими ключами необходима для обращения напрямую к HTTP API и поддерживается инструментами, перечисленными в разделе [Поддерживаемые инструменты](index.md).
  
{% note info %}

Вы можете [запретить доступ в бакет с помощью статических ключей](../operations/buckets/disable-statickey-auth.md). После запрета доступ будет прекращен для всех инструментов, которые их используют: AWS CLI, SDK и сторонние приложения. Это также отключит доступ с помощью [эфемерных ключей](../security/ephemeral-keys.md), [временных ключей доступа Security Token Service](../security/sts.md) и [подписанных (pre-signed) URL](../security/overview.md#pre-signed). Останется доступ только через [IAM-токен](../../iam/concepts/authorization/iam-token.md) или [анонимный доступ](../security/public-access.md) (если он включен).

{% endnote %}


Статический ключ для доступа к Object Storage можно безопасно хранить в сервисе Yandex Lockbox. Подробнее смотрите [Использование секрета Yandex Lockbox для хранения статического ключа доступа](../tutorials/static-key-in-lockbox/index.md).

{% note info %}

Сервисный аккаунт может просматривать список бакетов только в том каталоге, в котором он был создан.

Сервисный аккаунт может выполнять действия с объектами в бакетах, которые созданы в каталогах, отличных от каталога сервисного аккаунта. Для этого [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роли](../security/index.md#service-roles) на нужный каталог или бакет в нем.

{% endnote %}

## Установка {#installation}

Для установки AWS SDK для Go воспользуйтесь [инструкцией](https://docs.aws.amazon.com/sdk-for-go/v2/developer-guide/getting-started) на сайте производителя.

## Настройка {#setup}

### Настройка директории для аутентификационных данных

1. Создайте директорию для хранения аутентификационных данных и перейдите в нее: 

    Для macOS и Linux:

    ```bash
    mkdir ~/.aws/
    ```

    Для Windows:

    ```bash
    mkdir C:\Users\<имя_пользователя>\.aws\
    ```

1.  В директории `.aws` создайте файл `credentials` и скопируйте в него аутентификационные данные, [полученные ранее](#before-you-begin):

    ```text
    [default]
    aws_access_key_id = <идентификатор_статического_ключа>
    aws_secret_access_key = <секретный_ключ>
    ```

1. Создайте файл `config` с параметрами региона по умолчанию и скопируйте в него следующую информацию:

    ```text
    [default]
    region = ru-central1
    endpoint_url = https://storage.yandexcloud.net
    ```

    {% note info %}

    Некоторые приложения, предназначенные для работы с Amazon S3, не позволяют указывать регион, поэтому Object Storage принимает также значение основного региона AWS — [первая строка в таблице регионов](https://docs.aws.amazon.com/global-infrastructure/latest/regions/aws-regions.html#available-regions).

    {% endnote %}

Для доступа к Object Storage используйте эндпоинт `https://storage.yandexcloud.net`.

### Использование переменных окружения

AWS SDK для Go по умолчанию использует аутентификационные данные из переменных окружения, если они заданы. Эти переменные имеют приоритет над аутентификационными данными, которые указаны в файле `.aws/credentials`. 

Поддерживаются следующие переменные окружения:
* `AWS_ACCESS_KEY_ID` — идентификатор статического ключа;
* `AWS_SECRET_ACCESS_KEY` — секретный ключ;
* `AWS_SESSION_TOKEN` — (опционально) токен сессии. Подробнее на странице [Доступ в бакет с помощью Security Token Service](../operations/buckets/create-sts-key.md).

Чтобы задать переменные окружения, выполните следующие действия в зависимости от вашей операционной системы:

{% list tabs group=operating_system %}

- Linux/macOS

    В терминале выполните команду:
    
    ```bash
    export AWS_ACCESS_KEY_ID=<идентификатор_статического_ключа>
    export AWS_SECRET_ACCESS_KEY=<секретный_ключ>
    export AWS_SESSION_TOKEN=<опциональный_токен_сессии>
    ```

- Windows

    В PowerShell выполните команду:
    
    ```powershell
    $Env:AWS_ACCESS_KEY_ID=<идентификатор_статического_ключа>
    $Env:AWS_SECRET_ACCESS_KEY=<секретный_ключ>
    $Env:AWS_SESSION_TOKEN=<опциональный_токен_сессии>
    ```

{% endlist %}

## Примеры кода {#go-code-examples}

Развитие [AWS SDK v.1](https://github.com/aws/aws-sdk-go) для Go прекращено в июле 2024 г. Рекомендуем использовать актуальный пакет средств разработки [AWS SDK v.2](https://github.com/aws/aws-sdk-go-v2).

#### Получение списка имен бакетов {#list-buckets}

{% list tabs group=interface_relevance %}

- AWS SDK v.2 {#contemporary}

  ```go
  package main

  import (
      "context"
      "log"

      "github.com/aws/aws-sdk-go-v2/aws"
      "github.com/aws/aws-sdk-go-v2/config"
      "github.com/aws/aws-sdk-go-v2/service/s3"
  )

  func main() {

      // Подгружаем конфигурацию из ~/.aws/*
      cfg, err := config.LoadDefaultConfig(context.TODO())
      if err != nil {
          log.Fatal(err)
      }

      // Создаем клиента для доступа к хранилищу S3
      client := s3.NewFromConfig(cfg)

      // Запрашиваем список бакетов
      result, err := client.ListBuckets(context.TODO(), &s3.ListBucketsInput{})
      if err != nil {
          log.Fatal(err)
      }

      for _, bucket := range result.Buckets {
          log.Printf("bucket=%s creation time=%s", aws.ToString(bucket.Name), bucket.CreationDate.Local().Format("2006-01-02 15:04:05 Monday"))
      }
  }
  ```

- AWS SDK v.1 {#deprecated}

  ```go
  package main

  import (
      "context"
      "fmt"
      "log"

      "github.com/aws/aws-sdk-go-v2/aws"
      "github.com/aws/aws-sdk-go-v2/config"
      "github.com/aws/aws-sdk-go-v2/service/s3"
  )

  func main() {

      // Создаем кастомный обработчик эндпоинтов, который для сервиса S3 и региона ru-central1 выдаст корректный URL
      customResolver := aws.EndpointResolverWithOptionsFunc(func(service, region string, options ...interface{}) (aws.Endpoint, error) {
          if service == s3.ServiceID && region == "ru-central1" {
              return aws.Endpoint{
                  PartitionID:   "yc",
                  URL:           "https://storage.yandexcloud.net",
                  SigningRegion: "ru-central1",
              }, nil
          }
          return aws.Endpoint{}, fmt.Errorf("unknown endpoint requested")
      })

      // Подгружаем конфигурацию из ~/.aws/*
      cfg, err := config.LoadDefaultConfig(context.TODO(), config.WithEndpointResolverWithOptions(customResolver))
      if err != nil {
          log.Fatal(err)
      }

      // Создаем клиента для доступа к хранилищу S3
      client := s3.NewFromConfig(cfg)

      // Запрашиваем список бакетов
      result, err := client.ListBuckets(context.TODO(), &s3.ListBucketsInput{})
      if err != nil {
          log.Fatal(err)
      }

      for _, bucket := range result.Buckets {
          log.Printf("bucket=%s creation time=%s", aws.ToString(bucket.Name), bucket.CreationDate.Format("2006-01-02 15:04:05 Monday"))
      }
  }
  ```

{% endlist %}

#### Получение списка объектов в бакете {#list-buckets}

Чтобы получить список объектов в бакете, передайте его имя в параметре командной строки `-b`.

{% list tabs group=interface_relevance %}

- AWS SDK v.2 {#contemporary}

  ```go
  package main

  import (
      "context"
      "flag"
      "fmt"
      "log"

      "github.com/aws/aws-sdk-go-v2/aws"
      "github.com/aws/aws-sdk-go-v2/config"
      "github.com/aws/aws-sdk-go-v2/service/s3"
  )

  func main() {
      // Получаем имя бакета из аргумента командной строки
      bucketName := flag.String("b", "", "The name of the bucket")
      flag.Parse()

      if *bucketName == "" {
          fmt.Println("You must supply the name of a bucket (-b BUCKET)")
          return
      }

      // Подгружаем конфигурацию из ~/.aws/*
      cfg, err := config.LoadDefaultConfig(context.TODO())
      if err != nil {
          log.Fatal(err)
      }

      // Создаем клиента для доступа к хранилищу S3
      client := s3.NewFromConfig(cfg)

      // Запрашиваем список всех файлов в бакете
      result, err := client.ListObjectsV2(context.TODO(), &s3.ListObjectsV2Input{
          Bucket: aws.String(*bucketName),
      })
      if err != nil {
          log.Fatal(err)
      }

      for _, object := range result.Contents {
          log.Printf("object=%s size=%d Bytes last modified=%s", aws.ToString(object.Key), aws.ToInt64(object.Size), object.LastModified.Local().Format("2006-01-02 15:04:05 Monday"))
      }
  }
  ```

- AWS SDK v.1 {#deprecated}

  ```go
  package main

  import (
      "context"
      "fmt"
      "log"
      "flag"

      "github.com/aws/aws-sdk-go-v2/aws"
      "github.com/aws/aws-sdk-go-v2/config"
      "github.com/aws/aws-sdk-go-v2/service/s3"
  )

  func main() {
      // Получаем имя бакета из аргумента командной строки
      bucketName := flag.String("b", "", "The name of the bucket")
      flag.Parse()

      if *bucketName == "" {
          fmt.Println("You must supply the name of a bucket (-b BUCKET)")
          return
      }

      // Создаем кастомный обработчик эндпоинтов, который для сервиса S3 и региона ru-central1 выдаст корректный URL
      customResolver := aws.EndpointResolverWithOptionsFunc(func(service, region string, options ...interface{}) (aws.Endpoint, error) {
          if service == s3.ServiceID && region == "ru-central1" {
              return aws.Endpoint{
                  PartitionID:   "yc",
                  URL:           "https://storage.yandexcloud.net",
                  SigningRegion: "ru-central1",
              }, nil
          }
          return aws.Endpoint{}, fmt.Errorf("unknown endpoint requested")
      })

      // Подгружаем конфигурацию из ~/.aws/*
      cfg, err := config.LoadDefaultConfig(context.TODO(), config.WithEndpointResolverWithOptions(customResolver))
      if err != nil {
          log.Fatal(err)
      }

      // Создаем клиента для доступа к хранилищу S3
      client := s3.NewFromConfig(cfg)

      // Запрашиваем список всех файлов в бакете
      result, err := client.ListObjectsV2(context.TODO(), &s3.ListObjectsV2Input{
          Bucket: aws.String(*bucketName),
      })
      if err != nil {
          log.Fatal(err)
      }

      for _, object := range result.Contents {
          log.Printf("object=%s size=%d Bytes last modified=%s", aws.ToString(object.Key), object.Size, object.LastModified.Format("2006-01-02 15:04:05 Monday"))
      }
  }
  ```

{% endlist %}

Также смотрите [примеры кода](https://github.com/awsdocs/aws-doc-sdk-examples/tree/main/gov2/s3) и [справочник Go SDK API](https://pkg.go.dev/github.com/aws/aws-sdk-go-v2/service/s3).