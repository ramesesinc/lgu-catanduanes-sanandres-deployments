alter table account_incometarget add CONSTRAINT `fk_account_incometarget_itemid` 
   FOREIGN KEY (`itemid`) REFERENCES `account` (`objid`)
;

/*
CREATE TABLE `business_closure` ( 
   `objid` varchar(50) NOT NULL, 
   `businessid` varchar(50) NOT NULL, 
   `dtcreated` datetime NOT NULL, 
   `createdby_objid` varchar(50) NOT NULL, 
   `createdby_name` varchar(150) NOT NULL, 
   `dtceased` date NOT NULL, 
   `dtissued` datetime NOT NULL, 
   `remarks` text NULL,
   CONSTRAINT `pk_business_closure` PRIMARY KEY (`objid`),
   UNIQUE KEY `uix_businessid` (`businessid`),
   KEY `ix_createdby_objid` (`createdby_objid`),
   KEY `ix_dtceased` (`dtceased`),
   KEY `ix_dtcreated` (`dtcreated`),
   KEY `ix_dtissued` (`dtissued`),
   CONSTRAINT `fk_business_closure_businessid` FOREIGN KEY (`businessid`) REFERENCES `business` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
; 
*/

-- create UNIQUE index `uix_code` on businessrequirementtype (`code`); 
-- create UNIQUE index `uix_title` on businessrequirementtype (`title`); 

-- create UNIQUE index `uix_name` on businessvariable (`name`);

CREATE TABLE `cashreceipt_group` ( 
   `objid` varchar(50) NOT NULL, 
   `txndate` datetime NOT NULL, 
   `controlid` varchar(50) NOT NULL, 
   `amount` decimal(16,2) NOT NULL, 
   `totalcash` decimal(16,2) NOT NULL, 
   `totalnoncash` decimal(16,2) NOT NULL, 
   `cashchange` decimal(16,2) NOT NULL,
   CONSTRAINT `pk_cashreceipt_group` PRIMARY KEY (`objid`),
   KEY `ix_controlid` (`controlid`),
   KEY `ix_txndate` (`txndate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
; 


CREATE TABLE `cashreceipt_groupitem` ( 
   `objid` varchar(50) NOT NULL, 
   `parentid` varchar(50) NOT NULL,
   CONSTRAINT `pk_cashreceipt_groupitem` PRIMARY KEY (`objid`),
   KEY `ix_parentid` (`parentid`),
   CONSTRAINT `fk_cashreceipt_groupitem_objid` FOREIGN KEY (`objid`) REFERENCES `cashreceipt` (`objid`),
   CONSTRAINT `fk_cashreceipt_groupitem_parentid` FOREIGN KEY (`parentid`) REFERENCES `cashreceipt_group` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
; 


CREATE TABLE `cashreceipt_plugin` ( 
   `objid` varchar(50) NOT NULL, 
   `connection` varchar(150) NOT NULL, 
   `servicename` varchar(255) NOT NULL,
   CONSTRAINT `pk_cashreceipt_plugin` PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
; 


-- create unique index uix_receiptid on cashreceipt_void (receiptid); 

alter table collectiontype add info text null 
; 

CREATE TABLE `entity_mapping` ( 
   `objid` varchar(50) NOT NULL, 
   `parent_objid` varchar(50) NOT NULL, 
   `org_objid` varchar(50) NULL,
   CONSTRAINT `pk_entity_mapping` PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
; 

-- alter table lob add _ukey varchar(50) not null default '';
-- update lob set _ukey=objid where _ukey='';
-- create unique index uix_name on lob (name, _ukey);

DROP TABLE IF EXISTS `paymentorder`
;
CREATE TABLE `paymentorder` (
   `objid` varchar(50) NOT NULL, 
   `txndate` datetime NULL, 
   `payer_objid` varchar(50) NULL, 
   `payer_name` text NULL, 
   `paidby` text NULL, 
   `paidbyaddress` varchar(150) NULL, 
   `particulars` text NULL, 
   `amount` decimal(16,2) NULL, 
   `txntype` varchar(50) NULL, 
   `expirydate` date NULL, 
   `refid` varchar(50) NULL, 
   `refno` varchar(50) NULL, 
   `info` text NULL, 
   `txntypename` varchar(255) NULL, 
   `locationid` varchar(50) NULL, 
   `origin` varchar(50) NULL, 
   `issuedby_objid` varchar(50) NULL, 
   `issuedby_name` varchar(150) NULL, 
   `org_objid` varchar(50) NULL, 
   `org_name` varchar(255) NULL, 
   `items` text NULL, 
   `collectiontypeid` varchar(50) NULL, 
   `queueid` varchar(50) NULL,
   CONSTRAINT `pk_paymentorder` PRIMARY KEY (`objid`),
   KEY `ix_collectiontypeid` (`collectiontypeid`),
   KEY `ix_issuedby_name` (`issuedby_name`),
   KEY `ix_issuedby_objid` (`issuedby_objid`),
   KEY `ix_locationid` (`locationid`),
   KEY `ix_org_name` (`org_name`),
   KEY `ix_org_objid` (`org_objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
; 


drop table if exists `sync_data_forprocess`; 
drop table if exists `sync_data_pending`;
drop table if exists `sync_data`;

CREATE TABLE `sync_data` ( 
   `objid` varchar(50) NOT NULL, 
   `parentid` varchar(50) NOT NULL, 
   `refid` varchar(50) NOT NULL, 
   `reftype` varchar(50) NOT NULL, 
   `action` varchar(50) NOT NULL, 
   `orgid` varchar(50) NULL, 
   `remote_orgid` varchar(50) NULL, 
   `remote_orgcode` varchar(20) NULL, 
   `remote_orgclass` varchar(20) NULL, 
   `dtfiled` datetime NOT NULL, 
   `idx` int NOT NULL, 
   `sender_objid` varchar(50) NULL, 
   `sender_name` varchar(150) NULL, 
   `refno` varchar(50) NULL,
   CONSTRAINT `pk_sync_data` PRIMARY KEY (`objid`),
   KEY `ix_sync_data_dtfiled` (`dtfiled`),
   KEY `ix_sync_data_orgid` (`orgid`),
   KEY `ix_sync_data_refid` (`refid`),
   KEY `ix_sync_data_reftype` (`reftype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
; 


CREATE TABLE `sync_data_forprocess` ( 
   `objid` varchar(50) NOT NULL,
   CONSTRAINT `pk_sync_data_forprocess` PRIMARY KEY (`objid`),
   CONSTRAINT `fk_sync_data_forprocess_sync_data` FOREIGN KEY (`objid`) REFERENCES `sync_data` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
; 


CREATE TABLE `sync_data_pending` ( 
   `objid` varchar(50) NOT NULL, 
   `error` text NULL, 
   `expirydate` datetime NULL,
   CONSTRAINT `pk_sync_data_pending` PRIMARY KEY (`objid`),
   KEY `ix_expirydate` (`expirydate`),
   CONSTRAINT `fk_sync_data_pending_sync_data` FOREIGN KEY (`objid`) REFERENCES `sync_data` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
; 


-- CREATE UNIQUE INDEX `uix_ruleset_name` ON sys_rule (`ruleset`,`name`);
