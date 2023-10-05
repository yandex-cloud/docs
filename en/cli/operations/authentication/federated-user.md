# Authenticating as a federated user

You can use a [federated account](../../../iam/concepts/index.md#saml-federation) to work with {{ yandex-cloud }} if your company has an [identity federation](../../../iam/concepts/federations.md) set up. In this case, a personal [Yandex account](../../../iam/concepts/index.md#passport) is not required.

{% note info %}

To authenticate on a server with no GUI, you need to install a browser with [X11 forwarding set up](https://docs.ssh.com/manuals/client-user/53/tunnel-x11.html). With X11 forwarding, you can use your browser on the server over SSH. For SSH clients running on Linux, this feature is available by default. For Windows clients, you can use [Xming](https://sourceforge.net/projects/xming/).

If you cannot install a browser, use a [service account](../../../iam/concepts/users/service-accounts.md) instead of a federated account.

{% endnote %}

If you do not have the {{ yandex-cloud }} command line interface, [install it](../install-cli.md).


{% include [include](../../../_includes/cli/auth-federated-user.md) %}

