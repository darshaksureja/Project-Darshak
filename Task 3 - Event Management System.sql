-- 1. Database Creation

-- CREATE DATABASE EventsManagement;
-- Connect to the EventsManagement database

-- Create the Events table
CREATE TABLE Events (
    Event_Id SERIAL PRIMARY KEY,
    Event_Name TEXT,
    Event_Date DATE,
    Event_Location TEXT,
    Event_Description TEXT
);

-- Create the Attendees table
CREATE TABLE Attendees (
    Attendee_Id SERIAL PRIMARY KEY,
    Attendee_Name TEXT,
    Attendee_Phone TEXT,
    Attendee_Email TEXT,
    Attendee_City TEXT
);

-- Create the Registrations table
CREATE TABLE Registrations (
    Registration_Id SERIAL PRIMARY KEY,
    Event_Id INT,
    Attendee_Id INT,
    Registration_Date DATE,
    Registration_Amount NUMERIC,
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id),
    FOREIGN KEY (Attendee_Id) REFERENCES Attendees(Attendee_Id)
);

-- 2. Data Creation
-- Insert sample data for Events, Attendees, and Registrations tables
INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES
    ('Conference 2023', '2023-11-15', 'City Convention Center', 'Annual tech conference'),
    ('Music Festival', '2023-08-20', 'Central Park', 'Outdoor music event');

INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES
    ('Alice Johnson', '555-123-4567', 'alice@email.com', 'New York'),
    ('Bob Smith', '987-654-3210', 'bob@email.com', 'Los Angeles');

INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES
    (1, 1, '2023-11-05', 100.00),
    (2, 2, '2023-07-15', 50.00);

-- 3. Manage Event Details
-- a. Inserting a new event
INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES ('Workshop', '2023-10-10', 'Online', 'Hands-on workshop on web development');

-- b. Updating an event's information
UPDATE Events
SET Event_Location = 'City Hall'
WHERE Event_Name = 'Conference 2023';

-- c. Deleting an event

-- Drop the existing foreign key constraint
ALTER TABLE Registrations DROP CONSTRAINT registrations_event_id_fkey;

-- Add a new foreign key constraint with ON DELETE CASCADE
ALTER TABLE Registrations
ADD CONSTRAINT registrations_event_id_fkey
FOREIGN KEY (Event_Id)
REFERENCES Events(Event_Id)
ON DELETE CASCADE;

DELETE FROM Events
WHERE Event_Name = 'Music Festival';

-- 4. Manage Track Attendees & Handle Events
-- a. Inserting a new attendee
INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES ('Catherine Lee', '123-456-7890', 'catherine@email.com', 'Chicago');

-- b. Registering an attendee for an event
INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES (1, 3, '2023-10-12', 75.00);

-- 5. Develop queries to retrieve information

-- Total registration amount for each event
SELECT e.Event_Name, SUM(r.Registration_Amount) AS Total_Amount
FROM Events e
JOIN Registrations r ON e.Event_Id = r.Event_Id
GROUP BY e.Event_Name;

-- List of attendees for a specific event
SELECT a.Attendee_Name
FROM Attendees a
JOIN Registrations r ON a.Attendee_Id = r.Attendee_Id
WHERE r.Event_Id = 1;






