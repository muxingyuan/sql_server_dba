--Config AlwaysOn Group in sql server
--Condition: in domain, failover cluster must be ready, 
--verify: in Server Manager, Failover Cluster Manager, the cluster is there and at least 2 nodes are up and running

--AlwaysOn Group is a group of databases that will be synchronized with secondary replicas.
--In same instance, multiple AlwaysOn Groups can be configured.
--Condition of database to be in AlwaysOn Group: Full recovery mode, previously backed up.


CREATE DATABASE DB2
CREATE TABLE T1 ( COL1 INT PRIMARY KEY IDENTITY,
COL2 INT)
;

INSERT INTO T1 VALUES (1),(2),(3)
;

BACKUP DATABASE DB2 TO DISK='\\DBAPROD100\g$\SQLBACKUP\SQL2016PRDG1\DB2_FULL.BAK'
WITH COMPRESSION

--lesson learnt: sometimes TCP_endpoint already exists for this instance, 
--when configuring AlwaysOn group through wizzard, make sure to correct port number of the endpoint

SELECT * FROM SYS.tcp_endpoints

--if some conflicts cause error in AlwaysOn group, 
--drop the hadr endpoint, and specify a not used port number during AlwaysOn setup wizzard,
--practical tip: sql server documentation use port 7022 (for default instance), 7023 (for named instance).
    
DROP ENDPOINT [HADR_ENDPOINT]

--lesson learnt:
--should not delete AlwaysOn group in Secondary Replica Instance Object Explorer,
--because that will cause databases in both Replicas be in "Restoring" mode and inusable.

--Glad to grasp AlwaysOn config now!~~~