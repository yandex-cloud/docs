# Yandex Cloud Skill - Micro-Agents

Микро-агенты выполняют специализированные задачи параллельно и публикуют результаты в шину событий.

## Доступные агенты

### agent.docs-indexer.sh
Индексирует локальную документацию Yandex Cloud:
- Сканирует структуру `ru/` директории
- Создает индекс сервисов и документов
- Обновляет метаданные в шине

### agent.resource-analyzer.sh
Анализирует облачные ресурсы:
- Проверяет конфигурации Terraform
- Анализирует Docker/Kubernetes манифесты
- Находит потенциальные проблемы

### agent.cost-optimizer.sh
Ищет возможности оптимизации затрат:
- Анализирует использование ресурсов
- Предлагает использование preemptible VM
- Рекомендует оптимальные размеры

### agent.security-auditor.sh
Проверяет конфигурации безопасности:
- Сканирует на наличие секретов в коде
- Проверяет IAM политики
- Анализирует Security Groups

## Использование

Агенты запускаются автоматически через `agents-runner.sh`:

```bash
# Запуск всех агентов
./.claude/skills/yandex-cloud/scripts/agents-runner.sh all

# Запуск агентов для конкретной задачи
./.claude/skills/yandex-cloud/scripts/agents-runner.sh analyze

# Ограничение параллелизма
AGENTS_MAX=2 ./.claude/skills/yandex-cloud/scripts/agents-runner.sh all
```

## Создание нового агента

1. Создайте файл `agent.{name}.sh`
2. Сделайте его исполняемым: `chmod +x agent.{name}.sh`
3. Используйте bus.sh для публикации результатов
4. Добавьте в `skill.yaml` в секцию `agents.types`

Шаблон агента:

```bash
#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
source "$SKILL_DIR/scripts/bus.sh"

# Your logic here
# ...

# Publish results
publish_event "yc.agent.{name}.completed" '{"status":"success","data":{...}}'
```

## Взаимодействие с шиной

Агенты используют общую шину для:
- Чтения конфигурации из KV хранилища
- Публикации результатов работы
- Координации с другими агентами

Примеры:

```bash
# Чтение данных
project_name=$(bash "$SKILL_DIR/scripts/bus.sh" get project.name)

# Запись результатов
bash "$SKILL_DIR/scripts/bus.sh" put agent.result.{name} '{"foo":"bar"}'

# Публикация события
bash "$SKILL_DIR/scripts/bus.sh" publish agent.{name}.done '{"status":"ok"}'
```
