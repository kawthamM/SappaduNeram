-- seed.sql - minimal seed data

INSERT INTO users (email, name) VALUES
(''dev@example.com'', ''Developer'')
ON CONFLICT DO NOTHING;

INSERT INTO restaurants (name, cuisine, address) VALUES
(''Madras Mess'', ''South Indian'', ''Chennai''),
(''Annas Biryani'', ''Biryani'', ''Chennai'')
ON CONFLICT DO NOTHING;
