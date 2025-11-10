CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE events (
    event_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    event_date DATE NOT NULL
);

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


