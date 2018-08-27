CREATE DATABASE 'foobar';
CREATE USER 'foouser'@'localhost' IDENTIFIED BY 'foopass';
GRANT ALL PRIVILEGES ON foobar.* TO 'foouser'@'localhost';

