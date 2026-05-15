---
canonical: '{{ link-docs }}/tutorials/testing/loadtesting-gitlab-ci'
---

# Invoking a load test from {{ GL }} CI

[{{ GL }}](https://about.gitlab.com/) is a web-based Git repository management platform. {{ GL }} also allows developers to run a continuous process for writing, testing, and deploying code.

In this scenario, you will use [{{ load-testing-full-name }}](../../load-testing/) to add the stage of invoking a load test of the application being deployed to the continuous integration/continuous delivery (CI/CD) pipeline. At this stage, the script will create a test agent, run the test, and check the test result.

{% include [loadtesting-gitlab-ci](../../_tutorials/dev/loadtesting-gitlab-ci.md) %}
