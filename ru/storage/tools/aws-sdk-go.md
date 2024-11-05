# AWS SDK для Go


[AWS SDK для Go](https://aws.amazon.com/ru/sdk-for-go/) — это комплект средств разработки для работы с сервисами AWS на языке программирования Go.

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Установка {#installation}

{% include [install-go-sdk](../../_includes/aws-tools/install-go-sdk.md)%}

## Настройка {#setup}

{% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-storage-url.md) %}

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

      // Создаем кастомный обработчик эндпоинтов, который для сервиса S3 и региона {{ region-id }} выдаст корректный URL
      customResolver := aws.EndpointResolverWithOptionsFunc(func(service, region string, options ...interface{}) (aws.Endpoint, error) {
          if service == s3.ServiceID && region == "{{ region-id }}" {
              return aws.Endpoint{
                  PartitionID:   "yc",
                  URL:           "https://{{ s3-storage-host }}",
                  SigningRegion: "{{ region-id }}",
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

      // Создаем кастомный обработчик эндпоинтов, который для сервиса S3 и региона {{ region-id }} выдаст корректный URL
      customResolver := aws.EndpointResolverWithOptionsFunc(func(service, region string, options ...interface{}) (aws.Endpoint, error) {
          if service == s3.ServiceID && region == "{{ region-id }}" {
              return aws.Endpoint{
                  PartitionID:   "yc",
                  URL:           "https://{{ s3-storage-host }}",
                  SigningRegion: "{{ region-id }}",
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

Также см. [примеры кода](https://github.com/awsdocs/aws-doc-sdk-examples/tree/main/gov2/s3) и [справочник Go SDK API](https://pkg.go.dev/github.com/aws/aws-sdk-go-v2/service/s3).