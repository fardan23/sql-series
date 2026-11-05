/* terminal syntax / psql:
 * psql
 * psql --help
 * psql --username=postgres
 * exit
 * 
 * menggunakan postgresql client: 
 * psql --host=localhost --port=5432 --dbname=postgres --username=postgres --password
 * 
 * melihat semua database di postgresql: \l
 * 
 * menggunakan database (pindah database): \c nama_database
 * 
 * melihat semua table dan sequence: \d
 * 
 * melihat semua table: \dt
 * 
 * melihat struktur table: \d nama_tabel 
 *
 * melihat semua sequence: \ds
 * 
 * melihat struktur sequence: \d nama_sequence
 * 
 * melakukan backup database:
 * pg_dump --host=localhost --port=5432 --dbname=belajar --username=postgres --format=plain --file=/Users/MFard/backup.sql
 * 
 * melihat backup file: cat \Users\MFard\backup.sql
 * 
 * restore database: psql --host=localhost --port=5432 --dbname=belajar_restore --username=postgres --file=/Users/MFard/backup.sql
 */

/* docs:
 * postgresql client = dbeaver, pgadmin, jetbrains datagrip
 * https://www.postgresql.org/download/
 * https://www.postgresql.org/docs/current/datatype.html
 * https://www.postgresql.org/docs/15/functions-math.html
 * https://www.postgresql.org/docs/15/functions-string.html 
 * https://www.postgresql.org/docs/15/functions-datetime.html 
 * https://www.postgresql.org/docs/current/functions-conditional.html 
 * https://www.postgresql.org/docs/current/functions-aggregate.html 
 * https://www.postgresql.org/docs/current/textsearch-intro.html 
 * https://www.postgresql.org/docs/current/sql-createrole.html 
 * https://www.postgresql.org/docs/current/sql-alterrole.html
 * https://www.postgresql.org/docs/current/sql-grant.html 
 * https://www.postgresql.org/docs/current/sql-revoke.html 
 * https://www.postgresql.org/docs/current/app-pgdump.html 
 */

-- postgresql client syntax:
-- melihat semua database di postgresql
select datname from pg_database;

-- membuat database
create database nama_database;

-- menghapus database
drop database nama_database;

-- database belajar
create database belajar;

-- melihat table
select * from pg_tables where schemaname='public';

-- membuat table
create table barang(
	kode int not null,
	name varchar(100) not null,
	harga int not null default 1000,
	jumlah int not null default 0,
	waktu_dibuat TIMESTAMP not null default current_timestamp
);

-- melihat struktur table: pakai ui di dbeaver

-- mengubah table
alter table barang 
add column deskripsi text;

alter table barang 
drop column deskripsi;

alter table barang 
rename column name to nama;

-- membuat ulang table
truncate barang;

-- menghapus table
drop table barang;

-- membuat tabel produk
create table products
(
	id varchar(10) not null,
	name varchar(100) not null,
	description text,
	price int not null,
	quantity int not null default 0,
	created_at timestamp not null default current_timestamp,
	primary key(id)
);

-- memasukkan data
insert into products(id, name, price, quantity)
values ('P0001', 'Ketoprak', 15000, 100);

insert into products(id, name, description, price, quantity)
values ('P0002', 'Nasi Padang', 'Nasi, sayur, ayam, kuah gulai, dan sambal', 16000, 100);

insert into products(id, name, description, price, quantity)
values
('P0003', 'Soto Ayam', 'Nasi, suwiran ayam, bihun, telur, dan kuah soto', 18000, 80),
('P0004', 'Mie Goreng', 'Mie goreng dengan telur, sayuran, dan ayam', 15000, 90),
('P0005', 'Ayam Geprek', 'Nasi, ayam goreng tepung, sambal, dan lalapan', 20000, 75);

-- mengambil data
select * from products;

select id, name, price, quantity from products;

-- menambah primary key di tabel
alter table products
add primary key(id)

-- mencari data
select id, name, price, quantity
from products
where quantity = 0;

select id, name, price, quantity
from products
where price = 20000;

select id, name, price, quantity
from products
where id = 'P0004';

