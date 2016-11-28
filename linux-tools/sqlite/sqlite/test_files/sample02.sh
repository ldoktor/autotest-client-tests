#!/bin/sh
echo "3
one
two
other
other
4.0
1.0
2.5
2.5
1|UPDATE||100.0||3.0||`date +%F` `date +%T`
2|UPDATE||100.0||4.0||`date +%F` `date +%T`
3|INSERT|9|3.0||||
4|INSERT|10|3.0||||
5|INSERT|11|3.0||||
table|test|test|2|CREATE TABLE test (a integer PRIMARY KEY, b INT, c FLOAT, d TEXT, created DATE)
trigger|insert_test_date|test|0|CREATE TRIGGER insert_test_date AFTER INSERT ON test
BEGIN
UPDATE test SET created = DATETIME('NOW')  WHERE rowid = new.rowid;
END
table|log|log|3|CREATE TABLE log (pkey integer PRIMARY KEY, msg TEXT, nfldint int, nfldfloat float, ofldint int, ofldfloat float, created DATE, modified DATE)
trigger|update_test_c_data|test|0|CREATE TRIGGER update_test_c_data UPDATE OF c ON test  BEGIN     insert into log  (nfldfloat,ofldfloat,msg,modified) values (new.c, old.c,'UPDATE',DATETIME('NOW'));     END
trigger|insert_test_data|test|0|CREATE TRIGGER insert_test_data INSERT  ON test  BEGIN   insert into log  (nfldint,nfldfloat,msg) values (new.b,new.c,'INSERT');     END
log   test"
