#Testimonials Manager SQL Uninstall

SET @configuration_group_id=0;
SELECT @configuration_group_id:=configuration_group_id 
FROM configuration_group
WHERE configuration_group_title= 'Testimonials Manager'
LIMIT 1;

DELETE FROM configuration WHERE configuration_group_id = @configuration_group_id AND @configuration_group_id !=0;
DELETE FROM configuration_group WHERE configuration_group_id = @configuration_group_id AND @configuration_group_id !=0;
DELETE FROM configuration WHERE configuration_key = 'DEFINE_TESTIMONIAL_STATUS';

DROP TABLE IF EXISTS `testimonials_manager`;

DELETE FROM admin_pages WHERE page_key = 'configTestimonialsManager' LIMIT 1;
DELETE FROM admin_pages WHERE page_key = 'TestimonialsManager' LIMIT 1;
