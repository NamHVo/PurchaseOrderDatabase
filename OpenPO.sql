-- Nam Vo OpenPO Program --

spool C:\IS380\OpenPO.txt

set heading off
set feedback off
set echo off
set verify off

prompt
prompt **************OPEN ORDER**************
prompt
select 'Today''s Date: ',sysdate from dual;
Prompt
Accept vPnum prompt 'Please Enter the Item Number: ';

select 'Item Description: ', Name from Products
where P# = '&vPnum';

select 'Current Inventory Level: ', Inventory from Products
where P# = '&vPnum';

prompt

prompt Please select from one of the following Authorized Suppliers:

set heading on

select AuthorizedSellers.S#, SName, City, UnitPrice
From SupplierNames, AuthorizedSellers
Where P# = '&vPnum' and
AuthorizedSellers.S# = SupplierNames.S#;

prompt

set heading off

accept vSNum prompt 'Enter the Supplier Number: ';
Select 'Supplier Name: ', SName from SupplierNames
where S# = '&vSNum';

Select 'Address: ', Address from SupplierNames
where S# = '&vSNum';

Select 'City, State ZIP: ', City||', '||State ||' '||ZIP
from SupplierNames
where S# = '&vSNum';

Select 'Phone: ', '('||substr(Phone,1,3)||')'||substr(Phone,4,3)||'-'||substr(Phone,7,4)
from SupplierNames
where S# = '&vSNum';

prompt

accept vOrderQuantity prompt 'Enter Order Quantity: ';

Column UnitPrice heading 'Unit Price' format $999.99
Select 'Unit Price: ', UnitPrice from AuthorizedSellers
where S# = '&vSNum'
and P# = '&vPNum';

Column Total heading 'Total' format $999,999.99
Select 'Amount Ordered: ', UnitPrice*&vOrderQuantity Total
from AuthorizedSellers
where S# = '&vSNum'
and P# = '&vPNum';

prompt
prompt
prompt ****** Order Status: Open
select '******* Purchase Order Number Is --------->', MAXNUM 
from Counter;

insert into ProductOrders (PO#, P#, S#, PODate, UnitPrice, OrderQTY, OrderAMT, ShipDate, ShipQTY, ShipAMT, Status)
select MAXNUM, '&vPNum', '&VSNum', sysdate, UnitPrice, '&vOrderQuantity', UnitPrice*&vOrderQuantity, null, null, null, 'O'
from counter, AuthorizedSellers
where AuthorizedSellers.S# ='&vSNum' and AuthorizedSellers.P# = '&vPNum';

update counter set maxnum = maxnum + 1;

Commit;



spool off