  --1
SELECT  CUS.CUSTOMER_ID,
        MAX(ORD.ORDER_DATE) ULTIMA_COMPRA,
        SUM(OP.QUANTITY * PROD.LIST_PRICE) TOTAL
FROM CARLOSV.ORDERS ORD 
    INNER JOIN CARLOSV.ORDERS_PRODUCTS OP 
        ON ORD.ORDER_ID = OP.ORDER_ID
    INNER JOIN CARLOSV.PRODUCTS PROD 
        ON OP.PRODUCT_ID = PROD.PRODUCT_ID
    INNER JOIN CARLOSV.CUSTOMERS CUS 
        ON ORD.CUSTOMER_ID = CUS.CUSTOMER_ID
GROUP BY CUS.CUSTOMER_ID
ORDER BY CUS.CUSTOMER_ID ASC;
 
 --2
SELECT  CUSTOMER_ID, 
        FIRST_NAME,
        LAST_NAME
FROM CARLOSV.CUSTOMERS 
WHERE FIRST_NAME LIKE 'H%' OR LAST_NAME LIKE 'Z%';

--3
SELECT ORDER_ID, ORDER_DATE, CUSTOMER_ID, FIRST_NAME, PRODUCT_ID, TOTAL,
    (CASE WHEN TOTAL <= 10000 THEN TOTAL*0.1
    WHEN 10000 < TOTAL AND TOTAL <= 30000 THEN TOTAL*0.08
    ELSE TOTAL*0.05 END) SHIPPING
    FROM (SELECT  ORD.ORDER_ID, 
                ORD.ORDER_DATE,
                CUS.CUSTOMER_ID,
                CUS.FIRST_NAME,
                PROD.PRODUCT_ID,
                SUM(OP.QUANTITY * PROD.LIST_PRICE) TOTAL
            FROM CARLOSV.ORDERS ORD 
                INNER JOIN CARLOSV.ORDERS_PRODUCTS OP 
                    ON ORD.ORDER_ID = OP.ORDER_ID
                INNER JOIN CARLOSV.PRODUCTS PROD 
                    ON OP.PRODUCT_ID = PROD.PRODUCT_ID
                INNER JOIN CARLOSV.CUSTOMERS CUS 
                    ON ORD.CUSTOMER_ID = CUS.CUSTOMER_ID
                GROUP BY ORD.ORDER_ID, ORD.ORDER_DATE, CUS.CUSTOMER_ID, CUS.FIRST_NAME, PROD.PRODUCT_ID)
GROUP BY ORDER_ID, ORDER_DATE, CUSTOMER_ID, FIRST_NAME, PRODUCT_ID, TOTAL;

--4
SELECT  PRODUCT_ID, 
        LIST_PRICE
FROM CARLOSV.PRODUCTS 
WHERE LIST_PRICE > 100 
GROUP BY PRODUCT_ID, LIST_PRICE
ORDER BY LIST_PRICE DESC;

--5
SELECT  MAX(LIST_PRICE) MAXIMO ,
        AVG(LIST_PRICE) PROMEDIO
FROM CARLOSV.PRODUCTS;