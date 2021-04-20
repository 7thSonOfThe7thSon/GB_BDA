1. Создан файл .my.cnf

MacBook-Air-Igor-Gorelik:~ igorgorelik$ nano .my.cnf
MacBook-Air-Igor-Gorelik:~ igorgorelik$ ls -la
total 96
drwxr-xr-x    3 igorgorelik  staff     96 Jul 24  2020 .mono
-rw-r--r--    1 igorgorelik  staff     37 Mar 28 20:20 .my.cnf
-rw-------    1 igorgorelik  staff   1543 Mar 28 19:56 .mysql_history

Содержание файла .my.cnf
[mysql]
user=root
password=********

2.Создана база данных example

mysql> create database example;
Query OK, 1 row affected (0.20 sec)

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| example            |
| information_schema |
| mysql              |
| performance_schema |
| shop               |
| store              |
| sys                |
+--------------------+
7 rows in set (0.07 sec)

В ней размещена таблица users, состоящая из двух столбцов, числового id и строкового name.

mysql> use example
Database changed
mysql> create table (
    -> id int,
    -> name varchart(100));

mysql> show tables
    -> ;
+-------------------+
| Tables_in_example |
+-------------------+
| user              |
+-------------------+
1 row in set (0.00 sec)

mysql> describe user;
+-------+--------------+------+-----+---------+-------+
| Field | Type         | Null | Key | Default | Extra |
+-------+--------------+------+-----+---------+-------+
| id    | int          | YES  |     | NULL    |       |
| name  | varchar(100) | YES  |     | NULL    |       |
+-------+--------------+------+-----+---------+-------+
2 rows in set (0.04 sec)

3. Создан дамп БД example

MacBook-Air-Igor-Gorelik:~ igorgorelik$ mysqldump -u root -p'*********' example > example_dump.sql
mysqldump: [Warning] Using a password on the command line interface can be insecure.
MacBook-Air-Igor-Gorelik:~ igorgorelik$ ls
Applications		Documents		Library			Music			Public			example_dump.sql
Desktop			Downloads		Movies			Pictures		Yandex.Disk.localized

Дамп развернут в новуб БД sample

ysql> create database sample;
Query OK, 1 row affected (0.14 sec)

mysql> sample < example_dump.sql

mysql> use sample
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> show tables;
+------------------+
| Tables_in_sample |
+------------------+
| user             |
+------------------+
1 row in set (0.00 sec)

