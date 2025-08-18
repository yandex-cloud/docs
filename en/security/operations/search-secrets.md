---
title: Scanning for {{ yandex-cloud }} secrets in public sources
description: Follow this guide to check your repositories.
---

# Scanning for {{ yandex-cloud }} secrets in public sources

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

{{ iam-name }} will also include the `DetectLeakedCredential` [event](../../audit-trails/concepts/events.md#iam) in the audit log.

## What one can do if a secret is detected {#secret-is-leaked}

If your secret got leaked to a public repository:

1. Re-issue or revoke the secret by following [this guide](../../iam/operations/compromised-credentials.md). Delete the affected resources, if required.
1. Delete the secret from the repository or commit history. To do this, follow the guides for [GitHub](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository) or [GitLab](https://docs.gitlab.com/ee/user/project/repository/reducing_the_repo_size_using_git.html#purge-files-from-repository-history).

{% note warning %}

{{ yandex-cloud }} does not revoke detected secrets and does not remove them from repositories. Any action on a secret is only performed by their owner.

{% endnote %}

## Scanning secrets on your own {#self-implemented-search}

### Regular expressions for search {#regex}

You can use the following regular expressions to scan your repositories on your own:

* **{{ iam-short-name }} Cookies**

   ```regexp
   c1\.[A-Z0-9a-z_-]+[=]{0,2}\.[A-Z0-9a-z_-]{86}[=]{0,2}
   ```

* **{{ iam-short-name }} tokens**

   ```regexp
   t1\.[A-Z0-9a-z_-]+[=]{0,2}\.[A-Z0-9a-z_-]{86}[=]{0,2}
   ```

* **API keys**

   ```regexp
   AQVN[A-Za-z0-9_\-]{35,38}
   ```

* **Static access keys**

   ```regexp
   YC[a-zA-Z0-9_\-]{38}
   ```

* **OAuth tokens**

   ```regexp
   y[0-6]_[-_A-Za-z0-9]{55,199}
   ```

* **{{ captcha-name }} server keys**

   ```regexp
   ysc2_[a-zA-Z0-9]{40}[0-9a-f]{8}
   ```

* **Refresh tokens**

   ```regexp
   rt1\.[A-Z0-9a-z_-]+[=]{0,2}\.[A-Z0-9a-z_-]{86}[=]{0,2}
   ```

{% note info %}

Use regular expressions carefully because the format of secrets may change moving forward. The changes might not appear in the documentation immediately.

{% endnote %}


### Additional validation of found secrets {#additional-validation}

Finding certain types of secrets is likely to yield a large number of false-positive results. To make sure the found secrets are up-to-date, we recommend running an additional validation.

* **OAuth tokens**

    {% list tabs group=programming_language %}

    - Go {#go}

      ```golang
      package main

      import (
          "encoding/base64"
          "fmt"
          "os"
          "strconv"
          "hash/crc32"
      )

      const (
          statefulMaskLen  = 40
          maxShard         = 16
      )

      func isNotValidEnvironmentType(token string) bool {
          n, err := strconv.Atoi(token[1:2])
          if err != nil {
              return true
          }
          if 0 <= n && n <= 6 {
              return false
          }
          return true
      }

      func isStatefulToken(token string) bool {
          if isNotValidEnvironmentType(token) {
              return false
          }

          decoded, err := base64.RawURLEncoding.DecodeString(token[3:])
          if err != nil {
              return false
          }

          crc := uint32(0)
          for i := 0; i < 4; i++ {
              crc <<= 8
              crc |= uint32(decoded[i+(len(decoded)-4)])
          }

          if crc != crc32.Checksum(decoded[:len(decoded)-4], crc32.MakeTable(crc32.IEEE)) {
              return false
          }

          return true
      }

      func fatalf(msg string, a ...interface{}) {
          _, _ = fmt.Fprintf(os.Stderr, "oauth_filter: " + msg + "\n", a...)
          os.Exit(1)
      }

      func main() {
          fmt.Println(isStatefulToken("<TOKEN>"))
      }
      ```

    {% endlist %}

* **Static access keys**

    {% list tabs group=programming_language %}

    - Go {#go}

      ```golang
      package main

      import (
          base64 "encoding/base64"
          "encoding/binary"
          "fmt"
          "hash/crc32"
          "strings"
      )

      const (
          YcPrefix = "YC"
      )

      func checkStaticCred(token string) bool {
          if !strings.HasPrefix(token, YcPrefix) {
              return false
          }

          decoded, err := base64.RawURLEncoding.DecodeString(token)
          if err != nil {
              return false
          }

          // CRC32-C checksum
          calculatedChecksum := crc32.Checksum(decoded[0:len(decoded)-4], crc32.MakeTable(crc32.Castagnoli))
          checksum := binary.BigEndian.Uint32(decoded[len(decoded)-4:])

          return calculatedChecksum == checksum
      }

      func main() {
          // ^YC[a-zA-Z0-9_\-]{38}$ - regexp
          fmt.Println(checkStaticCred("<TOKEN>"))
          fmt.Println(checkStaticCred("<TOKEN>"))
      }
      ```

    {% endlist %}

* **{{ captcha-name }} server keys**

    {% list tabs group=programming_language %}

    - Go {#go}

      ```golang
      package main

      import (
          "fmt"
          "hash/crc32"
      )

      func isValidToken(token string) bool {
          calculatedChecksum := crc32.Checksum([]byte(token[:len(token)-8]), crc32.MakeTable(crc32.IEEE))

          return token[len(token)-8:] == fmt.Sprintf("%08x", calculatedChecksum)
      }

      func main() {
          fmt.Println(isValidToken("ysc2_D0ur60kwXTL7rM52UzJ7Vi5D7a5Qu48zktqy0fE0********"))
      }
      ```

    - Python {#python}

      ```python
      import re
      import zlib

      def is_valid_secret(secret):
          if not re.match("ysc2_[a-zA-Z0-9]{40}[0-9a-f]{8}", secret):
              return False

          if secret[-8:] != "%08x" % zlib.crc32(secret[:-8].encode()):
              return False

          return True

      print(is_valid_secret("ysc2_D0ur60kwXTL7rM52UzJ7Vi5D7a5Qu48zktqy0fE0********")) # True
      ```

    {% endlist %}