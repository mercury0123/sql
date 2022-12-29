SELECT * FROM example.buy;
-- buy 테이블에 값이 생성되면 product 테이블에 amount, sale_amount가 변동 되는 트리거 만들기
/*실행구문영역*/
/* new : buy 테이블에 insert 되는 값*/
/* old : 수정시 원래있던(수정전) 데이터 값 */
drop trigger if exists insert_buy; /*초기화*/

delimiter //
create trigger insert_buy after insert on buy 
for each row
begin
declare _amount int default 0;
set _amount = new.amount;
update product set amount = amount - _amount,
sale_amount = sale_amount + _amount
where name = new.product_name;
end//
delimiter ;   -- 꼭 ;붙여줘야함
select * from product;
insert into buy(customer,product_name,price,amount)
values('hong','에어나시',9000,5);
