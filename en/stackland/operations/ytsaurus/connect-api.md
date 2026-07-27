# Connecting to the {{ yt-name }} HTTP proxy

After the [component is enabled](enable.md), the {{ YT }} HTTP proxy is published at `https://api.ytsaurus.<system_domain>`. The proxy accepts requests via the [{{ YT }} CLI](https://ytsaurus.tech/docs/en/api/cli/install), [Python SDK](https://ytsaurus.tech/docs/en/api/python/start), and other {{ YT }} clients.

## Getting the HTTP proxy address {#get-url}

```bash
kubectl -n stackland-ytsaurus get ingress yt-http-proxies -o jsonpath='{.spec.rules[0].host}'
```

## Getting an administrator token {#get-token}

To get authenticated in the HTTP proxy, you need a token from the `ytadminsec` Secret. See [Getting an administrator password and token](get-admin-credentials.md).

Write the token into the environment variable:

```bash
export YT_TOKEN=$(kubectl -n stackland-ytsaurus get secret ytadminsec -o jsonpath='{.data.token}' | base64 -d)
```

## Connecting via the {{ YT }} CLI {#yt-cli}

1. Install the {{ YT }} CLI according to the [official guide](https://ytsaurus.tech/docs/ru/api/cli/install).
1. Specify the proxy address in the `YT_PROXY` environment variable:

    ```bash
    export YT_PROXY=https://api.ytsaurus.<system_domain>
    ```

1. Test the connection:

    ```bash
    yt list /
    ```

    The command returns the Cypress root directory contents.

## Connecting via the Python SDK {#python-sdk}

1. Install the [{{ YT }} Python SDK](https://ytsaurus.tech/docs/ru/api/python/start).
1. Connect to the cluster:

    ```python
    import os
    import yt.wrapper as yt

    client = yt.YtClient(
        proxy="https://api.ytsaurus.<system_domain>",
        token=os.environ["YT_TOKEN"],
    )

    print(client.list("/"))
    ```

## What's next {#what-is-next}

* [{{ YT }} CLI guide](https://ytsaurus.tech/docs/ru/api/cli/cli)
* [Python SDK guide](https://ytsaurus.tech/docs/ru/api/python/userdoc)
* [Opening the {{ YT }} web UI](connect-ui.md)
