-- psql -U dev -d noteful-app -f ./noteful-app.sql

-- Wipes table so this file can recreate it each time it is ran
DROP TABLE IF EXISTS notes_tags;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS notes;
DROP TABLE IF EXISTS folders;


CREATE TABLE folders (
  id int GENERATED ALWAYS AS IDENTITY (START WITH 100) PRIMARY KEY,
  name text NOT NULL
);

INSERT INTO folders (name) VALUES
  ('Archive'),
  ('Drafts'),
  ('Personal'),
  ('Work');

-- SELECT * FROM folders;


-- Sequence from 1000 using Postgres 10.X identity generators
CREATE TABLE notes (
  id int GENERATED ALWAYS AS IDENTITY (START WITH 1000) PRIMARY KEY, 
  title text NOT NULL, 
  content text, 
  created timestamp default now(),
  folder_id int REFERENCES folders(id) ON DELETE SET NULL
);



INSERT INTO notes (title, content, folder_id) VALUES
  ('5 life lessons learned from cats', 'Lorem ipsum.', 102),
  ('What the government doesn''t want you to know about cats', 'Posuere sollicitudin aliquam.', 102),
  ('The most boring article about cats you''ll ever read', 'Lorem ipsum dolor.', 102),
  ('Cats are cool. Just kidding.', 'Posuere sollicitudin aliquam nisl.', 102),
  ('7 things lady gaga has in common with cats', 'Lorem id est laborum.', 100),
  ('The most incredible article about cats you''ll ever read', 'mollit anim id est laborum.', 100),
  ('What the government doesn''t want you to know about dogs', 'Posuere sollicitudin aliquam.', 100),
  ('The most exciting article about dogs you''ll ever read', 'Lorem ipsum dolor.', 100),
  ('Dogs are cool. Not just kidding.', 'Posuere sollicitudin aliquam nisl.', 100),
  ('7 things jesus has in common with dogs', 'Lorem id est laborum.', 101);
  
INSERT INTO notes (title, content) VALUES
  ('We''re going to talk about dogs now', 'Lorem ipsum.'),
  ('Dogs dogs dogs dogs dogs. PUPPIES! Dogs.', 'mollit anim id est laborum.');

CREATE TABLE tags (
id serial NOT NULL PRIMARY KEY,
name text NOT NULL UNIQUE
);

INSERT INTO tags (name) VALUES
   ('work'),
   ('play'),
   ('school');

-- SELECT * FROM tags;

CREATE TABLE notes_tags (
  note_id INTEGER NOT NULL REFERENCES notes ON DELETE CASCADE,
  tag_id INTEGER NOT NULL REFERENCES tags ON DELETE CASCADE
);

INSERT INTO notes_tags (note_id, tag_id) VALUES
  (1000, 1),
  (1001,2),
  (1002,3),
  (1002,2),
  (1002,1),
  (1003,1),
  (1004,2),
  (1005,3),
  (1006,1),
  (1007,2),
  (1008,3),
  (1008,2),
  (1009,1),
  (1010,2);

-- SELECT title, tags.name, folders.name FROM notes
-- LEFT JOIN folders ON notes.folder_id = folders.id
-- LEFT JOIN notes_tags ON notes.id = notes_tags.note_id
-- LEFT JOIN tags ON notes_tags.tag_id = tags.id;

-- SELECT * FROM notes;

-- get all notes with folders
-- SELECT * FROM notes
-- INNER JOIN folders ON notes.folder_id = folders.id;

-- get all notes, show folders if they exists otherwise null
-- SELECT * FROM notes
-- LEFT JOIN folders ON notes.folder_id = folders.id;

-- get all notes, show folders if they exists otherwise null
-- SELECT * FROM notes
-- LEFT JOIN folders ON notes.folder_id = folders.id
-- WHERE notes.id = 1005;

-- SELECT * FROM folders where id = 102;