-- menambah kolom kategori
create type product_category as enum ('Makanan', 'Minuman', 'Lain-lain');

alter table products 
add column category product_category;

-- mengubah satu kolom
select * from products;

update products 
set category = 'Makanan' 
where id = 'P0001';

update products 
set category = 'Makanan' 
where id = 'P0002';

update products 
set category = 'Makanan' 
where id = 'P0003';

update products 
set category = 'Makanan' 
where id = 'P0004';

update products 
set category = 'Makanan' 
where id = 'P0005';

-- mengubah beberapa kolom
update products 
set category = 'Makanan',
	name = 'Ayam Geprek'
where id = 'P0005';

-- mengubah dengan value di kolom
select * from products;

update products
set price = price + 2000
where id = 'P0005';

-- menghapus data
select * from products;

insert into products(id, name, description, price, quantity, category)
values
('P0006', 'Es Teh Manis', 'Teh manis dan es batu', 5000, 100, 'Minuman');

delete from products where id = 'P0006';

-- alias untuk kolom
select id, price, description from products;

select id as Kode, price as Harga, description as Deskripsi from products;

select id as "Kode Barang", price as "Harga Barang", description as "Deskripsi Barang" from products;

select 
	p.id as Kode,
	p.price as Harga,
	p.description as Deskripsi
from products as p;

-- mencari data dengan operator perbandingan
select * from products where price > 15000;

select * from products where price < 15000;

select * from products where price <= 15000;

select * from products where category != 'Makanan';

select * from products where category != 'Minuman';

-- mencari data dengan operator and
select * from products;

insert into products(id, name, description, price, quantity, category)
values
('P0006', 'Es Teh Manis', 'Teh manis dan es batu', 5000, 100, 'Minuman'),
('P0007', 'Es Jeruk', 'Jus jeruk dan es batu', 8000, 80, 'Minuman'),
('P0008', 'Kopi Hitam', 'Kopi hitam dan gula', 7000, 60, 'Minuman'),
('P0009', 'Kerupuk', 'Kerupuk renyah', 3000, 150, 'Lain-lain'),
('P0010', 'Keripik Singkong', 'Keripik singkong gurih dan renyah', 10000, 50, 'Lain-lain');

select * from products where price > 15000 and category = 'Makanan';

select * from products where price < 15000 and category = 'Minuman';

-- mencari data dengan operator or
select * from products where price > 15000 or category = 'Makanan';

-- prioritas dengan kurung ()
select * from products
where (quantity > 100 or category = 'Makanan') and price > 15000;

select * from products
where category = 'Makanan' or (quantity > 100 and price > 15000);

-- mencari menggunakan like operator
select * from products where name ilike '%mie%';

select * from products where name ilike '%es%';

select * from products where name like '%mie%';

select * from products where name like '%es%';

-- mencari menggunakan null operator
select * from products where description is null;

select * from products where description is not null;

-- mencari menggunakan between operator
select * from products where price between 10000 and 20000;

select * from products where price not between 10000 and 20000;

-- mencari menggunakan in operator
select * from products where category in ('Makanan', 'Minuman');

select * from products where category in ('Makanan');

-- mengurutkan data
select * from products order by price asc;

select * from products order by price asc, id desc;

-- membatasi hasil query
select * from products 
where price > 0 
order by price asc;

select * from products 
where price > 0 
order by price asc, id desc limit 2;

-- skip hasil query
select * from products
where price > 0
order by price asc
limit 2 offset 2;

-- menghilangkan data duplikat
select category from products;

select distinct category from products; 

-- menggunakan arithmetic operator
select 10 + 10 as hasil;

select id, price from products;

select id, price / 1000 as price_in_k from products;

-- menggunakan mathematical function
select pi();

select power(10, 2);

select cos(10), sin(10), tan(10);

select id, name, power(quantity, 2) as quantity_power_2 from products;

-- membuat tabel dengan auto increment / default serial: integer
create table admin(
	id serial not null,
	first_name varchar(100) not null,
	last_name varchar(100),
	primary key(id)
);

