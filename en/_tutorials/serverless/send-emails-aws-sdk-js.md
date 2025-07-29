

In this tutorial, you will learn how to send emails via {{ postbox-full-name }} using the [AWS SDK for JavaScript](https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/welcome.html).

To start sending emails:

1. [Get your cloud ready](#before-begin).
1. [Configure a directory for authentication data](#auth).
1. [Create and run the application](#app).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](../../_includes/postbox/send-emails-aws-sdk/paid-resources.md) %}


### Set up resources {#infrastructure}

{% include [infrastructure](../../_includes/postbox/send-emails-aws-sdk/infrastructure.md) %}


## Configure a directory for authentication data {#auth}

{% include [sdk-auth](../../_includes/postbox/send-emails-aws-sdk/auth.md) %}


### Using environment variables {#variables}

{% include [sdk-env-variables](../../_includes/postbox/send-emails-aws-sdk/env-variables.md) %}


## Create and run the application {#app}

1. Get the application code:

    {% list tabs %}

    - Repository

      1. {% include [clone-yc-postbox-examples](../../_includes/postbox/send-emails-aws-sdk/clone-yc-postbox-examples.md) %}
      1. Navigate to the folder in the cloned `javascript/` repository.
      1. {% include [edit-main-js](../../_includes/postbox/send-emails-aws-sdk/edit-main-js.md) %}

    - Manually

      1. Create a directory named `postbox-javascript` and open it.
      1. Create a file named `main.js` and paste this code into it:

          ```javascript
          // AWS SDK for JavaScript v3 (ESM)
          import { SESv2Client, SendEmailCommand } from '@aws-sdk/client-sesv2';

          // The sender's address must be verified using Amazon SES.
          const SENDER = "<sender_address>";

          // Recipient's address.
          const RECIPIENT = "<recipient_address>";

          // Email subject.
          const SUBJECT = "{{ postbox-full-name }} Test via AWS SDK for JavaScript v3";

          // HTML text of the email.
          const HTML_BODY = `<h1>Amazon SES Test Email (AWS SDK for JavaScript v3)</h1>
          <p>This email was sent with <a href='{{ link-docs }}/postbox/quickstart'>{{ postbox-full-name }}</a> using the 
          <a href='https://aws.amazon.com/sdk-for-javascript/'>AWS SDK for JavaScript v3</a>.</p>`;

          // Email text for email clients without HTML support.
          const TEXT_BODY = "This email was sent with {{ postbox-full-name }} using the AWS SDK for JavaScript v3.";

          // Character encoding in the email.
          const CHARSET = "UTF-8";

          // Main function
          async function main() {
              // Create a SES client with an endpoint for {{ postbox-full-name }}
              const client = new SESv2Client({
                  region: '{{ region-id }}',
                  endpoint: '{{ postbox-endpoint }}',
                  // By default, the SDK uses the default credential provider chain.
                  // You can use static credentials by uncommenting and changing the following lines:
                  // credentials: {
                  //     accessKeyId: 'accessKeyID',
                  //     secretAccessKey: 'secretAccessKey',
                  // },
              });

              // Building the email.
              const params = {
                  Destination: {
                      ToAddresses: [RECIPIENT],
                  },
                  Content: {
                      Simple: {
                          Subject: {
                              Charset: CHARSET,
                              Data: SUBJECT,
                          },
                          Body: {
                              Html: {
                                  Charset: CHARSET,
                                  Data: HTML_BODY,
                              },
                              Text: {
                                  Charset: CHARSET,
                                  Data: TEXT_BODY,
                              },
                          },
                      },
                  },
                  FromEmailAddress: SENDER,
              };

              try {
                  // Creating a command.
                  const command = new SendEmailCommand(params);

                  // Sending the email.
                  const data = await client.send(command);
                  console.log(data.MessageId);
              } catch (err) {
                  console.error("Error sending email:", err);
                  throw err;
              }
          }

          // Running the main function.
          main().catch(err => {
              console.error("Unhandled error:", err);
              process.exit(1);
          });
          ```

      1. {% include [edit-main-js](../../_includes/postbox/send-emails-aws-sdk/edit-main-js.md) %}
      1. Create a file named `package.json` and paste this code into it:

          ```json
          {
            "name": "yc-postbox-example",
            "version": "1.0.0",
            "description": "Example of sending emails through {{ postbox-full-name }} using AWS SDK for JavaScript",
            "main": "main.js",
            "type": "module",
            "scripts": {
              "start": "node main.js"
            },
            "dependencies": {
              "@aws-sdk/client-sesv2": "^3.821.0"
            },
            "license": "MIT"
          }
          ```

    {% endlist %}

1. Install the dependencies:

    ```bash
    npm install
    ```

    Result:

    ```text
    added 79 packages, and audited 80 packages in 3s
    
    3 packages are looking for funding
      run `npm fund` for details
    
    found 0 vulnerabilities
    ```

  1. Run the application:

      ```bash
      npm start
      ```

      Result:

      ```text
      > yc-postbox-example@1.0.0 start
      > node main.js

      DB6TZYXAOBH1.2E2Q5********@ingress2-klg
      ```


## Check the result {#check-result}

Make sure the recipient specified in the file named `main.js` in the `RECIPIENT` field has received an email with the specified parameters.


## How to delete the resources you created {#clear-out}

{% include [clear-out](../../_includes/postbox/send-emails-aws-sdk/clear-out.md) %}