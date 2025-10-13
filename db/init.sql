-- Projects table
CREATE TABLE IF NOT EXISTS projects (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE
);

-- Tasks table
CREATE TABLE IF NOT EXISTS tasks (
    id SERIAL PRIMARY KEY,
    project_id INT REFERENCES projects(id),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    status VARCHAR(50),
    priority VARCHAR(50),
    due_date DATE,
    story_points INT,
    actual_days INT,
    external_id VARCHAR(255),   -- Jira issue key if applicable
    source VARCHAR(50)          -- 'local' or 'jira'
);

-- Dependencies table
CREATE TABLE IF NOT EXISTS dependencies (
    id SERIAL PRIMARY KEY,
    task_id INT REFERENCES tasks(id),
    depends_on_task_id INT REFERENCES tasks(id)
);

-- Seed data
INSERT INTO projects (name, description, start_date, end_date)
VALUES ('Demo Project', 'Initial seeded project', CURRENT_DATE, CURRENT_DATE + INTERVAL '30 days')
ON CONFLICT DO NOTHING;

INSERT INTO tasks (project_id, title, description, status, priority, due_date, story_points, actual_days, external_id, source)
VALUES (1, 'Initial Task', 'Seeded example task', 'TODO', 'Medium', CURRENT_DATE + INTERVAL '7 days', 3, 5, NULL, 'local')
ON CONFLICT DO NOTHING;

