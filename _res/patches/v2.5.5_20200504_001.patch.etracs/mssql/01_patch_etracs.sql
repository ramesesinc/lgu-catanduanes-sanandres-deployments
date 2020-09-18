

update aa set 
	aa.refdate = bb.receiptdate 
from af_control_detail aa, (
		select t2.*, (select min(receiptdate) from cashreceipt where controlid = t2.controlid) as receiptdate 
		from ( 
			select t1.* 
			from ( 
				select d.controlid, d.refdate, d.reftype, d.refid, d.objid as cdetailid, (
					select top 1 objid from af_control_detail 
						where controlid = d.controlid 
							order by refdate, txndate, indexno 
					) as firstdetailid 
				from aftxn aft 
					inner join aftxnitem afi on afi.parentid = aft.objid 
					inner join af_control_detail d on d.aftxnitemid = afi.objid 
				where aft.txntype = 'FORWARD' 
			)t1, af_control_detail d 
			where d.objid = t1.firstdetailid 
				and d.objid <> t1.cdetailid 
		)t2 
	)bb 
where aa.objid = bb.cdetailid 
	and bb.receiptdate is not null 
; 
