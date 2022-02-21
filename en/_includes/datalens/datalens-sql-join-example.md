A SQL query joins data from `samples.MS_SalesFacts`, `samples.MS_Products`, and `samples.MS_Shops` and groups them on the `Store` and the `Product type` fields. A sales total is computed for each group. At the same time, only sales records from 2019 are taken into consideration:

```sql
SELECT 
    t3.ShopName AS "Store",
    t2.ProductCategory AS "Product type",
    COUNT(t1.OrderID) AS "Number of sales",
    SUM(t1.Price*t1.ProductCount) AS "Sales total"
FROM
    samples.MS_SalesFacts t1
    INNER JOIN samples.MS_Products t2 ON t2.ProductID=t1.ProductID
    INNER JOIN samples.MS_Shops t3 ON t3.ShopID=t1.ShopID
WHERE
    toYear(t1.OrderDatetime)='2019' -- condition for selecting sales for the specified year (2019)
GROUP BY "Store", "Product type" -- group by Store and Product type
ORDER BY "Store", "Product Type" -- sort by Store and Product type
```