-- memasukkan data tanpa id
insert into admin(first_name, last_name)
values 
	('Muhamad', 'Fardan'),
	('Enami', 'Asa'),
	('Lee', 'Dain');

select * from admin;

-- melihat id terakhir
select currval(pg_get_serial_sequence('admin', 'id'));

select currval('admin_id_seq');

-- membuat sequence / default sequence: bigint
create sequence contoh_sequence;

-- memanggil sequence, otomatis increment
select nextval('contoh_sequence');

-- mengambil nilai terakhir sequence
select currval('contoh_sequence');

-- sequence dari serial
create sequence admin_id_seq;

create table admin(
	id int not null default nextval('admin_id_seq'),
	first_name varchar(100),
	last_name varchar(100),
	primary key(id)
);

-- menggunakan string function
select id, LOWER(name), length(name), LOWER(description) from products;

-- menggunakan date dan time function untuk menambah kolom timestamp 
select * from products;

select id, extract(year from created_at), extract(month from created_at) from products;

-- menggunakan control flow case
select id,
	case category
		when 'Makanan' then 'Enak'
		when 'Minuman' then 'Seger'
		else 'Apa itu?'
	end as category_case
from products;

-- menggunakan operator
select id,
	price,
	case
		when price <= 15000 then 'Murah'
		when price <= 20000 then 'Mahal'
		else 'Mahal banget'
	end as "apakah murah?"
from products;

-- menggunakan control flow check null
select id,
	name,
	case 
		when description is null then 'Kosong'
		else description
	end as description
from products;
	
-- menggunakan aggregate function
select COUNT(id) as "Total Product" from products;

select AVG(price) as "Rata-Rata Harga" from products;

select MAX(price) as "Harga Termahal" from products;

select MIN(price) as "Harga Termurah" from products;

-- menggunakan group by
select category, count(id) as "Total Product"
from products
group by category;

select category, 
	avg(price) as "Rata-Rata Harga", 
	min(price) as "Harga Termurah",
	max(price) as "Harga Termahal"
from products
group by category;

-- menggunakan having clause
select category, count(id) as total
from products
group by category
having count(id) > 3;

select category, 
	avg(price) as "Rata-Rata Harga", 
	min(price) as "Harga Termurah",
	max(price) as "Harga Termahal"
from products
group by category
having avg(price) >= 15000;

-- membuat table dengan unique constraint
create table customer(
	id serial not null,
	email varchar(100) not null,
	first_name varchar(100) not null,
	last_name varchar(100),
	primary key(id),
	constraint unique_email unique(email)
);

select * from customer;

insert into customer(email, first_name, last_name)
values ('fardan@gmail.com', 'Muhamad', 'Fardan');

insert into customer(email, first_name, last_name)
values 
	('asa@gmail.com', 'Enami', 'Asa'),
	('rora@gmail.com', 'Lee', 'Dain'),
	('ahyeon@gmail.com', 'Jung', 'Ahyeon');

-- menambah/menghapus unique constraint
alter table customer
drop constraint unique_email;

alter table customer
add constraint unique_email unique(email);

-- membuat table dengan check constraint
create table products
(
	id varchar(10) not null,
	name varchar(100) not null,
	description text,
	price int not null,
	quantity int not null default 0,
	created_at timestamp not null default current_timestamp,
	primary key(id),
	constraint price_check check(price >= 1000)
);

-- menambah/menghapus check constraint
alter table products
add constraint price_check check(price > 1000);

alter table products
add constraint quantity_check check(quantity >= 0);

alter table products 
drop constraint price_check;

select * from products;

-- membuat table sellers
create table sellers(
	id serial not null,
	name varchar(100) not null,
	email varchar(100) not null,
	primary key(id),
	constraint email_unique unique(email)
);

insert into sellers(name, email)
values
	('Galeri KPOP', 'kpop@galeri.com'),
	('Toko Fardan', 'fardan@toko.com'),
	('Toko Adan', 'adan@toko.com'),
	('Toko MuhFar', 'muhfar@toko.com');

select * from sellers;

select * from sellers where id = 1;

select * from sellers where email = 'adan@toko.com';

select * from sellers where id = 1 or name = 'Toko Fardan';

