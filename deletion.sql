USE [Task4]
GO
ALTER TABLE [dbo].[Task_statuses] DROP CONSTRAINT [FK2_CHANGER]
GO
ALTER TABLE [dbo].[Task_statuses] DROP CONSTRAINT [FK1_TASK]
GO
ALTER TABLE [dbo].[Task_assignment] DROP CONSTRAINT [FK2_TASK]
GO
ALTER TABLE [dbo].[Task_assignment] DROP CONSTRAINT [FK1_ROLE_ASSIGNMENT]
GO
ALTER TABLE [dbo].[Role_assignment] DROP CONSTRAINT [FK3_ROLE]
GO
ALTER TABLE [dbo].[Role_assignment] DROP CONSTRAINT [FK2_PROJECT]
GO
ALTER TABLE [dbo].[Role_assignment] DROP CONSTRAINT [FK1_EMPLOYEE]
GO
ALTER TABLE [dbo].[Project_statuses] DROP CONSTRAINT [FK1_PROJECT]
GO
/****** Object:  Table [dbo].[Tasks]    Script Date: 27.02.2020 1:11:39 ******/
DROP TABLE [dbo].[Tasks]
GO
/****** Object:  Table [dbo].[Task_statuses]    Script Date: 27.02.2020 1:11:39 ******/
DROP TABLE [dbo].[Task_statuses]
GO
/****** Object:  Table [dbo].[Task_assignment]    Script Date: 27.02.2020 1:11:39 ******/
DROP TABLE [dbo].[Task_assignment]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 27.02.2020 1:11:39 ******/
DROP TABLE [dbo].[Roles]
GO
/****** Object:  Table [dbo].[Role_assignment]    Script Date: 27.02.2020 1:11:39 ******/
DROP TABLE [dbo].[Role_assignment]
GO
/****** Object:  Table [dbo].[Projects]    Script Date: 27.02.2020 1:11:39 ******/
DROP TABLE [dbo].[Projects]
GO
/****** Object:  Table [dbo].[Project_statuses]    Script Date: 27.02.2020 1:11:39 ******/
DROP TABLE [dbo].[Project_statuses]
GO

/****** Object:  Table [dbo].[Employees]    Script Date: 27.02.2020 1:11:39 ******/
DROP TABLE [dbo].[Employees]
GO
