# Troubleshooting connecting to {{ ydb-short-name }} from {{ sf-name }} function code


## Issue description {#issue-description}

When you call a {{ sf-name }} function after creating its new revision, the connection to {{ ydb-short-name }} is no longer established.

## Solution {#issue-resolution}

Newer versions of the {{ ydb-short-name }} SDK require you to explicitly provide an authorization token. Earlier {{ ydb-short-name }} SDK versions did not have this requirement.

Add the `ydb==2.13.3` line to `requirements.txt`, create another revision of your function, call the function again, and check whether the connection to {{ ydb-short-name }} is successful.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Cloud function ID.
1. Full text of the {{ ydb-short-name }} connection error message from the function log.
