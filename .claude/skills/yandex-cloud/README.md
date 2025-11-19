# Yandex Cloud Skill v2.0 - C.R.A.F.T. Architecture

Комплексный навык для работы с Yandex Cloud, построенный по методологии C.R.A.F.T. (Context, Role, Action, Format, Target) с поддержкой:

- **Шины контекста** для обмена данными между навыками
- **Микро-агентов** для параллельной обработки задач
- **Автоматических хуков** для валидации и обновления документации
- **Множественных бэкендов хранения** (JSON, SQLite, Redis, Neo4j)

## Быстрый старт

```bash
# Проверка зависимостей
./.claude/skills/yandex-cloud/scripts/self-test.sh

# Просмотр окружения
./.claude/skills/yandex-cloud/scripts/env-check.sh

# Анализ инфраструктуры
./.claude/skills/yandex-cloud/scripts/skill-run.sh analyze

# Статистика
./.claude/skills/yandex-cloud/scripts/skill-run.sh stats
```

## Структура

```
.claude/skills/yandex-cloud/
├── skill.yaml                 # Конфигурация навыка
├── README.md                  # Эта документация
├── SKILL_GUIDE.md            # Подробное руководство
├── templates/
│   ├── bus.config.yaml       # Конфигурация шины событий
│   └── skill.env.example     # Пример переменных окружения
├── scripts/
│   ├── bus.sh                # API шины событий
│   ├── skill-run.sh          # Главный entrypoint
│   ├── self-test.sh          # Проверка зависимостей
│   ├── env-check.sh          # Информация об окружении
│   ├── agents-runner.sh      # Запуск микро-агентов
│   └── skill-undo.sh         # Удаление навыка
├── hooks/
│   ├── pre-commit            # Быстрые проверки (<10s)
│   ├── pre-push              # Тщательные проверки (<60s)
│   └── post-skill-run.d/
│       ├── 10-docs-update.sh # Автообновление документации
│       └── 20-emit-metrics.sh # Сбор метрик
└── agents/
    ├── agent.docs-indexer.sh         # Индексация документации
    ├── agent.resource-analyzer.sh    # Анализ ресурсов
    ├── agent.cost-optimizer.sh       # Оптимизация затрат
    └── agent.security-auditor.sh     # Аудит безопасности
```

## Возможности

### 1. Автоматизация задач

```bash
# Анализ инфраструктуры с агентами
./scripts/skill-run.sh analyze

# Поиск возможностей оптимизации
./scripts/skill-run.sh optimize

# Диагностика проблем
./scripts/skill-run.sh troubleshoot

# Обновление документации
./scripts/skill-run.sh document
```

### 2. Шина событий

Обмен данными между навыками и агентами:

```bash
# Публикация события
./scripts/bus.sh publish my.topic '{"key":"value"}'

# Чтение событий
./scripts/bus.sh read my.topic 10

# Key-Value хранилище
./scripts/bus.sh put project.name '"my-project"'
./scripts/bus.sh get project.name

# Статистика
./scripts/bus.sh stats
```

### 3. Переключение бэкендов

```bash
# JSON (по умолчанию, легковесный)
BUS_BACKEND=json ./scripts/skill-run.sh analyze

# SQLite (структурированные запросы)
BUS_BACKEND=sqlite ./scripts/skill-run.sh analyze

# Redis (распределенный, real-time)
export REDIS_URL=redis://localhost:6379/0
BUS_BACKEND=redis ./scripts/skill-run.sh analyze

# Neo4j (графовая БД)
export NEO4J_URI=bolt://localhost:7687
export NEO4J_PASSWORD=password
BUS_BACKEND=graph ./scripts/skill-run.sh analyze
```

### 4. Микро-агенты

Запускаются параллельно для ускорения обработки:

```bash
# Все агенты
./scripts/agents-runner.sh all

# Только для анализа
./scripts/agents-runner.sh analyze

# Ограничение параллелизма
AGENTS_MAX=2 ./scripts/agents-runner.sh all

# Пропустить агентов
SKIP_AGENTS=1 ./scripts/skill-run.sh analyze
```

### 5. Git Hooks

Автоматическая валидация при коммитах:

```bash
# pre-commit (макс 10 сек)
- Проверка синтаксиса скриптов
- Валидация YAML/JSON
- Проверка зависимостей

# pre-push (макс 60 сек)
- Полный self-test
- Проверка всех компонентов

# Пропустить хуки
SKIP_HOOKS=1 git commit ...
```

## Конфигурация

### Переменные окружения

Скопируйте `templates/skill.env.example` в `.env` и настройте:

```bash
# Event bus
BUS_BACKEND=json              # json|sqlite|redis|graph

# Yandex Cloud
YC_TOKEN=your_token
YC_CLOUD_ID=your_cloud_id
YC_FOLDER_ID=your_folder_id

# Performance
AGENTS_MAX=4                  # Макс параллельных агентов
SKIP_HOOKS=0                  # Пропустить Git hooks
SKIP_AGENTS=0                 # Пропустить агентов
FAST=1                        # Быстрый режим
```

### skill.yaml

Основная конфигурация навыка с описанием:
- Capabilities (возможности)
- Dependencies (зависимости)
- Agents (микро-агенты)
- Bus topics (темы событий)
- Documentation (ссылки на доки)

## Команды

### Основные задачи

