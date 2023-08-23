### Превышение квоты на длительность соединения {#conn-duration-quota}

В {{ mpg-full-name }} существует квота на длительность соединения — 12 часов.
​
​**Решение:** если перенос базы данных требует больше времени, [измените настройку кластера](../../../../managed-postgresql/operations/update.md#change-postgresql-config) {{ mpg-full-name }} [Session duration timeout](../../../../managed-postgresql/concepts/settings-list.md#setting-session-duration-timeout).
