

В этом руководстве вы научитесь отправлять электронные письма через {{ postbox-full-name }} с использованием [AWS SDK для Go](https://docs.aws.amazon.com/sdk-for-go/v2/developer-guide/getting-started).

Чтобы начать отправлять электронные письма:

1. [Подготовьте облако к работе](#before-begin).
1. [Настройте директорию для аутентификационных данных](#auth).
1. [Создайте и запустите приложение](#app).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../../_includes/postbox/send-emails-aws-sdk/paid-resources.md) %}


### Подготовьте ресурсы {#infrastructure}

{% include [clone-yc-postbox-examples](../../_includes/postbox/send-emails-aws-sdk/infrastructure.md) %}


## Настройте директорию для аутентификационных данных {#auth}

{% include [sdk-auth](../../_includes/postbox/send-emails-aws-sdk/auth.md) %}


### Использование переменных окружения {#variables}

{% include [sdk-env-variables](../../_includes/postbox/send-emails-aws-sdk/env-variables.md) %}


## Создайте и запустите приложение {#app}

1. Получите код приложения:

    {% list tabs %}

    - Репозиторий

      1. {% include [clone-yc-postbox-examples](../../_includes/postbox/send-emails-aws-sdk/clone-yc-postbox-examples.md) %}
      1. Перейдите в папку в склонированном репозитории `go/simple/`.
      1. {% include [edit-main-go](../../_includes/postbox/send-emails-aws-sdk/edit-main-go.md) %}
      1. Перейдите в папку `go/`.

    - Вручную

      1. Создайте папку `postbox-go` и перейдите в нее.
      1. Создайте файл `main.go` и вставьте в него код:

          ```go
          package main

          import (
            "context"
            "fmt"
            "net/url"
            "os"

            "github.com/aws/aws-sdk-go-v2/aws"
            "github.com/aws/aws-sdk-go-v2/config"
            "github.com/aws/aws-sdk-go-v2/service/sesv2"
            "github.com/aws/aws-sdk-go-v2/service/sesv2/types"
            transport "github.com/aws/smithy-go/endpoints"
          )

          const (
            // Адрес отправителя должен быть подтвержден с помощью Amazon SES.
            Sender = "<адрес_отправителя>"

            // Адрес получателя.
            Recipient = "<адрес_получателя>"

            // Тема письма.
            Subject = "{{ postbox-full-name }} Test via AWS SDK for Go"

            // HTML-текст письма.
            HtmlBody = "<h1>Amazon SES Test Email (AWS SDK for Go)</h1><p>This email was sent with " +
              "<a href='{{ link-docs }}/postbox/quickstart'>{{ postbox-full-name }}</a> using the " +
              "<a href='https://aws.amazon.com/sdk-for-go/'>AWS SDK for Go</a>.</p>"

            // Текст письма для почтовых клиентов без поддержки HTML.
            TextBody = "This email was sent with {{ postbox-full-name }} using the AWS SDK for Go."

            // Кодировка символов в письме.
            CharSet = "UTF-8"
          )

          func main() {
            cfg, err := config.LoadDefaultConfig(
              context.Background(),
            )
            if err != nil {
              fmt.Println("unable to load SDK config, " + err.Error())
              os.Exit(1)
            }

            client := sesv2.New(sesv2.Options{
              Region:             "{{ region-id }}",
              EndpointResolverV2: &resolverV2{},
              Credentials: cfg.Credentials,
            })

            // Сборка письма.
            input := &sesv2.SendEmailInput{
              Destination: &types.Destination{
                ToAddresses: []string{Recipient},
              },
              Content: &types.EmailContent{
                Simple: &types.Message{
                  Subject: &types.Content{
                    Charset: aws.String(CharSet),
                    Data:    aws.String(Subject),
                  },
                  Body: &types.Body{
                    Html: &types.Content{
                      Charset: aws.String(CharSet),
                      Data:    aws.String(HtmlBody),
                    },
                    Text: &types.Content{
                      Charset: aws.String(CharSet),
                      Data:    aws.String(TextBody),
                    },
                  },
                },
              },
              FromEmailAddress: aws.String(Sender),
            }

            // Отправка письма.
            ctx := context.Background()
            res, err := client.SendEmail(ctx, input)

            if err != nil {
              panic(err)
            }

            fmt.Println(*res.MessageId)
          }

          type resolverV2 struct{}

          func (*resolverV2) ResolveEndpoint(_ context.Context, _ sesv2.EndpointParameters) (
            transport.Endpoint, error,
          ) {
            u, err := url.Parse("{{ postbox-endpoint }}")
            if err != nil {
              return transport.Endpoint{}, err
            }
            return transport.Endpoint{
              URI: *u,
            }, nil
          }

          type staticCredentialsProvider struct {
            accessKeyID     string
            secretAccessKey string
          }

          func (s *staticCredentialsProvider) Retrieve(_ context.Context) (aws.Credentials, error) {
            return aws.Credentials{
              AccessKeyID:     s.accessKeyID,
              SecretAccessKey: s.secretAccessKey,
            }, nil
          }
          ```

      1. {% include [edit-main-go](../../_includes/postbox/send-emails-aws-sdk/edit-main-go.md) %}
      1. Создайте файл `go.mod` и вставьте в него код:

          ```goalng
          module postbox

          go 1.23

          require (
            github.com/aws/aws-sdk-go-v2 v1.36.3
            github.com/aws/aws-sdk-go-v2/config v1.29.14
            github.com/aws/aws-sdk-go-v2/service/sesv2 v1.42.0
            github.com/aws/smithy-go v1.22.2
            github.com/emersion/go-message v0.18.2
          )

          require (
            github.com/aws/aws-sdk-go-v2/credentials v1.17.67 // indirect
            github.com/aws/aws-sdk-go-v2/feature/ec2/imds v1.16.30 // indirect
            github.com/aws/aws-sdk-go-v2/internal/configsources v1.3.34 // indirect
            github.com/aws/aws-sdk-go-v2/internal/endpoints/v2 v2.6.34 // indirect
            github.com/aws/aws-sdk-go-v2/internal/ini v1.8.3 // indirect
            github.com/aws/aws-sdk-go-v2/internal/v4a v1.3.33 // indirect
            github.com/aws/aws-sdk-go-v2/service/internal/accept-encoding v1.12.3 // indirect
            github.com/aws/aws-sdk-go-v2/service/internal/presigned-url v1.12.15 // indirect
            github.com/aws/aws-sdk-go-v2/service/sso v1.25.3 // indirect
            github.com/aws/aws-sdk-go-v2/service/ssooidc v1.30.1 // indirect
            github.com/aws/aws-sdk-go-v2/service/sts v1.33.19 // indirect
          )
          ```

    {% endlist %}

1. Установите зависимости:

    ```bash
    go mod tidy
    ```

    Результат:

    ```text
    go: downloading github.com/aws/aws-sdk-go-v2 v1.36.3
    go: downloading github.com/aws/aws-sdk-go-v2/service/sesv2 v1.42.0
    ...
    go: downloading github.com/aws/aws-sdk-go-v2/internal/endpoints/v2 v2.6.34
    ```

1. Запустите приложение:

    ```bash
    go run main.go
    ```

    Результат:

    ```text
    DAEBWI6L7WN5.1RLCK********@ingress2-sas
    ```


## Проверьте результат {#check-result}

Убедитесь, что на адрес получателя, заданный в файле `main.go` в поле `Recipient`, пришло письмо с указанными параметрами.


## Как удалить созданные ресурсы {#clear-out}

{% include [clear-out](../../_includes/postbox/send-emails-aws-sdk/clear-out.md) %}
