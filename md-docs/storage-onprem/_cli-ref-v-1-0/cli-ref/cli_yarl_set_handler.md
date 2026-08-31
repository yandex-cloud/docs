[Документация Yandex Cloud](../../../index.md) > [storage-onprem/_cli-ref-v-1-0](../index.md) > yarl > set > handler

# cli yarl set handler

Set a per-handler operation quota

```
cli yarl set handler <entity> [flags]
```

## Options

```
  -h, --help                  help for handler
      --high-burst uint       high burst (default: limit * 100)
  -l, --limit uint            quota limit
      --low-burst uint        low burst (default: same as limit)
  -o, --operation Operation   handler name: x_s3_handler.toLower().replace(' ','_')
  -s, --scope Scope           scope: bucket, tenant (default bucket)
```

## Options inherited from parent commands

```
  -c, --config-dir string   path to configuration directory
      --debug               enable debug mode
      --insecure            use if console has self-signed certificate
  -p, --profile string      configuration profile
```

## See also

* [cli yarl set](cli_yarl_set.md)	 — Create or update a yarl quota