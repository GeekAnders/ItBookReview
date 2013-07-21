drop table if exists osc_forums;

/*==============================================================*/
/* Table: osc_forums 论坛*/
/*==============================================================*/

create table osc_forums
(
id smallint not null,
ident varchar(50),
title varchar(50) not null,
outline varchar(500),
sort_order smallint unsigned not null,
options int not null,
status tinyint not null,
primary key (id)
)
engine = MYISAM;

drop table if exists osc_threads;

/*==============================================================*/
/* Table: osc_threads 讨论主题*/
/*==============================================================*/
create table osc_threads
(
id bigint unsigned not null auto_increment,
user int unsigned not null comment '主题由某个人发起',
forum smallint unsigned not null comment '主题属于某个论坛',
project int unsigned not null comment '主题是针对某个开源项目的',
create_time timestamp not null default CURRENT_TIMESTAMP,
client_ip char(15) not null,
type tinyint not null,
title varchar(50) not null,
ident varchar(100),
content mediumtext,
tags varchar(100),
origin_url varchar(100),
view_count mediumint unsigned not null default 0,
post_count mediumint unsigned not null default 0,
last_post_id bigint unsigned not null,
last_post_user int unsigned not null default 0,
last_post_time datetime,
extid int not null,
as_top tinyint not null default 0,
as_good tinyint not null,
options int not null default 0,
status tinyint not null,
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_project_thread */
/*==============================================================*/
create index idx_project_thread on osc_threads
(
project
);

/*==============================================================*/
/* Index: idx_user_thread */
/*==============================================================*/
create index idx_user_thread on osc_threads
(
user
);

/*==============================================================*/
/* Index: idx_thread_list */
/*==============================================================*/
create index idx_thread_list on osc_threads
(
as_top,
last_post_time
);

/*==============================================================*/
/* Index: idx_thread_tag */
/*==============================================================*/
create index idx_thread_tag on osc_threads
(
forum
);

drop table if exists osc_thread_projects;

/*==============================================================*/
/* Table: osc_thread_projects 话题与项目之间多对多关系表 */
/*==============================================================*/
create table osc_thread_projects
(
thread bigint unsigned not null,
project int unsigned not null,
primary key (thread, project)
)
engine = MYISAM;

drop table if exists osc_posts;

/*==============================================================*/
/* Table: osc_posts 回帖*/
/*==============================================================*/
create table osc_posts
(
id bigint unsigned not null,
user int unsigned not null,
username varchar(40),
user_email varchar(50),
user_url varchar(100),
tag int unsigned not null,
project int unsigned not null,
thread bigint unsigned not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
client_ip char(15) not null,
title varchar(50),
content mediumtext,
options int not null default 0,
status tinyint not null,
primary key (id, user)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_project_post */
/*==============================================================*/
create index idx_project_post on osc_posts
(
project
);

/*==============================================================*/
/* Index: idx_thread_post */
/*==============================================================*/
create index idx_thread_post on osc_posts
(
thread
);

/*==============================================================*/
/* Index: idx_user_post */
/*==============================================================*/
create index idx_user_post on osc_posts
(
user
);

/*==============================================================*/
/* Index: idx_post_tag */
/*==============================================================*/
create index idx_post_tag on osc_posts
(
tag
);

drop table if exists osc_forum_fields;

/*==============================================================*/
/* Table: osc_forum_fields 条目属性表*/
/*==============================================================*/
create table osc_forum_fields
(
id int not null auto_increment,
forum smallint not null,
name varchar(40) not null,
summary varchar(255),
rule varchar(100),
type tinyint not null,
sort_order int not null,
required tinyint not null,
options int not null,
primary key (id)
)
engine = MYISAM;

alter table osc_forum_fields add constraint FK_forum_value foreign key (forum)
references osc_forums (id);

drop table if exists osc_forum_values;

/*==============================================================*/
/* Table: osc_forum_values 属性表*/
/*==============================================================*/
create table osc_forum_values
(
id int unsigned not null auto_increment,
field int not null,
parent int not null,
name varchar(50) not null,
value varchar(100),
sort_order int not null,
as_default tinyint not null,
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: fk_field_values_FK */
/*==============================================================*/
create index fk_field_values_FK on osc_forum_values
(
field
);

/*==============================================================*/
/* Index: idx_value_parent */
/*==============================================================*/
create index idx_value_parent on osc_forum_values
(
parent
);

alter table osc_forum_values add constraint FK_field_value foreign key (field)
references osc_forum_fields (id);

drop table if exists osc_topic_fields;

/*==============================================================*/
/* Table: osc_topic_fields 话题属性*/
/*==============================================================*/
create table osc_topic_fields
(
field int,
topic bigint,
val text
)
engine = MYISAM;

alter table osc_topic_fields add constraint FK_field_of_topic foreign key (topic)
references osc_threads (id);

alter table osc_topic_fields add constraint FK_value_of_field foreign key (field)
references osc_forum_fields (id);

drop table if exists osc_code_langs;

/*==============================================================*/
/* Table: osc_code_langs 代码语言*/
/*==============================================================*/
create table osc_code_langs
(
id int unsigned not null auto_increment,
name varchar(32) not null,
ident varchar(16),
brush varchar(16),
tag int not null,
sort_order int not null,
page_title varchar(128),
page_keywords varchar(64),
page_description varchar(128),
file_exts varchar(32),
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_lang_tag */
/*==============================================================*/
create index idx_lang_tag on osc_code_langs
(
tag
);

drop table if exists osc_code_catalogs;

/*==============================================================*/
/* Table: osc_code_catalogs 代码分类 */
/*==============================================================*/
create table osc_code_catalogs
(
id int unsigned not null auto_increment,
parent int unsigned not null,
name varchar(32) not null,
ident varchar(32),
tag int not null,
lang int unsigned not null,
sort_order int not null,
detail text,
primary key (id)
)
engine = MYISAM;

drop table if exists osc_codes;

/*==============================================================*/
/* Table: osc_codes 代码 */
/*==============================================================*/
create table osc_codes
(
id int unsigned not null auto_increment,
user int unsigned not null,
title varchar(64) not null,
outline text,
tags varchar(128),
lang int unsigned not null,
catalog int unsigned not null,
difficulty tinyint not null,
project int unsigned not null,
original_url varchar(128),
reply_count int not null,
view_count int not null,
score tinyint unsigned not null,
recomm tinyint not null,
options tinyint not null,
status tinyint not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
update_time datetime,
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_code_user */
/*==============================================================*/
create index idx_code_user on osc_codes
(
user
);

/*==============================================================*/
/* Index: idx_code_project */
/*==============================================================*/
create index idx_code_project on osc_codes
(
project
);

/*==============================================================*/
/* Index: idx_code_lang */
/*==============================================================*/
create index idx_code_lang on osc_codes
(
lang
);

drop table if exists osc_code_comments;

/*==============================================================*/
/* Table: osc_code_comments 代码评论 */
/*==============================================================*/
create table osc_code_comments
(
id int unsigned not null,
user int unsigned not null,
code int unsigned not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
content text not null,
options tinyint not null,
status tinyint not null,
primary key (id, user)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_code_replyer */
/*==============================================================*/
create index idx_code_replyer on osc_code_comments
(
user
);

/*==============================================================*/
/* Index: idx_comment_of_code */
/*==============================================================*/
create index idx_comment_of_code on osc_code_comments
(
code
);

drop table if exists osc_code_pieces;

/*==============================================================*/
/* Table: osc_code_pieces 代码片段 */
/*==============================================================*/
create table osc_code_pieces
(
id int unsigned not null auto_increment,
code int unsigned not null,
name varchar(64) not null,
type tinyint not null comment '1:代码文本;2:代码文件;3:图片',
lang int unsigned not null,
sort_order int not null,
file_name varchar(64),
file_path varchar(128),
source text,
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_pieces_of_code */
/*==============================================================*/
create index idx_pieces_of_code on osc_code_pieces
(
code
);

/*==============================================================*/
/* Index: idx_pieces_of_lang */
/*==============================================================*/
create index idx_pieces_of_lang on osc_code_pieces
(
lang
);


drop table if exists osc_code_ratings;

/*==============================================================*/
/* Table: osc_code_ratings 代码评分记录 */
/*==============================================================*/
create table osc_code_ratings
(
code int unsigned not null,
user int unsigned not null,
score tinyint not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
primary key (code, user)
)
engine = MYISAM;

drop table if exists osc_code_tags;

/*==============================================================*/
/* Table: osc_code_tags 代码标签*/
/*==============================================================*/
create table osc_code_tags
(
code int unsigned not null,
tag varchar(32) not null,
primary key (code, tag)
)
engine = MYISAM;

drop table if exists osc_visit_stats;

/*==============================================================*/
/* Table: osc_visit_stats 每天项目访问统计表*/
/*==============================================================*/
create table osc_visit_stats
(
stat_date int unsigned not null,
type tinyint not null,
id int unsigned not null,
view_count int not null,
primary key (stat_date, type, id)
)
engine = MYISAM;

drop table if exists osc_users;

/*==============================================================*/
/* Table: osc_users 会员表*/
/*==============================================================*/
create table osc_users
(
id int unsigned not null auto_increment,
email varchar(40) not null,
name varchar(20) not null,
pwd varchar(40) not null,
type tinyint unsigned not null,
the_email varchar(40),
blog varchar(50),
MSN varchar(40),
QQ int unsigned not null,
portrait varchar(40),
gender tinyint not null,
birth date,
resume mediumtext,
company varchar(50),
job varchar(20),
province varchar(40),
city varchar(40),
role tinyint not null,
score smallint unsigned not null,
rank tinyint not null,
options int not null,
notify_email varchar(50),
notify_email_validated tinyint(1) not null,
status tinyint unsigned not null,
online tinyint not null default 0,
reg_time timestamp not null default CURRENT_TIMESTAMP,
this_login_time datetime,
this_login_ip varchar(16),
last_login_time datetime,
last_login_ip varchar(16),
activate_code char(40),
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_user_email */
/*==============================================================*/
create unique index idx_user_email on osc_users
(
email
);

drop table if exists osc_favorites;

/*==============================================================*/
/* Table: osc_favorites 用户收藏*/
/*==============================================================*/
create table osc_favorites
(
user int unsigned not null,
obj_id int unsigned not null,
type tinyint unsigned not null,
options tinyint not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
primary key (user, obj_id, type)
)
engine = MYISAM;

drop table if exists osc_friends;

/*==============================================================*/
/* Table: osc_friends 好友关系表*/
/*==============================================================*/
create table osc_friends
(
user int unsigned not null,
friend int unsigned not null,
tag tinyint not null,
method tinyint not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
primary key (user, friend)
)
engine = MYISAM;

drop table if exists osc_invites;

/*==============================================================*/
/* Table: osc_invites */
/*==============================================================*/
create table osc_invites
(
user int unsigned not null,
id int unsigned not null,
email varchar(40) not null,
name varchar(20),
code char(40) not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
accept_time datetime,
primary key (user, id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_email_of_invite 邀请记录表 */
/*==============================================================*/
create index idx_email_of_invite on osc_invites
(
email
);

drop table if exists osc_user_settings;

/*==============================================================*/
/* Table: osc_user_settings 用户个性化设置*/
/*==============================================================*/
create table osc_user_settings
(
user int not null,
name varchar(20) not null,
val varchar(100),
primary key (user, name)
)
engine = MYISAM;

alter table osc_user_settings add constraint FK_user_setting foreign key (user)
references osc_users (id) on delete cascade;

drop table if exists osc_events;

/*==============================================================*/
/* Table: osc_events 活动总表*/
/*==============================================================*/
create table osc_events
(
id int unsigned not null auto_increment,
type char not null,
catagory tinyint unsigned not null,
user int unsigned not null,
topic varchar(50) not null,
logo varchar(100),
schedule_time datetime,
period mediumint unsigned not null,
spot varchar(100) ,
tags varchar(100),
style char(5),
create_time timestamp not null default CURRENT_TIMESTAMP,
update_time datetime,
nation varchar(20),
province varchar(20),
city varchar(20),
district varchar(20),
access_type tinyint unsigned not null,
access_code varchar(10),
join_type tinyint unsigned not null,
join_code varchar(10),
join_dead_time datetime,
reply_type tinyint unsigned not null,
actor_limit smallint unsigned not null,
fee_type tinyint unsigned not null,
fee_detail varchar(50),
view_count mediumint unsigned not null,
actor_count mediumint unsigned not null,
reply_count mediumint unsigned not null,
photo_count mediumint unsigned not null,
attention_count mediumint unsigned not null,
contact_name varchar(20),
contact_tel varchar(20),
remark text,
status tinyint unsigned not null,
primary key (id)
);

/*==============================================================*/
/* Index: idx_a_owner */
/*==============================================================*/
create index idx_a_owner on osc_events
(
user
);

/*==============================================================*/
/* Index: idx_a_type */
/*==============================================================*/
create index idx_a_type on osc_events
(
type
);

/*==============================================================*/
/* Index: idx_a_spot */
/*==============================================================*/
create index idx_a_spot on osc_events
(
spot
);

drop table if exists osc_event_photos;

/*==============================================================*/
/* Table: osc_event_photos 活动照片 */
/*==============================================================*/
create table osc_event_photos
(
id bigint unsigned not null auto_increment,
event int unsigned not null,
user int unsigned not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
title varchar(40) not null,
memo varchar(255),
tags varchar(40),
client_type tinyint unsigned not null,
client_ip varchar(16) not null,
base_url varchar(100) not null,
ext char(3) not null comment '(jpg,gif,png)',
as_top tinyint unsigned not null,
width int not null,
height int not null,
photo_size int not null,
color_bit int not null,
manufacturer varchar(50),
model varchar(50),
iso int not null,
aperture varchar(20),
shutter varchar(20),
exposure_bias varchar(20),
exposure_time varchar(20),
focal_length varchar(20),
color_space varchar(20),
view_count int unsigned not null,
reply_count int unsigned not null,
primary key (id)
);

/*==============================================================*/
/* Index: idx_photo_open_status */
/*==============================================================
create index idx_photo_open_status on osc_event_photos
(

);
*/
/*==============================================================*/
/* Index: idx_photo_event */
/*==============================================================*/
create index idx_photo_event on osc_event_photos
(
event
);

/*==============================================================*/
/* Index: idx_photo_uploader */
/*==============================================================*/
create index idx_photo_uploader on osc_event_photos
(
user
);

drop table if exists osc_event_photo_comments;

/*==============================================================*/
/* Table: osc_event_photo_comments 相片评论表*/
/*==============================================================*/
create table osc_event_photo_comments
(
id bigint unsigned not null,
photo bigint unsigned not null,
user int unsigned not null,
event int unsigned not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
title varchar(40),
content mediumtext not null,
client_type tinyint unsigned not null,
client_ip varchar(16) not null,
as_top tinyint unsigned not null,
primary key (user, id)
);

/*==============================================================*/
/* Index: idx_p_comment_of_event */
/*==============================================================*/
create index idx_p_comment_of_event on osc_event_photo_comments
(
event
);

/*==============================================================*/
/* Index: idx_p_comment */
/*==============================================================*/
create index idx_p_comment on osc_event_photo_comments
(
photo
);

drop table if exists osc_event_options;

/*==============================================================*/
/* Table: osc_event_options 活动参数设定表 */
/*==============================================================*/
create table osc_event_options
(
event int unsigned not null,
pname varchar(20) not null,
pvalue text not null,
primary key (event, pname)
);

drop table if exists osc_event_actors;

/*==============================================================*/
/* Table: osc_event_actors 活动参与人 */
/*==============================================================*/
create table osc_event_actors
(
event int unsigned not null,
user int unsigned not null,
assessor int unsigned,
agree_time datetime,
attend_time timestamp not null default CURRENT_TIMESTAMP,
attend_status tinyint unsigned not null,
primary key (event, user)
);

drop table if exists osc_event_comments;

/*==============================================================*/
/* Table: osc_event_comments 活动评论表*/
/*==============================================================*/
create table osc_event_comments
(
id bigint unsigned not null,
event int unsigned not null,
user int unsigned not null,
client_type tinyint unsigned not null,
client_ip varchar(16) not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
title varchar(40),
content text not null,
refer_id bigint unsigned not null,
as_top tinyint unsigned not null,
primary key (event, user, id)
);

/*==============================================================*/
/* Index: idx_cmt_open_status */
/*==============================================================
create index idx_cmt_open_status on osc_event_comments
(

);
*/
drop table if exists osc_group_buy_items;

/*==============================================================*/
/* Table: osc_group_buy_items 团购 */
/*==============================================================*/
create table osc_group_buy_items
(
id int unsigned not null auto_increment,
user int unsigned not null,
title varchar(100) not null,
type tinyint unsigned not null,
good_name varchar(40) not null,
value int not null,
price int not null,
inventory smallint not null,
per_count smallint not null,
persons smallint not null,
buyers smallint not null,
begin_time datetime not null,
end_time datetime not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
detail text not null,
pic varchar(100) not null,
reply_count int not null,
view_count int not null,
thread bigint unsigned not null,
status tinyint not null,
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_buy_item_user */
/*==============================================================*/
create index idx_buy_item_user on osc_group_buy_items
(
user
);

drop table if exists osc_group_buyers;

/*==============================================================*/
/* Table: osc_group_buyers 团购参与人*/
/*==============================================================*/
create table osc_group_buyers
(
id int unsigned not null auto_increment,
item int unsigned not null,
user int unsigned not null,
order_no varchar(20) not null,
buy_count smallint not null,
pay_status tinyint not null,
money int not null,
post_addr varchar(200),
post_code char(6),
name varchar(40),
tel varchar(40),
pay_mode tinyint not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
update_time datetime,
buyer_id varchar(30),
buyer_email varchar(100),
trade_no varchar(64),
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_buyer */
/*==============================================================*/
create index idx_buyer on osc_group_buyers
(
user
);

/*==============================================================*/
/* Index: idx_order_no */
/*==============================================================*/
create unique index idx_order_no on osc_group_buyers
(
order_no
);

alter table osc_group_buyers add constraint FK_fk_group_buyer foreign key (item)
references osc_group_buy_items (id);

drop table if exists misc_emails;

/*==============================================================*/
/* Table: misc_emails 邮箱地址表*/
/*==============================================================*/
create table misc_emails
(
email varchar(50) not null,
status tinyint not null,
last_send_time datetime,
primary key (email)
)
engine = MYISAM;

drop table if exists misc_weekly_reports;

/*==============================================================*/
/* Table: misc_weekly_reports 每周精粹内容*/
/*==============================================================*/
create table misc_weekly_reports
(
id int unsigned not null auto_increment,
editor int unsigned not null,
scope tinyint not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
send_time datetime not null,
subject varchar(100) not null,
body text not null,
begin_time datetime,
end_time datetime,
send_count int not null,
fail_count int not null,
primary key (id)
)
engine = MYISAM;

drop table if exists osc_files;

/*==============================================================*/
/* Table: osc_files 附件表 */
/*==============================================================*/
create table osc_files
(
id int unsigned not null auto_increment,
user int unsigned not null,
folder int unsigned not null,
ident char(40) not null,
name varchar(50) not null,
type tinyint not null,
path varchar(100) not null,
url varchar(100) not null,
detail varchar(250),
size int unsigned not null,
dl_count int not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
options tinyint not null,
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_file_ident */
/*==============================================================*/
create unique index idx_file_ident on osc_files
(
ident
);

/*==============================================================*/
/* Index: idx_file_folder */
/*==============================================================*/
create index idx_file_folder on osc_files
(
folder
);

drop table if exists osc_block_ips;

/*==============================================================*/
/* Table: osc_block_ips 阻止的IP地址清单 */
/*==============================================================*/
create table osc_block_ips
(
id int unsigned not null auto_increment,
prefix varchar(16) not null,
module varchar(20),
create_time timestamp not null default CURRENT_TIMESTAMP,
block_count int not null,
primary key (id)
)
engine = MYISAM;

drop table if exists osc_lucene_tasks;

/*==============================================================*/
/* Table: osc_lucene_tasks 索引更新任务表*/
/*==============================================================*/
create table osc_lucene_tasks
(
id int unsigned not null auto_increment,
obj_id int unsigned not null,
obj_type tinyint not null,
opt tinyint not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
status tinyint not null,
handle_time datetime,
primary key (id)
)
engine = MYISAM;

drop table if exists osc_opt_logs;

/*==============================================================*/
/* Table: osc_opt_logs 用户操作日志表*/
/*==============================================================*/
create table osc_opt_logs
(
user int unsigned not null,
obj_type tinyint unsigned not null,
obj_id bigint unsigned not null,
parent_type tinyint not null,
parent_id bigint not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
primary key (user, obj_type, obj_id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_log_parent */
/*==============================================================*/
create index idx_log_parent on osc_opt_logs
(
parent_type,
parent_id
);

/*==============================================================*/
/* Index: idx_log_time */
/*==============================================================*/
create index idx_log_time on osc_opt_logs
(
create_time
);

drop table if exists osc_ads;

/*==============================================================*/
/* Table: osc_ads 广告信息表*/
/*==============================================================*/
create table osc_ads
(
id int unsigned not null auto_increment,
name varchar(50) not null,
url varchar(255) not null,
click_count int unsigned not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
expired_time datetime,
status tinyint not null,
primary key (id)
)
engine = MYISAM;

drop table if exists osc_news;

/*==============================================================*/
/* Table: osc_news 新闻*/
/*==============================================================*/
create table osc_news
(
id int unsigned not null auto_increment,
type tinyint not null,
title varchar(100) not null,
detail text,
project int unsigned not null,
ident varchar(50),
pic varchar(100),
pub_time date not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
last_update datetime,
editor int unsigned not null,
keyword varchar(50),
source varchar(20),
original_url varchar(100),
view_count mediumint unsigned not null default 0,
reply_count mediumint unsigned not null default 0,
show_in_home tinyint(1) not null default 0,
as_recomm tinyint(1) not null,
flag tinyint not null,
status tinyint not null,
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_product_news */
/*==============================================================*/
create index idx_product_news on osc_news
(
project
);

/*==============================================================*/
/* Index: idx_news_type */
/*==============================================================*/
create index idx_news_type on osc_news
(
type
);

/*==============================================================*/
/* Index: idx_news_pub_time */
/*==============================================================*/
create index idx_news_pub_time on osc_news
(
pub_time
);

drop table if exists osc_news_comments;

/*==============================================================*/
/* Table: osc_news_comments 新闻评论 */
/*==============================================================*/
create table osc_news_comments
(
id int unsigned not null,
user int unsigned not null,
name varchar(20) not null,
email varchar(40),
url varchar(100),
news int unsigned not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
client_ip char(15) not null,
fmt tinyint not null,
content mediumtext,
primary key (id, user)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_comment_of_news */
/*==============================================================*/
create index idx_comment_of_news on osc_news_comments
(
news
);

/*==============================================================*/
/* Index: idx_user_comment */
/*==============================================================*/
create index idx_user_comment on osc_news_comments
(
user
);

drop table if exists osc_rss_items;

/*==============================================================*/
/* Table: osc_rss_items RSS信息临时存放表 */
/*==============================================================*/
create table osc_rss_items
(
id int unsigned not null auto_increment,
title varchar(100) not null,
link varchar(100) not null,
uuid char(40) not null,
pubdate date not null,
description text,
status tinyint not null,
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_uuid_of_rssitem */
/*==============================================================*/
create unique index idx_uuid_of_rssitem on osc_rss_items
(
uuid
);

drop table if exists osc_user_projects;

/*==============================================================*/
/* Table: osc_user_projects 用户发布的项目表 */
/*==============================================================*/
create table osc_user_projects
(
id int unsigned not null auto_increment,
user int unsigned not null,
name varchar(50) not null,
detail mediumtext not null,
home_url varchar(100),
doc_url varchar(100),
download_url varchar(100),
project int unsigned not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
status tinyint,
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_user_project */
/*==============================================================*/
create index idx_user_project on osc_user_projects
(
user
);

/*==============================================================*/
/* Index: idx_user_project_status */
/*==============================================================*/
create index idx_user_project_status on osc_user_projects
(
status
);

drop table if exists osc_weekly_projects;

/*==============================================================*/
/* Table: osc_weekly_projects 每周软件推荐 */
/*==============================================================*/
create table osc_weekly_projects
(
id int unsigned not null auto_increment,
project int unsigned not null,
recomm_time timestamp not null default CURRENT_TIMESTAMP,
detail text not null,
user int unsigned not null,
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_weekly_project */
/*==============================================================*/
create index idx_weekly_project on osc_weekly_projects
(
project
);

drop table if exists osc_projects;

/*==============================================================*/
/* Table: osc_projects 项目表 */
/*==============================================================*/
create table osc_projects
(
id int unsigned not null auto_increment,
user int unsigned not null,
name varchar(50) not null,
ident varchar(40) not null,
title varchar(50),
license varchar(20),
logo varchar(40),
tag int unsigned not null,
keyword varchar(40),
keywords varchar(200),
type tinyint not null comment '1:开源 2:免费非开源 3:共享 4:商业',
detail mediumtext,
home_url varchar(100),
doc_url varchar(100),
download_url varchar(100),
update_url varchar(100),
create_time timestamp not null default CURRENT_TIMESTAMP,
last_update datetime,
rank tinyint not null default 0,
recomm tinyint not null,
recomm_time datetime,
active_value tinyint not null default 0,
view_count mediumint unsigned not null default 0,
reply_count mediumint unsigned not null default 0,
attention_count mediumint unsigned not null default 0,
case_count mediumint unsigned not null default 0,
version int unsigned not null,
status tinyint not null default 1,
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_prj_ident */
/*==============================================================*/
create unique index idx_prj_ident on osc_projects
(
ident
);

/*==============================================================*/
/* Index: idx_prj_user */
/*==============================================================*/
create index idx_prj_user on osc_projects
(
user
);

/*==============================================================*/
/* Index: idx_prj_recomm */
/*==============================================================*/
create index idx_prj_recomm on osc_projects
(
recomm,
recomm_time
);

drop table if exists osc_project_versions;

/*==============================================================*/
/* Table: osc_project_versions 项目历史版本信息表*/
/*==============================================================*/
create table osc_project_versions
(
project int unsigned not null auto_increment,
version int unsigned not null,
name varchar(50) not null,
title varchar(50),
license varchar(20),
keyword varchar(40),
keywords varchar(200),
detail mediumtext,
home_url varchar(100),
doc_url varchar(100),
download_url varchar(100),
update_url varchar(100),
create_time timestamp not null default CURRENT_TIMESTAMP,
primary key (project, version)
)
engine = MYISAM;

drop table if exists osc_tags;

/*==============================================================*/
/* Table: osc_tags 分类目录*/
/*==============================================================*/
create table osc_tags
(
id int unsigned not null auto_increment,
parent int unsigned not null default 0,
ident varchar(20),
name varchar(40) not null,
detail mediumtext,
sorder smallint unsigned not null default 0,
flag tinyint not null default 1,
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_tag_parent */
/*==============================================================*/
create index idx_tag_parent on osc_tags
(
parent
);

drop table if exists osc_p2tags;

/*==============================================================*/
/* Table: osc_p2tags 项目分类关系*/
/*==============================================================*/
create table osc_p2tags
(
row int unsigned not null auto_increment,
project int unsigned not null,
tag int unsigned not null,
primary key (row)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_pt_project */
/*==============================================================*/
create index idx_pt_project on osc_p2tags
(
project
);

/*==============================================================*/
/* Index: idx_pt_tag */
/*==============================================================*/
create index idx_pt_tag on osc_p2tags
(
tag
);

drop table if exists osc_tag_links;

/*==============================================================*/
/* Table: osc_tag_links 标签热门关键词 */
/*==============================================================*/
create table osc_tag_links
(
id int unsigned not null auto_increment,
tag int unsigned not null,
title varchar(50) not null,
link varchar(100) not null,
img varchar(100),
type tinyint,
sort_order int not null,
disp_in_home tinyint(1) not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_link_of_tag */
/*==============================================================*/
create index idx_link_of_tag on osc_tag_links
(
tag
);

drop table if exists osc_msg_sents;

/*==============================================================*/
/* Table: osc_msg_sents站内留言 */
/*==============================================================*/
create table osc_msg_sents
(
id int unsigned not null,
sender int unsigned not null,
receiver int unsigned not null,
type tinyint not null,
content varchar(1000) not null,
send_time timestamp not null default CURRENT_TIMESTAMP,
read_time datetime,
status tinyint not null,
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_msg_sender */
/*==============================================================*/
create index idx_msg_sender on osc_msg_sents
(
sender
);

drop table if exists osc_drafts;

/*==============================================================*/
/* Table: osc_drafts 草稿表 */
/*==============================================================*/
create table osc_drafts
(
id int unsigned not null auto_increment,
space int unsigned not null,
catalog int unsigned not null,
project int unsigned not null,
title varchar(100) not null,
content text not null,
origin_url varchar(100),
music_url varchar(250),
save_time timestamp not null default CURRENT_TIMESTAMP,
type tinyint not null,
primary key (id)
)
engine = MYISAM;

drop table if exists osc_msgs;

/*==============================================================*/
/* Table: osc_msgs 站内留言 */
/*==============================================================*/
create table osc_msgs
(
id int unsigned not null auto_increment,
sender int unsigned not null,
receiver int unsigned not null,
type tinyint not null,
content varchar(1000) not null,
send_time timestamp not null default CURRENT_TIMESTAMP,
read_time datetime,
status tinyint not null,
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_msg_user */
/*==============================================================*/
create index idx_msg_user on osc_msgs
(
receiver
);

drop table if exists osc_spaces;

/*==============================================================*/
/* Table: osc_spaces 个人空间 */
/*==============================================================*/
create table osc_spaces
(
id int unsigned not null comment '值跟用户编号相同',
ident varchar(20) not null,
name varchar(40) not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
last_update datetime,
flag tinyint not null,
type tinyint not null,
status tinyint not null,
view_count int unsigned not null,
title varchar(100),
keywords varchar(200),
detail varchar(1000),
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_space_ident */
/*==============================================================*/
create unique index idx_space_ident on osc_spaces
(
ident
);

drop table if exists osc_space_visit_records;

/*==============================================================*/
/* Table: osc_space_visit_records空间访问统计表 */
/*==============================================================*/
create table osc_space_visit_records
(
id bigint unsigned not null auto_increment,
space int unsigned not null,
user int unsigned not null comment '0 表示游客',
ip char(15) not null,
visit_time timestamp not null default CURRENT_TIMESTAMP,
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_space_of_stat */
/*==============================================================*/
create index idx_space_of_stat on osc_space_visit_records
(
space
);

drop table if exists osc_links;

/*==============================================================*/
/* Table: osc_links 友情链接*/
/*==============================================================*/
create table osc_links
(
id int unsigned not null auto_increment,
space int unsigned not null,
sort_order smallint unsigned not null,
type tinyint not null,
title varchar(50) not null,
url varchar(100) not null,
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_link_of_space */
/*==============================================================*/
create index idx_link_of_space on osc_links
(
space
);

drop table if exists osc_blog_catalogs;

/*==============================================================*/
/* Table: osc_blog_catalogs 博客分类*/
/*==============================================================*/
create table osc_blog_catalogs
(
id int unsigned not null auto_increment,
space int unsigned not null,
name varchar(50) not null,
sort_order smallint unsigned not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
type tinyint not null,
options tinyint not null,
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_blog_catalog_of_space */
/*==============================================================*/
create index idx_blog_catalog_of_space on osc_blog_catalogs
(
space
);

drop table if exists osc_blogs;

/*==============================================================*/
/* Table: osc_blogs */
/*==============================================================*/
create table osc_blogs
(
id int unsigned not null auto_increment,
space int unsigned not null,
catalog int unsigned not null,
project int unsigned not null,
title varchar(100) not null,
ident varchar(100),
content text not null,
tags varchar(100),
type tinyint not null,
origin_url varchar(100),
music_url varchar(250),
create_time timestamp not null default CURRENT_TIMESTAMP,
view_count mediumint unsigned not null default 0,
reply_count mediumint unsigned not null default 0,
extid bigint unsigned not null,
folder tinyint not null,
options tinyint not null,
as_top tinyint not null default 0,
primary key (id)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_blog_of_space */
/*==============================================================*/
create index idx_blog_of_space on osc_blogs
(
space
);

/*==============================================================*/
/* Index: idx_blog_of_catalog */
/*==============================================================*/
create index idx_blog_of_catalog on osc_blogs
(
catalog
);

/*==============================================================*/
/* Index: idx_blog_folder */
/*==============================================================*/
create index idx_blog_folder on osc_blogs
(
folder
);

drop table if exists osc_blog_comments;

/*==============================================================*/
/* Table: osc_blog_comments 博客评论 */
/*==============================================================*/
create table osc_blog_comments
(
id int unsigned not null,
user int unsigned not null,
space int unsigned not null,
name varchar(20) not null,
email varchar(40),
url varchar(100),
blog int unsigned not null,
create_time timestamp not null default CURRENT_TIMESTAMP,
client_ip char(15) not null,
content mediumtext not null,
primary key (id, user)
)
engine = MYISAM;

/*==============================================================*/
/* Index: idx_blog_comment_of_space */
/*==============================================================*/
create index idx_blog_comment_of_space on osc_blog_comments
(
space
);

/*==============================================================*/
/* Index: idx_comment_of_blog */
/*==============================================================*/
create index idx_comment_of_blog on osc_blog_comments
(
blog
);

/*==============================================================*/
/* Index: idx_blog_comment_of_user */
/*==============================================================*/
create index idx_blog_comment_of_user on osc_blog_comments
(
user
);


