﻿/*
Deployment script for DipWeek5

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar LoadTestData "true"
:setvar DatabaseName "DipWeek5"
:setvar DefaultFilePrefix "DipWeek5"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

IF '$(LoadTestData)' = 'true'

BEGIN

DELETE FROM Borrow;
DELETE FROM Book;
DELETE FROM Author;
DELETE FROM Student;


INSERT INTO Student(StudentID, FirstName, LastName, Email, Phone) VALUES
('s12345678', 'Fred', 'Flintstone', '12345678@student.swin.edu.au ', 0400555111),
('s23456789', 'Barney', 'Rubble ', '23456789@student.swin.edu.au ', 0400555222 ),
('s34567890', 'Bam-Bam', 'Rubble', '23456789@student.swin.edu.au ', 0400555222 );


INSERT INTO Author (AuthorID, AuthorFirstName, AusthorLastName, AuthorTFN) VALUES
(32567 , 'Edgar', 'Codd', 150111222),
(32567 , 'Edgar', 'Codd', 150111222),
(76543 , 'Vinton', 'Cerf', 150222333),
(12345 , 'Alan', 'Turing', 150333444);


INSERT INTO Book(ISBN, Title, YearPublish, AuthorID) VALUES
('978-3-16148410-0', 'Relationships with Databases, the ins and outs', '1970', 32567),
('978-3-16148410-1', 'Normalisation, how to make a database geek fit in.', '1973', 32567), 
('978-3-16148410-2', 'TCP/IP, the protocol for the masses.', '1983', 76543), 
('978-3-16148410-3', 'The Man, the Bombe, and the Enigma.', '1940', 12345);


END;
GO

GO
PRINT N'Update complete.';


GO
