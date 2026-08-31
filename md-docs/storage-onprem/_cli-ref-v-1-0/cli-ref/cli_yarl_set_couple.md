[Документация Yandex Cloud](../../../index.md) > [storage-onprem/_cli-ref-v-1-0](../index.md) > yarl > set > couple

# cli yarl set couple

Set a bucket couple quota

```
cli yarl set couple <bucket> [flags]
```

## Options

```
      --couple int         couple ID
  -h, --help               help for couple
      --high-burst uint    high burst (default: limit * 100)
  -l, --limit uint         quota limit
      --low-burst uint     low burst (default: same as limit)
  -n, --namespace string   MDS namespace
      --unit Unit          quota unit: mbytes (default) or rps (deprecated) (default mbytes)
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