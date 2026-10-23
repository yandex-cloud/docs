Чтобы включить для кластера возможность перепаковки таблиц и индексов для устранения _раздувания данных_ (bloat), добавьте к описанию кластера {{ mpg-name }} блок `config.managed_repack`.

```hcl
resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
  ...
  config {
    managed_repack {
      enabled = true
    }
    ...
  }
}
```