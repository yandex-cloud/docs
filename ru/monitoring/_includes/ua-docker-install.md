  ```bash
  docker run --name ua-agent -v /proc/:/host/proc/:ro -v /sys:/host/sys:ro -v config.yml:/etc/yandex/unified_agent/conf.d/config.yml unified_agent:latest
  ```
