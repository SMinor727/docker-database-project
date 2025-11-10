CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(120) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE events (
  event_id SERIAL PRIMARY KEY,
  organizer_id INT NOT NULL REFERENCES users(user_id),
  title VARCHAR(150) NOT NULL,
  location VARCHAR(150) NOT NULL,
  start_at TIMESTAMP NOT NULL,
  capacity INT NOT NULL CHECK (capacity > 0),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE attendees (
  attendee_id SERIAL PRIMARY KEY,
  event_id INT NOT NULL REFERENCES events(event_id) ON DELETE CASCADE,
  user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
  status VARCHAR(20) NOT NULL CHECK (status IN ('registered','waitlisted','canceled','checked_in')),
  waitlist_position INT,
  registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  checked_in_at TIMESTAMP,
  canceled_at TIMESTAMP,
  CONSTRAINT uniq_event_user UNIQUE (event_id, user_id)
);

CREATE VIEW event_attendance_summary AS
SELECT e.event_id, e.title, e.capacity,
  SUM(CASE WHEN a.status='registered' THEN 1 ELSE 0 END) AS registered_count,
  SUM(CASE WHEN a.status='checked_in' THEN 1 ELSE 0 END) AS checked_in_count,
  SUM(CASE WHEN a.status='waitlisted' THEN 1 ELSE 0 END) AS waitlisted_count,
  SUM(CASE WHEN a.status='canceled' THEN 1 ELSE 0 END) AS canceled_count
FROM events e
LEFT JOIN attendees a ON e.event_id=a.event_id
GROUP BY e.event_id,e.title,e.capacity;

CREATE TABLE feedback (
    feedback_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    event_id INT REFERENCES events(event_id),
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comments TEXT,
    suggestions TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(student_id, event_id)
);