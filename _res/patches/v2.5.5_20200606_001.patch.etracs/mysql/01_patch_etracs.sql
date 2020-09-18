
alter table aftxn add lockid varchar(50) null 
; 

-- alter table af_control add constraint fk_af_control_afid 
--    foreign key (afid) references af (objid) 
-- ; 

alter table af_control add constraint fk_af_control_allocid 
	foreign key (allocid) references af_allocation (objid) 
; 

drop view if exists vw_af_inventory_summary
;
CREATE VIEW vw_af_inventory_summary AS 
select 
	af.objid, af.title, u.unit, af.formtype, 
	(case when af.formtype='serial' then 0 else 1 end) as formtypeindex, 
	(select count(0) from af_control where afid = af.objid and state = 'OPEN') AS countopen, 
	(select count(0) from af_control where afid = af.objid and state = 'ISSUED') AS countissued, 
	(select count(0) from af_control where afid = af.objid and state = 'ISSUED' and currentseries > endseries) AS countclosed, 
	(select count(0) from af_control where afid = af.objid and state = 'SOLD') AS countsold, 
	(select count(0) from af_control where afid = af.objid and state = 'PROCESSING') AS countprocessing, 
	(select count(0) from af_control where afid = af.objid and state = 'HOLD') AS counthold
from af, afunit u 
where af.objid = u.itemid
order by (case when af.formtype='serial' then 0 else 1 end), af.objid 
;

alter table af_control add salecost decimal(16,2) not null default '0.0'
;

-- update af_control set salecost = cost where state = 'SOLD' and cost > 0 and salecost = 0 
-- ; 


insert into sys_usergroup (
	objid, title, domain, role, userclass
) values (
	'TREASURY.AFO_ADMIN', 'TREASURY AFO ADMIN', 'TREASURY', 'AFO_ADMIN', 'usergroup' 
); 

insert into sys_usergroup_permission (
	objid, usergroup_objid, object, permission, title 
) values ( 
	'TREASURY-AFO-ADMIN-aftxn-changetxntype', 'TREASURY.AFO_ADMIN', 'aftxn', 'changeTxnType', 'Change Txn Type'
); 

