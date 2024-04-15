# {{ backup-full-name }} release notes

## Q1 2024 {#q1-2024}

* In the management console, on the ![list-check](../_assets/console-icons/list-check.svg) **Operations** tab, some inherently long-running tasks are now considered asynchronous operations, with a completion percentage added for certain actions.
* Updated the process of applying changes for [backup storage](./concepts/policy.md#retention) rules. By default, new rules will now take effect as soon as another backup is created.
* Added support for creation of a policy with the `scheduling.scheme=CUSTOM` custom backup schedule scheme. For more information, see [Backup policy specification](./concepts/policy.md#specification).