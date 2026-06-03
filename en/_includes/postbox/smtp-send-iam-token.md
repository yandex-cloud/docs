1. In your SMTP mail client settings, specify the following parameters:

    #|
    || | **Email client supports STARTTLS** | **Email client supports SMTPS instead of STARTTLS** ||
    || **Server name** | `{{ postbox-host }}` {align="center"} | > ||
    || **Port** | `587` | `465` ||
    || **Username** | `IAM_TOKEN` {align="center"} | > ||
    || **Password** | Service account IAM token {align="center"} | > ||
    |#

1. Send an email using your email client and make sure the specified recipients receive it.
