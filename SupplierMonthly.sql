-- Nam Vo Supplier Monthly Program --

spool c:/IS380/SupplierMonthly.txt

set echo off
set heading on

prompt
prompt ****** SUPPLIER MONTHLY Report ******
prompt

select productorders.S# "Supplier Number", Sname "Supplier Name", to_char(PODate, 'mm/yyyy') "Order Month", count(PO#) "No Of Orders", sum(OrderQty) "Total Units", sum(OrderAmt) "Total Amount"
from ProductOrders, SupplierNames
Where ProductOrders.S# = SupplierNames.S#
group by ProductOrders.S#, to_char(PODate, 'mm/yyyy'), Sname
order by ProductOrders.S#, to_char(PODate, 'mm/yyyy');

spool off