---
title: SMTP responses in {{ postbox-full-name }}
description: This article describes successful responses and errors returned by the {{ postbox-name }} SMTP interface when sending emails.
---

# SMTP responses

When sending via SMTP, {{ postbox-name }} returns responses in SMTP format: numeric response code, enhanced status code (`enhanced status code`), and text comment. For responses with 4xx or 5xx codes, a request ID (`RequestID`) is added to the text. Provide it when contacting support.

```
550 5.4.1 identity not verified RequestID: <request-id>
```

## Successful responses {#success}

#|
|| **Code** | **Enhanced code** | **Text** | **Value** ||
|| `250` | `2.6.0` | `OK: queued as <message-id>` | Email accepted and queued for sending. `<message-id>` is the message ID. ||
|#

## Temporary 4xx errors {#temporary-errors}

Responses with the 4xx code mean that you can repeat your request later.

#|
|| **Code** | **Enhanced code** | **Text** | **Cause** | **What to do** ||
|| `421` | `4.3.0` | `Unexpected error.` | Internal service error or unexpected processing error. | Resend later. If the error persists, contact support with `RequestID`. ||
|| `421` | `4.4.2` | `Idle timeout, bye bye` | The server closed the connection because it did not receive any SMTP commands from the client for longer than the allowed idle time (about one minute). | Do not keep the connection open while idle. Establish a new connection and retry sending. ||
|| `451` | `4.4.2` | `Timeout waiting for data from client` | Email body retrieval timeout expired or the connection was interrupted during data transmission. | Check the network connection and client timeouts, then resend. ||
|| `454` | — | `Maximum sending rate exceeded` | The `postbox.send.rate` quota has been exceeded. | Reduce the email sending rate and retry the request later. ||
|#

## Permanent 5xx errors {#permanent-errors}

5XX responses mean that the request will be not processed if not modified. Repeating it as is makes no sense.

### Authentication and authorization {#auth}

#|
|| **Code** | **Enhanced code** | **Text** | **Cause** | **What to do** ||
|| `538` | `5.7.8` | `Authentication credentials invalid` | No login or password provided, or credentials have an invalid signature format or are Base64 encoded. | Check your SMTP username and password. ||
|| `535` | `5.7.8` | `Authentication failed` | Credentials verification failed: invalid IAM token, API key, or static key. | Make sure your credentials are up-to-date and correct. ||
|| `534` | `5.7.8` | `Authorization failed` | Access permissions validation error. | Repeat your request later. If the error persists, contact support. ||
|| `534` | `5.7.8` | `Not enough permissions` | Credentials are correct, but the service account is not authorized to send emails. | Assign the `postbox.sender` [role](../security/index.md#service-roles) or higher to the service account. ||
|#

### Order of commands and TLS {#commands-and-tls}

#|
|| **Code** | **Enhanced code** | **Text** | **Cause** | **What to do** ||
|| `530` | `5.7.0` | `Must issue a STARTTLS command first` | Command sent over an unencrypted connection. | Establish a TLS connection (STARTTLS or SMTPS) before authentication and sending. ||
|| `502` | `5.7.0` | `Please authenticate first` | The `MAIL FROM`, `RCPT TO`, or `DATA` command executed before successful authentication. | Execute `AUTH` before you send the email. ||
|#

### Sender and recipients {#sender-and-recipients}

#|
|| **Code** | **Enhanced code** | **Text** | **Cause** | **What to do** ||
|| `550` | — | `Empty envelope senders not allowed` | Authenticated client specifies an empty sender address (`MAIL FROM:<>`). | Provide a valid sender address. ||
|| `550` | `5.4.1` | `identity not found` | Sender address not found. | Make sure the sender address was created in {{ postbox-name }}. ||
|| `550` | `5.4.1` | `identity not verified` | Sender address not verified. | Complete [domain ownership verification](../operations/check-domain.md). ||
|| `550` | `5.4.1` | `identity is blocked` | Sender address blocked. | Contact support to find out the reason for blocking. ||
|| `550` | `5.7.1` | `sender is not allowed` | Sender not on allowed list for the address. | Use an [allowed sender](../operations/restrict-senders.md) or add the sender to the allowed list. ||
|#

### Quotas and limits {#quotas-and-message-size}

Learn more about quotas and how to increase them [here](../concepts/limits.md).

#|
|| **Code** | **Enhanced code** | **Text** | **Cause** | **What to do** ||
|| `550` | `5.4.5` | `Daily sending quota exceeded.` | The `postbox.emails_sent.count` quota has been used up. | Wait for a quota reset or request an increase. ||
|| `552` | `5.5.3` | `Maximum limit of <N> recipients reached` | The `RCPT TO` command adds a recipient beyond the `postbox.recipients_per_email.count` quota. Only this command is rejected; previously accepted recipients remain in the transaction. | Do not proceed with the transaction: if you send the `DATA` command after this response, the email will be accepted and delivered to the first `<N>` recipients. Reset the transaction using the `RSET` command and split the delivery into multiple emails with fewer recipients. ||
|| `552` | `5.3.4` | `message is too big (message size quota exceeded)` | The `postbox.email.size` quota has been exceeded. | Reduce message size: email body or attachments. ||
|| `552` | `5.3.4` | `Maximum message size exceeded` | Message size exceeds the server's technical limit. | Reduce message size. ||
|#

### Syntax and validation {#syntax-and-validation}

#|
|| **Code** | **Enhanced code** | **Text** | **Cause** | **What to do** ||
|| `500` | — | `Line too long` | Command line too long. | Check your SMTP command format and shorten the lines as per the RFC 2822 [line length limit](https://datatracker.ietf.org/doc/html/rfc2822#section-2.1.1). ||
|| `500` | — | `validation failed` or a specific validation message | Request failed to pass validation. | Correct the email as per the error text. ||
|| `501` | — | `Syntax error in parameters or arguments` | Failed to parse the address in the `MAIL FROM` or `RCPT TO` command, or the address is empty. | Make sure the sender and recipient addresses are correct. ||
|#

## Request ID {#request-id}

If the response contains `RequestID: <request-id>`, save this ID and include it when contacting support to speed up troubleshooting.
