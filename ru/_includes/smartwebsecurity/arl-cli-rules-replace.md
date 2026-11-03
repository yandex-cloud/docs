Параметр `--advanced-rate-limiter-rules` заменяет полный список правил профиля. Перед обновлением получите профиль и сохраните массив `advancedRateLimiterRules` из ответа в файл `rules.json`:

```bash
yc smartwebsecurity advanced-rate-limiter advanced-rate-limiter-profile get \
  --id <идентификатор_профиля> \
  --format json