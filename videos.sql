CREATE TABLE videos(
  id serial8 primary key, 
  artist varchar(225),
  title varchar(225),
  description text,
  category varchar(225),
  genre varchar(30),
  url varchar(225)
);