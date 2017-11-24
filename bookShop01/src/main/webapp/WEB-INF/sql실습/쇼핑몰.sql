               
select * from T_GOODS_INFO;
select * from T_GOODS_DETAIL_IMAGE;
select * from t_shoping_member;
select * from t_shoping_cart; 
select * from t_shoping_order; 

--키워드 저장 테이블 생성
create table t_shoping_keyword(
    kCode varchar2(30) primary key,
    kName varchar2(40),
    kRegDate date,
    goods_id varchar2(30)
);

desc t_shoping_keyword;

select * from t_shoping_keyword;

select g.*,i.FILENAME as goods_fileName from t_goods_info g, t_shoping_keyword k, t_goods_detail_image i
                where g.goods_id=i.goods_id
                and g.goods_id=k.goods_id
                and k.kName='초보';
                
--입문 단어가 들어가는 모든 키워드를 출력하라.
--입문자, 입문서...
--%입문%
select * from t_shoping_keyword;
select * from t_shoping_keyword
    where kName like '%자바%';
    
delete from t_shoping_cart
    where cart_id=23;
    select * from t_shoping_cart;
    
--비로그인 시 장바구니와 로그인 시 장바구니 동기화 프로시저
--create or replace
--package bookshop_cart as
--    type cursorType is ref cursor;
--    type arr_goods_id is table of varchar2(50);
--    
--    procedure proc_addCartFromCookie(
--        pi_list_cookie in arr_goods_id,
--        po_cursor out cursorType);
--end bookshop_cart;

-- 프로시저 생성
--CREATE OR REPLACE PROCEDURE bookshop_cart.proc_addCartFromCookie
--(
-- pi_list_cookie in arr_goods_id,
-- po_cursor out cursorType
--)
--AS
--I BINARY_INTEGER;
--BEGIN
--   FOR I IN 1 .. pi_list_cookie.COUNT
--   LOOP
--      UPDATE TPC020
--         SET MOD_EMP = 'ARRARY',
--         ENT_EMP = b_arr(I)
--       WHERE EMP_NO = a_arr(I);
--      DBMS_OUTPUT.PUT_LINE(A_ARR(I));
--   END LOOP;
--   --COMMIT;
--END;
--
--CREATE OR REPLACE PROCEDURE bookshop_cart.proc_addCartFromCookie
--(
-- pi_list_cookie in arr_goods_id,
-- po_cursor out cursorType
--)
--AS
--I BINARY_INTEGER;
--BEGIN
--   FOR I IN 1 .. pi_list_cookie.COUNT
--   LOOP
--      
--      DBMS_OUTPUT.PUT_LINE(A_ARR(I));
--   END LOOP;
--   --COMMIT;
--END;
drop table t_shoping_reco;
create table t_shoping_reco(
    reco_id number(10) primary key,
    user_review_point number(10),
    goods_hit_point number(10),
    expert_eval_point number(10),
    sales_index number(10),
    reco_goods_id varchar2(10),
    regDate date,
    member_id varchar2(10),
    goods_id varchar2(10)
);
desc t_shoping_reco;
insert into t_shoping_reco(reco_id,
                            user_review_point,
                            goods_hit_point,
                            expert_eval_point,
                            sales_index,
                            reco_goods_id,
                            regDate,
                            member_id,
                            goods_id)
                    values(seq_reco_id.nextval,
                            1000,
                            1000,
                            1000,
                            1000,
                            '301',
                            sysdate,
                            'hong',
                            '350');
insert into t_shoping_reco(reco_id,
                            user_review_point,
                            goods_hit_point,
                            expert_eval_point,
                            sales_index,
                            reco_goods_id,
                            regDate,
                            member_id,
                            goods_id)
                    values(seq_reco_id.nextval,
                            1000,
                            1000,
                            1000,
                            1000,
                            '340',
                            sysdate,
                            'hong',
                            '350');
commit;

select g.*,d.fileName from t_goods_info g, t_goods_detail_image d
			        where g.goods_id=d.goods_id
			        and d.filetype='main_image'
                    and g.goods_id in(select reco_goods_id from t_shoping_reco
                                        where goods_id=350)
			        order by g.goods_creDate desc;

select reco_goods_id from t_shoping_reco
    where goods_id=350;
    
select * from t_shoping_reco
    where goods_id in (select goods_id 
                        from t_shoping_reco
                         where goods_id='350');
    
select * from t_shoping_reco;    
    desc t_shoping_reco;
        
        
        select g.*,d.fileName from t_goods_info g, t_goods_detail_image d
			        where g.goods_id=d.goods_id
			        and d.filetype='main_image'
                    and g.goods_id in(select reco_goods_id from t_shoping_reco
                                        where goods_id='350')
			        order by g.goods_creDate desc;
