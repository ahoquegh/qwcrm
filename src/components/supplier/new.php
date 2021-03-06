<?php
/**
 * @package   QWcrm
 * @author    Jon Brown https://quantumwarp.com/
 * @copyright Copyright (C) 2016 - 2017 Jon Brown, All rights reserved.
 * @license   GNU/GPLv3 or later; https://www.gnu.org/licenses/gpl.html
 */

defined('_QWEXEC') or die;

require(INCLUDES_DIR.'components/supplier.php');

// Predict the next supplier_id
$new_record_id = last_supplier_id_lookup($db) +1;

// If details submitted insert record, if non submitted load new.tpl and populate values
if((isset($VAR['submit'])) || (isset($VAR['submitandnew']))) {
        
    // insert the supplier record and get the supplier_id
    $VAR['supplier_id'] = insert_supplier($db, $VAR);
            
    if (isset($VAR['submitandnew'])) {

        // load the new supplier page
        force_page('supplier', 'new', 'information_msg='._gettext("Supplier added successfully.")); 

    } else {

        // load the supplier details page
        force_page('supplier', 'details&supplier_id='.$VAR['supplier_id'], 'information_msg='._gettext("Supplier added successfully.")); 

    }

}

// Build the page
$smarty->assign('supplier_types', get_supplier_types($db));
$smarty->assign('new_record_id', $new_record_id);
$smarty->assign('tax_rate', get_company_details($db, 'tax_rate'));
$BuildPage .= $smarty->fetch('supplier/new.tpl');