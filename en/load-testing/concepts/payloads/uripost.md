# URIPOST

A type of payload used to describe HTTP `POST` requests. Used in Pandora and Phantom load generators.

The payload starts with request headers in square brackets. On a new line, the size of the request body in bytes and the request URI separated by a space are specified. For example:

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

## Configuration for Phantom {#phantom-config}

```
phantom:
  ammo_type: uripost # Required, otherwise load testing tool won't be able to distinguish it from uri-style.
  ammofile: /path/to/ammo_file # or an HTTP link
```

## Configuration for Pandora {#pandora-config}

When configuring the Pandora load generator using a file, specify the `uripost` type in the `ammo` section:

```
config_content:
          pools:
             ammo:
               type: uripost
               file: ./ammo.uripost
```

When uploading a file with a payload via the management console, data types and paths are substituted automatically.