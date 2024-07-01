# URIPOST

Type of test data used for describing HTTP `POST` requests. Used in Pandora and Phantom load generators.

The test data type is specified when [creating a test](../../operations/create-test-bucket.md#create-test).

Test data starts with request headers in square brackets. Next, the request body size in bytes and the request URI separated by a space are specified on a new line. For example:

```
[Host: example.com]
[User-Agent: Tank]
5 /route/?rll=50.262025%2C53.276083~50.056015%2C53.495561&origin=1&simplify=1
class
6 /route/?rll=50.262025%2C53.276083~50.056015%2C53.495561&origin=1&simplify=1
hello!
7 /route/?rll=37.565147%2C55.695758~37.412796%2C55.691454&origin=1&simplify=1
uripost
```

## Configuring load generators

{% list tabs group=instructions %}

- Phantom {#phantom}

   When configuring the Phantom load generator using a YAML file, specify the `uripost` type and the path to the file with request headers and endpoints:

   ```
   phantom:
     ammo_type: uripost # Required, otherwise the load testing tool won't be able to distinguish it from uri-style.
     ammofile: ./ammo.txt # or HTTP link
   ```

- Pandora {#pandora}

   When configuring the Pandora load generator using a file, specify the `uripost` type in the `ammo` section:

   ```
   config_content:
      pools:
         ammo:
            type: uripost
            file: ./ammo.uripost
   ```

{% endlist %}

When uploading a file with test data via the management console, data types and paths are filled in automatically.