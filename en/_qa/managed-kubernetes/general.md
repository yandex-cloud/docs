---
title: "{{ managed-k8s-full-name }}. Questions and answers"
description: "How do I get the logs of my activity in Yandex Managed Service for {{ k8s }}? Find the answer to this and other questions in this article."
---

# General questions about {{ managed-k8s-name }}

#### What services are available in {{ managed-k8s-name }} clusters by default? {#defaults}

The following services are available by default:
* [Metrics Server](https://github.com/kubernetes-sigs/metrics-server) for data aggregation on resource usage in a [{{ k8s }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).
* [{{ k8s }} plugin for CoreDNS](https://coredns.io/plugins/kubernetes/) for name resolution in a cluster.
* [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) supporting [CSI plugins](https://github.com/container-storage-interface/spec) to work with [persistent volumes](../../managed-kubernetes/concepts/volume.md) (`PersistentVolume`).

#### Which version of the {{ k8s }} CLI (kubectl) must be installed for comprehensive work with a cluster? {#kubectl-version}

We recommend using the latest official version of [kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl/) to avoid compatibility issues.

#### Can {{ yandex-cloud }} restore the health of the cluster if I configure it incorrectly? {#tech-support-cases}

The [master](../../managed-kubernetes/concepts/index.md#master) is managed by {{ yandex-cloud }}, that's why you can't damage it. If you have issues with {{ k8s }} cluster components, [contact technical support]({{ link-console-support }}).

#### Who will be monitoring the health of the cluster? {#health-check}

{{ yandex-cloud }}. A cluster is monitored for corrupted file system, kernel deadlock, internet connection loss and {{ k8s }} component issues. We're also developing a self-healing mechanism for faulty components.

#### How quickly does {{ yandex-cloud }} address vulnerabilities discovered in the security system? What do I do if an attacker has taken advantage of a vulnerability and my data is damaged? {#security-updates}

{{ yandex-cloud }} services, images and master configuration initially undergo [various security tests and checks for standard compliance](../../security).

Users can choose [frequency of updates](../../managed-kubernetes/concepts/release-channels-and-updates.md#updates) depending on their tasks and cluster configuration. It's important to consider attack targets and vulnerabilities in applications deployed in a {{ k8s }} cluster. Application security can be affected by such factors as [network security policies](../../managed-kubernetes/concepts/network-policy.md) between applications, vulnerabilities inside {% if lang == "ru" %}[Docker containers](https://cloud.yandex.ru/blog/posts/2022/03/docker-containers){% else %}Docker containers{% endif %}, and incorrect launch mode of containers in a cluster.