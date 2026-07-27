# Getting a {{ yt-name }} administrator password and token

After you [enable the component](enable.md), the {{ YT }} cluster administrator credentials are stored in the `ytadminsec` Secret in the `stackland-ytsaurus` namespace.

The secret contains three keys:

* `login`: Administrator login, always `admin`.
* `password`: Administrator password for accessing the [{{ YT }} web UI](connect-ui.md).
* `token`: Token for accessing the [{{ YT }} HTTP proxy](connect-api.md) via the `yt` CLI, SDK, and third-party clients.

## Getting an administrator login {#get-login}

```bash
kubectl -n stackland-ytsaurus get secret ytadminsec -o jsonpath='{.data.login}' | base64 -d
```

## Getting an administrator password {#get-password}

```bash
kubectl -n stackland-ytsaurus get secret ytadminsec -o jsonpath='{.data.password}' | base64 -d
```

## Getting an administrator token {#get-token}

```bash
kubectl -n stackland-ytsaurus get secret ytadminsec -o jsonpath='{.data.token}' | base64 -d
```

{% note warning %}

The token provides full administrative access to the {{ YT }} cluster. Keep the token secure and do not expose it in version control systems, logs, or messages.

{% endnote %}

## Getting all values at once {#get-all}

The following command decodes and outputs all three Secret keys:

```bash
for KEY in login password token; do
  printf '%s: ' "$KEY"
  kubectl -n stackland-ytsaurus get secret ytadminsec -o jsonpath="{.data.$KEY}" | base64 -d
  printf '\n'
done
```
