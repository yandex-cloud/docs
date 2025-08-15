1. Enter Python code in a cell. Here is an example:

   ```python
   import random

   def inside(p):
       x, y = random.random(), random.random()
       return x*x + y*y < 1

   NUM_SAMPLES = 1_000_000_0

   count = sc.parallelize(range(0, NUM_SAMPLES)).filter(inside).count()
   print("Pi is roughly %f" % (4.0 * count / NUM_SAMPL))
   ```
1. Select the code cell and run your computations.
1. In the **{{ ui-key.yc-ui-datasphere.open-project.select-configuration }}** window that opens, go to the **{{ ui-key.yc-ui-datasphere.open-project.with-dataproc-cluster }}** tab.
1. Select a computing resource configuration and a Spark connector.
1. Click **{{ ui-key.yc-ui-datasphere.common.select }}**.

You set the connector and environment configuration manually only when running a computation for the first time. All subsequent computations in this notebook will be performed on the VM created during the first run. A {{ dataproc-name }} cluster connects to the VM using the Spark connector.
