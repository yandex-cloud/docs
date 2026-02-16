---
title: Поиск секретов {{ yandex-cloud }} в открытых источниках
description: Следуя данной инструкции, вы сможете самостоятельно проверять свои репозитории.
---

# Поиск секретов {{ yandex-cloud }} в открытых источниках

{{ yandex-cloud }} ищет следующие типы секретов в открытых источниках:

{% include [secret-types](../../_includes/security/standard/secret-types.md) %}

{{ yandex-cloud }} подключен к следующим программам поиска секретов:

{% include [secret-sources](../../_includes/security/standard/secret-sources.md) %}

## Партнерская программа поиска секретов {{ yandex-cloud }} {#leak-detection-affiliate-program}

В {{ yandex-cloud }} действует собственная партнерская программа поиска скомпрометированных секретов в публичных репозиториях и других открытых источниках.

Вы можете присоединиться к партнерской программе поиска секретов {{ yandex-cloud }}, чтобы повысить безопасность ваших сервисов.

Для работы с партнерской программой вам потребуется [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud). Рекомендуем [создать](../../organization/operations/enable-org.md#create-additional-org) отдельную организацию и [отдельное облако](../../resource-manager/operations/cloud/create.md) в ней для работы с партнерской программой. Так вы не потеряете доступ к партнерской программе, даже если ваше основное облако окажется заблокировано или удалено.

### Механизм работы партнерской программы {#program-roadmap}

Для взаимодействия с {{ yandex-cloud }} в рамках партнерской программы используется [сервисный аккаунт](../../iam/concepts/users/service-accounts.md). При регистрации в программе вы передадите {{ yandex-cloud }} идентификатор вашего сервисного аккаунта и получите уникальный идентификатор `leak_source`, который будете использовать для взаимодействия с API.

Участвуя в партнерской программе поиска секретов {{ yandex-cloud }}, вы выполняете сканирование публичных репозиториев и других источников на наличие скомпрометированных секретов и передаете в {{ yandex-cloud }} данные о найденных ключах и токенах. {{ yandex-cloud }} проверяет полученные от вас секреты.

Взаимодействие с API {{ yandex-cloud }} происходит в два этапа:

1. Вы регулярно запрашиваете в {{ yandex-cloud }} актуальный список [регулярных выражений](#regex), соответствующих известным типам секретов:

    * Эндпоинт запроса: `https://leak-detector.yandexcloud.net/secret-types`.
    * Метод запроса: `GET`.
    * Пример запроса:

        ```bash
        curl \
          --request GET \
          --header "Authorization: Bearer <IAM-токен>" \
          "https://leak-detector.yandexcloud.net/secret-types?leak_source_id=<идентификатор_leak_source>"
        ```

        Где:
        * `<IAM-токен>` — [IAM-токен](../../iam/concepts/authorization/iam-token.md), полученный для зарегистрированного в партнерской программе сервисного аккаунта.
        * `<идентификатор_leak_source>` — уникальный идентификатор, полученный при регистрации в партнерской программе.

    {% cut "Пример ответа:" %}

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

1. Вы сканируете ваши данные на предмет поиска соответствий полученному списку регулярных выражений. При обнаружении таких соответствий вы отправляете данные о них в {{ yandex-cloud }} для проверки:

    * Эндпоинт запроса: `https://leak-detector.yandexcloud.net/suspects`.
    * Метод запроса: `POST`.
    * Пример запроса:

        ```bash
        curl \
          --request POST \
          --header "Content-Type: application/json" \
          --header "Authorization: Bearer <IAM-токен>" \
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

        Где:
        * `<IAM-токен>` — [IAM-токен](../../iam/concepts/authorization/iam-token.md), полученный для зарегистрированного в партнерской программе сервисного аккаунта.
        * `<идентификатор_leak_source>` — уникальный идентификатор, полученный при регистрации в партнерской программе.
        * `suspects` — список объектов, каждый из которых содержит информацию об одном найденном соответствии регулярному выражению.
        * `data_type` — тип секрета, как он указан в ответе на GET-запрос при получении списка регулярных выражений.
        * `uri` — [URI](../../glossary/url.md#uri) ресурса, на котором обнаружена потенциальная утечка.
        * `payload` — тело (содержимое) найденного секрета.

    * Пример ответа:

        ```json
        ["NOT_CONFIRMED","CONFIRMED"]
        ```

        Ответ содержит список статусов. Количество и порядок возвращенных в ответе статусов соответствует количеству и порядку секретов, отправленных в GET-запросе в объекте `suspects`.

        Возможные статусы:

        * `NOT_CONFIRMED` — обнаруженный случай соответствия регулярному выражению не является секретом.
        * `CONFIRMED` — обнаруженный случай соответствия регулярному выражению является секретом.
        * `TEMPORARILY_UNAVAILABLE` — провайдер секретов недоступен. Повторите запрос в отношении данного секрета позднее с применением алгоритма [экспоненциальной выдержки](https://ru.wikipedia.org/wiki/Экспоненциальная_выдержка).

### Условия участия в программе {#conditions}

Партнерская программа поиска секретов {{ yandex-cloud }} действует в течение периода, установленного при вашем присоединении к ней. При отсутствии с вашей стороны заявления о выходе из программы ее действие продлевается на один год. Количество таких продлений не ограничено.

Сотрудничество с {{ yandex-cloud }} в рамках партнерской программы поиска секретов не предполагает материального вознаграждения и нацелено на совместное принятие мер по повышению уровня информационной безопасности.

{% note info "Как присоединиться к программе" %}

Чтобы присоединиться к программе, воспользуйтесь [формой обратной связи](https://forms.yandex.ru/surveys/13806106.25404433c712687b0fff48ef01ba08bbcf89ffb2) и передайте в ней идентификатор вашего сервисного аккаунта, информацию о ваших сервисах и ваши контактные данные. Мы свяжемся с вами и подробно расскажем об условиях участия в нашей партнерской программе.

{% endnote %}

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