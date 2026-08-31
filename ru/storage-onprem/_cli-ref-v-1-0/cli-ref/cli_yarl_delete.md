# cli yarl delete

Delete a yarl quota

```
cli yarl delete [flags]
```

## Options

```
  -h, --help             help for delete
  -n, --name yarl list   delete quota by its full name (from yarl list)
```

## Options inherited from parent commands

```
  -c, --config-dir string   path to configuration directory
      --debug               enable debug mode
      --insecure            use if console has self-signed certificate
  -p, --profile string      configuration profile
```

## See also

* [cli yarl](cli_yarl.md)	 — Yarl rate-limit quotas
* [cli yarl delete common](cli_yarl_delete_common.md)	 — Delete a common quota
* [cli yarl delete couple](cli_yarl_delete_couple.md)	 — Delete a bucket couple quota
* [cli yarl delete handler](cli_yarl_delete_handler.md)	 — Delete a per-handler operation quota
* [cli yarl delete shard](cli_yarl_delete_shard.md)	 — Delete a bucket shard quota

