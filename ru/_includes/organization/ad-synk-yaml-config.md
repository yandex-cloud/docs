```yml
# Default configuration for yc-identityhub-sync-agent
# This is a template - please update with your actual values

userpool_id: "<идентификатор_пула_пользователей>"
cloud_credentials_file_path: "<путь_к_файлу_с_авторизованным_ключом>"
replication_tokens_path: "<путь_к_директории_с_токенами_процессов>"
working_directory: "<путь_к_рабочей_директории_агента>"

# Active Directory replication API client settings
drsr:
  host: "<IP-адрес_контроллера_домена>"
  username: "username"
  password: "password"

# LDAP client settings
ldap:
  host: "ldap://<IP-адрес_контроллера_домена>:389"
  username: "ldap_username"
  password: "ldap_password"

# Logger configuration
logger:
  level: "<уровень_логирования>"
  format: "plain|json"
  file:
    filename: "<путь_к_файлу_с_логами>"
    maxsize: 30
    maxbackups: 10

# Sync settings
sync_settings:
  interval: "600s"
  allow_to_capture_users: true|false
  allow_to_capture_groups: true|false
  # Remove the following line if you don't need to replace domain
  replacement_domain: "<домен_пула_пользователей>"
  filter:
    domain: "<имя_домена_в_Active_Directory>"
    organization_units:
      - OU=IdPUsersOU,DC=example,DC=com
      - OU=IdPGroupsOU,DC=example,DC=com
  remove_user_behavior: "remove|block"
```