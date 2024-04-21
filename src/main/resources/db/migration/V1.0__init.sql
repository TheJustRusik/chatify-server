--Users and roles
create table users (
    id              bigserial primary key,
    nickname        varchar(128) unique not null,
    first_name      varchar(64) not null,
    second_name     varchar(64),
    email           varchar(128) not null unique,
    password        varchar(80) not null,
    created_time    timestamp not null DEFAULT CURRENT_TIMESTAMP
);

create table roles (
    id              serial primary key,
    role            varchar(16) not null unique
);

create table user_roles (
    role_id         int references roles,
    user_id         bigint references users
);

--Messages
create table messages (
    id              bigserial primary key,
    sender          bigint not null references users,
    recipient       bigint not null references users,
    message         text not null,
    created_time    timestamp not null DEFAULT CURRENT_TIMESTAMP
);

create table message_reactions (
    message_id      int references messages,
    sender_id       bigint references users,
    reaction        varchar(8) not null
);

--Posts, likes, comments
create table posts (
    id              bigserial primary key,
    author          bigint not null references users,
    text_content    text,
    created_time    timestamp not null DEFAULT CURRENT_TIMESTAMP,
    likes           bigint default 0,
    comments        bigint default 0
);

create table post_likes (
    user_id         bigint references users,
    post_id         bigint references posts,
    created_time    timestamp not null DEFAULT CURRENT_TIMESTAMP,
    primary key (user_id, post_id)
);

create table comments (
    id              bigserial primary key,
    author          bigint references users not null,
    post_id         bigint references posts,
    comment_id      bigint references comments,
    message         text not null,
    created_time    timestamp not null DEFAULT CURRENT_TIMESTAMP
);

create table comment_likes (
    user_id         bigint references users,
    comment_id      bigint references comments,
    created_time    timestamp not null DEFAULT CURRENT_TIMESTAMP,
    primary key (user_id, comment_id)
);

