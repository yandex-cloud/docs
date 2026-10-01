# Managing key versions

You can make key versions primary (a primary key version is used for encryption and decryption by default) and destroy them. To create a new key version, [rotate](key.md#rotate) the key.

## Making a version primary {#make-primary}

{% note info %}

Updating the primary version of a key is an [eventually consistent](../concepts/consistency.md) operation. Changes resulting from such operations take effect with a delay of up to three hours.

{% endnote %}

To make a version primary:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate]({{ link-console-main }}/link/kms) to **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. Click the key in the list to open its attribute page.
  1. In the version row, click ![menu](../../_assets/console-icons/ellipsis.svg) and select ![flag](../../_assets/console-icons/flag.svg) **{{ ui-key.yacloud.kms.symmetric-key.overview.button_action-set-primary }}**.

- CLI {#cli}

  1. Get a list of versions for the key:

     ```bash
     yc kms symmetric-key list-versions example-key
     ```

     Result:

     ```text
     +----------------------+---------+--------+-----------+
     |          ID          | PRIMARY | STATUS | ALGORITHM |
     +----------------------+---------+--------+-----------+
     | abjhduu82ao0******** | true    | ACTIVE | AES_128   |
     | abj8cvn99nam******** | false   | ACTIVE | AES_128   |
     | abjed9ciau8e******** | false   | ACTIVE | AES_256   |
     | abjvejjvfktq******** | false   | ACTIVE | AES_128   |
     +----------------------+---------+--------+-----------+
     ```

  1. Change the key version, specifying the version ID you need:

     ```bash
     yc kms symmetric-key set-primary-version example-key-1 \
       --version-id abj8cvn99nam********
     ```

- API {#api}

  Use the [setPrimaryVersion](../../kms/api-ref/SymmetricKey/setPrimaryVersion.md) REST API method for the [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/SetPrimaryVersion](../../kms/api-ref/grpc/SymmetricKey/setPrimaryVersion.md) gRPC API call.

{% endlist %}

The next encryption or decryption request that does not specify a particular key version will use the new primary version.

## Destroying a key version {#delete}

You cannot destroy a key version right away; you can only schedule its destruction for the next day or later.

{% note alert %}

At the scheduled time and date, the key version is permanently destroyed. If you still have any data encrypted with this key version, you will not be able to decrypt it.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  To destroy a version:

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate]({{ link-console-main }}/link/kms) to **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. Click the key in the list to open its attribute page.
  1. In the version row, click ![menu](../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.kms.symmetric-key.overview.button_action-schedule-destruction }}**.

  The version will change its status to `Scheduled for destruction`, and the **{{ ui-key.yacloud.kms.symmetric-key.overview.column_version-destroy }}** column will show the scheduled destruction date.

- CLI {#cli}

  To destroy a version:

  1. Get a list of versions for the key:

     ```bash
     yc kms symmetric-key list-versions example-key
     ```

     Result:

     ```text
     +----------------------+---------+--------+-----------+
     |          ID          | PRIMARY | STATUS | ALGORITHM |
     +----------------------+---------+--------+-----------+
     | abj8cvn99nam******** | true    | ACTIVE | AES_128   |
     | abjed9ciau8e******** | false   | ACTIVE | AES_256   |
     | abjhduu82ao0******** | false   | ACTIVE | AES_128   |
     | abjvejjvfktq******** | false   | ACTIVE | AES_128   |
     +----------------------+---------+--------+-----------+
     ```

  1. Schedule the destruction of the version:

     ```bash
     yc kms symmetric-key schedule-version-destruction example-key \
       --version-id abjed9ciau8e********
     ```

     The version will change its status to `SCHEDULED_FOR_DESTRUCTION`, and the `destroy_at` field will show the scheduled destruction time.

- API {#api}

  Use the [scheduleVersionDestruction](../../kms/api-ref/SymmetricKey/scheduleVersionDestruction.md) REST API method for the [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/ScheduleVersionDestruction](../../kms/api-ref/grpc/SymmetricKey/scheduleVersionDestruction.md) gRPC API call.

{% endlist %}

{% note info %}

Scheduling key version destruction is an [eventually consistent](../concepts/consistency.md) operation. Changes resulting from such operations take effect with a delay of up to three hours.

{% endnote %}

## Canceling version destruction {#cancel-delete}

If you scheduled the destruction of a key version, you can cancel it before the scheduled date:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate]({{ link-console-main }}/link/kms) to **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. Click the key in the list to open its attribute page.
  1. In the version row, click ![menu](../../_assets/console-icons/ellipsis.svg) and select ![arrow-rotate-left](../../_assets/console-icons/arrow-rotate-left.svg) **{{ ui-key.yacloud.kms.symmetric-key.overview.button_action-cancel-destruction }}**.
  
  The version status will revert to `Active`.

- CLI {#cli}

  1. Get a list of versions for the key:

     ```bash
     yc kms symmetric-key list-versions example-key
     ```

     Result:

     ```text
     +----------------------+---------+---------------------------+-----------+
     |          ID          | PRIMARY |          STATUS           | ALGORITHM |
     +----------------------+---------+---------------------------+-----------+
     | abj8cvn99nam******** | true    | ACTIVE                    | AES_128   |
     | abjed9ciau8e******** | false   | SCHEDULED_FOR_DESTRUCTION | AES_256   |
     | abjhduu82ao0******** | false   | ACTIVE                    | AES_128   |
     | abjvejjvfktq******** | false   | ACTIVE                    | AES_128   |
     +----------------------+---------+---------------------------+-----------+
     ```

  1. Cancel the destruction of the version:

     ```bash
     yc kms symmetric-key cancel-version-destruction example-key \
       --version-id abjed9ciau8e********
     ```

     The version status will revert to `ACTIVE`.

- API {#api}

  Use the [cancelVersionDestruction](../../kms/api-ref/SymmetricKey/cancelVersionDestruction.md) REST API method for the [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/CancelVersionDestruction](../../kms/api-ref/grpc/SymmetricKey/cancelVersionDestruction.md) gRPC API call.

{% endlist %}
