# cli tenants update

Update tenant

```
cli tenants update <tenant_id> -n <new_name> -s <max_size> -b <max_buckets> [flags]
```

## Options

```
  -h, --help               help for update
  -b, --max-buckets uint   New max buckets
  -s, --max-size string    New max size
  -n, --name string        New name
```

## Options inherited from parent commands

```
  -c, --config-dir string   path to configuration directory
      --debug               enable debug mode
      --insecure            use if console has self-signed certificate
  -p, --profile string      configuration profile
```

## See also

* [cli tenants](cli_tenants.md)	 — Tenants management

