### Exceeding the connection time-to-live quota {#conn-duration-quota}

{{ mpg-full-name }} has a connection time-to-live quota of 12 hours.
​​
**Solution:** If transferring a database requires more time, [change the [Session duration timeout](../../../../managed-postgresql/concepts/settings-list.md#setting-session-duration-timeout) setting of the {{ mpg-full-name }} cluster](../../../../managed-postgresql/operations/update.md#change-postgresql-config).