| Команда | Описание | Время |
|---------|----------|-------|
| `analyze` | Анализ инфраструктуры и документации | ~30s |
| `build` | Сборка конфигураций | ~1m |
| `test` | Тестирование | ~30s |
| `deploy` | Развертывание (требует ALLOW_DEPLOY=1) | ~5m |
| `monitor` | Настройка мониторинга | ~10s |
| `troubleshoot` | Диагностика проблем | ~1m |
| `optimize` | Поиск оптимизаций | ~30s |
| `document` | Обновление документации | ~20s |
| `stats` | Статистика навыка | <1s |

### Полезные команды

```bash
# Справка
./scripts/skill-run.sh help

# Проверка окружения
./scripts/env-check.sh

# Тест зависимостей
./scripts/self-test.sh

# Статистика шины
./scripts/bus.sh stats

# Список ключей
./scripts/bus.sh keys

# Удаление навыка
./scripts/skill-undo.sh
```

## Интеграция с Claude Code

Навык автоматически активируется в Claude Code при обращении к задачам Yandex Cloud.

### Использование в slash-командах

```
/yc-setup          - Настройка Yandex Cloud CLI
/yc-search-docs    - Поиск в документации
/yc-create-terraform - Генерация Terraform конфигураций
/yc-troubleshoot   - Диагностика проблем
```

### Программное использование

```python
# Python пример
import subprocess
import json

# Запуск анализа
result = subprocess.run([
    "./.claude/skills/yandex-cloud/scripts/skill-run.sh",
    "analyze"
], capture_output=True, text=True)

# Чтение результатов из шины
bus_result = subprocess.run([
    "./.claude/skills/yandex-cloud/scripts/bus.sh",
    "get", "yc.analysis.doc_count"
], capture_output=True, text=True)

doc_count = json.loads(bus_result.stdout.strip())
print(f"Found {doc_count} documentation files")
```

## Разработка

### Добавление нового агента

1. Создайте файл `agents/agent.{name}.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
source "$SKILL_DIR/scripts/bus.sh"

# Publish start
publish_event "yc.agent.{name}.started" '{"status":"running"}'

# Your logic here
result='{"status":"success","data":{}}'

# Store results
put_kv "yc.agent.{name}.result" "$result"

# Publish completion
publish_event "yc.agent.{name}.completed" "$result"
```

2. Сделайте исполняемым: `chmod +x agents/agent.{name}.sh`

3. Добавьте в `skill.yaml` в секцию `agents.types`

4. Агент автоматически будет запускаться при вызове `agents-runner.sh`

### Добавление нового hook

1. Создайте скрипт в `hooks/post-skill-run.d/{number}-{name}.sh`
2. Сделайте исполняемым
3. Хук будет автоматически выполняться после каждого запуска навыка

## Best Practices

1. **Используйте шину** для обмена данными между компонентами
2. **Ограничивайте время выполнения** хуков (pre-commit <10s, pre-push <60s)
3. **Пишите idempotent скрипты** - повторный запуск должен быть безопасен
4. **Логируйте в шину** важные события для отладки
5. **Используйте агентов** для длительных операций
6. **Документируйте** изменения в README
7. **Тестируйте** через self-test.sh перед коммитом

## Troubleshooting

### Проблема: "jq not found"
```bash
# Ubuntu/Debian
sudo apt-get install jq

# macOS
brew install jq
```

### Проблема: "bus publish failed"
```bash
# Проверьте backend
./scripts/bus.sh stats

# Переключитесь на JSON
BUS_BACKEND=json ./scripts/skill-run.sh analyze
```

### Проблема: "agent timeout"
```bash
# Увеличьте timeout или пропустите агентов
SKIP_AGENTS=1 ./scripts/skill-run.sh analyze
```

### Проблема: "hook too slow"
```bash
# Пропустите хуки
SKIP_HOOKS=1 git commit -m "message"
```

## Performance

- **Pre-commit hook**: <10s (проверка синтаксиса)
- **Pre-push hook**: <60s (self-test)
- **Analyze task**: ~30s (с 4 агентами)
- **Bus operations**: <100ms (JSON), <50ms (SQLite/Redis)

## Security

- ✅ Секреты только через переменные окружения
- ✅ `.gitignore` для конфиденциальных файлов
- ✅ Аудит команд в security.allowed_commands
- ✅ Запрет опасных паттернов
- ✅ Шифрование значений в bus (опционально)

## Метрики

Навык собирает метрики:
- Время выполнения задач
- Количество запусков агентов
- Успешность операций
- Обновления документации

Доступ к метрикам:
```bash
./scripts/bus.sh read yc.metrics 50
```

## Roadmap

- [ ] Интеграция с Yandex Cloud API
- [ ] Автоматический деплой через Terraform
- [ ] Web UI для просмотра метрик
- [ ] ML-анализ затрат
- [ ] Интеграция с CI/CD системами
- [ ] Plugin система для расширений

## Лицензия

Этот навык является частью репозитория yandex-cloud-docs.

## Ссылки

- [Yandex Cloud Docs](https://yandex.cloud/docs)
- [C.R.A.F.T. Methodology](../.../README.md)
- [Event Bus Architecture](./templates/bus.config.yaml)
- [Agents Guide](./agents/README.md)

---

**Version**: 2.0.0
**Updated**: 2025-11-19
**Status**: Active ✨
