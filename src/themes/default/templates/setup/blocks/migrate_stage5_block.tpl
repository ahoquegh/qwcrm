<!-- migrate_stage5_block.tpl -->
{*
 * @package   QWcrm
 * @author    Jon Brown https://quantumwarp.com/
 * @copyright Copyright (C) 2016 - 2017 Jon Brown, All rights reserved.
 * @license   GNU/GPLv3 or later; https://www.gnu.org/licenses/gpl.html
*}
<link rel="stylesheet" href="{$theme_js_dir}jscal2/css/jscal2.css" />
<link rel="stylesheet" href="{$theme_js_dir}jscal2/css/steel/steel.css" />
<script src="{$theme_js_dir}jscal2/jscal2.js"></script>
<script src="{$theme_js_dir}jscal2/unicode-letter.js"></script>
<script>{include file="../`$theme_js_dir_finc`jscal2/language.js"}</script>
<script src="{$theme_js_dir}tinymce/tinymce.min.js"></script>
<script>{include file="../`$theme_js_dir_finc`editor-config.js"}</script>

<form method="post" action="index.php?component=setup&page_tpl=migrate" enctype="multipart/form-data">
    <table width="600" cellpadding="5" cellspacing="0" border="0">
        <tr>
            <td class="menuhead2" width="80%">&nbsp;{t}Stage 5 - Company Details{/t}</td>
            {*<td class="menuhead2" width="20%" align="right" valign="middle">  <img src="{$theme_images_dir}icons/16x16/help.gif" border="0" onMouseOver="ddrivetip('<div><strong>{t escape=tooltip}ADMINISTRATOR_CONFIG_HELP_TITLE{/t}</strong></div><hr><div>{t escape=tooltip}ADMINISTRATOR_CONFIG_HELP_CONTENT{/t}</div>');" onMouseOut="hideddrivetip();"></td>*}
        </tr>
        <tr>
            <td class="menutd2">
                <table width="600" class="olotable" cellpadding="5" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <div id="tabs_container">
                                <ul class="tabs">
                                    <li class="active"><a href="javascript:void(0)" rel="#tab_1_contents" class="tab"><img src="{$theme_images_dir}icons/key.png" alt="" border="0" height="14" width="14"/>&nbsp;{t}Company Details{/t}</a></li>
                                    <li><a href="javascript:void(0)" rel="#tab_2_contents" class="tab"><img src="{$theme_images_dir}icons/money.png" alt="" border="0" height="14" width="14"/>&nbsp;{t}Localisation Setup{/t}</a></li>                        
                                    <li><a href="javascript:void(0)" rel="#tab_3_contents" class="tab"><img src="{$theme_images_dir}icons/16x16/email.jpg" alt="" border="0" height="14" width="14" />&nbsp;{t}Email Messages{/t}</a></li>
                                </ul>

                                <!-- This is used so the contents don't appear to the right of the tabs -->
                                <div class="clear"></div>

                                <!-- This is a div that hold all the tabbed contents -->
                                <div class="tab_contents_container">

                                    <!-- Tab 1 Contents -->
                                    <div id="tab_1_contents" class="tab_contents tab_contents_active">                    
                                        <table width="100%" cellpadding="5" cellspacing="0" border="0">
                                            <tr>
                                                <td class="menuhead2" width="80%">&nbsp;{t}Edit The Company Information{/t}</td>
                                            </tr>
                                            <tr>
                                                <td class="menutd2">
                                                    <table width="100%" class="olotable" cellpadding="5" cellspacing="0" border="0">
                                                        <tr>
                                                            <td width="100%" valign="top">

                                                                <table cellpadding="5" cellspacing="0">
                                                                    <tr>
                                                                        <td align="right"><b>{t}Company Name{/t}:</b> <span style="color: #ff0000">*</span></td>
                                                                        <td><input name="display_name" class="olotd5" value="{$company_details.display_name}" type="text" maxlength="50" required onkeydown="return onlyName(event);"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right"><b>{t}Logo{/t}:</b></td>
                                                                        <td>
                                                                            <input type="file" name="logo" accept=".png, .jpg, .jpeg, .gif">
                                                                            <img src="{$company_details.logo}" height="50px" alt="{t}Company Logo{/t}">
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right"></td>
                                                                        <td>
                                                                            <input type="checkbox" name="delete_logo" value="1">{t}Delete Logo{/t}
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right"><b>{t}Address{/t}:</b> <span style="color: #ff0000">*</span></td>
                                                                        <td><textarea name="address" class="olotd5 mceNoEditor" cols="30" rows="3" maxlength="100" required onkeydown="return onlyAddress(event);">{$company_details.address}</textarea></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right"><b>{t}City{/t}:</b> <span style="color: #ff0000">*</span></td>
                                                                        <td><input name="city" class="olotd5" value="{$company_details.city}" type="text" maxlength="20" required onkeydown="return onlyAlpha(event);"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right"><b>{t}State{/t}:</b> <span style="color: #ff0000">*</span></td>
                                                                        <td><input name="state" class="olotd5" value="{$company_details.state}" type="text" maxlength="20" required onkeydown="return onlyAlpha(event);"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right"><b>{t}Zip{/t}:</b> <span style="color: #ff0000">*</span></td>
                                                                        <td><input name="zip" class="olotd5" value="{$company_details.zip}" type="text" maxlength="20" required onkeydown="return onlyAlphaNumeric(event);"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right"><b>{t}Country{/t}:</b> <span style="color: #ff0000">*</span></td>
                                                                        <td><input name="country" class="olotd5" value="{$company_details.country}" type="text" maxlength="50" required onkeydown="return onlyAlpha(event);"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right"><b>{t}Primary{/t}:</b></td>
                                                                        <td><input name="primary_phone" class="olotd5" value="{$company_details.primary_phone}" type="tel" maxlength="20" onkeydown="return onlyPhoneNumber(event);"</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right"><b>{t}Mobile{/t}:</b></td>
                                                                        <td><input name="mobile" class="olotd5" value="{$company_details.mobile}" type="tel" maxlength="20" onkeydown="return onlyPhoneNumber(event);"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right"><b>{t}Fax{/t}:</b></td>
                                                                        <td><input name="fax" class="olotd5" value="{$company_details.fax}" type="tel" maxlength="20" onkeydown="return onlyPhoneNumber(event);"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right"><b>{t}Email{/t}:</b></td>                                                                
                                                                        <td><input name="email" class="olotd5" value="{$company_details.email}" size="50" type="email" maxlength="50" placeholder="no-reply@quantumwarp.com" onkeydown="return onlyEmail(event);"/></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right"><b>{t}Website{/t}:</b></td>                                                                
                                                                        <td><input name="website" class="olotd5" value="{$company_details.website}" size="50" type="url" maxlength="50" placeholder="https://quantumwarp.com/" pattern="^https?://.+" onkeydown="return onlyURL(event);"/></td>
                                                                    </tr>
                                                                    
                                                                    <tr>
                                                                        <td align="right"><b>{t}Company Number{/t}:</b></td>
                                                                        <td><input name="company_number" class="olotd5" value="{$company_details.company_number}" type="text" maxlength="20" onkeydown="return onlyAlphaNumeric(event);"/></td>
                                                                    </tr>                                                                    
                                                                    <tr>
                                                                        <td align="right"><b>{t}Tax Type{/t}:</b> <span style="color: #ff0000">*</span></td>
                                                                        <td>
                                                                            <select class="olotd5" id="tax_type" name="tax_type" required>
                                                                                <option value=""{if $company_details.tax_type == ''} selected{/if}>&nbsp;</option>
                                                                                <option value="none"{if $company_details.tax_type == 'none'} selected{/if}>{t}None{/t}</option>
                                                                                <option value="sales"{if $company_details.tax_type == 'sales'} selected{/if}>{t}Sales{/t}</option>
                                                                                <option value="vat"{if $company_details.tax_type == 'vat'} selected{/if}>{t}VAT{/t}</option>
                                                                            </select>                                                    
                                                                        </td> 
                                                                    </tr> 
                                                                    <tr>
                                                                        <td align="right"><b>{t}Tax Rate{/t}:</b></td>
                                                                        <td><input name="tax_rate" class="olotd5" size="6" value="{$company_details.tax_rate}" maxlength="5" pattern="{literal}^[0-9]{0,2}(\.[0-9]{0,2})?${/literal}" onkeydown="return onlyNumberPeriod(event);"/>%</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right"><b>{t}VAT Number{/t}:</b></td>
                                                                        <td><input name="vat_number" class="olotd5" value="{$company_details.vat_number}" type="text" maxlength="20" onkeydown="return onlyAlphaNumeric(event);"/></td>
                                                                    </tr>
                                                                    <tr>
                                                                    <td align="right"><b>{t}Financial Year Start{/t}:</b> <span style="color: #ff0000">*</span></td>
                                                                    <td>
                                                                        <input id="year_start" name="year_start" class="olotd4" size="10" value="{$company_details.year_start|date_format:$date_format}" type="text" maxlength="10" pattern="{literal}^[0-9]{1,2}(\/|-)[0-9]{1,2}(\/|-)[0-9]{2,2}([0-9]{2,2})?${/literal}" required onkeydown="return onlyDate(event);">
                                                                        <input id="year_start_button" value="+" type="button">                                                    
                                                                        <script>                                                        
                                                                            Calendar.setup( {
                                                                                trigger     : "year_start_button",
                                                                                inputField  : "year_start",
                                                                                dateFormat  : "{$date_format}"                                                                                            
                                                                            } );                                                        
                                                                        </script>                                                    
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right"><b>{t}Financial Year End{/t}:</b> <span style="color: #ff0000">*</span></td>
                                                                    <td>
                                                                        <input id="year_end" name="year_end" class="olotd4" size="10" value="{$company_details.year_end|date_format:$date_format}" type="text" maxlength="10" pattern="{literal}^[0-9]{1,2}(\/|-)[0-9]{1,2}(\/|-)[0-9]{2,2}([0-9]{2,2})?${/literal}" required onkeydown="return onlyDate(event);">
                                                                        <input id="year_end_button" value="+" type="button">                                                    
                                                                        <script>                                                        
                                                                            Calendar.setup( {
                                                                                trigger     : "year_end_button",
                                                                                inputField  : "year_end",
                                                                                dateFormat  : "{$date_format}"                                                                                            
                                                                            } );                                                        
                                                                        </script>                                                    
                                                                    </td>
                                                                </tr>
                                                                    <tr>
                                                                        <td><b>{t}Company Welcome Message{/t}:</b><br>{t}(Dashboard){/t}</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2"><textarea class="olotd5" cols="80" rows="5" name="welcome_msg">{$company_details.welcome_msg}</textarea></td>
                                                                    </tr>                                                                                                           
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                    <!-- Tab 2 Contents -->
                                    <div id="tab_2_contents" class="tab_contents">
                                        <table width="100%" cellpadding="5" cellspacing="0" border="0">
                                            <tr>
                                                <td class="menuhead2" width="80%">&nbsp;{t}Edit your Company's Currency Settings{/t}</td>
                                            </tr>
                                            <tr>
                                                <td class="menutd2">
                                                    <table width="100%" class="olotable" cellpadding="5" cellspacing="0" border="0">
                                                        <tr>
                                                            <td width="100%" valign="top">                                     
                                                                <table cellpadding="5" cellspacing="0">                                                        
                                                                    <tr>
                                                                        <td align="right"><b>{t}Currency Symbol{/t}:</b> <span style="color: #ff0000">*</span></td>
                                                                        <td><input name="currency_symbol" class="olotd5" size="3" value="{$company_details.currency_symbol}" type="text" maxlength="1" required onkeydown="return onlyCurrencySymbol(event);"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right"><b>{t}Currency Code{/t}:</b> <span style="color: #ff0000">*</span></td>
                                                                        <td><input name="currency_code" class="olotd5" size="5" value="{$company_details.currency_code}" type="text" maxlength="3" required onkeydown="return onlyAlpha(event);">{t}eg: British Pound = GBP, Euro = EUR, US Dollars = USD, Australian Dollars = AUD{/t}</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right"><b>{t}Date Format{/t}:</b></td>
                                                                        <td>
                                                                            <select name="date_format" class="olotd5">
                                                                                <option value="%d/%m/%Y"{if $company_details.date_format == '%d/%m/%Y'} selected{/if}>dd/mm/yyyy</option>                                                            
                                                                                <option value="%m/%d/%Y"{if $company_details.date_format == '%m/%d/%Y'} selected{/if}>mm/dd/yyyy</option>
                                                                                <option value="%d/%m/%y"{if $company_details.date_format == '%d/%m/%y'} selected{/if}>dd/mm/yy</option>
                                                                                <option value="%m/%d/%y"{if $company_details.date_format == '%m/%d/%y'} selected{/if}>mm/dd/yy</option>
                                                                            </select>
                                                                        </td>
                                                                    </tr>                                                        
                                                                </table>                                                                                               
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                    <!-- Tab 3 Contents -->                        
                                    <div id="tab_3_contents" class="tab_contents">
                                        <table width="100%" cellpadding="5" cellspacing="0" border="0">                                
                                            <tr>
                                                <td class="menutd2">                                        
                                                    <table width="100%" class="olotable" cellpadding="5" cellspacing="0" border="0">                                            
                                                        <tr>
                                                            <td class="menuhead2" width="80%">&nbsp;{t}Edit Email Messaging functions{/t}</td>
                                                        </tr>

                                                        <!-- Workorder -->

                                                        <tr>
                                                            <td>
                                                                <input type="hidden" name="email_msg_workorder" value="">
                                                                {*<table cellpadding="5" cellspacing="0">
                                                                    <tr>
                                                                        <td class="menuhead">{t}Workorder Message{/t}:</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>                                                                
                                                                            <strong>Placeholders</strong><br>
                                                                            {literal}{customer_display_name}{/literal} = {t}Customer's name{/t}<br>
                                                                            {literal}{customer_first_name}{/literal} = {t}Customer's contact first name{/t}<br> 
                                                                            {literal}{customer_last_name}{/literal} = {t}Customer's contact last name{/t}<br> 
                                                                            {literal}{customer_credit_terms}{/literal} = {t}Customer's credit terms{/t} 
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td><textarea cols="80" rows="15" class="olotd5" name="email_msg_workorder">{$company_details.email_msg_workorder}</textarea></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="left"><b>{t}Enabled{/t}:</b>
                                                                            <select name="email_msg_workorder_active">                                                                    
                                                                                <option value="1" {if $company_details.email_msg_workorder_active == '1'} selected{/if}>{t}Yes{/t}</option>
                                                                                <option value="0" {if $company_details.email_msg_workorder_active == '0'} selected{/if}>{t}No{/t}</option>
                                                                            </select>
                                                                        </td>
                                                                    </tr>
                                                                </table>*}                                                       
                                                            </td>
                                                        </tr>                                            

                                                        <!-- Invoice -->

                                                        <tr>
                                                            <td>
                                                                <table cellpadding="5" cellspacing="0">
                                                                    <tr>
                                                                        <td class="menuhead">{t}Invoice Message{/t}:</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>                                                                
                                                                            <strong>Placeholders</strong><br>
                                                                            {literal}{customer_display_name}{/literal} = {t}Customer's name{/t}<br>
                                                                            {literal}{customer_first_name}{/literal} = {t}Customer's contact first name{/t}<br> 
                                                                            {literal}{customer_last_name}{/literal} = {t}Customer's contact last name{/t}<br> 
                                                                            {literal}{customer_credit_terms}{/literal} = {t}Customer's credit terms{/t} 
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td><textarea cols="80" rows="15" class="olotd5" name="email_msg_invoice">{$company_details.email_msg_invoice}</textarea></td>
                                                                    </tr>
                                                                    {*<tr>
                                                                        <td align="left"><b>{t}Enabled{/t}:</b>
                                                                            <select name="email_msg_invoice_active">                                                                    
                                                                                <option value="1" {if $company_details.email_msg_invoice_active == '1'} selected{/if}>{t}Yes{/t}</option>
                                                                                <option value="0" {if $company_details.email_msg_invoice_active == '0'} selected{/if}>{t}No{/t}</option>
                                                                            </select>
                                                                        </td>
                                                                    </tr>*}
                                                                </table>                                                        
                                                            </td>
                                                        </tr>                                             

                                                        <!-- Email Signature -->

                                                        <tr>
                                                            <td>
                                                                <table cellpadding="5" cellspacing="0">
                                                                    <tr>
                                                                        <td class="menuhead">{t}Email Signature{/t}</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>                                                                
                                                                            <strong>Placeholders</strong><br>
                                                                            {literal}{logo}{/literal} = {t}Use this to place your logo in the message{/t}                                                               
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td><textarea cols="80" rows="15" class="olotd5" name="email_signature">{$company_details.email_signature}</textarea></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="left"><b>{t}Enabled{/t}:</b>
                                                                            <select name="email_signature_active">                                                                    
                                                                                <option value="1" {if $company_details.email_signature_active == '1'} selected{/if}>{t}Yes{/t}</option>
                                                                                <option value="0" {if $company_details.email_signature_active == '0'} selected{/if}>{t}No{/t}</option>
                                                                            </select>
                                                                        </td>
                                                                    </tr>
                                                                </table>                                                        
                                                            </td>
                                                        </tr>                                         
                                                    </table>
                                                </td>
                                            </tr>                                
                                        </table>
                                    </div>

                                </div><!-- EOF of tab_contents_container-->
                            </div> <!-- EOF of tabs_container -->            
                        </td>
                    </tr>

                    <!-- Submit Button -->

                    <tr>
                        <td colspan="2" style="text-align: center;">
                            <input type="hidden" name="stage" value="5">
                            <button class="olotd5" type="submit" name="submit" value="stage5">{t}Next{/t}</button>
                        </td>
                    </tr>
                    
                </table>
            </td>
        </tr>
    </table>
</form>