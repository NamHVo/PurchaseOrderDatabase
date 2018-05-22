-- Nam Vo Short Ship Program --

spool c:/IS380/ShortShip.txt

set echo off
set heading off

prompt
prompt ****** SHORT SHIP Report ******
prompt

select 'Today''s date: ', sysdate from dual;
prompt

set heading on

select PO#, Status, PODate, ProductOrders.P#, Name, OrderQty, ShipQty, OrderQty - ShipQty ShortQty, SupplierNames.S#, SName
from ProductOrders, Products, SupplierNames
Where orderqty > Shipqty
and productOrders.P# = Products.P#
and SupplierNames.S# = ProductOrders.S#
order by PO# desc;

spool off
