---
title: FAQ about {{ postbox-full-name }}
description: This page covers questions and answers about {{ postbox-name }}.
---

# General questions about {{ postbox-name }}

#### Is there support for Cyrillic domains? {#cyrillic-domains}

Yes, {{ postbox-name }} supports Cyrillic domains ([IDN](https://{{ lang }}.wikipedia.org/wiki/Internationalized_domain_name)). To use a Cyrillic domain, specify it in [Punycode](../operations/create-address.md) encoding when [creating an address](https://{{ lang }}.wikipedia.org/wiki/Punycode). For example, the domain `пример.рф` will appear as `xn--e1afmkfd.xn--p1ai` in Punycode.

#### Can I use my {{ yandex-360 }} organization's primary domain for {{ postbox-name }} mailings? {#domain-yandex-360-mailing}

Yes, you can specify your {{ yandex-360 }} organization's domain in the address settings and send your emails from it.

#### Are there any {{ yandex-360 }} or {{ postbox-name }} quotas and limits when using a {{ yandex-360 }} domain? {#domain-yandex-360-limits}

{{ postbox-name }} quotas and limits apply when using any domains. For more information, see [{#T}](../concepts/limits.md).

#### Is it required to create an SPF record? {#spf-required}

No, creating an SPF record on your custom domain is not required. Each email sent via {{ postbox-name }} is signed with two DKIM signatures: one from `postbox.yandexcloud.net`, our technical domain (with its SPF record preconfigured), and a second from your custom domain. In most cases, such authentication is sufficient for successful email delivery.

However, if the recipient has strict incoming mail screening policies, you may need to add an SPF record to your custom domain as well. Learn how to do this in [{#T}](../concepts/dns-records.md#spf).

#### Why do I need to add two CNAME records when setting up Easy DKIM, but the TXT record resolves only through one of them? {#dkim-two-records}

Two CNAME records are required to enable {{ postbox-name }} to automatically rotate DKIM key pairs. Public key TXT records resolve through both CNAME records only during key rotation. At other times, only a single TXT record is available. For more information, see [{#T}](../concepts/dns-records.md#key-rotation).

#### Why is email delivery delayed? {#delivery-delay}

One common cause of delays is [greylisting](https://en.wikipedia.org/wiki/Greylisting_(email)) (`greylisting`) on the recipient's mail server. This is an anti-spam technique where the server temporarily rejects the first email delivery attempt assuming that a legitimate mail server will repeat it later.

{{ postbox-name }} will automatically retry delivery. Usually, after the delay set by the recipient's server, the email will be accepted and delivered.

#### Why was an email not sent to the recipient? {#message-suppressed}

One possible reason is that the recipient's address is on a [suppression list](../concepts/suppression-list.md). For more information, see [{#T}](../concepts/suppression-list.md).

#### Why does my connection drop with a `421 4.4.2 Idle timeout` error? {#idle-timeout}

The SMTP connection remains open for as long as the client is sending commands: the idle timeout restarts on each command received by the server. If the pause between commands exceeds the allowed idle time (around one minute), the server will respond with `421 4.4.2 Idle timeout, bye bye` and close the connection. This error comes between transactions, so the email is neither lost nor duplicated. To continue sending, establish a new connection.

To avoid getting this error:

* If using a connection pool, send emails in succession, send the `NOOP` command more often than once per minute (any command resets the idle timeout), or close the connection with the `QUIT` command and open a new one before the next send.
* Your pauses between retries, including after the `454 Maximum sending rate exceeded` error, should be between connections, not during an active connection.
* The message body must fit entirely within the same timeout after the `DATA` command; the timeout is counted from the `DATA` command. Otherwise, the server will return the `451 4.4.2 Timeout waiting for data from client` error. If your data transmission channel is slow and the attachments are large, reduce the size of the email.

The `421 4.4.2` error is neither a quota error nor a bounce. For more on SMTP responses, see [{#T}](../api-ref/smtp-errors.md).
