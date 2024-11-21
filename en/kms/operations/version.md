# Key version control

You can make key versions primary (a primary key version is used for encryption and decryption by default) and destroy them. To create a new key version, [rotate](key.md#rotate) the key.

## Make a version primary {#make-primary}

To make a version primary:

{% list tabs group=instructions %}

- Management console {#console}

  1. Log in to the [management console]({{ link-console-main }}).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. Click the key you need in the list to open its attribute page.
  1. In the line of the appropriate version, click ![menu](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.kms.symmetric-key.overview.button_action-set-primary }}**.

- CLI {#cli}

  1. Get a list of versions for the desired key:

     ```
     yc kms symmetric-key list-versions example-key
     ```
	 
	 Result:
	 
	 ```
     +----------------------+---------+--------+-----------+
     |          ID          | PRIMARY | STATUS | ALGORITHM |
     +----------------------+---------+--------+-----------+
     | abjhduu82ao0******** | true    | ACTIVE | AES_128   |
     | abj8cvn99nam******** | false   | ACTIVE | AES_128   |
     | abjed9ciau8e******** | false   | ACTIVE | AES_256   |
     | abjvejjvfktq******** | false   | ACTIVE | AES_128   |
     +----------------------+---------+--------+-----------+
     ```

  1. Change the key version by specifying the ID of the desired version:

     ```
     yc kms symmetric-key set-primary-version example-key-1 \
       --version-id abj8cvn99nam********
     ```

- API {#api}

  Use the [setPrimaryVersion](../../kms/api-ref/SymmetricKey/setPrimaryVersion.md) REST API method for the [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/SetPrimaryVersion](../../kms/api-ref/grpc/SymmetricKey/setPrimaryVersion.md) gRPC API call.

{% endlist %}

The next encryption or decryption request omitting the key version will use the new primary version.

## Destroy a key version {#delete}

You cannot destroy a key version right away: you can only schedule its destruction (for the next day at least).

{% note alert %}

At the scheduled time and date, the key version is permanently destroyed: if you still have data encrypted with this key version, you can no longer decrypt it.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  To destroy a version:

  1. Log in to the [management console]({{ link-console-main }}).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. Click the key you need in the list to open its attribute page.
  1. In the line of the appropriate version, click ![menu](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.kms.symmetric-key.overview.button_action-schedule-destruction }}**.

  The version will change its status to `Scheduled for destruction`, and the **{{ ui-key.yacloud.kms.symmetric-key.overview.column_version-destroy }}** column will show the scheduled destruction date.

- CLI {#cli}

  To destroy a version:

  1. Get a list of versions for the desired key:

     ```
     yc kms symmetric-key list-versions example-key
	 ```
	 
	 Result:
	 
	 ```
     +----------------------+---------+--------+-----------+
     |          ID          | PRIMARY | STATUS | ALGORITHM |
     +----------------------+---------+--------+-----------+
     | abj8cvn99nam******** | true    | ACTIVE | AES_128   |
     | abjed9ciau8e******** | false   | ACTIVE | AES_256   |
     | abjhduu82ao0******** | false   | ACTIVE | AES_128   |
     | abjvejjvfktq******** | false   | ACTIVE | AES_128   |
     +----------------------+---------+--------+-----------+
     ```

  1. Schedule the destruction of a version:

     ```
     yc kms symmetric-key schedule-version-destruction example-key \
       --version-id abjed9ciau8e********
     ```

     The version will change its status to `SCHEDULED_FOR_DESTRUCTION`, and the `destroy_at` field will show the scheduled destruction time.

- API {#api}

  Use the [scheduleVersionDestruction](../../kms/api-ref/SymmetricKey/scheduleVersionDestruction.md) REST API method for the [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/ScheduleVersionDestruction](../../kms/api-ref/grpc/SymmetricKey/scheduleVersionDestruction.md) gRPC API call.

{% endlist %}

## Cancel version destruction {#cancel-delete}

If you scheduled the destruction of a key version, you can cancel it before the scheduled date:

{% list tabs group=instructions %}

- Management console {#console}

  1. Log in to the [management console]({{ link-console-main }}).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. Click the key you need in the list to open its attribute page.
  1. In the line of the appropriate version, click ![menu](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.kms.symmetric-key.overview.button_action-cancel-destruction }}**.
  
  The version status will revert to `Active`.

- CLI {#cli}

  1. Get a list of versions for the desired key:

     ```
     yc kms symmetric-key list-versions example-key
	 ```
	 
	 Result:
	 
	 ```
     +----------------------+---------+---------------------------+-----------+
     |          ID          | PRIMARY |          STATUS           | ALGORITHM |
     +----------------------+---------+---------------------------+-----------+
     | abj8cvn99nam******** | true    | ACTIVE                    | AES_128   |
     | abjed9ciau8e******** | false   | SCHEDULED_FOR_DESTRUCTION | AES_256   |
     | abjhduu82ao0******** | false   | ACTIVE                    | AES_128   |
     | abjvejjvfktq******** | false   | ACTIVE                    | AES_128   |
     +----------------------+---------+---------------------------+-----------+
     ```

  1. Cancel the destruction of a version:

     ```
     yc kms symmetric-key cancel-version-destruction example-key \
       --version-id abjed9ciau8e********
     ```

     The version status will revert to `ACTIVE`.

- API {#api}

  Use the [cancelVersionDestruction](../../kms/api-ref/SymmetricKey/cancelVersionDestruction.md) REST API method for the [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/CancelVersionDestruction](../../kms/api-ref/grpc/SymmetricKey/cancelVersionDestruction.md) gRPC API call.

{% endlist %}




