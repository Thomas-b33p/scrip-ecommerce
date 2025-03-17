-- criação do banco de dados para o cenário de E-commerce
drop database ecommerce;
create database ecommerce;
use ecommerce;

-- criar tabelas cliente
create table clients(
        idClient int auto_increment primary key,
		Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        Address varchar(30),
        constraint unique_CPF_client unique (CPF)
);

alter table clients auto_increment=1;
 
-- desc clients;
-- criar tabelas produto

-- size = dimensão do produto
create table product(
        idProduct int auto_increment primary key,
        Pname varchar(10) not null,
        Classification_kids bool default false,
        Category enum('Eletronico','Vestimenta','Brinquedo','Alimento','Moveis') not null,
        Avaliação float default 0,
        Size varchar(10)
);

create table payment(
        idClient int,
        idpayment int, 
        TypePayment enum('Boleto','Cartão', 'Dois Cartões'),
        LimitAvailable float,
        Primary key(idClient, idPayment)
);

-- criar tabelas pedido
create table orders(
        idOrder int auto_increment primary key,
        idOrderClient int,
        OrderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
        OrderDescription varchar(255),
        SendValue float default 10,
        PaymentCash bool default false,
        Constraint fk_orders_client foreign key(idOrderClient) references clients(idClient)
                on update cascade
);

-- criar tabela estoque
create table productStorage(
        idProdStorage int auto_increment primary key,
		storageLocation varchar(255),
        Quantity int default 0
);

-- criar tabela fornecedor
create table supplier(
        idSupplier int auto_increment primary key,
		SocialName varchar(255) not null,
        CNPJ char(15) not null,
        Contact char(11) not null,
        constraint unique_supplier unique (CNPJ)
);

-- criar tabela vendedor
create table seller(
        idSeller int auto_increment primary key,
		SocialName varchar(255) not null,
        AbstName varchar(255),
        CNPJ char(15),
        CPF char(11),
        Location varchar(255),
        Contact char(11) not null,
        constraint unique_CNPJ_seller unique (CNPJ),
		constraint unique_CPF_seller unique (CPF)
);

create table productseller(
        idPseller int,
        idPproduct int,
        prodQuantity int default 1,
        primary key (idPseller, idPproduct),
        constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
        constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

create table productOrder(
        idPOproduct int,
        idPOorder int,
        poQuantity int default 1,
        poStatus enum('Disponivel','Sem estoque') default 'Disponivel',
        primary key (idPOproduct, idPOorder),
        constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
        constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

create table storageLocation(
        idLproduct int,
        idLstorage int,
        Location varchar(255) not null,
        primary key (idLproduct, idLstorage),
        constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
        constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

create table productSupplier(
        idPsSupplier int,
        idPsProduct int,
        quantity int not null,
        primary key (idPsSupplier, idPsProduct),
        constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
        constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

show tables;
show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce'; 