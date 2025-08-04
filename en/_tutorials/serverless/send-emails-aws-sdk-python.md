

In this tutorial, you will learn how to send emails via {{ postbox-full-name }} using the [AWS SDK for Python (Boto3)](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html).

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
      1. Navigate to the folder in the cloned `/` repository.
      1. {% include [edit-main-python](../../_includes/postbox/send-emails-aws-sdk/edit-main-python.md) %}

    - Manually

      1. Create a directory named `postbox-python` and open it.
      1. Create a file named `raw.py` and paste this code into it:

          ```python
          import boto3
          from botocore.config import Config
          from email.mime.multipart import MIMEMultipart
          from email.mime.text import MIMEText
          from email.mime.application import MIMEApplication
          import os

          # The sender's address must be verified using Amazon SES.
          SENDER = "<sender_address>"

          # Recipient's address.
          RECIPIENT = "<recipient_address>"

          # Email subject:
          SUBJECT = "{{ postbox-full-name }} Raw Email Test via AWS SDK for Python"

          # Path to the file you need to attach to the email.
          ATTACHMENT = "attachment.txt"

          # HTML text of the email.
          HTML_BODY = """<h1>Amazon SES Raw Email Test (AWS SDK for Python)</h1>
          <p>This email was sent with <a href='{{ link-docs }}/postbox/quickstart'>{{ postbox-full-name }}</a> using the 
          <a href='https://aws.amazon.com/sdk-for-python/'>AWS SDK for Python</a> with raw email format.</p>
          <p>Please see the attached file.</p>"""

          # Email text for email clients without HTML support.
          TEXT_BODY = "This email was sent with {{ postbox-full-name }} using the AWS SDK for Python with raw email format. Please see the attached file."

          # Character encoding in the email.
          CHARSET = "UTF-8"

          def main():
              # Creating a custom endpoint resolver for {{ postbox-full-name }}
              endpoint_url = "{{ postbox-endpoint }}"

              # Configuring a SES client with a custom endpoint
              config = Config(
                  region_name="{{ region-id }}",
                  # Uncomment the following line to enable debug logging
                  # parameter_validation=False,
              )

              # Creating a SES client
              # By default, the SDK uses the default credential provider chain.
              # You can use static credentials by uncommenting and changing the following lines:
              # session = boto3.Session(
              #     aws_access_key_id='accessKeyID',
              #     aws_secret_access_key='secretAccessKey',
              # )
              # ses_client = session.client('sesv2', config=config, endpoint_url=endpoint_url)

              # Using default credentials
              ses_client = boto3.client('sesv2', config=config, endpoint_url=endpoint_url)

              # Creating a parent multipart/mixed container
              msg = MIMEMultipart('mixed')
              # Adding lines: subject, from, to
              msg['Subject'] = SUBJECT
              msg['From'] = SENDER
              msg['To'] = RECIPIENT

              # Creating a child multipart/alternative container
              msg_body = MIMEMultipart('alternative')

              # Enconding the content in text and HTML formats and setting the character encoding
              textpart = MIMEText(TEXT_BODY.encode(CHARSET), 'plain', CHARSET)
              htmlpart = MIMEText(HTML_BODY.encode(CHARSET), 'html', CHARSET)

              # Adding parts with text and HTML content to the child container
              msg_body.attach(textpart)
              msg_body.attach(htmlpart)

              # Identifying the part with attachments and enconding it with MIMEApplication
              try:
                  att = MIMEApplication(open(ATTACHMENT, 'rb').read())
                  # Adding a header to inform the email client that this part is an attachment
                  att.add_header('Content-Disposition', 'attachment', filename=os.path.basename(ATTACHMENT))
                  # Assigning the attachment to the parent container
                  msg.attach(att)
              except FileNotFoundError:
                  print(f"Warning: Attachment file {ATTACHMENT} not found. Sending email without attachment.")

              # Assigning the child multipart/alternative container to the parent multipart/mixed container
              msg.attach(msg_body)

              # Converting the MIME message into a string and then into bytes
              raw_message = str(msg)
              raw_message_bytes = bytes(raw_message, CHARSET)

              try:
                  # Sending an email
                  response = ses_client.send_email(
                      FromEmailAddress=SENDER,
                      Destination={
                          'ToAddresses': [RECIPIENT]
                      },
                      Content={
                          'Raw': {
                              'Data': raw_message_bytes
                          }
                      }
                  )
                  # Printing the email ID
                  print(f"Email sent! Message ID: {response['MessageId']}")
              except Exception as e:
                  print(f"Error sending email: {e}")
                  raise

          if __name__ == "__main__":
              main()
          ```

      1. {% include [edit-main-python](../../_includes/postbox/send-emails-aws-sdk/edit-main-python.md) %}
      1. Create a file named `requirements.txt` and insert this line into it: `boto3`.
      1. Create a file named `attachment.txt` and insert any text into it.

    {% endlist %}

1. Create a virtual environment and install the dependencies:

    {% list tabs group=operating_system %}

    - Linux/MacOS {#linux-macos}

      ```bash
      python -m venv venv
      source venv/bin/activate
      pip install -r requirements.txt
      ```

    - Windows {#windows}

      ```bash
      python -m venv venv
      source venv\Scripts\activate
      pip install -r requirements.txt
      ```

    {% endlist %}

    Result:

    ```text
    ...
    Successfully installed boto3-1.39.4 botocore-1.39.4 jmespath-1.0.1 python-dateutil-2.9.0.post0 s3transfer-0.13.0 six-1.17.0 urllib3-2.5.0
    ```

1. Run the application:

    ```bash
    python raw.py
    ```

    Result:

    ```text
    Email sent! Message ID: DB9WSLG38TUS.11PW8********@ingress2-klg
    ```


## Check the result {#check-result}

Make sure the recipient specified in the file named `raw.py` in the `RECIPIENT` field has received an email with the specified parameters. The email should contain the attachment, i.e., the `attachment.txt` file.


## How to delete the resources you created {#clear-out}

{% include [clear-out](../../_includes/postbox/send-emails-aws-sdk/clear-out.md) %}