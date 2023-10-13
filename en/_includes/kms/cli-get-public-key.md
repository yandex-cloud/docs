Get a digital signature public key by specifying the previously obtained key pair ID:

```bash
yc kms asymmetric-signature-crypto get-public-key \
  --id <key_pair_ID>
```

Result:

```bash
key_id: abj9g2dil5sj********
public_key: |
-----BEGIN PUBLIC KEY-----
MIIB...
...QAB
-----END PUBLIC KEY-----
```

Save the obtained key to a file, such as `public.key`. Make sure that lines in the file do not start with spaces.