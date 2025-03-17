-- inserção de dados e queries
use ecommerce;

show tables;
-- idClient, Fname, Lname, CPF, Address
insert into Clients (Fname, Minit, Lname, CPF, Address)
	   values('Maria', 'M', 'Silva', 123456789, 'rua silva de prata 29, Carangola - Cidade das flores'),
             ('Matheus', 'O', 'Pimentel', 987654321, 'rua alemeda 289, Centro - Cidade das flores'),
			 ('Ricardo', 'F', 'Silva', 456789123, 'avenida alemeda vinha 1009, Centro - Cidade das flores'),
             ('Julia', 'S', 'França', 789123456, 'rua laranjeiras 861, Centro - Cidade das flores'),
             ('Roberta', 'G', 'Assis', 987456321, 'avenida koller 19, Centro - Cidade das flores'),
             ('Isabela', 'M', 'Cruz', 654789123, 'rua alemeda das flores 28, Centro - Cidade das flores');
             
             
-- idProduct, Pname, classification_kids boolean, category('Eletronico', 'Brinquedos', 'Alimentos', 'Moveis'), avaliação, size
insert into product (Pname, classification_kids, category, avaliação, size) values
							  ('Fone de ouvido', false, 'Eletronico','4', null),
                              ('Barbie Elsa', true, 'Brinquedos','3', null),
                              ('Body Carters', true, 'Vestimenta','5', null),
                              ('Microfone Vedo - Youtuber', false, 'Eletronico','4', null),
                              ('Sofá Retratil', false, 'Moveis','3', '3x57x80'),
                              ('Farinha de arroz', false, 'Alimentos','3', null),
                              ('Fire Stick Amazon', false, 'Eletronico', '3', null);

select * from clients;
select * from product;
-- IdOrder, idOrderClient, orderStatus, orderDEscription, sendValue, paymentCash

delete from orders where idOrderClient in (1,2,3,4);
insert into orders (idOrderClient, orderStatus, orderDEscription, sendValue, paymentCash) values
                            (1, default, 'compra via aplicativo', null, 1),
                            (2, default, 'compra via aplicativo', 50,0),
                            (3, 'Confimardo', null, null, 1),
                            (4, default, 'compra via web site', 150,0);
                            
-- idPOproduct, idPOorder, poQuantity, poStatus
select * from orders;
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
						 (1,1,2, null),
						 (2,1,1, null),
                         (3,2,1, null);
                         
-- storageLocation, quantity
insert into productStorage (storageLocation, quantity) values
						   ('Rio de Janeiro', 1000),
                           ('Rio de Janeiro', 500),
                           ('São Paulo', 10),
                           ('São Paulo', 100),
                           ('São Paulo', 10),
                           ('Brasilia', 60);
                           
-- idLproduct, idLstorage, location
insert into storageLocation (idLproduct, idLstorage, location) values
                         (1,2,'RJ'),
                         (2,6,'GO');
                         
-- idSupplier, SocialName, CNPJ, contact
insert into supplier (SocialName, CNPJ, contact) values
							 ('Almeida e filhos', 123456789123456,'21985474'),
                             ('Eletronicos Silva', 854519649143457,'21985484');
						
select * from supplier;
-- idPsSupplier, idPsProduct, quantity
insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
                         (1,1,500),
                         (1,2,400),
                         (2,4,633),
                         (3,3,5),
                         (2,5,10);
                         
-- idSeller, SocialName, AbstName, CNPJ, CPF, location, contact
insert into Seller (SocialName, AbstName, CNPJ, CPF, location, contact) values
						('Tech eletronics', null, 123456789456321, null, 'Rio de Janeiro', 219946287),
                        ('Botique Durgas', null, null, 123456783, 'Rio de Janeiro', 219567895),
                        ('Kids World', null, 456789123654485, null, 'São Paulo', 1198657484);
                        
select * from seller;
-- idPseller, idPproduct, prodQuantity
insert into productSeller (idPseller, idPproduct, prodQuantity) values
						  (1,6,80),
                          (2,7,10);
                          
select * from productSeller;

select count(*) from clients;
select * from clients c, orders o where c.idClient = idOrderClient;
                       
select Fname, Lname, idOrder, orderStatus from clients c, orders o where c.idClient = idOrderClient;
select concat(Fname,' ', Lname)as client, idOrder as Request, orderStatus as Status from clients c, orders o where c.idClient = idOrderClient;

insert into orders (idOrderClient, clientStatus, orderDescription, sendValues, paymentCash) values
                     (2, default,'Compra via aplicativo',null,1);
                     
select count(*) from clients c, orders o
           where c.idClient = idOrderClient
           group by idOrder;
           
select * from orders;

-- REcuperação de pedido com produto associados
select * from clients c
                           inner join orders o ON c.idClient = o.idOrderClient
                           inner join productOrder p on p.idPOorder = idOrder
		group by idClient;
-- Recuperar quantos pedidos foram realizados pelos clients?
select c.idClient, Fname, count(*) as Number_of_Orders from clients c
                           inner join orders o ON c.idClient = o.idOrderClient
                           inner join productOrder p on p.idPOorder = idOrder
		group by idClient;