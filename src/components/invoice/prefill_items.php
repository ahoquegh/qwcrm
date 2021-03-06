<?php
/**
 * @package   QWcrm
 * @author    Jon Brown https://quantumwarp.com/
 * @copyright Copyright (C) 2016 - 2017 Jon Brown, All rights reserved.
 * @license   GNU/GPLv3 or later; https://www.gnu.org/licenses/gpl.html
 */

defined('_QWEXEC') or die;

require(INCLUDES_DIR.'components/invoice.php');

// If the export of the invoice prefill items has been requested
if($VAR['export_invoice_prefill_items'] == 'export') {
    export_invoice_prefill_items_csv($db);
    die();
}

// if something submitted
if(isset($VAR['submit'])) {

    // New invoice labour rates item
    if($VAR['submit'] == 'new') {
        insert_invoice_prefill_item($db, $VAR);
    }    
    
    // Update invoice labour rates item
    if($VAR['submit'] == 'update') {            
        update_invoice_prefill_item($db, $VAR);        
    }
    
    // Delete invoice labour rates item
    if($VAR['submit'] == 'delete') {        
        delete_invoice_prefill_item($db, $VAR['invoice_prefill_id']);
    }
    
    // Upload CSV file of invoice labour rates items
    if($VAR['submit'] == 'csv_upload') {
        upload_invoice_prefill_items_csv($db, $VAR);
    }
    
}

// Build Page
$smarty->assign('invoice_prefill_items', get_invoice_prefill_items($db));
$BuildPage .= $smarty->fetch('invoice/prefill_items.tpl');