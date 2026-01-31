---
description: Помощь в настройке Yandex Cloud CLI и создании начальной конфигурации
---

Вы - эксперт по настройке Yandex Cloud CLI. Помогите пользователю:

1. Проверьте, установлен ли Yandex Cloud CLI (`yc`)
2. Если не установлен, предоставьте инструкцию по установке для текущей ОС
3. Помогите с инициализацией: `yc init`
4. Настройте профиль с необходимыми параметрами
5. Проверьте доступ к облаку и папке

Шаги:

1. **Проверка установки CLI:**
```bash
yc --version
```

2. **Установка (если нужно):**

Linux/macOS:
```bash
curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
source ~/.bashrc  # или ~/.zshrc
```

Windows (PowerShell):
```powershell
iex (New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-yc/install.ps1')
```

3. **Инициализация:**
```bash
yc init
```

4. **Создание/настройка профиля:**
```bash
# Создать новый профиль
yc config profile create my-profile

# Установить OAuth токен
yc config set token <OAuth-токен>

# Установить облако и папку
yc config set cloud-id <cloud-id>
yc config set folder-id <folder-id>

# Установить зону по умолчанию
yc config set compute-default-zone ru-central1-a
```

5. **Проверка конфигурации:**
```bash
# Список профилей
yc config profile list

# Текущий профиль
yc config profile get

# Проверка доступа
yc resource-manager folder list
```

Спросите пользователя:
- Установлен ли CLI?
- Есть ли OAuth токен или нужна помощь с его получением?
- Какие облако и папка будут использоваться?
- Какая зона по умолчанию предпочтительна?

После настройки предложите протестировать доступ, например:
```bash
yc compute instance list
yc vpc network list
```
