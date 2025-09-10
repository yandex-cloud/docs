---
title: Поиск секретов {{ yandex-cloud }} в открытых источниках
description: Следуя данной инструкции, вы сможете самостоятельно проверять свои репозитории.
---

# Поиск секретов {{ yandex-cloud }} в открытых источниках

{{ yandex-cloud }} ищет следующие типы секретов в открытых источниках:

* [API-ключи](../../iam/concepts/authorization/api-key.md).
* [{{ iam-short-name }} Cookies](../../iam/concepts/authorization/cookie.md).
* [{{ iam-short-name }}-токены](../../iam/concepts/authorization/iam-token.md).
* [Статические ключи доступа](../../iam/concepts/authorization/access-key.md).
* [OAuth-токен](../../iam/concepts/authorization/oauth-token.md).
* [Серверные ключи {{ captcha-name }}](../../smartcaptcha/concepts/keys.md).
* [Refresh-токены](../../iam/concepts/authorization/refresh-token.md).
* [Секреты OIDC-приложений](../../organization/concepts/applications.md#oidc-secret).

{{ yandex-cloud }} подключен к следующим программам поиска секретов:

* [GitHub Secret scanning partner program](#github-secret-scanning).
* [GitLab Secret Detection](#gitlab-secret-detection).
* [Поисковый индекс Яндекс](#secret-is-leaked).
* [Helm-чарты в {{ marketplace-full-name }}](#helm-charts).

## GitHub {#github-secret-scanning}

{{ yandex-cloud }} подключен к [secret scanning partner program](https://docs.github.com/en/developers/overview/secret-scanning-partner-program), чтобы уменьшить риски пользователей от утечек секретов в публичные репозитории.

По умолчанию GitHub ищет секреты {{ yandex-cloud }} в публичных репозиториях и отправляет все подозрительные фрагменты в {{ yandex-cloud }}.

В публичных репозиториях поиск выполняется автоматически. [Включить secret scanning](https://docs.github.com/en/code-security/secret-scanning/configuring-secret-scanning-for-your-repositories) для приватного репозитория может администратор репозитория или владелец организации.

## GitLab {#gitlab-secret-detection}

[Стандартный список](https://gitlab.com/gitlab-org/security-products/analyzers/secrets/-/blob/master/gitleaks.toml) шаблонов секретов для [Secret Detection](https://docs.gitlab.com/ee/user/application_security/secret_detection/#enable-secret-detection-using-a-merge-request) включает секреты {{ yandex-cloud }}.

Чтобы включить Secret Detection для вашего проекта, следуйте [инструкции](https://docs.gitlab.com/ee/user/application_security/secret_detection/#enable-secret-detection-using-a-merge-request).

## Поисковый индекс Яндекс {#search-index-detection}

{{ yandex-cloud }} по умолчанию ищет секреты на страницах, которые проиндексированы поиском Яндекс.

## Helm-чарты в {{ marketplace-full-name }} {#helm-charts}

{{ yandex-cloud }} по умолчанию ищет секреты в [Helm-чартах](https://helm.sh/docs/topics/charts/), доступных в [{{ marketplace-full-name }}](../../managed-kubernetes/operations/applications/marketplace.md).

## Как узнать, что секрет обнаружен {#secret-is-detected}

Если будет обнаружен валидный секрет, владельцу организации придет письмо c адреса технической поддержки {{ yandex-cloud }}. Письмо будет содержать часть обнаруженного секрета и адрес в интернете, где секрет был обнаружен.

Также {{ iam-name }} запишет в аудитный лог [событие](../../audit-trails/concepts/events.md#iam) `DetectLeakedCredential`.

## Что делать если секрет обнаружен {#secret-is-leaked}

Если ваш секрет попал в публичный репозиторий:

1. Перевыпустите или отзовите секрет по [инструкции](../../iam/operations/compromised-credentials.md). Удалите затронутые ресурсы при необходимости.
1. Удалите секрет из репозитория и истории коммитов по инструкции для [GitHub](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository) или [GitLab](https://docs.gitlab.com/ee/user/project/repository/reducing_the_repo_size_using_git.html#purge-files-from-repository-history).

{% note warning %}

{{ yandex-cloud }} не отзывает найденные секреты и не удаляет их из репозитория. Все действия над секретом выполняет только владелец секрета.

{% endnote %}

## Самостоятельный поиск секретов {#self-implemented-search}

### Регулярные выражения для поиска {#regex}

Вы можете использовать следующие регулярные выражения, чтобы самостоятельно проверять свои репозитории:

* **{{ iam-short-name }} Cookies**

   ```regexp
   c1\.[A-Z0-9a-z_-]+[=]{0,2}\.[A-Z0-9a-z_-]{86}[=]{0,2}
   ```

* **{{ iam-short-name }}-токены**

   ```regexp
   t1\.[A-Z0-9a-z_-]+[=]{0,2}\.[A-Z0-9a-z_-]{86}[=]{0,2}
   ```

* **API-ключи**

   ```regexp
   AQVN[A-Za-z0-9_\-]{35,38}
   ```

* **Статические ключи доступа**

   ```regexp
   YC[a-zA-Z0-9_\-]{38}
   ```

* **OAuth-токены**

   ```regexp
   y[0-6]_[-_A-Za-z0-9]{55,199}
   ```

* **Серверные ключи {{ captcha-name }}**

   ```regexp
   ysc2_[a-zA-Z0-9]{40}[0-9a-f]{8}
   ```

* **Refresh-токены**

   ```regexp
   rt1\.[A-Z0-9a-z_-]+[=]{0,2}\.[A-Z0-9a-z_-]{86}[=]{0,2}
   ```

* **Секреты OIDC-приложений**

   ```regexp
   yccs__[0-9a-f]{64}_[0-9a-f]{8}
   ```

{% note info %}

С осторожностью используйте регулярные выражения, так как со временем форматы секретов могут измениться. В документации эти изменения могут отразиться с задержкой.

{% endnote %}


### Дополнительная валидация найденных секретов {#additional-validation}

При обнаружении некоторых типов секретов вероятно появление большого количества ложноположительных результатов. Чтобы удостовериться, что обнаружены актуальные секреты, рекомендуется проводить дополнительную валидацию.

* **OAuth-токены**

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

* **Статические ключи доступа**

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

* **Серверные ключи {{ captcha-name }}**

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

* **Секреты OIDC-приложений**

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