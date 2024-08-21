1. Введите в ячейку Python-код, например:

   ```python
   import random

   def inside(p):
       x, y = random.random(), random.random()
       return x*x + y*y < 1

   NUM_SAMPLES = 1_000_000_0

   count = sc.parallelize(range(0, NUM_SAMPLES)).filter(inside).count()
   print("Pi is roughly %f" % (4.0 * count / NUM_SAMPL))
   ```
1. Выберите ячейку с кодом и запустите вычисления.
1. В открывшемся окне **{{ ui-key.yc-ui-datasphere.open-project.select-configuration }}** перейдите на вкладку **{{ ui-key.yc-ui-datasphere.open-project.with-dataproc-cluster }}**.
1. Выберите конфигурацию вычислительных ресурсов и коннектор Spark.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.select }}**.

Коннектор и конфигурация окружения задаются вручную только при первом запуске вычисления. Все последующие вычисления в этом ноутбуке будут производиться на созданной при первом запуске ВМ. Кластер {{ dataproc-name }} подключается к ней при помощи коннектора Spark.
