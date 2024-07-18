-- session 05

-- create view from customer
create view customer_view as
select * from customer;

-- show customer_view
select * from customer_view;

-- create view to show all orders which have order_total>150
create or replace view order_view as
select * from order_table
where order_table.o_total_price > 150000;

select * from order_view;

-- Index on cName column in customer table
CREATE INDEX idx_customer_cname ON customer(c_name);

-- Index on pName column in product table
CREATE INDEX idx_product_pname ON product(p_name);

-- Procedure to display the order with the lowest total price
DELIMITER //
CREATE PROCEDURE sp_lowest_total_price_order()
BEGIN
    SELECT * FROM order_table
    ORDER BY o_total_price ASC
    LIMIT 3;
END //
DELIMITER ;

call sp_lowest_total_price_order();

-- procedure to display the customers who buy 'may giat'
Delimiter //
create procedure customers_buy_maygiat()
begin 

select customer.c_name, product.p_name,  sum(order_detail.od_quantity) from order_detail
join product on product.p_id = order_detail.p_id
join order_table on order_table.o_id = order_detail.o_id
join customer on customer.c_id = order_table.c_id
where product.p_name = 'Máy giặt'
group by customer.c_name
order by sum(order_detail.od_quantity) asc
limit 1
;

end //
delimiter ;
drop procedure customers_buy_maygiat;
call customers_buy_maygiat();