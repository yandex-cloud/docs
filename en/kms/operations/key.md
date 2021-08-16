# Key management

You can use {{ kms-name }} to create, rotate, and destroy symmetric encryption keys.

## Create a key {#create}

To create a key:

{% list tabs %}

- Management console
  1. Log in to [management console]({{ link-console-main }}).
  1. Select **{{ kms-name }}**.
  1. In the **Keys** tab, click **Create** and set the key attributes:
     * Any name and optional description.
     * Encryption algorithm, such as AES-256.
     * [Rotation period](../concepts/index.md#rotation) (how often to change key versions).
     * Click **Create**.

  The key is created along with its first version: click the key in the list to open the page with its attributes.

- CLI

  Run the command with the following parameters:
  - `name`: Key name.
  - `default-algorithm`: Encryption algorithm (`aes-128`, `aes-192`, or `aes-256`).
  - `rotation-period`: Key rotation period. To create a key without automatic rotation, don't specify the `rotation-period` parameter.

  ```
  $ yc kms symmetric-key create \
    --name example-key \
    --default-algorithm aes-256 \
    --rotation-period 24h
  ```

  The key is created along with its first version. It's specified in the `primary_version` field.

- API

    Use the [create](../api-ref/SymmetricKey/create) method for the `SymmetricKey` resource.

{% endlist %}

## Change a key {#update}

After creating a key, you can change any of its attributes. If you change the encryption algorithm, the new algorithm is used starting with the next key version. To immediately create a new version and make it the default version, rotate the key.

To edit a key:

{% list tabs %}

- Management console
  1. Log in to [management console]({{ link-console-main }}).
  1. Select **{{ kms-name }}**.
  1. In the **Keys** tab, click the key in the list to open the page with its attributes and click **Edit**.
  1. Change the key attributes and click **Save**.

- CLI

  Run the command with the following parameters:
  - `name`: Key name. If there are multiple keys with the same name in the folder, use the key ID.
  - `new-name`: New key name.
  - `default-algorithm`: Encryption algorithm (`aes-128`, `aes-192`, or `aes-256`).
  - `rotation-period`: Key rotation period. To disable automatic rotation for an updated key, don't specify the `rotation-period` parameter.

  ```
  $ yc kms symmetric-key update \
    --name example-key \
    --new-name example-key-2 \
    --default-algorithm aes-128 \
    --rotation-period 48h
  ```

- API

  Use the [update](../api-ref/SymmetricKey/update) method for the `SymmetricKey` resource.

{% endlist %}

## Rotate a key {#rotate}

When a key is rotated, a new version is generated and immediately set as the default version. You can set up automatic rotation, but you can also rotate a key manually at any time.

To rotate a key:

{% list tabs %}

- Management console
  1. Log in to [management console]({{ link-console-main }}).
  1. Select **{{ kms-name }}**.
  1. In the **Keys** tab, click the key in the list to open the page with its attributes.
  1. Click **Rotate** and confirm the rotation (make sure that changing the default version doesn't affect your work).

- CLI

  Run the command with the key ID or name specified:

  ```
  $ yc kms symmetric-key rotate example-key
  ```

- API

  Use the [rotate](../api-ref/SymmetricKey/rotate) method for the `SymmetricKey` resource.

{% endlist %}

## Destroy a key {#delete}

By destroying a key you also destroy all its versions. You can't destroy a key immediately: the key marked for destruction can be restored with its versions within 3 days by sending a request to technical support.

{% note alert %}

3 days after the key is requested to be destroyed, the key and its versions are permanently destroyed: if you still have any data encrypted with this key, you can't decrypt the data.

{% endnote %}

To destroy a key:

{% list tabs %}

- Management console
  1. Log in to [management console]({{ link-console-main }}).
  1. Select **{{ kms-name }}**.
  1. In the **Keys** tab, click the key in the list to open the page with its attributes.
  1. Click **Delete** and confirm the destruction.

- CLI

  Run the command with the key ID or name specified:

  ```
  $ yc kms symmetric-key delete example-key
  ```

- API

  Use the [delete](../api-ref/SymmetricKey/delete) method for the `SymmetricKey` resource.

{% endlist %}

