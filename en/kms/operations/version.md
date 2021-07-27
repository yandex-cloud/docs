---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Key version management

You can make key versions primary (the default key version is used for encryption and decryption) and destroy them. To create a new key version, [rotate](key.md#rotate) the key.

## Make a version primary {#make-primary}

To make a version primary:

{% list tabs %}

- Management console
  1. Log in to [management console]({{ link-console-main }}).
  1. Select **{{ kms-name }}**.
  1. In the **Keys** tab, click the key in the list to open the page with its attributes.
  1. Click ![menu](../../_assets/horizontal-ellipsis.svg) in the line of the desired version and select **Make primary** from the menu.

- CLI

  1. Get a list of versions for the desired key:

     ```
     $ yc kms symmetric-key list-versions example-key
     
     +----------------------+---------+--------+-----------+
     |          ID          | PRIMARY | STATUS | ALGORITHM |
     +----------------------+---------+--------+-----------+
     | abjhduu82ao0r0tkjlp2 | true    | ACTIVE | AES_128   |
     | abj8cvn99nam26f0f4a3 | false   | ACTIVE | AES_128   |
     | abjed9ciau8eatb0pg93 | false   | ACTIVE | AES_256   |
     | abjvejjvfktqc4hsqpss | false   | ACTIVE | AES_128   |
     +----------------------+---------+--------+-----------+
     ```

  1. Change the key version by specifying the ID of the desired version:

     ```
     $ yc kms symmetric-key set-primary-version example-key-1 \
       --version-id abj8cvn99nam26f0f4a3
     ```

{% endlist %}

The next encryption or decryption request omitting the key version will use the new primary version.

## Destroy a key version {#delete}

You can't destroy a version immediately: you can only schedule its destruction (for the next day at least).

{% note alert %}

On the scheduled date, the key version is permanently destroyed: if you still have data encrypted with this key version, you can no longer decrypt it.

{% endnote %}

{% list tabs %}

- Management console

  To destroy a version:
  1. Log in to [management console]({{ link-console-main }}).
  1. Select **{{ kms-name }}**.
  1. In the **Keys** tab, click the key in the list to open the page with its attributes.
  1. Click ![menu](../../_assets/horizontal-ellipsis.svg) in the line of the desired version and select **Schedule destruction** from the menu.

  The version switches to the `Scheduled For Destruction` status. The day that destruction is scheduled for is shown in the **Destruction date** column.

- CLI

  To destroy a version:

  1. Get a list of versions for the desired key:

     ```
     $ yc kms symmetric-key list-versions example-key
     +----------------------+---------+--------+-----------+
     |          ID          | PRIMARY | STATUS | ALGORITHM |
     +----------------------+---------+--------+-----------+
     | abj8cvn99nam26f0f4a3 | true    | ACTIVE | AES_128   |
     | abjed9ciau8eatb0pg93 | false   | ACTIVE | AES_256   |
     | abjhduu82ao0r0tkjlp2 | false   | ACTIVE | AES_128   |
     | abjvejjvfktqc4hsqpss | false   | ACTIVE | AES_128   |
     +----------------------+---------+--------+-----------+
     ```

  1. Schedule the destruction of a version:

     ```
     $ yc kms symmetric-key schedule-version-destruction example-key \
       --version-id abjed9ciau8eatb0pg93
     ```

     The status of the version switches to `SCHEDULED_FOR_DESTRUCTION` and the `destroy_at` field shows the time when destruction is scheduled for.

{% endlist %}

## Cancel version destruction {#cancel-delete}

If you scheduled the destruction of a key version, you can cancel it before the scheduled date:

{% list tabs %}

- Management console
  1. Log in to [management console]({{ link-console-main }}).
  1. Select **{{ kms-name }}**.
  1. In the **Keys** tab, click the key in the list to open the page with its attributes.
  1. Click ![menu](../../_assets/horizontal-ellipsis.svg) in the line of the desired version and select **Cancel destruction** from the menu.

  The version reverts to the `Active` status.

- CLI

  1. Get a list of versions for the desired key:

     ```
     $ yc kms symmetric-key list-versions example-key
     +----------------------+---------+---------------------------+-----------+
     |          ID          | PRIMARY |          STATUS           | ALGORITHM |
     +----------------------+---------+---------------------------+-----------+
     | abj8cvn99nam26f0f4a3 | true    | ACTIVE                    | AES_128   |
     | abjed9ciau8eatb0pg93 | false   | SCHEDULED_FOR_DESTRUCTION | AES_256   |
     | abjhduu82ao0r0tkjlp2 | false   | ACTIVE                    | AES_128   |
     | abjvejjvfktqc4hsqpss | false   | ACTIVE                    | AES_128   |
     +----------------------+---------+---------------------------+-----------+
     ```

  1. Cancel the destruction of a version:

     ```
     $ yc kms symmetric-key cancel-version-destruction example-key \
       --version-id abjed9ciau8eatb0pg93
     ```

     The version reverts to the `Active` status.

{% endlist %}

