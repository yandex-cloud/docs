#### Получение FQDN {#example1}

Чтобы получить полное имя ВМ ([FQDN](../../../compute/concepts/network.md#hostname)) из каталога [computeMetadata](../../../compute/concepts/metadata/directories.md#dir-compute), [подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ и выполните запрос:

```bash
curl \
  --header Metadata-Flavor:Google \
  169.254.169.254/computeMetadata/v1/instance/hostname
```

#### Получение метаданных ВМ в удобном для чтения формате {#example2}

Чтобы получить метаданные в удобном для чтения формате, [подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ и выполните запрос, воспользовавшись утилитой [jq](https://stedolan.github.io/jq/):

```bash
  curl \
    --header Metadata-Flavor:Google \
    169.254.169.254/computeMetadata/v1/instance/?recursive=true | \
    jq -r '.'
```

#### Получение идентификационного документа {#example3}

Чтобы получить [идентификационный документ](../../../compute/concepts/metadata/identity-document.md) из каталога [computeMetadata](../../../compute/concepts/metadata/directories.md#dir-compute), [подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ и выполните запрос:

```bash
curl \
  --header Metadata-Flavor:Google \
  169.254.169.254/computeMetadata/v1/instance/vendor/identity/document
```

#### Получение данных из каталога user-data {#example4}

Чтобы получить метаданные из каталога [user-data](../../../compute/concepts/metadata/directories.md#dir-user), [подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ и выполните запрос:

```bash
curl \
  --header Metadata-Flavor:Google \
  169.254.169.254/latest/user-data
```

В ответ сервис метаданных вернет результат в формате YAML:

```yaml
#cloud-config
datasource:
 Ec2:
  strict_id: false
ssh_pwauth: no
users:
- name: admin
  sudo: ALL=(ALL) NOPASSWD:ALL
  shell: /bin/bash
  ssh_authorized_keys:
  - ssh-ed25519 AAAAC3Nza******l0pTWGO
```

Чтобы получить в выводе только значение определенного ключа (например, имени пользователя), воспользуйтесь инструментом [yq](https://github.com/mikefarah/yq).

```bash
curl \
  --silent \
  --fail \
  --header Metadata-Flavor:Google \
  169.254.169.254/latest/user-data | \
  yq .users[].name
```

#### Получение IAM-токена сервисного аккаунта {#example5}

При выполнении запросов к [API {{ yandex-cloud }}](../../../api-design-guide/index.yaml) необходим [IAM-токен](../../../iam/concepts/authorization/iam-token.md), выданный [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md). Такой IAM-токен может быть получен через сервис метаданных изнутри ВМ. Для этого к виртуальной машине должен быть [привязан](../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) сервисный аккаунт.

Чтобы получить IAM-токен из каталога [computeMetadata](../../../compute/concepts/metadata/directories.md#dir-compute), [подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ и выполните запрос:

```bash
curl \
  --silent \
  --fail \
  --header Metadata-Flavor:Google \
  169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token | \
  jq -r .access_token
```

#### Получение данных из каталога user-data снаружи ВМ {#example6}

Чтобы получить метаданные снаружи ВМ, воспользуйтесь инструментом [{{ yandex-cloud }} CLI](../../../cli/cli-ref/compute/cli-ref/instance/get.md):

```bash
yc compute instance get my-vm --full --jq .metadata
```

В ответ сервис метаданных вернет результат в формате JSON:

```json
{
  "install-unified-agent": "0",
  "serial-port-enable": "0",
  "ssh-keys": "admin:ssh-ed25519 AAAAC3N******l0pTWGO admin@my.domain\n",
  "user-data": "#cloud-config\ndatasource:\n Ec2:\n  strict_id: false\nssh_pwauth: no\nusers:\n- name: admin\n  sudo: ALL=(ALL) NOPASSWD:ALL\n  shell: /bin/bash\n  ssh_authorized_keys:\n  - ssh-ed25519 AAAAC3N******l0pTWGO"
}
```

Информацию о способах получить переданные через метаданные значения переменных и [секретов {{ lockbox-full-name }}](../../../lockbox/concepts/secret.md) см. в инструкциях [{#T}](../../../compute/operations/vm-create/create-with-env-variables.md) и [{#T}](../../../compute/operations/vm-create/create-with-lockbox-secret.md).