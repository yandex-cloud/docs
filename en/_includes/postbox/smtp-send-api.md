1. In the SMTP server settings of your email client, specify the following parameters:
    * Server name: `{{ postbox-host }}`.
    * Port: `587`.
    * Username: `API_KEY`.
    * Password: Secret part of the created API key.

    {% include [starttls-support](starttls-support.md) %}

1. Send an email using your email client and make sure the specified recipients receive it.