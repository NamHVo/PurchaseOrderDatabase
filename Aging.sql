-- Nam Vo Aging Program --

spool c:/IS380/aging.txt

set echo off
set heading off

prompt
prompt ******* PURCHASE ORDER AGING REPORT ******
prompt

select 'Today''s date: ', sysdate from dual;

prompt

accept vDaysQuery prompt 'Please enter number of days to query: ';

set heading on

prompt

select PO#, status, PODate, ProductOrders.P#, Name, OrderQty, ProductOrders.UnitPrice, OrderAMT, ProductOrders.S#, SName, trunc(sysdate) - trunc(PODate) DaysOpen
from productorders, products, suppliernames
where '&vDaysQuery' <= trunc(sysdate) - trunc(PODate)
and ProductOrders.P# = Products.P#
and ProductOrders.S# = SupplierNames.S#
order by trunc(sysdate) - trunc(PODate) desc;

prompt

spool off