update af_control_detail set reftype = 'ISSUE' where txntype='SALE' and reftype <> 'ISSUE' 
; 

update 
	af_control_detail aa, ( 
		select 
			(select count(*) from cashreceipt where controlid = d.controlid) as receiptcount, 
			d.objid, d.controlid, d.endingstartseries, d.endingendseries, d.qtyending 
		from af_control_detail d 
		where d.txntype='SALE' 
			and d.qtyending > 0
	)bb 
set 
	aa.issuedstartseries = bb.endingstartseries, aa.issuedendseries = bb.endingendseries, aa.qtyissued = bb.qtyending, 
	aa.endingstartseries = null, aa.endingendseries = null, aa.qtyending = 0 
where aa.objid = bb.objid 
	and bb.receiptcount = 0 
;

update 
	af_control_detail aa, ( 
		select 
			(select count(*) from cashreceipt where controlid = d.controlid) as receiptcount, 
			d.objid, d.controlid, d.endingstartseries, d.endingendseries, d.qtyending 
		from af_control_detail d 
		where d.txntype='SALE' 
			and d.qtyending > 0
	)bb 
set 
	aa.reftype = 'ISSUE', aa.txntype = 'COLLECTION', aa.remarks = 'COLLECTION' 
where aa.objid = bb.objid 
	and bb.receiptcount > 0 
;


insert into sys_usergroup_permission (
	objid, usergroup_objid, object, permission, title 
) values ( 
	'TREASURY-COLLECTOR-ADMIN-remittance-modifyCashBreakdown', 'TREASURY.COLLECTOR_ADMIN', 'remittance', 'modifyCashBreakdown', 'Modify Remittance Cash Breakdown'
); 
