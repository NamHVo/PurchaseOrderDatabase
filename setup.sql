-- Nam Vo Revised First Project Deliverable --

set echo on
spool c:/IS380/setup.txt

drop table Counter;
drop table ProductOrders;
drop table AuthorizedSellers;
drop table SupplierNames;
drop table Products;

create table Products(
P# varchar2 (5),
Name varchar2 (15),
Inventory number (5),
primary key(P#));

create table SupplierNames(
S# varchar2(5),
SName varchar2(15),
Address varchar2(15),
City varchar2(15),
State varchar2(5),
ZIP varchar2(10),
Phone varchar2(15),
primary key(S#));

create table AuthorizedSellers(
P# varchar2 (5),
S# varchar2 (5),
UnitPrice number (10,2),
primary key (P#,S#),
constraint fkas1 foreign key (P#) references Products(P#),
constraint fkas2 foreign key (S#) references SupplierNames(S#));

create table ProductOrders(
PO# varchar2 (5),
P# varchar2 (5),
S# varchar2 (5),
PODate date,
UnitPrice number (10,2),
OrderQTY number (10),
OrderAMT number (10,2),
ShipDate date,
ShipQTY number (10),
ShipAMT number (10,2),
Status varchar (2),
primary key (PO#),
constraint fkpo1 foreign key (P#) references Products(P#),
constraint fkpo2 foreign key (S#) references SupplierNames(S#));

create table Counter(
MAXNUM number (5));

insert into Counter values (1000);

Insert into Products values ('101', 'Pen', 201);
Insert into Products values ('102', 'Eraser', 86);
Insert into Products values ('103', 'Pencil', 319);
Insert into Products values ('104', 'Marker', 9);
Insert into Products values ('105', 'Notebook', 131);

select * from Products;


Insert into SupplierNames values ('10', 'OfficeMax', '123 ABC St', 'Glendale', 'CA', '91829', '1232132213');
Insert into SupplierNames values ('11', 'OfficeDepot', '125 ABC St', 'Long Beach', 'CA', '93429', '1231532213');
Insert into SupplierNames values ('12', 'Office', '126 ABC St', 'Anaheim', 'CA', '95223', '1232213218');
Insert into SupplierNames values ('13', 'Staples', '127 ABC St', 'Lakewood', 'CA', '98365', '7382212738');
Insert into SupplierNames values ('14', 'Gears', '128 ABC St', 'Santa Ana', 'CA', '91439', '4367212654');

select * from SupplierNames;

Insert into AuthorizedSellers values ('101', '10', 10.50);
Insert into AuthorizedSellers values ('102', '10', 11.50);
Insert into AuthorizedSellers values ('101', '13', 6.75);
Insert into AuthorizedSellers values ('103', '14', 2.20);
Insert into AuthorizedSellers values ('104', '14', 6.75);
Insert into AuthorizedSellers values ('104', '11', 3.50);
Insert into AuthorizedSellers values ('104', '12', 4.50);
Insert into AuthorizedSellers values ('105', '11', 1.25);
Insert into AuthorizedSellers values ('105', '13', 5.75);


select * from AuthorizedSellers;

Insert into ProductOrders values ('995', '101', '10', '16-APR-18', 12.50, 2, 25.00, '17-APR-18', 2, 25.00, 'C');
Insert into ProductOrders values ('996', '102', '11', '17-APR-18', 12.50, 2, 25.00, null, null, null, 'O');
Insert into ProductOrders values ('997', '103', '12', '18-APR-18', 12.50, 2, 25.00, null, null, null, 'O');
Insert into ProductOrders values ('998', '104', '13', '19-APR-18', 2.25, 2, 4.50, '20-APR-18', 2, 4.50, 'C');
Insert into ProductOrders values ('999', '105', '14', '21-APR-18', 1.50, 2, 3.00, '22-APR-18', 2, 3.00, 'C');

select * from ProductOrders;

Commit;

spool off