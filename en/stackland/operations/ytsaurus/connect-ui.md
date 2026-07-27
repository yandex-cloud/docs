# Opening the {{ yt-name }} web UI

After [enabling the component](enable.md) with the `spec.cluster.ui.enabled: true` and `spec.cluster.ui.ingressEnabled: true` parameters, the {{ YT }} web interface becomes available.

## Getting the web UI address {#get-url}

The web UI URL is `https://ytsaurus.<system_domain>`. To get the full address, run the following command:

```bash
kubectl -n stackland-ytsaurus get ingress yt-ui -o jsonpath='{.spec.rules[0].host}'
```

## Logging in to the web UI {#login}

There are two supported login methods:

* **Local administrator**: `admin` for username and a password from the `ytadminsec` Secret. See [Getting an administrator password and token](get-admin-credentials.md).
* **{{ iam-name }} login**: OAuth authentication via {{ iam-name }}. The user must exist in {{ iam-name }} and have access to the platform.

Login steps:

1. Open the web UI address in your browser.
1. On the login page, select your authentication method:

    * To log in as a local administrator, enter `admin` for username and a password from the `ytadminsec` Secret.
    * To log in via {{ iam-name }}, click the relevant button: the browser will navigate you to the {{ iam-name }} authentication page.

1. After a successful login, the main page of the {{ YT }} cluster with the name specified in `spec.clusterName` will open.

## What's next {#what-is-next}

* [Connecting to the {{ YT }} HTTP proxy](connect-api.md): for requests via the {{ YT }} CLI and SDK.