select * from sellers where email = 'adan@toko.com' or name = 'Toko Fardan';

-- menambah/menghapus index
create index sellers_id_and_name_index on sellers(id, name); 

create index sellers_email_and_name_index on sellers(email, name);

create index sellers_name_index on sellers(name);

drop index sellers_name_index;

select * from sellers where name = 'Toko Fardan';

-- mencari tanpa index
select * from products where name ilike '%mie%'; -- versi ilike

select * from products where to_tsvector(name) @@ to_tsquery('mie');

-- membuat index full-text search
select cfgname from pg_ts_config;

create index products_name_search on products using gin (to_tsvector('indonesian', name));

create index products_description_search on products using gin (to_tsvector('indonesian', description));

drop index products_name_search;

drop index products_description_search;

-- mencari menggunakan full-text search
select * from products where name @@ to_tsquery('mie');

select * from products where description @@ to_tsquery('mie');

-- mencari dengan operator
select * from products where name @@ to_tsquery('mie & goreng');

select * from products where name @@ to_tsquery('mie | ayam');

select * from products where name @@ to_tsquery('!ayam');

select * from products where name @@ to_tsquery('''mie goreng''');

select * from products where name @@ to_tsquery('''es jeruk''');

-- membuat table dengan foreign key / default foreign key = restrict (ON DELETE ditolak dan ON UPDATE ditolak)
create table wishlist(
	id serial not null,
	id_product varchar(10) not null,
	description text,
	primary key(id),
	constraint fk_wishlist_product foreign key(id_product) references products(id)
);

-- menambah/menghapus foreign key
alter table wishlist
drop constraint fk_wishlist_product;

alter table wishlist
add constraint fk_wishlist_product foreign key(id_product) references products(id);

insert into wishlist (id_product, description)
values 
	('P0001', 'Mie ayam kesukaan'),
	('P0002', 'Mie ayam kesukaan'),
	('P0005', 'Mie ayam kesukaan');

select * from wishlist;

-- mengubah behavior menghapus relasi
alter table wishlist
add constraint fk_wishlist_product foreign key(id_product) references products (id)
on delete cascade on update cascade; 

insert into products (id, name, price, quantity, category)
values ('XXX', 'Xxx', 10000, 100, 'Minuman');

select * from products;

insert into wishlist(id_product, description)
values ('XXX', 'Contoh');

select * from wishlist;

delete from products where id = 'XXX';

-- melakukan join table
select * from wishlist join products on products.id = wishlist.id_product;

select products.id, products.name, wishlist.description from wishlist join products on products.id = wishlist.id_product;

select p.id, p.name, w.description from wishlist as w join products as p on p.id = w.id_product;

-- membuat relasi ke table customers
alter table wishlist
add column id_customer int;

alter table wishlist 
add constraint fk_wishlist_customer foreign key(id_customer) references customer(id);

update wishlist set id_customer = 1 where id in (2, 3);

update wishlist set id_customer = 3 where id = 4;

select * from customer;

select * from wishlist;

-- melakukan join multiple table
select c.email, p.id, p.name, w.description
from wishlist as w
	join products as p on w.id_product = p.id 
	join customer as c on w.id_customer = c.id;

-- one to one relationship
-- membuat table wallet
create table wallet(
	id serial not null,
	id_customer int not null,
	balance int not null default 0,
	primary key(id),
	constraint wallet_customer_unique unique(id_customer),
	constraint fk_wallet_customer foreign key(id_customer) references customer(id)
);

select * from customer;

insert into wallet (id_customer, balance)
values
	(1, 1000000),
	(3, 2000000),
	(4, 3000000),
	(5, 4000000);

select * from wallet;

select * from customer join wallet on wallet.id_customer = customer.id;

-- one to many relationship
-- membuat table category
create table categories(
	id varchar(10) not null,
	name varchar(100) not null,
	primary key(id)
);

insert into categories(id, name)
values
	('C0001', 'Makanan'),
	('C0002', 'Minuman');

select * from categories;

-- mengubah tabel product
alter table products 
add column id_category varchar(10);

alter table products
drop column id_category;

