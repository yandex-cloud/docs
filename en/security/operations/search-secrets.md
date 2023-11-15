# Detecting {{ yandex-cloud }} secrets in public sources

{{ yandex-cloud }} scans public sources for the following types of secrets:

* [API keys](../../iam/concepts/authorization/api-key.md)
* [{{ iam-short-name }} Cookies](../../iam/concepts/authorization/cookie.md)
* [{{ iam-short-name }} tokens](../../iam/concepts/authorization/iam-token.md)
* [Static access keys](../../iam/concepts/authorization/access-key.md)
* [OAuth token](../../iam/concepts/authorization/oauth-token.md)
* [{{ captcha-name }} server keys](../../smartcaptcha/concepts/keys.md)

{{ yandex-cloud }} is connected to the following secret scanning tools:

* [GitHub Secret scanning partner program](#github-secret-scanning)
* [GitLab Secret Detection](#gitlab-secret-detection)
* [Yandex search index](#secret-is-leaked)
* [Helm charts in {{ marketplace-full-name }}](#helm-charts)

## GitHub {#github-secret-scanning}

{{ yandex-cloud }} is connected to the [secret scanning partner program](https://docs.github.com/en/developers/overview/secret-scanning-partner-program) to reduce user risks caused by a leak of secrets to public repositories.

By default, GitHub scans public repositories for {{ yandex-cloud }} secrets and sends any suspicious fragment to {{ yandex-cloud }}.

Scanning in public repositories is done automatically. A repository administrator or organization owner can [enable secret scanning](https://docs.github.com/en/code-security/secret-scanning/configuring-secret-scanning-for-your-repositories) for a private repository.

## GitLab {#gitlab-secret-detection}

A [standard list](https://gitlab.com/gitlab-org/security-products/analyzers/secrets/-/blob/master/gitleaks.toml) of secret templates for [Secret Detection](https://docs.gitlab.com/ee/user/application_security/secret_detection/#enable-secret-detection-using-a-merge-request) includes {{ yandex-cloud }} secrets.

To enable Secret Detection for your project, follow [this guide](https://docs.gitlab.com/ee/user/application_security/secret_detection/#enable-secret-detection-using-a-merge-request).

## Yandex search index {#search-index-detection}

By default, {{ yandex-cloud }} scans pages indexed with the Yandex search engine for secrets.

## Helm charts in {{ marketplace-full-name }} {#helm-charts}

By default, {{ yandex-cloud }} scans [Helm charts](https://helm.sh/docs/topics/charts/) available in [{{ marketplace-full-name }}](../../managed-kubernetes/operations/applications/marketplace.md) for secrets.

## How one may learn that a secret has been detected {#secret-is-detected}

If a valid secret is detected, the organization owner will get an email from the {{ yandex-cloud }} support email address. It will contain part of the detected secret and the URL of the resource where it is detected.

{{ iam-name }} will also log the `DetectLeakedCredential` [event](../../audit-trails/concepts/events.md#iam) to the audit log.

## What one can do if a secret is detected {#secret-is-leaked}

If your secret got leaked to a public repository:

1. Re-issue or revoke the secret by following [this guide](../../iam/operations/compromised-credentials.md). Delete the affected resources, if required.
1. Delete the secret from the repository or commit history. To do this, follow the guides for [GitHub](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository) or [GitLab](https://docs.gitlab.com/ee/user/project/repository/reducing_the_repo_size_using_git.html#purge-files-from-repository-history).

{% note warning %}

{{ yandex-cloud }} does not revoke detected secrets and does not remove them from repositories. Any action on a secret is only performed by their owner.

{% endnote %}

## Scanning secrets on your own {#self-implemented-search}

You can use the following regular expressions to scan your repositories on your own:

* {{ iam-short-name }} Cookies

   ```regexp
   c1\.[A-Z0-9a-z_-]+[=]{0,2}\.[A-Z0-9a-z_-]{86}[=]{0,2}
   ```

* {{ iam-short-name }} tokens

   ```regexp
   t1\.[A-Z0-9a-z_-]+[=]{0,2}\.[A-Z0-9a-z_-]{86}[=]{0,2}
   ```

* API keys

   ```regexp
   AQVN[A-Za-z0-9_\-]{35,38}
   ```

* Static access keys

   ```regexp
   YC[a-zA-Z0-9_\-]{38}
   ```

* OAuth tokens

   ```regexp
   y[0-3]_[-_A-Za-z0-9]{55}
   ```

* {{ captcha-name }} server keys

   ```regexp
   ysc2_[a-zA-Z0-9]{40}[0-9a-f]{8}
   ```

{% note info %}

Use regular expressions carefully because the format of secrets may change moving forward. The changes might not appear in the documentation immediately.

{% endnote %}
