-- Nam Vo QueryPO Program --

spool c:/IS380/QueryPO.txt

set heading off
set feedback off
set echo off
set verify off

prompt
prompt ******** Q U E R Y   O R D E R********
prompt
accept vPO prompt 'Please enter the Purchase Order Number: ';
prompt

select 'Purchase Order Number: ', PO#
from ProductOrders
where PO# = '&vPO';

Select 'Item Number: ', P#
from ProductOrders
where PO# = '&vPO';

Select 'Item Description: ', Name
from Products, ProductOrders
where PO# = '&vPO'
and Products.P# = ProductOrders.P#;

Select 'Current Inventory Level: ', Inventory
from Products, ProductOrders
where PO# = '&vPO'
and Products.P# = ProductOrders.P#;

Select 'Supplier Number: ', S#
from ProductOrders
Where PO# = '&vPO';

prompt

Select 'Date Ordered: ', PODate
from ProductOrders
Where PO# = '&vPO';

Select 'Quantity Ordered: ', OrderQTY
from ProductOrders
Where PO# = '&vPO';

Select 'Date Received: ', ShipDate
from ProductOrders
Where PO# = '&vPO';

Select 'Quantity Received: ', ShipQTY
from ProductOrders
where PO# = '&vPO';

Select 'Unit Price: ', UnitPrice
from ProductOrders
where PO# = '&vPO';

Column Total format $999,999.99
select 'Amount Ordered: ',UnitPrice*&vOrderQuantity Total
from ProductOrders
where PO# = '&vPO';

Column ShipAMT format $999,999.99
Select 'Amount Due: ', ShipAMT
from ProductOrders
where PO# ='&vPO';

prompt

Select 'Order Status: ', Status
from ProductOrders
where PO# = '&vPO';

spool off
