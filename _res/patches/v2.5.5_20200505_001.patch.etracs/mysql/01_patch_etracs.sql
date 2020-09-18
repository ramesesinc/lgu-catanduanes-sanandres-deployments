
alter table creditmemo change payername _payername varchar(255) null
;
-- alter table creditmemo add payer_name varchar(255) null
-- ;
update creditmemo set payer_name = _payername where payer_name is null 
; 
alter table creditmemo modify payer_name varchar(255) not null
;
create index ix_payer_name on creditmemo (payer_name)
;

-- alter table creditmemo add payer_address_objid varchar(50) null
-- ;
create index ix_payer_address_objid on creditmemo (payer_address_objid)
; 

alter table creditmemo change payeraddress _payeraddress varchar(255) null 
;
-- alter table creditmemo add payer_address_text varchar(255) null 
-- ;
update creditmemo set payer_address_text = _payeraddress where payer_address_text is null 
;
