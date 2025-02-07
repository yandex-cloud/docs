1. Delete the existing agent binary file.
1. Download the latest version of the agent as a binary file:

    ```bash
    ua_version=$(curl --silent https://{{ s3-storage-host }}/yc-unified-agent/latest-version) \
    bash -c 'curl --silent --remote-name https://{{ s3-storage-host }}/yc-unified-agent/releases/$ua_version/unified_agent && chmod +x ./unified_agent'
    ```

1. Download the agent's executable file and then create a configuration file, for example, with the settings for [delivering Linux system metrics](../../monitoring/operations/unified-agent/linux_metrics.md). For more information on agent configuration, see [{#T}](../../monitoring/concepts/data-collection/unified-agent/configuration.md).


1. Move the downloaded file to the `/bin/unified_agent` folder.
1. [Restart](../../monitoring/concepts/data-collection/unified-agent/run-and-stop.md#run) the agent.

To find out all available versions of the agent, run this command:

```(bash)
curl --silent https://{{ s3-storage-host }}/yc-unified-agent/all-versions
```