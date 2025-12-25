## Use cases

### One-way encryption

1. Create a table:

    ```sql
    CREATE TABLE tbl_one_way_crypt(username varchar(100) PRIMARY KEY, cryptpwd text);
    ```

1. Insert hashed text data into the `cryptpwd` column:

    ```sql
    INSERT INTO tbl_one_way_crypt(username, cryptpwd)
        VALUES ('bob', crypt('Password123', gen_salt('md5'))),
               ('alice', crypt('Password123', gen_salt('md5')));
    ```

1. Verify that the data in the `cryptpwd` column is encrypted:

    ```sql
    SELECT * FROM tbl_one_way_crypt;
    ```

1. Verify that the encrypted data contains `Password123`:

    ```sql
    SELECT username FROM tbl_one_way_crypt
    WHERE cryptpwd = crypt('Password123', cryptpwd);
    ```

### Symmetric encryption

1. Create a table:

    ```sql
    CREATE TABLE tbl_sym_crypt (username varchar(100) PRIMARY KEY, crypttext text);
    ```

1. Insert the encrypted text data into the `crypttext` column:

    ```sql
    INSERT INTO tbl_sym_crypt (username, crypttext)
        VALUES ('bob', pgp_sym_encrypt('Text to encrypt','!qazSymKeyXsw2')),
               ('alice', pgp_sym_encrypt('Secret Data','!qazSymKeyXsw2'));
    ```

1. Verify that the data in the `crypttext` column is encrypted:

    ```sql
    SELECT * FROM tbl_sym_crypt;
    ```

1. Retrieve the decrypted data by explicitly specifying `bytea` data type:

    ```sql
    SELECT username, pgp_sym_decrypt(crypttext::bytea, '!qazSymKeyXsw2')
    FROM tbl_sym_crypt;
    ```

### Asymmetric encryption

1. Generate a key pair using [GnuPG](https://www.gnupg.org/download/index.html):

    1. Generate a key pair:

        ```bash
        gpg --gen-key
        ```

        Specify the key `USER-ID`, i.e., `Real name` and `Email address`, and `Passphrase`.

    1. Export the generated keys to files:

        ```bash
        gpg -a --export <Real_key_name> > public.key && \
        gpg -a --export-secret-keys <Real_key_name> > private.key
        ```

1. Create a table:

    ```sql
    CREATE TABLE tbl_asym_crypt(ssn_id SERIAL PRIMARY KEY,
        username varchar(100), ssn bytea);
    ```

1. Insert the public key encrypted text into the `ssn` column:

    ```sql
    INSERT INTO tbl_asym_crypt (username, ssn)
    SELECT tmp.username, pgp_pub_encrypt(tmp.ssn, keys.pubkey) AS tbl
    FROM (
        VALUES ('Alice', '123-45-6788'), ('Bob', '123-45-6799'))
        AS tmp(username, ssn)
    CROSS JOIN (SELECT dearmor('<public.key_file_contents>') AS pubkey) AS keys;
    ```

1. Verify that the data in the `ssn` column is encrypted:

    ```sql
    SELECT * FROM tbl_asym_crypt;
    ```

1. Use the private key to decrypt the data in the `ssn` column:

    ```sql
    SELECT username, pgp_pub_decrypt(ssn, keys.privkey, '<Key_passphrase>')
        AS decrypted_ssn FROM tbl_asym_crypt
    CROSS JOIN (SELECT dearmor('<private.key_file_contents>') AS privkey) AS keys;
    ```