alter table products
add constraint fk_product_category foreign key (id_category) references categories(id);

select * from products;

update products set id_category = 'C0001' where category = 'Makanan';

update products set id_category = 'C0002' where category = 'Minuman';

alter table products
drop column category;

select * from products join categories on products.id_category = categories.id;

-- many to many relationship
-- membuat table order
create table orders(
	id serial not null,
	total int not null,
	order_date timestamp not null default current_timestamp,
	primary key(id)
);

-- membuat table order detail
create table orders_detail(
	id_product varchar(10) not null,
	id_order int not null,
	price int not null,
	quantity int not null,
	primary key(id_product, id_order)
);

-- membuat foreign key
alter table orders_detail
add constraint fk_orders_detail_product foreign key(id_product) references products(id);

alter table orders_detail
add constraint fk_orders_detail_order foreign key(id_order) references orders(id);

insert into orders(total)
values
	(1),
	(1),
	(1);

select * from orders;

insert into orders_detail(id_product, id_order, price, quantity)
values
	('P0001', 1, 1000, 2),
	('P0002', 1, 1000, 2),
	('P0003', 1, 1000, 2);

insert into orders_detail(id_product, id_order, price, quantity)
values
	('P0004', 2, 1000, 2),
	('P0006', 2, 1000, 2),
	('P0007', 2, 1000, 2);

insert into orders_detail(id_product, id_order, price, quantity)
values
	('P0001', 3, 1000, 2),
	('P0004', 3, 1000, 2),
	('P0005', 3, 1000, 2);

select * from orders_detail;

-- melihat data order, detail, product
select * from orders_detail
	join orders on orders_detail.id_order = orders.id
	join products on orders_detail.id_product = products.id;

select * from orders
	join orders_detail on orders_detail.id_order = orders.id
	join products on orders_detail.id_product = products.id;

select * from orders
	join orders_detail on orders_detail.id_order = orders.id
	join products on orders_detail.id_product = products.id
where orders.id = 1;

select * from orders
	join orders_detail on orders_detail.id_order = orders.id
	join products on orders_detail.id_product = products.id
where orders.id = 2;

select * from orders
	join orders_detail on orders_detail.id_order = orders.id
	join products on orders_detail.id_product = products.id
where orders.id = 3;

/* jenis-jenis join:
 * inner join = irisan / default join table
 * left join = irisan / semua data di tabel pertama diambil dan data irisan, kalo gak ada datanya maka null
 * right join = irisan / semua data di tabel kedua diambil dan data irisan, kalo gak ada datanya maka null
 * full join = gabungan / semua data di tabel pertama dan kedua diambil, kalo gak ada datanya maka null
 */

insert into categories(id, name)
values
	('C0003', 'Gadget'),
	('C0004', 'Laptop'),
	('C0005', 'Pulsa');

select * from categories;

select * from products;

insert into products(id, name, price, quantity)
values
	('X0001', 'Contoh 1', 10000, 1000),
	('X0002', 'Contoh 2', 10000, 1000);

-- melakukan inner join
select * from categories
inner join products on products.id_category = categories.id;

-- melakukan left join
select * from categories
left join products on products.id_category = categories.id;

-- melakukan right join
select * from categories
right join products on products.id_category = categories.id;

-- melakukan full join
select * from categories
full join products on products.id_category = categories.id;

-- melakukan subquery di where clause
select AVG(price) from products;

select * from products where price > (select AVG(price) from products);

-- melakukan subquery di from clause
select * from products;

select products.price as price
from categories join products on products.id_category = categories.id;

select max(price) from (select products.price as price
from categories join products on products.id_category = categories.id) as contoh;

/* set operator:
 * union: gabungan, hapus duplikasi
 * union all: gabungan, data duplikasi tetap ditampilkan
 * intersect: irisan
 * except: pengurangan (A-B / B-A)
 */

-- membuat table guest book
create table guestbooks(
	id serial not null,
	email varchar(100) not null,
	title varchar(100) not null,
	content text,
	primary key(id)
);

select * from customer;

