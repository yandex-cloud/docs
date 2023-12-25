# Creating a partner connector

If you are a {{ datalens-short-name }} partner, you can create your own connector (connection type) and add it to [{{ datalens-short-name }} {{ marketplace-short-name }}](../../concepts/marketplace.md) or to the [connections]({{ link-datalens-main }}/connections/new) page. With the help of a connector, users will be able to create datasets, charts, and dashboards from your data.

Advantages of working with a connector for {{ datalens-short-name }} partners:

* Easy user access to data.
* Data access control (each user only sees the data that you make available).
* Deployment of a ready-made configurable dashboard with your data.

## How to become a partner {#how-to-become-a-partner}

On the [{{ marketplace-short-name }}](/marketplace) home page, click **Offer product** and complete an application.

After you submit the application, a {{ datalens-short-name }} manager will contact you.

Provide the {{ datalens-short-name }} manager with your product information:

* Name in Russian and English.
* Description in Russian and English.
* Use cases in Russian and English.
* User manual in Russian and English.
* Icon (vector, SVG).
* Price and preferred payment method (if your product is fee-based).
* Developer contacts.

## How to create a connector {#how-to-create-connector}

You need to create a connector in the same CH cluster that will host your user data.

1. Create a [{{ CH }} cluster](../../../managed-clickhouse/operations/cluster-create.md) in the cloud.

   1. In the cluster, add a DB user called `datalens` with [readonly = 2]({{ ch.docs }}/operations/settings/permissions-for-queries/#settings_readonly).

      {% note info %}

      If the user management via SQL is enabled for the cluster, you can create a user with the following command:

      ```sql
      CREATE USER IF NOT EXISTS <username> ON CLUSTER <cluster_name>
          IDENTIFIED WITH plaintext_password by '<user_password>'
          SETTINGS readonly = 2;
      ```

      {% endnote %}

   1. In the settings, enable **Access from {{ datalens-short-name }}** and **Database management via SQL**.

1. Provide the password and the cluster host list to {{ datalens-short-name }} managers. They will contact you after they receive your request in {{ marketplace-short-name }}.
1. Generate a pair of RSA-2048 keys. Provide the public key and the key version to {{ datalens-short-name }} managers.
   Key generation requirements: `public_exponent=65537`, `key_size=2048`. A key version is an integer that is required for future seamless key rotation.

   {% cut "Python code to generate a pair of keys" %}

   ```python
   from cryptography.hazmat.primitives.asymmetric import rsa
   from cryptography.hazmat.primitives import serialization

   private_key = rsa.generate_private_key(
       public_exponent=65537,
       key_size=2048,
   )
   private_pem = private_key.private_bytes(
       encoding=serialization.Encoding.PEM,
       format=serialization.PrivateFormat.TraditionalOpenSSL,
       encryption_algorithm=serialization.NoEncryption()
   ).decode()

   public_key = private_key.public_key()
   public_pem = public_key.public_bytes(
       encoding=serialization.Encoding.PEM,
       format=serialization.PublicFormat.SubjectPublicKeyInfo
   ).decode()
   print(public_pem)
   ```

   {% endcut %}

1. {{ datalens-short-name }} will also provide you with the public part of its key and the key version.
   At this point, {{ datalens-short-name }} creates a connector to send queries to your {{ CH }} cluster.

## Connecting a new user {#how-to-add-new-user}

1. Add databases intended for your users to the {{ CH }} cluster. Create a dedicated database in the {{ CH }} cluster for each user. The database gets read access from the `datalens` user's DB.
1. Prepare an access token for the user:

   {% note warning %}

   Each user must have a separate access token string.

   {% endnote %}

   1. Generate a JSON with the client database name, such as `{"db_name":"client_1234383"}`.
   1. Encrypt the JSON with the {{ datalens-short-name }} public key. Encryption parameters: `padding scheme PKCS1 v1.5`.
   1. Sign the encrypted string with your private key. Signature parameters: `padding scheme PKCS1 v1.5, signature hash algorithm: SHA1`.
   1. Generate an access token using the following structure `<datalens_key_version>:<partner_key_version>:<encrypted_data>:<signature>`, where:
      * `datalens_key_version` and `partner_key_version` are key versions.
      * `encrypted_data` is the Base64-encoded encrypted JSON (outcome of step 2.2).
      * `signature` is the Base64-encoded encrypted message signature (outcome of step 2.3).

   {% cut "Python code to generate the access token" %}

   ```python
    import json
    from base64 import b64encode, b64decode
    from cryptography.hazmat.primitives import serialization
    from cryptography.hazmat.primitives import hashes
    from cryptography.hazmat.primitives.asymmetric import padding

    public_key_datalens_pem = '''-----BEGIN PUBLIC KEY-----...''' # DataLens public RSA key.
    private_key_partner_pem = '''-----BEGIN RSA PRIVATE KEY-----...''' # Your private RSA key.
    datalens_key_version, partner_key_version = '1', '1' # Key versions.

    data = json.dumps({'db_name': 'db_name_123'}) # JSON with the user database in the {{ CH }} cluster.

    public_key_datalens = serialization.load_pem_public_key(public_key_datalens_pem.encode())
    private_key_partner = serialization.load_pem_private_key(
        private_key_partner_pem.encode(),
        password=None,
    )
    ciphertext = public_key_datalens.encrypt(data.encode(), padding.PKCS1v15()) # Encrypted JSON message with the user database.
    signature = private_key_partner.sign(ciphertext, padding.PKCS1v15(), hashes.SHA1()) # Encrypted message signature.

    access_token = ':'.join((
        datalens_key_version,
        partner_key_version,
        b64encode(ciphertext).decode(encoding='utf-8'),
        b64encode(signature).decode(encoding='utf-8'),
    ))
   ```

   {% endcut %}

1. Deliver the access token to the user through your website or some other way.

## User steps for a connector {#work-with-connector}

1. Gets an access token for {{ datalens-short-name }} on your website.
1. Goes to {{ datalens-short-name }} {{ marketplace-short-name }}, purchases a connector, or activates a free product.
1. Goes to the [{{ datalens-short-name }} connections]({{ link-datalens-main }}/connections/new) page and selects an activated connector from the list.
1. Enters the access token you provided on the page where you create new connections. This links the connection to the database whose name is encrypted in the access token.

   {% cut "Example for connecting" %}

   ![image](../../../_assets/datalens/partners-connector.png)

   {% endcut %}

1. Saves the connection. At this point, {{ datalens-short-name }} deploys a standard dashboard based on connector data.

#### See also

* [{#T}](../../concepts/marketplace.md)

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
