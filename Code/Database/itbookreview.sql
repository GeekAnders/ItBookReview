/*==============================================================*/
/* itbookreview 的数据库脚本， 存储引擎使用的是MYISAM！*/
/*==============================================================*/
set names 'utf8';
use itbookreview;

/*==============================================================*/
/* Table:ibr_users 用户表 */
/*==============================================================*/
drop table if exists ibr_users;
create table ibr_users
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

create unique index idx_user_email on ibr_users ( email );
create unique index idx_user_name on ibr_users ( name );

/*==============================================================*/
/* Table:ibr_links 友情链接 */
/*==============================================================*/
create table ibr_links
(
id int unsigned not null auto_increment,
sort_order smallint unsigned not null,
title varchar(50) not null,
url varchar(100) not null,
primary key (id)
)ENGINE=MYISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
