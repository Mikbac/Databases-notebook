SELECT table_name AS TABLE_NAME
FROM information_schema.tables
WHERE table_name REGEXP '^.*[0-9]$';

SELECT IF(FIND_IN_SET('Drop', Table_priv)) AS 'DROP'
FROM mysql.tables_priv
WHERE User = 'aaa'
  AND Host = '%';

SELECT Customers.CustomerName
FROM Customers
         LEFT JOIN Orders
                   ON Customers.CustomerID=Orders.CustomerID
ORDER BY Customers.CustomerName;