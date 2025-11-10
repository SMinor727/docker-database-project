INSERT INTO users(full_name,email) VALUES
('Sekou Organizer','sekou@gatherpoint.example'),
('Shefe Attendee','shefe@example.com'),
('Sydney Attendee','sydney@example.com'),
('Gabby Attendee','gabby@example.com'),
('William Attendee','william@example.com');

INSERT INTO events(organizer_id,title,location,start_at,capacity)
VALUES(1,'Intro to Data Viz','Room ITE 456',NOW()+INTERVAL '7 days',2);

SELECT register_user(1,2);
SELECT register_user(1,3);
SELECT register_user(1,4);
SELECT register_user(1,5);

UPDATE attendees SET status='canceled',canceled_at=NOW()
WHERE event_id=1 AND user_id=3;


INSERT INTO feedback (student_id, event_id, rating, comments, suggestions) VALUES
(1, 1, 5, 'Great event!', 'More hands-on activities'),
(2, 2, 4, 'Informative', 'Longer Q&A session');

