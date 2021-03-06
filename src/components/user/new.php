<?php
/**
 * @package   QWcrm
 * @author    Jon Brown https://quantumwarp.com/
 * @copyright Copyright (C) 2016 - 2017 Jon Brown, All rights reserved.
 * @license   GNU/GPLv3 or later; https://www.gnu.org/licenses/gpl.html
 */

defined('_QWEXEC') or die;

require(INCLUDES_DIR.'components/customer.php');
require(INCLUDES_DIR.'components/user.php');

// Set the template for the correct user type (customer/employee)
if($VAR['customer_id'] != '') {
    
    // check if there is already a user for the customer (and error if there is)
    if(!check_customer_already_has_login($db, $VAR['customer_id'])) {
        
        $smarty->assign('is_employee', '0');
        $smarty->assign('customer_display_name', get_customer_details($db, $VAR['customer_id'], 'customer_display_name'));
        $smarty->assign('usergroups', get_usergroups($db, 'customers'));
        
    } else {
        
        force_page('customer', 'details', 'customer_id='.$VAR['customer_id'].'&warning_msg='._gettext("The customer already has a login."));
        
    }    
    
} else {
    $smarty->assign('is_employee', '1');    
    $smarty->assign('usergroups', get_usergroups($db, 'employees'));
}

// If user data has been submitted
if(isset($VAR['submit'])) { 
            
    // Insert the record - if the username or email have not been used
    if (check_user_username_exists($db, $VAR['username'], get_user_details($db, $VAR['user_id'], 'username')) ||
        check_user_email_exists($db, $VAR['email'], get_user_details($db, $VAR['user_id'], 'email'))) {     
        
        // send the posted data back to smarty
        $user_details = $VAR;
        
        // Reload the page with the POST'ed data
        $smarty->assign('user_details', $user_details);        
        $BuildPage .= $smarty->fetch('user/new.tpl');
            
        } else {    
            
            // Insert user record (and return the new ID)
            $VAR['user_id'] = insert_user($db, $VAR);
            
            // Redirect to the new user's details page
            force_page('user', 'details&user_id='.$VAR['user_id']);
            
        }

} else {
    
    // Build the page from the database       
    $BuildPage .= $smarty->fetch('user/new.tpl');
    
}