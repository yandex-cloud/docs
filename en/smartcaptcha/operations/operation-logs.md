# Viewing operations on {{ captcha-name }} resources

The system logs all actions on {{ captcha-name }} resources in an operation list. Each operation gets a unique ID.

## Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}**. This will open the list of all operations, including those on currently deleted resources.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
