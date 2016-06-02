create database myGive;
use myGive;

create table User(
	userEmail varchar(75) not null,
    userFirst varchar(35) not null,
    userLast varchar(50) not null,
    userLine1 varchar(100) not null,
    userLine2 varchar(75),
    userCity varchar(50) not null,
    userState char(2),
    userZip int,
    password varchar(20) not null,
    userPhone varchar(15),
    ccID int, 
	primary key(userEmail)
);

create table CreditCard (
	ccID int not null auto_increment,
    ccNumber varchar(20) not null,
    ccExp varchar(15),
    ccSecurityCode varchar(20) not null,
    ccFirst varchar(35) not null,
    ccLast varchar(50) not null,
	userEmail varchar(75) not null,
    primary key(ccID),
	foreign key(userEmail) references User(userEmail)
);

alter table User
add foreign key(ccID) references CreditCard(ccID);

/*Every organization is categorized under a larger more general category of organizations*/
create table Category (
    categoryTitle varchar(100) not null,
	categoryIcon blob,
    primary key (categoryTitle)
);

create table Organization(
	orgID int not null auto_increment,
    orgEmail varchar(100),
	orgName varchar(200) not null,
	orgDescription text,
	orgLogo longblob,
	categoryTitle varchar(100) not null,
	primary key(orgID),
	foreign key(categoryTitle) references Category(categoryTitle)
);

/* One of the organizations listed in a category*/
create table CategoryItem(
	categoryItemID int not null auto_increment,
	orgID int not null,
	categoryTitle varchar(100) not null,
	primary key (categoryItemID),
	foreign key(orgID) references Organization(orgID),
	foreign key(categoryTitle) references Category(categoryTitle)
);

create table Cart (
    cartSessionID int not null auto_increment,
	primary key(cartSessionID)
);

/* An order item in the cart*/
create table CartItem(
	cartItemID int not null auto_increment,
	cartSessionID int not null,
	orgID int not null,
	donationAmount DECIMAL(15, 2),
	primary key(cartItemID),
	foreign key(orgID) references Organization(orgID),
	foreign key(cartSessionID) references Cart(cartSessionID)
);

create table Orders (
    orderID int not null auto_increment,
    orderDate date not null,
    userEmail varchar(75) not null,
    paymentType varchar(50) not null,
    cartSessionID int not null,
    ccID int,
    primary key(orderID),
	foreign key(userEmail) references User(userEmail),
	foreign key(ccID) references CreditCard(ccID),
	foreign key(cartSessionID) references Cart(cartSessionID)
);

create table OrgPhone(
	orgPhoneID int not null auto_increment,
	orgPhone varchar(15) not null,
	primary key(orgPhoneID)
);

/*connects an organization to all its stored phone number*/
create table OrgPhoneOrg(
	orgPhoneID int not null,
	orgID int not null,
	foreign key(orgPhoneID) references OrgPhone(orgPhoneID),
	foreign key(orgID) references Organization(orgID)
);

create table Keyword(
	keywordID int not null auto_increment,
	keyword varchar(75) not null,
	primary key (keywordID)
);

/*connects and organization to all its descriptive keywords*/
create table KeywordOrg(
	keywordID int not null,
	orgID int not null,
	foreign key(keywordID) references Keyword(keywordID),
	foreign key(orgID) references Organization(orgID)
);

create table OrgAddress(
	orgAddressID int not null auto_increment,
	orgLine1 varchar(100) not null,
    orgLine2 varchar(75),
    orgCity varchar(50) not null,
    orgState char(2),
    orgZip int,
	primary key(orgAddressID)
);

/*connects an organization to all its stored addresses*/
create table OrgAddressOrg(
	orgAddressID int not null,
	orgID int not null,
	foreign key(orgAddressID) references OrgAddress(orgAddressID),
	foreign key(orgID) references Organization(orgID)
);

create table Photo(
	photoID int not null auto_increment,
	photo blob,
	primary key(photoID)
);

/*connects an organization to all of its stored photos*/
create table PhotoOrg(
	orgID int not null,
	photoID int not null,
	foreign key(orgID) references Organization(orgID),
	foreign key(photoID) references Photo(photoID)
);