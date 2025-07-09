

In this tutorial, you will learn how to send emails via {{ postbox-full-name }} using the [AWS SDK for Go](https://docs.aws.amazon.com/sdk-for-go/v2/developer-guide/getting-started).

To start sending emails:

1. [Get your cloud ready](#before-begin).
1. [Configure a directory for authentication data](#auth).
1. [Create and run the application](#app).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support costs include:

* Fee for using {{ postbox-full-name }} (see [{{ postbox-name }} pricing](../../postbox/pricing.md)).
* Fee for public DNS queries and [DNS zones](../../dns/concepts/dns-zone.md), if you are creating a resource record in {{ dns-name }} (see [{{ dns-name }} pricing](../../dns/pricing.md)).


### Set up resources {#infrastructure}

{% include [clone-yc-postbox-examples](../../_includes/postbox/send-emails-aws-sdk/send-emails-infrastructure.md) %}


## Configure a directory for authentication data {#auth}

{% include [sdk-auth](../../_includes/postbox/send-emails-aws-sdk/auth.md) %}


### Using environment variables {#variables}

{% include [sdk-env-variables](../../_includes/postbox/send-emails-aws-sdk/env-variables.md) %}


## Create and run the application {#app}

1. Get the application code:

    {% list tabs %}

    - Repository

      1. {% include [clone-yc-postbox-examples](../../_includes/postbox/send-emails-aws-sdk/clone-yc-postbox-examples.md) %}
      1. Navigate to the folder in the cloned `go/simple/` repository.
      1. {% include [edit-main-go](../../_includes/postbox/send-emails-aws-sdk/edit-main-go.md) %}
      1. Go to the `go/` directory.

    - Manually

      1. Create a directory named `postbox-go` and open it.
      1. Create a file named `main.go` and paste this code into it:

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
            // The sender's address must be verified using Amazon SES.
            Sender = "<sender_address>"

            // Recipient's address.
            Recipient = "<recipient_address>"

            // Email subject.
            Subject = "{{ postbox-full-name }} Test via AWS SDK for Go"

            // HTML text of the email.
            HtmlBody = "<h1>Amazon SES Test Email (AWS SDK for Go)</h1><p>This email was sent with " +
              "<a href='{{ link-docs }}/postbox/quickstart'>{{ postbox-full-name }}</a> using the " +
              "<a href='https://aws.amazon.com/sdk-for-go/'>AWS SDK for Go</a>.</p>"

            // Email text for email clients without HTML support.
            TextBody = "This email was sent with {{ postbox-full-name }} using the AWS SDK for Go."

            // Character encoding in the email.
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

            // Building the email.
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

            // Sending the email.
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
      1. Create a file named `go.mod` and paste this code into it:

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

1. Install the dependencies:

    ```bash
    go mod tidy
    ```

    Result:

    ```text
    go: downloading github.com/aws/aws-sdk-go-v2 v1.36.3
    go: downloading github.com/aws/aws-sdk-go-v2/service/sesv2 v1.42.0
    ...
    go: downloading github.com/aws/aws-sdk-go-v2/internal/endpoints/v2 v2.6.34
    ```

1. Run the application:

    ```bash
    go run main.go
    ```

    Result:

    ```text
    DAEBWI6L7WN5.1RLCK********@ingress2-sas
    ```


## Check the result {#check-result}

Make sure the recipient specified in the file named `main.go` in the `Recipient` field has received an email with the specified parameters.


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* Delete the [address](../../postbox/operations/).
* Delete the [DNS zone](../../dns/operations/zone-delete.md) if you had created a resource record in it.
