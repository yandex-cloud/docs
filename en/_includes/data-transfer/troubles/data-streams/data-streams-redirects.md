### {{ sf-short-name }} redirects {#redirects}

In rare cases, the following error may occur during transfers from {{ yds-short-name }} or {{ KF }}:

```text
redirect to SOME_URL is requested but no redirects are allowed.
```

Possible cause:

The use of the {{ sf-short-name }} function is set up on the source. It returns a redirect to another URL rather than data.

**Solution:**

Such redirects are not allowed for security reasons. Avoid using redirects to {{ sf-short-name }} during transfers.