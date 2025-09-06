-- Pre-populate Admin Table with Single Admin Record
USE [shifathasan];
GO

-- Clear existing admin records (if any)
DELETE FROM [admin];
GO

-- Insert the single admin record
INSERT INTO [admin] (
    is_signed_in, 
    signed_in_count, 
    name,
    country, 
    university, 
    current_institution, 
    email, 
    github, 
    linkedin, 
    facebook, 
    instagram, 
    youtube
) VALUES (
    0, -- Not signed in initially
    0, -- Zero sign-in count initially
    'Md. Shifat Hasan', -- Full name
    'Bangladesh', -- Country
    'KUET (Khulna University of Engineering and Technology)', -- University
    'KUET (Khulna University of Engineering and Technology)', -- Current institution
    'shifathasangns@gmail.com', -- IMPORTANT: Replace with actual admin email
    'https://github.com/ShifatHasanGNS', -- GitHub profile
    'https://www.linkedin.com/in/mdshifathasan/', -- LinkedIn profile
    'https://www.facebook.com/ShifatHasanGNS/', -- Facebook profile
    'https://www.instagram.com/ShifatHasanGNS/', -- Instagram profile
    'https://www.youtube.com/@shifathasangns' -- YouTube channel
);
GO

-- Verify the insertion
SELECT * FROM [admin];
GO
