<?php
/**
 * @package   QWcrm
 * @author    Jon Brown https://quantumwarp.com/
 * @copyright Copyright (C) 2016 - 2017 Jon Brown, All rights reserved.
 * @license   GNU/GPLv3 or later; https://www.gnu.org/licenses/gpl.html
 */

defined('_QWEXEC') or die;

// Prevent direct access to this page
if(!check_page_accessed_via_qwcrm()) {
    die(_gettext("No Direct Access Allowed."));
}

/* Grab and Process Values befor sending to the log and displaying */
//$error_page         = prepare_error_data('error_page'); // only needed when using referrer
$error_component    = $VAR['error_component'];
$error_page_tpl     = $VAR['error_page_tpl'];
$error_type         = $VAR['error_type'];
$error_location     = $VAR['error_location'];
$error_php_function = $VAR['error_php_function'];
$error_database     = $VAR['error_database'];
$error_sql_query    = $VAR['error_sql_query'];
$error_msg          = $VAR['error_msg'];

// Is Logging of SQL enabled
if(QFactory::getConfig()->get('qwcrm_error_logging')) {
    
    // Prepare the SQL statement for the error log (already been prepared for output to screen)
    $sql_query_for_log = str_replace('<br>', '\r\n', $error_sql_query);
    
} else {    
    $sql_query_for_log = '';    
}

/* This logs errors to the error log (does not currently record the SQL Query) */
if($qwcrm_error_log){    
    
    write_record_to_error_log($error_component.':'.$error_page_tpl, $error_type, $error_location, $error_php_function, $error_database, $sql_query_for_log, $error_msg);
    
}

/* Smarty Template output */

// Assign variables to display on the error page (core:error)
$smarty->assign('error_component',      $error_component        );
$smarty->assign('error_page_tpl',       $error_page_tpl         );
$smarty->assign('error_type',           $error_type             );
$smarty->assign('error_location',       $error_location         );
$smarty->assign('error_php_function',   $error_php_function     );
$smarty->assign('error_database',       $error_database         );
$smarty->assign('error_sql_query',      $error_sql_query        );
$smarty->assign('error_msg',            $error_msg              );
    
// Prevent Customers/Guests/Public users and scapers accidentally seeing the errors
if($user->login_usergroup_id <= 6){
    $BuildPage .= $smarty->fetch('core/error.tpl');
} else {
    $BuildPage .= _gettext("An error has occured but you are not allowed to see it.").'<br>';
    $BuildPage .= _gettext("Timestamp").': '.time().'<br>';
    $BuildPage .= _gettext("Give this information to an admin and they can have a look at it for you.");
}
