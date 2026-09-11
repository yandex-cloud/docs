# cli yarl set shard

Set a bucket shard quota

```
cli yarl set shard <bucket> [flags]
```

## Options

```
  -h, --help               help for shard
      --high-burst uint    high burst (default: limit * 100)
  -l, --limit uint         quota limit
      --low-burst uint     low burst (default: same as limit)
  -o, --operation string   operation type: read, list, modify, dread, dwrite
  -s, --shard Shard        shard type: db or meta (default db)
  -i, --shard-id int       shard ID, generally X-1 where X is s3dbX
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

