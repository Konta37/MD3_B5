-- session 05 using stock_manager (accounts, bill, product,...)

-- show accounts who have more than 1 bill 
delimiter //
create procedure account_bill()
begin
select accounts.username, count(bill.acc_id) from bill
join accounts on accounts.id = bill.acc_id
group by accounts.username
having count(bill.acc_id)>1
order by count(bill.acc_id) desc
limit 1
;
end //
delimiter ;

-- show all product which havent bought
delimiter //
create procedure product_isNot_buy()
begin
select * from product
where product.id not in (select distinct bill_detail.product_id from bill_detail);
end //
delimiter ;

-- show top 2 products which have been bought the most
delimiter //
create procedure top_2_products_buy_the_most()
begin
select product.name, sum(bill_detail.quantity) from bill_detail
join product on product.id = bill_detail.product_id
group by product.name
order by sum(bill_detail.quantity) desc
limit 2
;
end //
delimiter ;

call top_2_products_buy_the_most();

-- create procedure to insert accounts
delimiter //
create procedure insert_account(in username1 varchar(100), password1 varchar(255), address1 varchar(255), status1 bit)
begin 
insert into accounts(username,password,address,status) values
(username1,password1,address1,status1);
end //
delimiter ;

call insert_account('konta','123','VN',1);
select * from accounts;


-- show every bill detail with id
delimiter //
create procedure show_bill_detail(in bill_id1 int)
begin
select * from bill_detail
where bill_detail.bill_id = bill_id1;
end //
delimiter ;

drop procedure show_bill_detail;

-- out the unknow details where bill detail id = id
delimiter //
CREATE PROCEDURE add_new_bill(
    IN p_bill_type BIT,
    IN p_acc_id INT,
    IN p_created DATETIME,
    IN p_auth_date DATETIME,
    OUT p_bill_id INT
)
BEGIN
    -- Insert a new bill into the bill table
    INSERT INTO bill (bill_type, acc_id, created, auth_date)
    VALUES (p_bill_type, p_acc_id, p_created, p_auth_date);
    
    -- Get the last inserted bill_id
    SET p_bill_id = LAST_INSERT_ID();
END //
delimiter ;

-- show every products which have been bought more than 5
delimiter //
create procedure show_products_more_than_st()
begin
select product.name, sum(bill_detail.quantity) from product
join bill_detail on bill_detail.product_id = product.id
group by product.name
having sum(bill_detail.quantity) > 5;
end //
delimiter ;

call show_products_more_than_st();