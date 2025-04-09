In the SMTP server settings of your email client, specify the following parameters:

{% note info %}

We do not recommend using email clients that do not support the [STARTTLS](https://ru.wikipedia.org/wiki/STARTTLS) extension to encrypt emails you send.

{% endnote %}

#|
|| | **Email client supports STARTTLS** | **Email client supports SMTPS instead of STARTTLS** ||
|| **Server name** | `{{ postbox-host }}` {.cell-align-center} | > ||
|| **Port** | `587` | `465` ||
|| **Username** | `API_KEY` {.cell-align-center} | > ||
|| **Password** | Secret part of the created API key {.cell-align-center} | > ||
|#