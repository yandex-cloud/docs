1. In the SMTP server settings of your email client, specify the following parameters:

    #|
    || | **Email client supports STARTTLS** | **Email client supports SMTPS instead of STARTTLS** ||
    || **Server name** | `{{ postbox-host }}` {align="center"} | > ||
    || **Port** | `587` | `465` ||
    || **Username** | ID of the created API key {align="center"} | > ||
    || **Password** | Secret part of the created API key {align="center"} | > ||
    |#

1. Send an email using your email client and make sure the specified recipients receive it.
