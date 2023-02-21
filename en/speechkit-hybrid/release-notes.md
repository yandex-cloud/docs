# {{ speechkit-full-name }} hybrid releases

Information about updates to the {{ sk-hybrid-name }} image versions will be published here.

## Current version {#current}

### Release 20.01.23 {#200123}

1. Updated all the system components to remove critical vulnerabilities.
1. Built a new `envoy` container based on Ubuntu 20.04 with the latest security updates.
1. Added the option to enable phone number normalization in speech recognition.
1. Decreased memory consumption in speech synthesis at RPS values exceeding the service's [estimated bandwidth](system-requirements.md#hardware)

## Previous versions {#previous}

### Release 05.12.22 {#051222}

1. Added the option to set [logging](operations/logging.md) levels for {{ sk-hybrid-name }} containers.
1. Updated time format in logs to be the same in all components.
1. Fixed part of the problems that prevented the agent from launching because `swaydb` was damaged.
1. Added the option to enable [TLS termination](operations/tls-proxy.md).
1. Installed the latest security updates.
1. Updated the script to launch services inside containers. Improved system behavior at `kill -15`: the shutdown is graceful now.