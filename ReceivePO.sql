-- Nam Vo Receive PO Program --

spool c:/IS380/ReceivePO.txt

set echo off
set verify off
set heading off
set feedback off

prompt
prompt ****** R E C E I V E    O R D E R ******
prompt
select 'Today''s date: ', sysdate from dual;
prompt
accept vPO prompt 'Please enter the Purchase Order Number: ';
prompt

select 'Order Number: ', PO#
from ProductOrders
where PO# = '&vPO';

select 'Item Number: ', P#
from ProductOrders
where PO# = '&vPO';

select '    Item Description: ', name
from ProductOrders, Products
where PO# = '&vPO'
and ProductOrders.P# = Products.P#;

select 'Supplier Number: ', S#
from ProductOrders
where PO# = '&vPO';

select '    Supplier Name: ', sname
from ProductOrders, SupplierNames
where PO# = '&vPO'
and ProductOrders.S# = Suppliernames.S#;

select 'Date ordered: ', PODate
from ProductOrders
where PO# = '&vPO';

select 'Today''s date: ', sysdate from dual;

select 'Quantity ordered: ', OrderQty
from ProductOrders
Where PO# = '&vPO';

select 'Unit Price: ', ProductOrders.UnitPrice
from ProductOrders
Where PO# = '&vPO'

select 'Amount Ordered: ', OrderAmt
from ProductOrders
Where PO# = '&vPO';

prompt

accept vShipQTY prompt 'Enter Quantity Received: ';

select 'Amount Due: ', '&vShipQty'*ProductOrders.UnitPrice
from AuthorizedSellers, ProductOrders
where PO# = '&vPO'
and AuthorizedSellers.P# = ProductOrders.P#
and AuthorizedSellers.S# = ProductOrders.S#
and AuthorizedSellers.UnitPrice = ProductOrders.UnitPrice;

select 'Inventory Level: ', '&vShipQTY' + Inventory
from products, productorders
where PO# = '&vPO'
and productorders.p# = products.p#;

update productOrders
set shipqty = '&vShipQty',
shipamt = '&vShipQty' * UnitPrice,
Status = 'C',
ShipDate = (select sysdate from dual)
where PO# = '&vPO';

update Products
set inventory = inventory + '&vShipQty'
where P# = (select P#
	from ProductOrders
	where PO# = '&vPO');

prompt
prompt *********************************
prompt Order is now ---> Closed
select 'Date closed: ', sysdate from dual;

commit;

spool off