insert into guestbooks(email, title, content)
values 
	('fardan@gmail.com', 'feedback fardan', 'ini feedback fardan'),
	('asa@gmail.com', 'feedback asa', 'ini feedback asa'),
	('rora@gmail.com', 'feedback rora', 'ini feedback rora'),
	('ahyeon@gmail.com', 'feedback ahyeon', 'ini feedback ahyeon'),
	('chiquita@gmail.com', 'feedback chiquita', 'ini feedback chiquita'),
	('pharita@gmail.com', 'feedback pharita', 'ini feedback pharita'),
	('rami@gmail.com', 'feedback rami', 'ini feedback rami'),
	('ruka@gmail.com', 'feedback ruka', 'ini feedback ruka');

select * from guestbooks;

select distinct email from customer;

select distinct email from guestbooks;

select distinct email from customer
union
select distinct email from guestbooks;

select distinct email from customer
union all
select distinct email from guestbooks;

select email from customer
union all
select email from guestbooks;

select email, count(email)
from (select email from customer union all select email from guestbooks) as contoh 
group by email;

select distinct email from customer
intersect
select distinct email from guestbooks

select distinct email from customer
except
select distinct email from guestbooks;

select distinct email from guestbooks
except
select distinct email from customer;

-- transaction
-- percobaan pertama
start transaction;

insert into guestbooks(email, title, content)
values 
	('transaction@gmail.com', 'transaction', 'transaction');

insert into guestbooks(email, title, content)
values 
	('transaction@gmail.com', 'transaction', 'transaction 2');

insert into guestbooks(email, title, content)
values 
	('transaction@gmail.com', 'transaction', 'transaction 3');

insert into guestbooks(email, title, content)
values 
	('transaction@gmail.com', 'transaction', 'transaction 4');

insert into guestbooks(email, title, content)
values 
	('transaction@gmail.com', 'transaction', 'transaction 5');

select * from guestbooks;

commit;

-- percobaan kedua 
start transaction;

insert into guestbooks(email, title, content)
values 
	('transaction@gmail.com', 'transaction', 'rollback');

insert into guestbooks(email, title, content)
values 
	('transaction@gmail.com', 'transaction', 'rollback 2');

insert into guestbooks(email, title, content)
values 
	('transaction@gmail.com', 'transaction', 'rollback 3');

insert into guestbooks(email, title, content)
values 
	('transaction@gmail.com', 'transaction', 'rollback 4');

insert into guestbooks(email, title, content)
values 
	('transaction@gmail.com', 'transaction', 'rollback 5');

select * from guestbooks;

rollback;

-- locking record otomatis (sejak update)
start transaction;

select * from products;

update products set description = 'Ketoprak asli wenakkk' where id = 'P0001';

select * from products where id = 'P0001';

commit;

-- locking record manual (sejak select)
start transaction;

select * from products where id = 'P0001' for update;

rollback;

select * from products where id = 'P0001';

-- deadlock, keduanya sama-sama menunggu, pengguna pertama diberhasilkan dan pengguna kedua dibatalkan
start transaction;

select * from products where id = 'P0001' for update;

select * from products where id = 'P0002' for update;

rollback;

-- melihat schema saat ini
select current_schema();

show search_path;

-- membuat dan menghapus schema
create schema contoh;

drop schema contoh;

-- pindah schema
set search_path to contoh;

select current_schema();

select * from public.products;

-- membuat table di schema
create table contoh.products(
	id serial not null,
	name varchar(100) not null,
	primary key(id)
);

set search_path to public;

select * from products;

select * from contoh.products;

insert into contoh.products(name)
values ('Iphone'), ('Play Station');

select * from contoh.products;

-- membuat/menghapus user
create role fardan;

create role asa;

drop role fardan;

drop role asa;


-- menambah option ke user
alter role fardan login password 'rahasia';

alter role asa login password 'rahasia';

-- menambah/menghapus hak akses ke user
grant insert, update, select on all tables in schema public to fardan;

grant usage, select, update on guestbooks_id_seq to fardan;

grant insert, update, select on customer to asa;

revoke insert, update, select on customer from asa;

-- membuat database untuk restore
create database belajar_restore; -- lanjut restore database terminal
