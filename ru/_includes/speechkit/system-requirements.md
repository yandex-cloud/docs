Для установки {{ sk-hybrid-name }} вам необходим сервер с ОС Linux, который поддерживает Docker Engine. Список поддерживаемых ОС см. в [официальной документации Docker](https://docs.docker.com/engine/install/#server).

{% note warning %}

Процессор должен поддерживать набор инструкций [AVX2](https://ru.wikipedia.org/wiki/AVX) (Advanced Vector Support).

{% endnote %}

В Linux вы можете проверить, поддерживает ли ваш хост AVX2, командой:

```bash
grep -q avx2 /proc/cpuinfo && echo AVX2 || echo No AVX2
```
