SELECT P.*, I.P_IMGNAME
FROM PRODUCT P
LEFT JOIN PRODUCT_IMG I ON P.PRO_NUM = I.PRO_NUM;

UPDATE PRODUCT_CATEGORY  SET PRO_CATEGORY = '가전제품' WHERE PRO_CATEGORY_ID  = 4;

insert into PRODUCT_CATEGORY pc 

values (8,'중고몬 나눔');

SELECT * FROM PRODUCT p ;
update product set P_TITLE = '123',PRO_CATEGORY_ID = '1',P_STATE = '123213', P_EXCHANGE = '123123', P_PRICE = '12314', P_DFEE = '1', P_CONTENT = '11', P_CONTACT = '12321' where PRO_NUM = 7