PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    question_id INTEGER NOT NULL,
    parent_id INTEGER,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_id) REFERENCES replies(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
    users (fname, lname)
VALUES
    ('Philip', 'Lowe'),
    ('Julia', 'Kim'),
    ('Darren', 'Eid');


INSERT INTO
    questions (title, body, author_id)
VALUES
    ('SQL', 'How do I make a database :(', (SELECT id FROM users WHERE fname = 'Philip')),
    ('Ruby', 'How do I make a class :(', (SELECT id FROM users WHERE fname = 'Julia')),
    ('General', 'Do ur hoemwork', (SELECT id FROM users WHERE fname = 'Darren'));

INSERT INTO
    replies(body, question_id, parent_id, user_id)
VALUES  
    ('IDK LOL', 1, NULL, 2), 
    ('Okay Thank you......',1, 1, 1),
    ('you just type class', 2, NULL, 2), 
    ('Okay Thank you......',3, NULL, 1),
    ('Okay Thank you......',2, 2, 1);


INSERT INTO 
    question_follows(user_id, question_id)
VALUES
    (1,1),
    (2,1),
    (3,1),
    (2,2),
    (1,3),
    (2,3);