<?php
/**
 * @package   QWcrm
 * @author    Jon Brown https://quantumwarp.com/
 * @copyright Copyright (C) 2016 - 2017 Jon Brown, All rights reserved.
 * @license   GNU/GPLv3 or later; https://www.gnu.org/licenses/gpl.html
 */

defined('_QWEXEC') or die;

require(INCLUDES_DIR.'components/company.php');
require(INCLUDES_DIR.'components/customer.php');
require(INCLUDES_DIR.'components/invoice.php');
require(INCLUDES_DIR.'components/payment.php');
require(INCLUDES_DIR.'components/user.php');
require(INCLUDES_DIR.'components/workorder.php');
require(INCLUDES_DIR.'mpdf.php');

// Check if we have an invoice_id
if($VAR['invoice_id'] == '') {
    force_page('invoice', 'search', 'warning_msg='._gettext("No Invoice ID supplied."));
}

// Check there is a print content and print type set
if($VAR['print_content'] == '' || $VAR['print_type'] == '') {
    force_page('workorder', 'overview', 'warning_msg='._gettext("Some or all of the Printing Options are not set."));
}

// Get Record Details
$invoice_details = get_invoice_details($db, $VAR['invoice_id']);
$customer_details = get_customer_details($db, $invoice_details['customer_id']);

/// Assign Variables
$smarty->assign('company_details',                  get_company_details($db)                                        );
$smarty->assign('employee_details',                 get_user_details($db, $invoice_details['employee_id'])          );
$smarty->assign('customer_details',                 $customer_details                                               );
$smarty->assign('invoice_details',                  $invoice_details                                                );
$smarty->assign('workorder_details',                get_workorder_details($db, $invoice_details['workorder_id'])    );
$smarty->assign('payment_details',                  get_payment_details($db)                                        );
$smarty->assign('active_payment_system_methods',    get_active_payment_system_methods($db)                          );
$smarty->assign('invoice_statuses',                 get_invoice_statuses($db)                                       );
$smarty->assign('labour_items',                     get_invoice_labour_items($db, $VAR['invoice_id'])               );
$smarty->assign('parts_items',                      get_invoice_parts_items($db, $VAR['invoice_id'])                );
$smarty->assign('labour_sub_total',                 labour_sub_total($db, $VAR['invoice_id'])                       );
$smarty->assign('parts_sub_total',                  parts_sub_total($db, $VAR['invoice_id'])                        );

// Invoice Print Routine
if($VAR['print_content'] == 'invoice') {
    
    // Build the PDF filename
    $pdf_filename = _gettext("Invoice").'-'.$VAR['invoice_id'];
    
    // Print HTML Invoice
    if ($VAR['print_type'] == 'print_html') {
        
        // Log activity
        $record = _gettext("Invoice").' '.$VAR['invoice_id'].' '._gettext("has been printed as html.");
        write_record_to_activity_log($record, $invoice_details['employee_id'], $invoice_details['customer_id'], $invoice_details['workorder_id'], $invoice_details['invoice_id']);
        
        // Build the page
        $BuildPage .= $smarty->fetch('invoice/printing/print_invoice.tpl'); 
    }
    
    // Print PDF Invoice
    if ($VAR['print_type'] == 'print_pdf') {
        
        // Get Print Invoice as HTML into a variable
        $pdf_template = $smarty->fetch('invoice/printing/print_invoice.tpl');
        
        // Log activity
        $record = _gettext("Invoice").' '.$VAR['invoice_id'].' '._gettext("has been printed as a PDF.");
        write_record_to_activity_log($record, $invoice_details['employee_id'], $invoice_details['customer_id'], $invoice_details['workorder_id'], $invoice_details['invoice_id']);
        
        // Output PDF in brower
        mpdf_output_in_browser($pdf_filename, $pdf_template);
        
    }        
        
    // Email PDF Invoice
    if($VAR['print_type'] == 'email_pdf') {  
        
        // Get Print Invoice as HTML into a variable
        $pdf_template = $smarty->fetch('invoice/printing/print_invoice.tpl');
        
        // Return the PDF in a variable
        $pdf_as_string = mpdf_output_as_varible($pdf_filename, $pdf_template);
        
        // Build the PDF        
        $attachment['data'] = $pdf_as_string;
        $attachment['filename'] = $pdf_filename;
        $attachment['filetype'] = 'application/pdf';
        
        // Build the message body        
        $body = get_email_message_body($db, 'email_msg_invoice', $customer_details);
        
        // Log activity
        $record = _gettext("Invoice").' '.$VAR['invoice_id'].' '._gettext("has been emailed as a PDF.");
        write_record_to_activity_log($record, $invoice_details['employee_id'], $invoice_details['customer_id'], $invoice_details['workorder_id'], $invoice_details['invoice_id']);
        
        // Email the PDF        
        send_email($customer_details['email'], _gettext("Invoice").' '.$VAR['invoice_id'], $body, $customer_details['display_name'], $attachment, $invoice_details['employee_id'], $invoice_details['customer_id'], $invoice_details['workorder_id'], $VAR['invoice_id']);
                
        // End all other processing
        die();
        
    }
    
}

// Customer Envelope Print Routine
if($VAR['print_content'] == 'customer_envelope') {
    
    // Print HTML Customer Envelope
    if ($VAR['print_type'] == 'print_html') {
        
        // Log activity
        $record = _gettext("Address Envelope").' '._gettext("for").' '.$customer_details['display_name'].' '._gettext("has been printed as html.");
        write_record_to_activity_log($record, $invoice_details['employee_id'], $invoice_details['customer_id'], $invoice_details['workorder_id'], $invoice_details['invoice_id']);
        
        // Build the page
        $BuildPage .= $smarty->fetch('invoice/printing/print_customer_envelope.tpl');
        
    }
    
}