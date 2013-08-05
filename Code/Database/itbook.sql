/*==============================================================*/
/* itbook 的数据库脚本， 存储引擎使用的是MYISAM！*/
/*==============================================================*/
set names 'utf8';
use itbook;

/*==============================================================*/
/* Table:ib_users 用户表 */
/*==============================================================*/
drop table if exists ib_users;
create table ib_users
(
id int unsigned not null auto_increment,
email varchar(40) not null comment '用来登录的邮箱',
name varchar(20) not null comment '用户自己给自己起的ID',
pwd varchar(40) not null,
weibo varchar(255),
QQ varchar(20),
portrait varchar(255) comment '头像',
gender tinyint(1) not null comment '性别1：男，2：女,0:未知',
birth date,
job varchar(20),
province varchar(40),
city varchar(40),
resume varchar(512) comment '个人简介',
role tinyint(1) not null comment '用户角色',
score int unsigned not null comment '用户积分，利用百度知道的那套积分系统',
rank tinyint not null comment '等级，初入江湖等',
status tinyint(1) unsigned not null comment '可能是不法用户，0:ok,1:黑名单',
reg_time timestamp not null default CURRENT_TIMESTAMP,
this_login_time datetime comment '上次登录时间',
this_login_ip char(16) comment '上次登录的IP',
primary key (id)
)ENGINE=MYISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

create unique index idx_user_email on ib_users ( email );
create unique index idx_user_name on ib_users ( name );
/*==============================================================*/
/* Table:ib_book_catalogs 书籍的分类 */
/*==============================================================*/
drop table if exists ib_book_catalogs;
create table ib_book_catalogs
(
id int unsigned not null auto_increment,
name varchar(32) not null comment '分类名称',
ident varchar(50) not null comment '分类英文名称',
sort_order smallint not null comment '排序权值',
primary key (id)
)ENGINE=MYISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*==============================================================*/
/* Table:ib_books IT书籍 */
/*==============================================================*/
drop table if exists ib_books;
create table ib_books
(
id int unsigned not null auto_increment,
name varchar(128) not null comment '书名',
ident varchar(128) comment '书名english',
pic varchar(255) comment '图书封面',
content text comment '内容简介',
author varchar(128) not null comment '作者',
translator varchar(128) not null comment '译者',
publisher varchar(128) not null comment '出版社',
publication_year date not null comment '出版时间',
user_id int unsigned not null comment '上传书的贡献者',
pages_number mediumint unsigned not null comment '页数',
catalog_id int unsigned not null comment '书的分类',
price double unsigned not null comment '定价',
tags varchar(100) comment '标签',
status tinyint(1) not null comment '书的状态0:未审核,1:ok,2:不OK',
ctime timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
view_times mediumint not null default 0 comment '点击次数',
comment_times mediumint not null default 0 comment '评论次数',
note_times mediumint not null default 0 comment '笔记次数',
as_top tinyint(1) not null default 0,
primary key (id)
)ENGINE=MYISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

create index idx_book_user on ib_books ( user_id );
create index idx_book_catalog on ib_books ( catalog_id );

/*==============================================================*/
/* Table:ib_tags 标签 */
/*==============================================================*/
drop table if exists ib_tags;
create table ib_tags
(
id int unsigned not null auto_increment,
name varchar(32) not null,
relevant_count int unsigned not null default 0 comment '这个tag关联的book数目',
primary key (id)
)ENGINE=MYISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

create index idx_tag_name on ib_tags ( name );

/*==============================================================*/
/* Table:ib_book_comments 书评 */
/*==============================================================*/
drop table if exists ib_book_comments;
create table ib_book_comments
(
id int unsigned not null auto_increment,
content text comment '内容',
user_id int unsigned not null comment '评论人',
book_id int unsigned not null comment '针对哪本book',
ctime timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
useful int not null default 0 comment '有多少人评价是有用的',
useless int not null default 0 comment '有多少人评价是没用的',
score int not null comment '对书的评价得分',
primary key (id)
)ENGINE=MYISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

create index idx_b_c_bookid on ib_book_comments ( book_id );

/*==============================================================*/
/* Table:ib_comment_votes 对书评投票的记录，不允许多次投票 */
/*==============================================================*/
drop table if exists ib_comment_votes;
create table ib_comment_votes
(
id int unsigned not null auto_increment,
vote_type tinyint not null default 0 comment '投的什么票',
comment_id int unsigned not null comment '对哪个评论投的票',
user_id int unsigned not null comment '投票人',
primary key (id)
)ENGINE=MYISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

create index idx_c_v_user_id on ib_comment_votes ( user_id );

/*==============================================================*/
/* Table:ib_book_comments 对书评的回应 */
/*==============================================================*/
drop table if exists ib_comment_responses;
create table ib_comment_responses
(
id int unsigned not null auto_increment,
content text comment '内容',
user_id int unsigned not null comment '回应人',
book_id int unsigned not null comment '针对哪个书评',
ctime timestamp not null default CURRENT_TIMESTAMP comment '创建时间',
primary key (id)
)ENGINE=MYISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

create index idx_c_r_bookid on ib_comment_responses ( book_id );

/*==============================================================*/
/* Table:ib_links 友情链接 */
/*==============================================================*/
drop table if exists ib_links;
create table ib_links
(
id int unsigned not null auto_increment,
sort_order smallint unsigned not null,
title varchar(50) not null,
url varchar(100) not null,
primary key (id)
)ENGINE=MYISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
