INSERT INTO users(full_name,email) VALUES
('Sekou Organizer','sekou@gatherpoint.example'),
('Shefe Attendee','shefe@example.com'),
('Sydney Attendee','sydney@example.com'),
('Gabby Attendee','gabby@example.com'),
('William Attendee','william@example.com');

INSERT INTO venues (name, building, room, address, capacity) VALUES
('Sherman Hall Auditorium', 'Sherman Hall', 'AUD', '1000 Hilltop Circle, Baltimore, MD', 250),
('ITE Lab 456', 'ITE Building', '456', '1000 Hilltop Circle, Baltimore, MD', 40);

INSERT INTO events (title, description, start_time, end_time, capacity, status, organizer_id, venue_id) VALUES
('Intro to SQL', 'Hands-on session for SQL basics.', NOW(), NOW() + INTERVAL '2 HOURS', 40, 'published', 1, 2),
('Career Night with Alumni', 'Panel and networking with alumni.', NOW() + INTERVAL '1 DAY', NOW() + INTERVAL '1 DAY 3 HOURS', 200, 'published', 1, 1);

INSERT INTO feedback (user_id, event_id, rating, comments, suggestions) VALUES
(1, 1, 5, 'Great event!', 'More hands-on activities'),
(2, 2, 4, 'Informative', 'Longer Q&A session');

