Contribution:  Testimonials Manager
Designed for: Zen Cart v1.5.1 
Author: Clyde Jones
Version:  1.5.4
Updated: By CountryCharm 10/26/2012
Thanks to lat9 for their Updates and Support.
License: under the GPL - See attached License for info.
Support:  Only given via the forums, please. (http://www.zen-cart.com/forum/showthread.php?t=55604)
========================================================
Contribution:  Testimonials Manager
Designed for: Zen Cart v1.5.0 
Author: Clyde Jones
Version:  1.5.3d
Updated: By CountryCharm 4/15/2012
Thanks to Diva and Lat9 and Webkat for their Support.
License: under the GPL - See attached License for info.
========================================================

Notes:

1. BACKUP THE DATABASE BEFORE INSTALLING!!!
2. You should test this on TEST SITE before going live
=========================================================
New Install Instructions

1) Login the store admin
2) Unzip the contribution.
3) Open the install-upgrade folder
4) Change the YOUR_TEMPLATE folders to match the name of your custom template.
        includes/languages/english/extra_definitions/YOUR_TEMPLATE
        includes/languages/english/YOUR_TEMPLATE
        includes/languages/english/html_includes/YOUR_TEMPLATE
        includes/modules/sideboxes/YOUR_TEMPLATE
        includes/templates/YOUR_TEMPLATE
5) Change the name of the Admin folder to whatever you've renamed your installation's Admin folder. (See the Zen Cart documentation for why you should rename your Admin folder.)
6) Upload the files in the new_installation folder to your server (maintaning directory structure). There are three folders which need to be uploaded--admin 
   (name changed to match yours), images, and includes (with the template name changes mentioned above). Make sure you upload ALL of the files.
7) Click any link in the store admin to activate the auto-installer
8) Go to admin -> tools -> layout boxes contoller and activate the new sidebox.


========================================================

FILES TO OVER-RIDE

none
========================================================

File Modifications:

8) Add the following declarations to your stylesheet.css.

.testimonial {
color: #000;
padding: 0 5px 5px 5px;
text-align:left;
}
.testimonial p {
margin: 0; padding: 5px 0;
}
.testimonial span {
float:right;
}
.testimonialImage {
margin: 0;
padding: 0;
text-align: center;
}

-----------------------------

9) This section is entirely optional.
To implement metatags for your testimonials;
open includes/modules/meta_tags.php.
locate the following line of code (around line 336)
// NO "break" here. Allow defaults if not overridden at the per-page level
Immediately above this line copy and paste the code below.
(save the edited file to includes/modules/YOUR_TEMPLATE/meta_tags.php and upload to your server.

  break;
//TESTIMONIALS:
case 'display_all_testimonials':

$sql = "select * from " . TABLE_TESTIMONIALS_MANAGER . " where status = 1 and language_id = '" . (int)$_SESSION['languages_id'] . "' order by date_added DESC, testimonials_title";
$testimonials = $db->Execute($sql);
while (!$testimonials->EOF) {
  $testimonial_string_metatags .= zen_clean_html($testimonials->fields['testimonials_title']) . METATAGS_DIVIDER;
	
$testimonials->MoveNext();
	
} //EOF
    define('META_TAG_TITLE', META_TAG_TITLE_PAGE_TESTIMONIALS_MANAGER_ALL_TESTIMONIALS . $testimonial_string_metatags);
    define('META_TAG_DESCRIPTION', META_TAG_TITLE_PAGE_TESTIMONIALS_MANAGER_ALL_TESTIMONIALS . $testimonial_string_metatags);
    define('META_TAG_KEYWORDS', META_TAG_TITLE_PAGE_TESTIMONIALS_MANAGER_ALL_TESTIMONIALS . $testimonial_string_metatags);
break;

case 'testimonials_manager':
    define('META_TAG_TITLE', META_TAG_TITLE_PAGE_TESTIMONIALS_MANAGER . $page_check->fields['testimonials_title']);
    define('META_TAG_DESCRIPTION', META_TAG_TITLE_PAGE_TESTIMONIALS_MANAGER . zen_trunc_string($page_check->fields['testimonials_html_text'],TESTIMONIALS_MANAGER_DESCRIPTION_LENGTH));
    define('META_TAG_KEYWORDS', META_TAG_TITLE_PAGE_TESTIMONIALS_MANAGER . $page_check->fields['testimonials_title']);

-----------------------------

10) This section is entirely optional.
To change the testimonials to only display your customers' first names (for their privacy) make the following changes to the file /includes/modules/pages/testimonials_add/header_php.php

Line 126:
Find code:
     $account_query = "select customers_firstname, customers_lastname, customers_email_address

Replace with:
     $account_query = "select customers_firstname, customers_email_address

Line 132:
Find code:
     $extra_info=email_collect_extra_info($name,$email_address, $account->fields['customers_firstname'] . ' ' . $account->fields['customers_lastname'] , $account->fields['customers_email_address'] );

Replace with:
     $extra_info=email_collect_extra_info($name,$email_address, $account->fields['customers_firstname'] . ' ' . $account->fields[''] , $account->fields['customers_email_address'] );

Line 150:
Find code:
     $sql = "SELECT c.customers_id, c.customers_firstname, c.customers_lastname, c.customers_email_address, c.customers_default_address_id, c.customers_telephone, ab.customers_id, ab.entry_street_address, ab.entry_company, ab.entry_city, ab.entry_postcode, ab.entry_zone_id, ab.entry_country_id, z.zone_id, z.zone_code, cn.countries_id, cn.countries_name FROM " . TABLE_CUSTOMERS . " c, " . TABLE_ADDRESS_BOOK . " ab, "  . TABLE_ZONES  . " z, " . TABLE_COUNTRIES . " cn WHERE c.customers_id = :customersID AND ab.customers_id = :customersID AND ab.entry_country_id = cn.countries_id";

Replace with:
     $sql = "SELECT c.customers_id, c.customers_firstname, c.customers_email_address, c.customers_default_address_id, c.customers_telephone, ab.customers_id, ab.entry_street_address, ab.entry_company, ab.entry_city, ab.entry_postcode, ab.entry_zone_id, ab.entry_country_id, z.zone_id, z.zone_code, cn.countries_id, cn.countries_name FROM " . TABLE_CUSTOMERS . " c, " . TABLE_ADDRESS_BOOK . " ab, "  . TABLE_ZONES  . " z, " . TABLE_COUNTRIES . " cn WHERE c.customers_id = :customersID AND ab.customers_id = :customersID AND ab.entry_country_id = cn.countries_id";

Line 155:
Find code:
     $testimonials_name = $check_customer->fields['customers_firstname'] . ' ' . $check_customer->fields['customers_lastname'];

Replace with: 
     $testimonials_name = $check_customer->fields['customers_firstname'] . ' ' . $check_customer->fields[''];

That's it! No need to edit templates to hide data or anything--this edit will make it so that the customer's last name is never added to their testimonial in the first place.
Note, this will only change new testimonials, it will not change testimonials already in the system. You can change existing testimonials by editing them in the ZC Admin interface.