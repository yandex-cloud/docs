  ```bash
    docker run -d --name yandex-unified-agent \
    -v example.yml:/etc/yandex/unified-agent/example.yml
    -e UNIFIED_AGENT_CONFIG=/etc/yandex/unified-agent/example.yml \
    -v /proc/:/host/proc/:ro -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro \
    cr.yandex/yc/yandex-unified-agent:latest
  ```
