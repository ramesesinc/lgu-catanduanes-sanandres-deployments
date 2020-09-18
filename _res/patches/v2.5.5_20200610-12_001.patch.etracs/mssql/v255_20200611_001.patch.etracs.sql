
update aa set 
	aa.receivedstartseries = bb.issuedstartseries, aa.receivedendseries = bb.issuedendseries, aa.qtyreceived = bb.qtyissued, 
	aa.beginstartseries = null, aa.beginendseries = null, aa.qtybegin = 0 
from af_control_detail aa, ( 
		select objid, issuedstartseries, issuedendseries, qtyissued 
		from af_control_detail 
		where txntype='sale' 
			and qtyissued > 0 
	) bb  
where aa.objid = bb.objid 
; 

update aa set 
	aa.currentdetailid = null, aa.currentindexno = 0 
from af_control aa, ( 
		select a.objid 
		from af_control a 
		where a.objid not in (
			select distinct controlid from af_control_detail where controlid = a.objid
		) 
	)bb 
where aa.objid = bb.objid 
; 


update aa set 
	aa.currentseries = aa.endseries+1 
from  af_control aa, ( 
		select d.controlid 
		from af_control_detail d, af_control a 
		where d.txntype = 'SALE' 
			and d.controlid = a.objid 
			and a.currentseries <= a.endseries 
	)bb 
where aa.objid = bb.controlid 
; 


update af_control set 
	currentindexno = (select indexno from af_control_detail where objid = af_control.currentdetailid)
where currentdetailid is not null 
; 


insert into sys_usergroup_permission (
	objid, usergroup_objid, object, permission, title 
) values ( 
	'TREASURY-COLLECTOR-ADMIN-remittance-voidReceipt', 'TREASURY.COLLECTOR_ADMIN', 'remittance', 'voidReceipt', 'Void Receipt'
); 
