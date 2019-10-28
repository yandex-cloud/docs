# Key management

You can use {{ kms-name }} to create, rotate, and destroy symmetric encryption keys.

## Create a key {#create}

To create a key:

1. Log in to the [management console]({{link-console-main}}).
1. Select **{{ kms-name }}**.
1. In the **Keys** tab, click **Create** and set the key attributes:

  * Any name and optional description.
  * Encryption algorithm, such as AES-256.
  * [Rotation period](../concepts/index.md#rotation) (how often to change key versions).
  * Click **Create**.

The key is created along with its first version: click the key in the list to open the page with its attributes.

## Edit a key {#update}

After creating a key, you can change any of its attributes. If you change the encryption algorithm, the new algorithm is used starting with the next key version. To immediately create a new version and make it the default version, rotate the key.

To edit a key:

1. Log in to the [management console]({{link-console-main}}).
1. Select **{{ kms-name }}**.
1. In the **Keys** tab, click the key in the list to open the page with its attributes and click **Edit**.
1. Change the key attributes and click **Save**.

## Rotate a key {#rotate}

When a key is rotated, a new version is generated and immediately set as the default version. You can set up automatic rotation, but you can also rotate a key manually at any time.

To rotate a key:

1. Log in to the [management console]({{link-console-main}}).
1. Select **{{ kms-name }}**.
1. In the **Keys** tab, click the key in the list to open the page with its attributes.
1. Click **Rotate** and confirm the rotation (make sure that changing the default version doesn't affect your work).

## Destroy a key {#delete}

By destroying a key you also destroy all its versions. You can't destroy a key immediately: the key marked for destruction can be restored with its versions within 3 days by sending a request to technical support.

{% note alert %}

3 days after the key is requested to be destroyed, the key and its versions are permanently destroyed: if you still have any data encrypted with this key, you can't decrypt the data.

{% endnote %}

To destroy a key:

1. Log in to the [management console]({{link-console-main}}).
1. Select **{{ kms-name }}**.
1. In the **Keys** tab, click the key in the list to open the page with its attributes.
1. Click **Delete** and confirm the destruction.

