# Fixing the `TestsFailure` error



## Issue description {#issue-description}

When building a Docker image, you see this error during testing: 
```
TestsFailure:It is not possible to start the docker container for testing.
Make sure that the requirements from the documentation are satisfied.
```

## Solution {#issue-resolution}

Correctness tests ensure that the project operates properly on the Docker image. The possible errors include:

1. The image is intended for launching a service, e.g., a web application, than a launch in {{ jlab }}. 
1. The error occurs because there is no `jupyter` user in Docker. You can install it using this command:

    ```
    RUN useradd -ms /bin/bash --uid 1000 jupyter
    ```

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). When creating a request, attach your Dockerfile for analysis.