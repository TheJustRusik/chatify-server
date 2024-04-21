--Users and roles
create table if not exists users (
    id              bigserial primary key,
    nickname        varchar(128) unique not null,
    first_name      varchar(64) not null,
    second_name     varchar(64),
    email           varchar(128) not null unique,
    password        varchar(80) not null,
    created_time    timestamp not null DEFAULT CURRENT_TIMESTAMP
);

create table if not exists roles (
    id              serial primary key,
    role            varchar(16) not null unique
);

create table if not exists user_roles (
    role_id         int references roles,
    user_id         bigint references users
);

create table if not exists relations (
    id              serial primary key,
    name            varchar(16) not null unique
);

create table if not exists relationship (
    initiator       bigint references users,
    victim          bigint references users,
    relation_type   int references relations,
    created_time    timestamp not null DEFAULT CURRENT_TIMESTAMP
);

--Messages
create table if not exists messages (
    id              bigserial primary key,
    sender          bigint not null references users,
    recipient       bigint not null references users,
    message         text not null,
    created_time    timestamp not null DEFAULT CURRENT_TIMESTAMP
);

create table if not exists message_reactions (
    message_id      int references messages,
    sender_id       bigint references users,
    reaction        varchar(8) not null
);

--Posts, likes, comments
create table if not exists posts (
    id              bigserial primary key,
    author          bigint not null references users,
    text_content    text,
    created_time    timestamp not null DEFAULT CURRENT_TIMESTAMP,
    likes           bigint default 0,
    comments        bigint default 0
);

create table if not exists post_likes (
    user_id         bigint references users,
    post_id         bigint references posts,
    created_time    timestamp not null DEFAULT CURRENT_TIMESTAMP,
    primary key (user_id, post_id)
);

create table if not exists comments (
    id              bigserial primary key,
    author          bigint references users not null,
    post_id         bigint references posts,
    comment_id      bigint references comments,
    message         text not null,
    created_time    timestamp not null DEFAULT CURRENT_TIMESTAMP
);

create table if not exists comment_likes (
    user_id         bigint references users,
    comment_id      bigint references comments,
    created_time    timestamp not null DEFAULT CURRENT_TIMESTAMP,
    primary key (user_id, comment_id)
);

insert into users values
                      (1, 'TheJustRusik', 'Ruslan', '', '7thejustrusik9@gmail.com', '$2a$05$4yj17z9Ciges6y8F/C1PQuTmsqeW2/qoG0EDIPu/O4nThLWrHKes6', CURRENT_TIMESTAMP);
