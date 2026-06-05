* The `users` and `groups` parameters define users the rule applies to.

  * `users`: List of user IDs. The rule will only apply to the specified users.

  * `groups`: List of group IDs. The rule will only apply to users who belong to at least one of these groups.

  You can specify either one or both parameters. If you specify both, the rule will apply to all users from the `users` parameter who also belong to at least one group listed under `groups`. If neither parameter is provided, the rule will apply to all users.

* `description`: Rule description.
