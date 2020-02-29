USE Task4;

INSERT INTO Employees (f_name, l_name)
VALUES ('John', 'Johnson'),
('Jane', 'Doe'),
('Jim', 'Peterson'),
('Limmy', 'Stevenson'),
('Stephen', 'Nobody'),
('Ivan', 'Ivanov'),
('Kenjiro','Agatsuma'),
('Harvey', 'Davidson'),
('Vinny', 'Moreno');


INSERT INTO Roles (title)
VALUES ('Manager'),
('Analyst'),
('Scrum Master'),
('Coffee delivery boy'),
('Repairman'),
('Architect'),
('Coder'),
('Cleaner'),
('A Liability'),
('Dead Weight'),
('Accountant');

INSERT INTO Projects (p_name, date_started, date_completed)
VALUES ('Delivery App', '2009-01-01', NULL),
('Uber Rip-Off', '2019-01-01', '2020-01-01'),
('Promotional Game', '2018-05-06', '2019-01-02'),
('File Transfer System', '2020-01-03', NULL),
('Spotify Rip-Off', '2017-02-03', '2018-09-10'),
('Real Estate Rating Service', '2010-02-02', '2013-03-05');

INSERT INTO Project_statuses (project_id, closed)
VALUES (1, 0),
(2,1),
(3,1),
(4,0),
(5,1),
(6,1);

INSERT INTO Role_assignment (emp_id, project_id, role_id)
VALUES (1, 1, 3),
(2, 1, 9),
(3, 1, 11),
(9, 2, 4),
(1, 2, 7),
(5, 2, 1),
(6, 3, 2),
(7, 3, 8),
(8, 3, 11),
(4, 3, 3),
(3, 4, 5),
(7, 4, 2),
(8, 4, 1),
(5, 4, 4),
(8, 5, 2),
(4, 5, 3),
(2, 5, 6),
(9, 5, 11),
(6, 5, 5),
(4, 6, 2),
(9, 6, 7),
(3, 6, 1),
(8, 6, 4);


INSERT INTO Tasks (t_description, deadline)
VALUES ('Create Back-End', '2020-01-01'), -- 1
('Create Front-End', '2020-03-04'),
('Connect with DB', '2020-02-01'),
('Contact Suppliers', '2019-12-11'),
('Connect GPS System', '2019-07-06'), -- 2
('Recruit Drivers', '2019-09-10'),
('SNS Advertising', '2019-10-11'),
('Promotions', '2019-12-12'),
('Create Unity Proto', '2018-07-10'), -- 3
('HD Textures', '2018-11-11'),
('Voice Acting', '2018-12-12'),
('Testing', '2019-01-01'),
('Unix Support', '2020-07-07'), -- 4
('Android Support', '2020-09-09'),
('Streaming', '2021-01-01'),
('File converison', '2020-12-03'),
('Contact Artists', '2018-03-03'), -- 5
('Streaming', '2018-04-04'),
('Playlist Support', '2018-07-07'),
('Recommendations', '2017-12-03'),
('Analyze Market', '2010-03-03'), -- 6
('Find Metrics', '2010-04-04'),
('Find Clients', '2011-01-01'),
('Map Support', '2012-01-01');


INSERT INTO Task_assignment (ra_id, task_id)
VALUES (1, 1),
(1, 4),
(2, 2),
(3, 3),
(4, 6),
(5, 5),
(6, 8),
(6, 7),
(7, 10),
(8, 11),
(9, 12),
(10, 9),
(11, 13),
(12, 16),
(13, 15),
(14, 14),
(15, 17),
(16, 19),
(17, 20),
(18, 18),
(19, 19),
(20, 20),
(21, 21),
(22, 22),
(22, 23),
(23,  24);


INSERT INTO Task_statuses (task_id, s_description, change_date, changer_id)
VALUES (1, 'Open', '2019-10-10', 1),
(2, 'Complete', '2020-02-02', 1),
(3, 'Unfinished', '2020-01-01', 1),
(4, 'Open', '2011-01-01', 1),
(5, 'Accepted', '2019-06-01', 5),
(6, 'Accepted', '2019-08-01', 5),
(7, 'Accepted', '2019-09-01', 5),
(8, 'Accepted', '2019-12-11', 5),
(9, 'Complete', '2018-06-06', 6),
(10, 'Accepted', '2018-10-07', 6),
(11, 'Accepted', '2018-12-10', 6),
(12, 'Accepted', '2018-01-01', 6),
(13, 'Accepted', '2020-06-06', 8),
(14, 'Accepted', '2020-11-11', 8),
(15, 'Accepted', '2020-12-12', 8),
(16, 'Accepted', '2020-12-01', 8),
(17,'Unfinished', '2018-02-02', 8),
(18, 'Accepted', '2018-04-04', 8),
(19, 'Complete', '2018-07-01', 8),
(20, 'Accepted', '2017-12-01', 8),
(21, 'Accepted', '2010-03-03', 3),
(22, 'Open', '2010-03-04', 3),
(23, 'Unfinished', '2012-01-01', 3),
(24,  'Open', '2011-12-01' , 3);