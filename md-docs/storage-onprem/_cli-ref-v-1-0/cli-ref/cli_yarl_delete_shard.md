[Документация Yandex Cloud](../../../index.md) > [storage-onprem/_cli-ref-v-1-0](../index.md) > yarl > delete > shard

# cli yarl delete shard

Delete a bucket shard quota

```
cli yarl delete shard <bucket> [flags]
```

## Options

```
  -h, --help               help for shard
  -o, --operation string   operation type: read, list, modify, dread, dwrite
  -s, --shard Shard        shard type: db or meta (default db)
  -i, --shard-id int       shard ID
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