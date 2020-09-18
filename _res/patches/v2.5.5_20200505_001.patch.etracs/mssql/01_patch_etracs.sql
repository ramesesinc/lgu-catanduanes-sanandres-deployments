
EXEC sp_rename N'[dbo].[creditmemo].[payername]', N'_payername', 'COLUMN'
go 
alter table creditmemo add payer_name varchar(255) null
go 
update creditmemo set payer_name = _payername where payer_name is null
go 
alter table creditmemo alter column payer_name varchar(255) not null
go 
create index ix_payer_name on creditmemo (payer_name)
go 


alter table creditmemo add payer_address_objid varchar(50) not null
go 
create index ix_payer_address_objid on creditmemo (payer_address_objid)
go 


EXEC sp_rename N'[dbo].[creditmemo].[payeraddress]', N'_payeraddress', 'COLUMN'
go 
alter table creditmemo add payer_address_text varchar(255) null 
go 
update creditmemo set payer_address_text = _payeraddress where payer_address_text is null 
go 
