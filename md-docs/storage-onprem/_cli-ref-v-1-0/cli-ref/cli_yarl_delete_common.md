[Документация Yandex Cloud](../../../index.md) > [storage-onprem/_cli-ref-v-1-0](../index.md) > yarl > delete > common

# cli yarl delete common

Delete a common quota

```
cli yarl delete common <entity> [flags]
```

## Options

```
  -a, --action Action   action: read, write, server_read, server_write
  -h, --help            help for common
  -s, --scope Scope     scope: bucket, tenant (default bucket)
  -u, --unit Unit       quota unit: rps or kbytes (default rps)
```

## Options inherited from parent commands

```
  -c, --config-dir string   path to configuration directory
      --debug               enable debug mode
      --insecure            use if console has self-signed certificate
  -p, --profile string      configuration profile
```

## See also

* [cli yarl delete](cli_yarl_delete.md)	 — Delete a yarl quota