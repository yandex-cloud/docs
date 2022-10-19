## Use cases

### One-way encryption

1. Create a table:

   ```sql
   CREATE TABLE tbl_one_way_crypt(username varchar(100) PRIMARY KEY, cryptpwd text);
   ```

1. Insert the hash text data in the `cryptpwd` column:

   ```sql
   INSERT INTO tbl_one_way_crypt(username, cryptpwd)
       VALUES ('bob', crypt('Password123', gen_salt('md5'))),
              ('alice', crypt('Password123', gen_salt('md5')));
   ```

1. Make sure that the data in the `cryptpwd` column is encrypted:

   ```sql
   SELECT * FROM tbl_one_way_crypt;
   ```

1. See if `Password123` is stored in the encrypted data:

   ```sql
   SELECT username FROM tbl_one_way_crypt
   WHERE cryptpwd = crypt('Password123', cryptpwd);
   ```

### Symmetric encryption

1. Create a table:

   ```sql
   CREATE TABLE tbl_sym_crypt (username varchar(100) PRIMARY KEY, crypttext text);
   ```

1. Insert the encrypted text data in the `crypttext` column:

   ```sql
   INSERT INTO tbl_sym_crypt (username, crypttext)
       VALUES ('bob', pgp_sym_encrypt('Text to encrypt','!qazSymKeyXsw2')),
              ('alice', pgp_sym_encrypt('Secret Data','!qazSymKeyXsw2'));
   ```

1. Make sure that the data in the `crypttext` column is encrypted:

   ```sql
   SELECT * FROM tbl_sym_crypt;
   ```

1. Retrieve the decrypted data by explicitly specifying `bytea` as the data type:

   ```sql
   SELECT username, pgp_sym_decrypt(crypttext::bytea, '!qazSymKeyXsw2')
   FROM tbl_sym_crypt;
   ```

### Public-key encryption

1. Use the [GnuPG](https://www.gnupg.org/download/index.html) utility to generate a pair of keys:

   1. Create a pair of keys:

      ```bash
      gpg --gen-key
      ```

      Specify the key `USER-ID` (`Real name` and `Email address`) and the `Passphrase`.

   1. Export the keys to files:

      ```bash
      gpg -a --export <key Real name> > public.key && \
      gpg -a --export-secret-keys <key Real name> > private.key
      ```

1. Create a table:

   ```sql
   CREATE TABLE tbl_asym_crypt(ssn_id SERIAL PRIMARY KEY,
       username varchar(100), ssn bytea);
   ```

1. Insert the encrypted text data in the `ssn` column using the public key:

   ```sql
   INSERT INTO tbl_asym_crypt (username, ssn)
   SELECT tmp.username, pgp_pub_encrypt(tmp.ssn, keys.pubkey) AS tbl
   FROM (
       VALUES ('Alice', '123-45-6788'), ('Bob', '123-45-6799'))
       AS tmp(username, ssn)
   CROSS JOIN (SELECT dearmor('<contents of public.key file>') AS pubkey) AS keys;
   ```

1. Check to see that the data in the `ssn` column is encrypted:

   ```sql
   SELECT * FROM tbl_asym_crypt;
   ```

1. Decrypt the data in the `ssn` column using the private key:

   ```sql
   SELECT username, pgp_pub_decrypt(ssn, keys.privkey, '<key Passphrase>')
       AS decrypted_ssn FROM tbl_asym_crypt
   CROSS JOIN (SELECT dearmor('<contents of private.key file>') AS privkey) AS keys;
   ```
