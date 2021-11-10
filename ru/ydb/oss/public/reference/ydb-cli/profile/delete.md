# Удаление профиля

{% include [profile-list](../../../_includes/profile-list.md) %}

Удалите профиль `example`:

```bash
ydb config profile delete example
```

Результат:

```text
Profile "example" will be permanently removed. Continue? (y/n): 
```

Подтвердите удаление. Результат:

```text
Profile "example" was removed.
```
