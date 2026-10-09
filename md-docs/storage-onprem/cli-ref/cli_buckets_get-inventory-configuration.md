[Документация Yandex Cloud](../../index.md) > [On-premises Yandex Object Storage](../index.md) > Версия 26.3 > Справочник CLI (англ.) > buckets > get-inventory-configuration

# cli buckets get-inventory-configuration

Get an inventory configuration as JSON

```
cli buckets get-inventory-configuration [bucket] [flags]
```

## Examples

```
cli buckets get-inventory-configuration my-bucket --id config_id --tenant <tenant-id>
```

## Options

```
  -h, --help            help for get-inventory-configuration
      --id string       Inventory configuration ID
      --name string     Bucket name
  -t, --tenant string   Tenant ID
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