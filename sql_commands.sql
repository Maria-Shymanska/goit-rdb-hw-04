SELECT
    categories.name AS category_name,
    customers.name AS customer_name,
    customers.contact AS customer_contact,
    customers.address AS customer_address,
    employees.first_name AS employee_first_name,
    employees.last_name AS employee_last_name,
    orders.date AS order_date,
    products.name AS product_name,
    order_details.quantity AS product_quantity,
    shippers.name AS shipper_name,
    suppliers.name AS supplier_name
FROM
    categories
INNER JOIN products ON categories.id = products.category_id
INNER JOIN order_details ON products.id = order_details.product_id
INNER JOIN orders ON order_details.order_id = orders.id
INNER JOIN customers ON orders.customer_id = customers.id
INNER JOIN employees ON orders.employee_id = employees.employee_id
INNER JOIN shippers ON orders.shipper_id = shippers.id
INNER JOIN suppliers ON products.supplier_id = suppliers.id;


-- count, total_rows 518
SELECT COUNT(*) AS total_rows
FROM
    categories
INNER JOIN products ON categories.id = products.category_id
INNER JOIN order_details ON products.id = order_details.product_id
INNER JOIN orders ON order_details.order_id = orders.id
INNER JOIN customers ON orders.customer_id = customers.id
INNER JOIN employees ON orders.employee_id = employees.employee_id
INNER JOIN shippers ON orders.shipper_id = shippers.id
INNER JOIN suppliers ON products.supplier_id = suppliers.id;

-- left
-- Заміна INNER JOIN на LEFT JOIN не змінює кількість рядків, тому що всі дані в таблицях пов'язані. 
-- LEFT JOIN впливає лише на відсутні відповідності, а якщо таких немає — результат не змінюється
SELECT COUNT(*) AS total_rows
FROM
    categories
LEFT JOIN products ON categories.id = products.category_id
LEFT JOIN order_details ON products.id = order_details.product_id
INNER JOIN orders ON order_details.order_id = orders.id
INNER JOIN customers ON orders.customer_id = customers.id
INNER JOIN employees ON orders.employee_id = employees.employee_id
INNER JOIN shippers ON orders.shipper_id = shippers.id
INNER JOIN suppliers ON products.supplier_id = suppliers.id;


-- Об'єднуємо всі таблиці через INNER JOIN.
-- Рахуємо загальну кількість рядків (COUNT(*)).
-- Фільтруємо employee_id > 3 AND ≤ 10.
-- Групуємо за категорією товару (GROUP BY).
-- Фільтруємо групи, де AVG(order_details.quantity) > 21.
-- Сортуємо за кількістю рядків у групі (ORDER BY COUNT(*) DESC).
-- Пропускаємо перший рядок і вибираємо наступні 4 (LIMIT 4 OFFSET 1).
SELECT 
    categories.name AS category_name,
    COUNT(*) AS row_count,
    AVG(order_details.quantity) AS avg_quantity
FROM 
    order_details
INNER JOIN orders ON order_details.order_id = orders.id
INNER JOIN employees ON orders.employee_id = employees.employee_id
INNER JOIN products ON order_details.product_id = products.id
INNER JOIN categories ON products.category_id = categories.id
WHERE 
    orders.employee_id > 3 AND orders.employee_id <= 10
GROUP BY 
    categories.name
HAVING 
    AVG(order_details.quantity) > 21
ORDER BY 
    row_count DESC
LIMIT 4 OFFSET 1;