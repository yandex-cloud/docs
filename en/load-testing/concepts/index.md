# {{ load-testing-full-name }} overview

{{ load-testing-full-name }} lets you perform load testing of your applications and services.

To perform a load test, you'll need:

* A service to test.
* An agent: a VM with the load testing tool and [load generators](load-generator.md).
* A test configuration.
* A payload.

You can test any resource that is publicly available or located in the same subnet as the load source. For example, a VM, DB host, or network or L7 load balancer.

The main parameters for the test are set by the configuration. They include the time of load generation, its volume, growth, and auxiliary functions. For simple cases, {{ load-testing-name }} lets you configure a test from the interface. For more nuanced testing, you can upload a configuration file in YAML format and edit it in the interface.

The payload is the [test data](payload.md) that will be transmitted to the service. This can be a set of requests, parameters, or scripts, or a log that needs to be simulated. You can pass the payload as part of a configuration or as a file.

Test results are available in test [reports](reports.md) or in the application server and load source logs.