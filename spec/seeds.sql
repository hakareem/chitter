TRUNCATE TABLE users, posts RESTART IDENTITY;

INSERT INTO users (name, username, email, password) VALUES ('Moe', 'moeez', 'moeez@gmail.com', 'strong123');
INSERT INTO users (name, username, email, password) VALUES ('Joe', 'joeez', 'joeez@gmail.com', 'weak123');
INSERT INTO users (name, username, email, password) VALUES ('Foe', 'foeez', 'foeez@gmail.com', 'wicked123');


INSERT INTO posts (message, timestamp, user_id) VALUES ('first message', '2022-03-01 12:00:00', 1);
INSERT INTO posts (message, timestamp, user_id) VALUES ('second message', '2022-12-04 12:00:00', 2);
INSERT INTO posts (message, timestamp, user_id) VALUES ('third message', '2022-10-06 12:00:00', 3);


