# cli buckets create-inventory-configuration

Create or replace an inventory configuration

## Synopsis

Create or replace a scheduled CSV inventory configuration using the current CLI login. The configuration ID is read from the JSON configuration. This command does not start an immediate report.

```
cli buckets create-inventory-configuration [bucket] [flags]
```

## Examples

```
cli buckets create-inventory-configuration my-bucket --file config.json --tenant <tenant-id>
```

## Options

```
      --configuration string   Inventory configuration JSON, as in yc CLI
  -f, --file string            Path to inventory configuration JSON
  -h, --help                   help for create-inventory-configuration
      --name string            Bucket name
  -t, --tenant string          Tenant ID
```

## Options inherited from parent commands

```
  -c, --config-dir string   path to configuration directory
      --debug               enable debug mode
      --insecure            use if console has self-signed certificate
  -p, --profile string      configuration profile
```

## See also

* [cli buckets](cli_buckets.md)	 — Buckets management
