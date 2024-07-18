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