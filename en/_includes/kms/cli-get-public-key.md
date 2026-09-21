Get the digital signature public key, specifying the previously obtained key pair ID:

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

Save this key to a file, e.g., `public.key`. Make sure that lines in the file do not start with spaces.