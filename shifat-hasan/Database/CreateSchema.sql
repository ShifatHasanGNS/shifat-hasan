-- MS SQL Server 2022 Express Tables Creation Script
-- Creates 4 tables in existing database: shifathasan

USE [shifathasan];
GO

DROP TABLE IF EXISTS [user];
DROP TABLE IF EXISTS [contact];
DROP TABLE IF EXISTS [showcase];
DROP TABLE IF EXISTS [admin];

-- Create USER Table
CREATE TABLE [user] (
    user_email NVARCHAR(255) NOT NULL UNIQUE,
    user_name NVARCHAR(255) NOT NULL,
    PRIMARY KEY (user_email)
);

-- Create indexes for sorting
CREATE INDEX IX_user_user_name ON [user] (user_name);
CREATE INDEX IX_user_user_email ON [user] (user_email);
GO

-- Create CONTACT Table
CREATE TABLE [contact] (
    id INT IDENTITY(1,1) PRIMARY KEY,
    datetime_user_feedback DATETIME2 NULL,
    datetime_admin_reply DATETIME2 NULL,
    user_email NVARCHAR(255) NOT NULL UNIQUE,
    user_name NVARCHAR(255) NOT NULL,
    user_message_title NVARCHAR(500) NULL,
    user_message_body NTEXT NULL,
    admin_message_title NVARCHAR(500) NULL,
    admin_message_body NTEXT NULL
);

-- Create indexes for sorting
CREATE INDEX IX_contact_datetime_user_feedback ON [contact] (datetime_user_feedback);
CREATE INDEX IX_contact_datetime_admin_reply ON [contact] (datetime_admin_reply);
CREATE INDEX IX_contact_user_name ON [contact] (user_name);
CREATE INDEX IX_contact_user_email ON [contact] (user_email);
GO

-- Create SHOWCASE Table
CREATE TABLE [showcase] (
    id INT IDENTITY(1,1) PRIMARY KEY,
    type NVARCHAR(255) NOT NULL,
    title NVARCHAR(500) NOT NULL,
    description NTEXT NULL,
    url_cover_image NVARCHAR(2048) NULL,
    url_github NVARCHAR(2048) NULL,
    url_drive NVARCHAR(2048) NULL,
    url_youtube NVARCHAR(2048) NULL,
    url_other NVARCHAR(2048) NULL
);

-- Create indexes for sorting
CREATE INDEX IX_showcase_type ON [showcase] (type);
CREATE INDEX IX_showcase_title ON [showcase] (title);
GO

-- Create ADMIN Table
CREATE TABLE [admin] (
    is_signed_in BIT NOT NULL DEFAULT 0,
    signed_in_count INT NOT NULL DEFAULT 0 CHECK (signed_in_count >= 0),
    name NVARCHAR(255) NULL,
    country NVARCHAR(255) NULL,
    university NVARCHAR(255) NULL,
    current_institution NVARCHAR(255) NULL,
    email NVARCHAR(255) NULL,
    github NVARCHAR(2048) NULL,
    linkedin NVARCHAR(2048) NULL,
    facebook NVARCHAR(2048) NULL,
    instagram NVARCHAR(2048) NULL,
    youtube NVARCHAR(2048) NULL
);
GO
