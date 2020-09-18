update aa set 
	aa.receivedstartseries = bb.issuedstartseries, aa.receivedendseries = bb.issuedendseries, aa.qtyreceived = bb.qtyissued, 
	aa.issuedstartseries = null, aa.issuedendseries = null, aa.qtyissued = 0 
from af_control_detail aa, ( 
		select objid, issuedstartseries, issuedendseries, qtyissued 
		from af_control_detail d 
		where d.reftype = 'ISSUE' and d.txntype = 'COLLECTION' 
			and d.qtyreceived = 0 
	)bb 
where aa.objid = bb.objid 
; 

update af_control_detail set receivedstartseries = null where receivedstartseries = 0 ; 
update af_control_detail set receivedendseries = null where receivedendseries  = 0 ; 
update af_control_detail set beginstartseries = null where beginstartseries = 0 ; 
update af_control_detail set beginendseries = null where beginendseries = 0 ; 
update af_control_detail set issuedstartseries = null where issuedstartseries = 0 ; 
update af_control_detail set issuedendseries = null where issuedendseries = 0 ; 
update af_control_detail set endingstartseries = null where endingstartseries = 0 ; 
update af_control_detail set endingendseries = null where endingendseries = 0 ; 


update aa set 
	aa.remarks = 'COLLECTION' 
from af_control_detail aa, ( 
		select d.objid 
		from af_control_detail d 
			inner join af_control a on a.objid = d.controlid 
		where d.reftype = 'ISSUE' and d.txntype = 'COLLECTION' 
			and d.remarks = 'SALE' 
	)bb 
where aa.objid = bb.objid 
;

update aa set 
	aa.beginstartseries = bb.receivedstartseries, aa.beginendseries = bb.receivedendseries, aa.qtybegin = bb.qtyreceived, 
	aa.receivedstartseries = null, aa.receivedendseries = null, aa.qtyreceived = 0 
from af_control_detail aa, ( 
		select rd.objid, rd.receivedstartseries, rd.receivedendseries, rd.qtyreceived 
		from ( 
			select tt.*, (
					select top 1 objid from af_control_detail 
					where controlid = tt.controlid and reftype in ('ISSUE','MANUAL_ISSUE') 
					order by refdate, txndate, indexno 
				) as pdetailid, (
					select top 1 objid from af_control_detail 
					where controlid = tt.controlid and refdate = tt.refdate 
						and reftype = tt.reftype and txntype = tt.txntype and qtyreceived > 0 
					order by refdate, txndate, indexno 
				) as cdetailid 
			from ( 
				select d.controlid, d.reftype, d.txntype, min(d.refdate) as refdate  
				from af_control_detail d 
				where d.reftype = 'remittance' and d.txntype = 'remittance' 
				group by d.controlid, d.reftype, d.txntype 
			)tt 
		)tt 
			inner join af_control_detail rd on rd.objid = tt.cdetailid 
			inner join af_control_detail pd on pd.objid = tt.pdetailid 
		where pd.refdate <> rd.refdate 
	)bb 
where aa.objid = bb.objid 
;

