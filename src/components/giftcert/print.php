<?php
/**
 * @package   QWcrm
 * @author    Jon Brown https://quantumwarp.com/
 * @copyright Copyright (C) 2016 - 2017 Jon Brown, All rights reserved.
 * @license   GNU/GPLv3 or later; https://www.gnu.org/licenses/gpl.html
 */

defined('_QWEXEC') or die;

require(INCLUDES_DIR.'components/customer.php');
require(INCLUDES_DIR.'components/giftcert.php');
require(INCLUDES_DIR.'mpdf.php');

// Generate the barcode (as html)
$bc_generator = new Picqer\Barcode\BarcodeGeneratorHTML();
$barcode = $bc_generator->getBarcode(get_giftcert_details($db, $VAR['giftcert_id'], 'giftcert_code'), $bc_generator::TYPE_CODE_128);

// Check if we have an giftcert_id
if($VAR['giftcert_id'] == '') {
    force_page('giftcert', 'search', 'warning_msg='._gettext("No Gift Certificate ID supplied."));
}

// Check there is a print content and print type set
if($VAR['print_content'] == '' || $VAR['print_type'] == '') {
    force_page('giftcert', 'search', 'warning_msg='._gettext("Some or all of the Printing Options are not set."));
}

// Get Gift Certificate details
$giftcert_details = get_giftcert_details($db, $VAR['giftcert_id']);
$customer_details = get_customer_details($db, $giftcert_details['customer_id']);

// Assign Variables
$smarty->assign('company_details',  get_company_details($db)    );
$smarty->assign('customer_details', $customer_details           );
$smarty->assign('giftcert_details', $giftcert_details           );
$smarty->assign('barcode',          $barcode                    );

// Gift Certificate Print Routine
if($VAR['print_content'] == 'gift_certificate') {    
    
    // Build the PDF filename
    $pdf_filename = _gettext("Gift Certificate").' '.$VAR['giftcert_id'];
    
    // Print HTML
    if ($VAR['print_type'] == 'print_html') {
        
        // Log activity
        $record = _gettext("Gift Certificate").' '.$VAR['giftcert_id'].' '._gettext("has been printed as html.");
        write_record_to_activity_log($record, $giftcert_details['employee_id'], $giftcert_details['customer_id'], $giftcert_details['workorder_id'], $giftcert_details['invoice_id']);
        
        // Build the page
        $BuildPage .= $smarty->fetch('giftcert/printing/print_gift_certificate.tpl');
    
    // Print PDF
    } elseif ($VAR['print_type'] == 'print_pdf') {        
        
        // Get Print Invoice as HTML into a variable
        $pdf_template = $smarty->fetch('giftcert/printing/print_gift_certificate.tpl');
        
        // Log activity
        $record = _gettext("Gift Certificate").' '.$VAR['giftcert_id'].' '._gettext("has been printed as a PDF.");
        write_record_to_activity_log($record, $giftcert_details['employee_id'], $giftcert_details['customer_id'], $giftcert_details['workorder_id'], $giftcert_details['invoice_id']);
        
        // Output PDF in brower
        mpdf_output_in_browser($pdf_filename, $pdf_template);
        
    // Email PDF
    } elseif ($VAR['print_type'] == 'email_pdf') {
        
        // Get Print Invoice as HTML into a variable
        $pdf_template = $smarty->fetch('giftcert/printing/print_gift_certificate.tpl');
        
        // return the PDF in a variable
        $pdf_as_string = mpdf_output_as_varible($pdf_filename, $pdf_template);
        
        // Build the PDF        
        $attachment['data'] = $pdf_as_string;
        $attachment['filename'] = $pdf_filename;
        $attachment['filetype'] = 'application/pdf';
        
        // Build the message body        
        $body = get_email_message_body($db, 'email_msg_giftcert', $customer_details);
        
        // Log activity
        $record = _gettext("Gift Certificate").' '.$VAR['giftcert_id'].' '._gettext("has been emailed as a PDF.");
        write_record_to_activity_log($record, $giftcert_details['employee_id'], $giftcert_details['customer_id'], $giftcert_details['workorder_id'], $giftcert_details['invoice_id']);
        
        // Email the PDF
        send_email($customer_details['email'], _gettext("Gift Certificate").' '.$VAR['giftcert_id'], $body, $customer_details['display_name'], $attachment);
        
        // End all other processing
        die();
        
    }
}