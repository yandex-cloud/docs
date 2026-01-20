---
title: Scanning for {{ yandex-cloud }} secrets in public sources
description: Follow this guide to check your repositories.
---

# Scanning for {{ yandex-cloud }} secrets in public sources

{{ yandex-cloud }} scans public sources for the following types of secrets:

{% include [secret-types](../../_includes/security/standard/secret-types.md) %}

{{ yandex-cloud }} is connected to the following secret scanning tools:

{% include [secret-sources](../../_includes/security/standard/secret-sources.md) %}

## {{ yandex-cloud }} secret scanning partner program {#leak-detection-affiliate-program}

{{ yandex-cloud }} runs a partner program of its own for detection of compromised secrets in public repositories and other open sources.

You can join this partner program to make your services more secure.

To join the program, you will need a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud). We recommend [creating](../../organization/operations/enable-org.md#create-additional-org) a separate organization and a dedicated [cloud](../../resource-manager/operations/cloud/create.md) within it for the partner program. This way, you will not lose access to the partner program, even if your main cloud is suspended or deleted.

### How the partner program works {#program-roadmap}

To interact with {{ yandex-cloud }} as a member of the partner program, you will use a [service account](../../iam/concepts/users/service-accounts.md). When signing up for the program, you will give {{ yandex-cloud }} your service account ID and get a unique `leak_source` ID you will use for the API.

As a member of the {{ yandex-cloud }} secret scanning partner program, you scan your public repositories and other sources for compromised secrets and provide to {{ yandex-cloud }} the information on the keys and tokens you find. {{ yandex-cloud }} runs a check on the secrets it gets from you.

With the {{ yandex-cloud }} API, you follow these two steps:

1. You request {{ yandex-cloud }} on a regular basis to provide the current list of [regular expressions](#regex) corresponding to known types of secrets:

    * Request endpoint: `https://leak-detector.yandexcloud.net/secret-types`.
    * Request method: `GET`.
    * Request example:

        ```bash
        curl \
          --request GET \
          --header "Authorization: Bearer <IAM_token>" \
          "https://leak-detector.yandexcloud.net/secret-types?leak_source_id=<leak_source_ID>"
        ```

        Where:
        * `<IAM_token>`: [IAM token](../../iam/concepts/authorization/iam-token.md) you got for the service account registered in the partner program.
        * `<leak_source_ID>`: Unique ID you got when registering for the partner program.

    {% cut "Response example:" %}

    ```json
    [
      {
        "type": "yandex_cloud_api_key_v1",
        "regex_matcher": "AQW9[A-Za-z0-9_-]{35,38}"
      },
      {
        "type": "yandex_cloud_iam_access_secret",
        "regex_matcher": "YC[a-zA-Z0-9_\\-]{38}"
      },
      {
        "type": "yandex_cloud_iam_cookie_v1",
        "regex_matcher": "c1\\.[A-Z0-9a-z_-]{200,1000}[A-Z0-9a-z_-]{0,1000}[A-Z0-9a-z_-]{0,1000}[A-Z0-9a-z_-]{0,1000}[A-Z0-9a-z_-]{0,1000}[A-Z0-9a-z_-]{0,1000}[A-Z0-9a-z_-]{0,1000}[A-Z0-9a-z_-]{0,910}[=]{0,2}\\.[A-Z0-9a-z_-]{86}[=]{0,2}"
      },
      {
        "type": "yandex_cloud_iam_key_v1",
        "regex_matcher": "PLEASE DO NOT REMOVE THIS LINE\\! Yandex\\.Cloud SA Key ID (<|(\\\\u003[cC]))([0-9a-zA-Z+/=]*)(>|(\\\\u003[eE]))(\\s+)(-----BEGIN PRIVATE KEY-----(\\s+)([0-9a-zA-Z+/=]{64}(\\s+))*([0-9a-zA-Z+/=]{1,63}(\\s+))?-----END PRIVATE KEY-----\\s?)"
      },
      {
        "type": "yandex_cloud_iam_refresh_token_v1",
        "regex_matcher": "rt1\\.[A-Z0-9a-z_-]{200,1000}[A-Z0-9a-z_-]{0,1000}[A-Z0-9a-z_-]{0,1000}[A-Z0-9a-z_-]{0,1000}[A-Z0-9a-z_-]{0,1000}[A-Z0-9a-z_-]{0,1000}[A-Z0-9a-z_-]{0,1000}[A-Z0-9a-z_-]{0,910}[=]{0,2}\\.[A-Z0-9a-z_-]{86}[=]{0,2}"
      },
      {
        "type": "yandex_cloud_iam_token_v1",
        "regex_matcher": "t1\\.[A-Z0-9a-z_-]{200,1000}[A-Z0-9a-z_-]{0,1000}[A-Z0-9a-z_-]{0,1000}[A-Z0-9a-z_-]{0,1000}[A-Z0-9a-z_-]{0,1000}[A-Z0-9a-z_-]{0,1000}[A-Z0-9a-z_-]{0,1000}[A-Z0-9a-z_-]{0,910}[=]{0,2}\\.[A-Z0-9a-z_-]{86}[=]{0,2}"
      },
      {
        "type": "yandex_cloud_lockbox_secret_v1",
        "regex_matcher": "(yc|YC)[!-~]{18,254}"
      },
      {
        "type": "yandex_cloud_smartcaptcha_server_key",
        "regex_matcher": "ysc2_[a-zA-Z0-9]{40}[0-9a-f]{8}"
      },
      {
        "type": "yandex_passport_oauth_token",
        "regex_matcher": "y[0-6]_[-_A-Za-z0-9]{55,199}"
      }
    ]
    ```

    {% endcut %}

1. You scan your data for matches against the list of regular expressions. If detecting such matches, you submit the data to {{ yandex-cloud }} to get checked:

    * Request endpoint: `https://leak-detector.yandexcloud.net/suspects`.
    * Request method: `POST`.
    * Request example:

        ```bash
        curl \
          --request POST \
          --header "Content-Type: application/json" \
          --header "Authorization: Bearer <IAM_token>" \
          --data \
                  '''
                  {
                    "leak_source_id": "my_leak_source",
                    "suspects": [
                      {
                        "data_type": "yandex_cloud_lockbox_secret_v1",
                        "uri": "https://www.example.com/vcs/sources/project1/my_data.yaml",
                        "payload": "ycBHKGefu78t^%RD3gre387HO"
                      },
                      {
                        "data_type": "yandex_cloud_iam_token_v1",
                        "uri": "https://www.example.com/vcs/sources/project2/my_data.yaml",
                        "payload": "t1.Aga0BCD123efGhIjkLmNoPqRsTuVwXyZ1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcdefghijklmnopqrstuvwxyz.ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
                      }
                    ]
                  }
                  ''' \
          "https://leak-detector.yandexcloud.net/suspects"
        ```

        Where:
        * `<IAM_token>`: [IAM token](../../iam/concepts/authorization/iam-token.md) you got for the service account registered in the partner program.
        * `<leak_source_ID>`: Unique ID you got when registering for the partner program.
        * `suspects`: List of objects, each containing information about a single regular expression match.
        * `data_type`: Secret type as it appears in the response to the GET request when retrieving the list of regular expressions.
        * `uri`: URI of the resource containing a potential leak.
        * `entries`: Body (content) of the detected secret.

    * Response example:

        ```json
        ["NOT_CONFIRMED","CONFIRMED"]
        ```

        The response provides a list of statuses. The number and order of statuses returned match those of the secrets you sent in the `suspects` object of your GET request.

        The following statuses are possible:

        * `NOT_CONFIRMED`: Detected regular expression match is not a secret.
        * `CONFIRMED`: Detected regular expression match is a secret.
        * `TEMPORARILY_UNAVAILABLE`: Secret provider is unavailable. Retry the request for this secret later using [exponential backoff](https://en.wikipedia.org/wiki/Exponential_backoff).

### Terms of participation in the program {#conditions}

The {{ yandex-cloud }} secret scanning partner program will be active for the duration of the period specified at your registration. If you do not submit an exit notice, the program will be automatically extended for another year. The number of such extensions is not limited.

Your cooperation with {{ yandex-cloud }} under the secret scanning partner program does not imply any material remuneration and is intended as a joint effort to strengthen information security.

{% note info "How to join the program" %}

To join the program, use our [feedback form](https://forms.yandex.ru/surveys/13806106.25404433c712687b0fff48ef01ba08bbcf89ffb2) and provide your service account ID, information about your services, and your contact details. We will reach out to you with details on the terms of participation in our partner program.

{% endnote %}

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

1. Re-issue or revoke the secret according to [this guide](../../iam/operations/compromised-credentials.md). Delete the affected resources, if required.
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

* **OIDC app secrets**

   ```regexp
   yccs__[0-9a-f]{64}_[0-9a-f]{8}
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

* **OIDC app secrets**

    {% list tabs group=programming_language %}

    - Go {#go}

      ```golang
      package main

      import (
        "encoding/binary"
        "encoding/hex"
        "fmt"
        "regexp"

        "github.com/spaolacci/murmur3"
      )

      func ValidateOauthClientSecret(str string) bool {
        re := regexp.MustCompile(`yccs__[0-9a-f]{64}_[0-9a-f]{8}`)
        if !re.MatchString(str) {
          return false
        }

        prefix := str[:71]
        suffix := str[71:]

        hash := murmur3.Sum32([]byte(prefix))

        hashBytes := make([]byte, 4)
        binary.BigEndian.PutUint32(hashBytes, hash)

        expectedSuffix := hex.EncodeToString(hashBytes)
        return suffix == expectedSuffix
      }

      func main() {
        test := "<SECRET>"
        isValid := ValidateOauthClientSecret(test)
        if isValid {
          fmt.Println("Secret is valid.")
        } else {
          fmt.Println("Secret isn't valid")
        }
      }
      ```

    - Java {#java}

      ```java
      package yandex.cloud.leakdetector.server.provider;

      import org.apache.commons.codec.binary.Hex;
      import org.apache.commons.codec.digest.MurmurHash3;
      import java.nio.ByteBuffer;
      import java.nio.ByteOrder;
      import java.util.regex.Pattern;

      public class Main {
          private static final Pattern SECRET_PATTERN = Pattern.compile("yccs__[0-9a-f]{64}_[0-9a-f]{8}");

          public static boolean validateOauthClientSecret(String str) {
              if (!SECRET_PATTERN.matcher(str).matches()) {
                  return false;
              }

              String prefix = str.substring(0, 71);
              String suffix = str.substring(71);

              String hashHex = hashStringMurmur3(prefix);
              return suffix.equals(hashHex);
          }

          private static String hashStringMurmur3(String str) {
              int intHashValue = MurmurHash3.hash32x86(str.getBytes());
              return Hex.encodeHexString(
                      ByteBuffer.allocate(4)
                              .order(ByteOrder.BIG_ENDIAN)
                              .putInt(intHashValue)
                              .array()
              );
          }

          public static void main(String[] args) {
              String test = "<SECRET>";
              boolean isValid = validateOauthClientSecret(test);
              if (isValid) {
                  System.out.println("Secret is valid.");
              } else {
                  System.out.println("Secret isn't valid");
              }
          }
      }
      ```

    {% endlist %}