INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_weazel','Weazel News',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_weazel','Weazel News',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_weazel', 'Weazel News', 1)
;

INSERT INTO `jobs` (`name`, `label`) VALUES
('weazel', 'Weazel News');

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('weazel', 0, 'stagaire', 'Stagaire', 100, 'null', 'null'),
('weazel', 1, 'employe', 'employe', 200, 'null', 'null'),
('weazel', 2, 'responsable', 'Responsable', 300, 'null', 'null'),
('weazel', 3, 'boss', 'Patron', 400, 'null', 'null');