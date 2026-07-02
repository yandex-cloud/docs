[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Бессерверные технологии](index.md) > Отправка писем в Yandex Cloud Postbox с помощью AWS SDK > Go

# Отправка писем с помощью AWS SDK для Go

В этом руководстве вы научитесь отправлять электронные письма через Yandex Cloud Postbox с использованием [AWS SDK для Go](https://docs.aws.amazon.com/sdk-for-go/v2/developer-guide/getting-started).

Чтобы начать отправлять электронные письма:

1. [Подготовьте облако к работе](#before-begin).
1. [Настройте директорию для аутентификационных данных](#auth).
1. [Создайте и запустите приложение](#app).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за использование Yandex Cloud Postbox ([тарифы Yandex Cloud Postbox](../../postbox/pricing.md));
* плата за публичные [DNS-запросы](../../glossary/dns.md) и [зоны DNS](../../dns/concepts/dns-zone.md), если вы создаете ресурсную запись в Cloud DNS ([тарифы Cloud DNS](../../dns/pricing.md)).


### Подготовьте ресурсы {#infrastructure}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../postbox/security/index.md#postbox-sender) `postbox.sender`.
1. [Создайте](../../iam/operations/authentication/manage-access-keys.md) статический ключ доступа для сервисного аккаунта. Сохраните идентификатор и секретный ключ.
1. [Создайте](../../postbox/operations/create-address.md) адрес.
1. [Пройдите](../../postbox/operations/check-domain.md) проверку владения доменом.


## Настройте директорию для аутентификационных данных {#auth}

1. Создайте директорию для хранения аутентификационных данных и перейдите в нее: 

    Для macOS и Linux:

    ```bash
    mkdir ~/.aws/
    ```

    Для Windows:

    ```bash
    mkdir C:\Users\<имя_пользователя>\.aws\
    ```

1. В директории `.aws` создайте файл `credentials` и скопируйте в него аутентификационные данные, полученные при [создании статического ключа доступа](#infrastructure):

    ```text
    [default]
    aws_access_key_id = <идентификатор_статического_ключа>
    aws_secret_access_key = <секретный_ключ>
    ```

1. Создайте файл `config` с параметрами региона по умолчанию и скопируйте в него следующую информацию:

    ```text
    [default]
    region = ru-central1
    endpoint_url = https://postbox.cloud.yandex.net
    ```


### Использование переменных окружения {#variables}

AWS SDK по умолчанию использует аутентификационные данные из переменных окружения, если они заданы. Эти переменные имеют приоритет над аутентификационными данными, которые указаны в файле `.aws/credentials`.

Поддерживаются следующие переменные окружения:

* `AWS_ACCESS_KEY_ID` — идентификатор статического ключа;
* `AWS_SECRET_ACCESS_KEY` — секретный ключ.

Чтобы задать переменные окружения, выполните следующие действия в зависимости от вашей операционной системы:

{% list tabs group=operating_system %}

- Linux/macOS

    В терминале выполните команду:

    ```bash
    export AWS_ACCESS_KEY_ID=<идентификатор_статического_ключа>
    export AWS_SECRET_ACCESS_KEY=<секретный_ключ>
    ```

- Windows

    В PowerShell выполните команду:

    ```powershell
    $Env:AWS_ACCESS_KEY_ID=<идентификатор_статического_ключа>
    $Env:AWS_SECRET_ACCESS_KEY=<секретный_ключ>
    ```

{% endlist %}


## Создайте и запустите приложение {#app}

1. Получите код приложения:

    {% list tabs %}

    - Репозиторий

      1. Склонируйте репозиторий:
         
         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-postbox-examples
         ```
      1. Перейдите в папку в склонированном репозитории `go/simple/`.
      1. В файле `main.go` укажите данные:
         
         * В поле `Sender` — электронную почту отправителя.
         
             Домен электронной почты отправителя должен совпадать с указанным в адресе Yandex Cloud Postbox, созданном при [подготовке к работе](#infrastructure). Например, если домен, на который вы подтвердили владение, — `yourdomain.com`, можно указать электронную почту `noreply@yourdomain.com` или `admin@yourdomain.com`, а `user@mail.yourdomain.com` — нельзя.
         
         * В поле `Recipient` — электронную почту получателя. Например: `receiver@domain.com`. Далее для проверки вам потребуется доступ к этой электронной почте.
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
            Subject = "Yandex Cloud Postbox Test via AWS SDK for Go"

            // HTML-текст письма.
            HtmlBody = "<h1>Amazon SES Test Email (AWS SDK for Go)</h1><p>This email was sent with " +
              "<a href='https://yandex.cloud/ru/docs/postbox/quickstart'>Yandex Cloud Postbox</a> using the " +
              "<a href='https://aws.amazon.com/sdk-for-go/'>AWS SDK for Go</a>.</p>"

            // Текст письма для почтовых клиентов без поддержки HTML.
            TextBody = "This email was sent with Yandex Cloud Postbox using the AWS SDK for Go."

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
              Region:             "ru-central1",
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
            u, err := url.Parse("https://postbox.cloud.yandex.net")
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

      1. В файле `main.go` укажите данные:
         
         * В поле `Sender` — электронную почту отправителя.
         
             Домен электронной почты отправителя должен совпадать с указанным в адресе Yandex Cloud Postbox, созданном при [подготовке к работе](#infrastructure). Например, если домен, на который вы подтвердили владение, — `yourdomain.com`, можно указать электронную почту `noreply@yourdomain.com` или `admin@yourdomain.com`, а `user@mail.yourdomain.com` — нельзя.
         
         * В поле `Recipient` — электронную почту получателя. Например: `receiver@domain.com`. Далее для проверки вам потребуется доступ к этой электронной почте.
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

Чтобы перестать платить за созданные ресурсы:

1. Удалите [адрес](../../postbox/concepts/glossary.md#adress).
1. [Удалите](../../dns/operations/zone-delete.md) зону DNS, если создавали в ней ресурсную запись.