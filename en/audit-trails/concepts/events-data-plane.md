# Service-level event reference

The value of the `event_type` (_event type_) field in a service-level (Data Plane) audit log is determined by the event source service.

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

The general value format is as follows:

```text
{{ at-event-prefix }}.audit.<service_name>.<event_name>
```

Below are events for services:

* [{{ dns-name }}](#dns)
* [{{ lockbox-name }}](#lockbox)
* [{{ kms-name }}](#kms)
* [{{ objstorage-name }}](#objstorage)

## {{ dns-name }} {#dns}

Service name: `dns`

| Event name | Description |
--- | ---
| `ProcessDnsQuery` | Execution result of a DNS query from a Cloud DNS client |

## {{ lockbox-name }} {#lockbox}

Service name: `lockbox`

| Event name | Description |
--- | ---
| `GetPayload` | Accessing the contents of a secret |

## {{ kms-name }} {#kms}

Service name: `kms`

| Event name | Description |
--- | ---
| `Decrypt` | Decrypting ciphertext with a key |
| `Encrypt` | Encrypting a text string with a key |
| `GenerateDataKey` | Generating a high-entropy key for Envelope Encryption |
| `ReEncrypt` | Decrypting ciphertext with a previous-version key and re-encrypting the decrypted text with a new version of the same key |

## {{ objstorage-name }} {#objstorage}

Service name: `storage`

| Event name | Description |
--- | ---
| `ObjectAclUpdate` | Updating an object's ACL in a bucket |
| `ObjectCreate` | Creating an object in a bucket |
| `ObjectDelete` | Deleting an object from a bucket |
| `ObjectTagsDelete` | Deleting bucket object tags |
| `ObjectTagsUpdate` | Updating bucket object tags |
| `ObjectUpdate` | Updating an object in a bucket |
