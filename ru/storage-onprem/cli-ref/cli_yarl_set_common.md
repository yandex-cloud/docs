# cli yarl set common

Set a common quota (read/write for bucket/tenant)

```
cli yarl set common <entity> [flags]
```

## Options

```
  -a, --action Action     action: read, write, server_read, server_write
  -h, --help              help for common
      --high-burst uint   high burst (default: limit * 100)
  -l, --limit uint        quota limit
      --low-burst uint    low burst (default: same as limit)
  -s, --scope Scope       scope: bucket, tenant (default bucket)
  -u, --unit Unit         measurement unit: rps, kbytes (default rps)
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

