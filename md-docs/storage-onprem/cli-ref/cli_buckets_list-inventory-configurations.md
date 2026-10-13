[Документация Yandex Cloud](../../index.md) > [On-premises Yandex Object Storage](../index.md) > Версия 26.3 > Справочник CLI (англ.) > buckets > list-inventory-configurations

# cli buckets list-inventory-configurations

List inventory configurations as JSON

```
cli buckets list-inventory-configurations [bucket] [flags]
```

## Examples

```
cli buckets list-inventory-configurations my-bucket --tenant <tenant-id>
```

## Options

```
  -h, --help                help for list-inventory-configurations
      --name string         Bucket name
      --page-token string   Page token for pagination
  -t, --tenant string       Tenant ID
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