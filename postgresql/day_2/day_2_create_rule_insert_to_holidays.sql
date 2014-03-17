CREATE RULE insert_holidays AS ON INSERT TO holidays DO INSTEAD
INSERT INTO events (title, starts)
VALUES (NEW.name, NEW.date);