1. В начале конфигурационного файла необходимо задать настройки провайдера.

    {% note info %}

    Настройки применимы для Terraform `0.13` и более поздних версий.

    {% endnote %}

   ```hcl
   terraform {
     required_providers {
       yandex = {
         source  = "yandex-cloud/yandex"
         version = "0.61.0"
       }
     }
   }

   provider "yandex" {
     token     = "<OAuth>"
     cloud_id  = "<идентификатор облака>"
     folder_id = "<идентификатор каталога>"
     zone      = "<зона доступности по умолчанию>"
   }
   ```

   * `source` — глобальный [адрес источника](https://www.terraform.io/docs/language/providers/requirements.html#source-addresses) провайдера.
   * `version` — минимальная версия провайдера, с которой совместим модуль. Номер версии можно посмотреть на [странице провайдера](https://registry.terraform.io/providers/yandex-cloud/yandex/latest) (кнопка **USE PROVIDER** в верхнем правом углу).
   * `provider` — название провайдера.
   * `token` — [OAuth-токен](../../iam/concepts/authorization/oauth-token.md) для доступа к {{ yandex-cloud }}.
   * `cloud_id` — идентификатор облака, в котором Terraform создаст ресурсы.
   * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором по умолчанию будут создаваться ресурсы.
   * `zone` — [зона доступности](../../overview/concepts/geo-scope.md), в которой по умолчанию будут создаваться все облачные ресурсы.

1.  Выполните команду `terraform init` в папке с конфигурационным файлом. Эта команда инициализирует провайдеров, указанных в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
