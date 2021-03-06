<!-- edit.tpl -->
{*
 * @package   QWcrm
 * @author    Jon Brown https://quantumwarp.com/
 * @copyright Copyright (C) 2016 - 2017 Jon Brown, All rights reserved.
 * @license   GNU/GPLv3 or later; https://www.gnu.org/licenses/gpl.html
*}
<script src="{$theme_js_dir}tinymce/tinymce.min.js"></script>
<script>{include file="`$theme_js_dir_finc`editor-config.js"}</script>
<link rel="stylesheet" href="{$theme_js_dir}jscal2/css/jscal2.css" />
<link rel="stylesheet" href="{$theme_js_dir}jscal2/css/steel/steel.css" />
<script src="{$theme_js_dir}jscal2/jscal2.js"></script>
<script src="{$theme_js_dir}jscal2/unicode-letter.js"></script>
<script>{include file="`$theme_js_dir_finc`jscal2/language.js"}</script>

<table width="100%" border="0" cellpadding="20" cellspacing="0">
    <tr>
        <td>
            <table width="700" cellpadding="5" cellspacing="0" border="0" >
                <tr>
                    <td class="menuhead2" width="80%">&nbsp;{t}Expense Edit Page{/t}</td>
                    <td class="menuhead2" width="20%" align="right" valign="middle">
                        <a>
                            <img src="{$theme_images_dir}icons/16x16/help.gif" border="0" onMouseOver="ddrivetip('<div><strong>{t escape=tooltip}EXPENSE_EDIT_HELP_TITLE{/t}</strong></div><hr><div>{t escape=tooltip}EXPENSE_EDIT_HELP_CONTENT{/t}</div>');" onMouseOut="hideddrivetip();">
                        </a>
                    </td>
                </tr>
                <tr>
                    <td class="menutd2" colspan="2">
                        <table width="100%" class="olotable" cellpadding="5" cellspacing="0" border="0" >
                            <tr>
                                <td width="100%" valign="top" >
                                    <table class="menutable" width="100%" border="0" cellpadding="0" cellspacing="0" >
                                     <tr>
                                         <td>                                                                                           
                                            <form method="post" action="index.php?component=expense&page_tpl=edit" name="edit_expense" id="edit_expense">                                                
                                                <table width="100%" cellpadding="2" cellspacing="2" border="0">                                                    
                                                    <tr>
                                                        <td align="right"><b>{t}Expense ID{/t}</b></td>
                                                        <td colspan="3"><input name="expense_id" value="{$expense_details.expense_id}" type="hidden">{$expense_details.expense_id}</td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right"><b>{t}Payee{/t}</b><span style="color: #ff0000"> *</span></td>
                                                        <td colspan="3"><input name="payee" class="olotd5" size="50" value="{$expense_details.payee}" type="text" maxlength="50" required onkeydown="return onlyName(event);"></td>
                                                    </tr><tr>
                                                        <td align="right"><b>{t}Date{/t}</b><span style="color: #ff0000"> *</span></td>
                                                        <td>
                                                            <input id="date" name="date" class="olotd5" size="10" value="{$expense_details.date|date_format:$date_format}" type="text" maxlength="10" pattern="{literal}^[0-9]{1,2}(\/|-)[0-9]{1,2}(\/|-)[0-9]{2,2}([0-9]{2,2})?${/literal}" required onkeydown="return onlyDate(event);">
                                                            <input id="date_button" value="+" type="button">                                                            
                                                            <script>                                                                
                                                                Calendar.setup( {
                                                                    trigger     : "date_button",
                                                                    inputField  : "date",
                                                                    dateFormat  : "{$date_format}"                                                                                            
                                                                } );                                                                  
                                                            </script>                                                            
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right"><b>{t}Invoice ID{/t}</b></td>
                                                        <td colspan="3"><input id="invoice_id" name="invoice_id" class="olotd5" size="5" value="{$expense_details.invoice_id}" type="text" maxlength="10" onkeydown="return onlyNumber(event);"></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right"><b>{t}Type{/t}</b><span style="color: #ff0000"> *</span></td>
                                                        <td>
                                                            <select id="type" name="type" class="olotd5">
                                                                {section name=s loop=$expense_types}    
                                                                    <option value="{$expense_types[s].expense_type_id}"{if $expense_details.type == $expense_types[s].expense_type_id} selected{/if}>{t}{$expense_types[s].display_name}{/t}</option>
                                                                {/section} 
                                                            </select>
                                                        </td>                                                            
                                                    </tr>
                                                    <tr>
                                                        <td align="right"><b>{t}Payment Method{/t}</b><span style="color: #ff0000"> *</span></td>
                                                        <td>
                                                            <select id="payment_method" name="payment_method" class="olotd5">
                                                                {section name=s loop=$payment_methods}    
                                                                    <option value="{$payment_methods[s].manual_method_id}"{if $expense_details.payment_method == $payment_methods[s].manual_method_id} selected{/if}>{t}{$payment_methods[s].display_name}{/t}</option>
                                                                {/section} 
                                                            </select>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right"><b>{t}Net Amount{/t}</b><span style="color: #ff0000"> *</span></td>
                                                        <td><input name="net_amount" class="olotd5" style="border-width: medium;" size="10" value="{$expense_details.net_amount}" type="text" maxlength="10" pattern="{literal}[0-9]{1,7}(.[0-9]{0,2})?{/literal}" required onkeydown="return onlyNumberPeriod(event);"></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right"><b>{t}VAT{/t} {t}Rate{/t}</b></td>
                                                        <td><input name="vat_rate" class="olotd5" size="4" value="{$expense_details.vat_rate}" type="text" maxlength="5" pattern="{literal}^[0-9]{0,2}(\.[0-9]{0,2})?${/literal}" required onkeydown="return onlyNumberPeriod(event);"/><b>%</b></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right"><b>{t}VAT{/t} {t}Amount{/t}</b></td>
                                                        <td><input name="vat_amount" class="olotd5" size="10" value="{$expense_details.vat_amount}" type="text" maxlength="10" pattern="{literal}[0-9]{1,7}(.[0-9]{0,2})?{/literal}" required onkeydown="return onlyNumberPeriod(event);"/></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right"><b>{t}Gross Amount{/t}</b><span style="color: #ff0000"> *</span></td>
                                                        <td><input name="gross_amount" class="olotd5" size="10" value="{$expense_details.gross_amount}" type="text" maxlength="10" pattern="{literal}[0-9]{1,7}(.[0-9]{0,2})?{/literal}" required onkeydown="return onlyNumberPeriod(event);"/></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right"><b>{t}Items{/t}</b><span style="color: #ff0000"> *</span></td>
                                                        <td><textarea name="items" class="olotd5 mceCheckForContent" cols="50" rows="15">{$expense_details.items}</textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right"><b>{t}Notes{/t}</b></td>
                                                        <td><textarea name="notes" class="olotd5" cols="50" rows="15">{$expense_details.notes}</textarea></td>
                                                    </tr>                                                    
                                                    <tr>
                                                        <td colspan="2">
                                                            <input name="submit" class="olotd5" value="{t}Update{/t}" type="submit">
                                                            <input class="olotd4" value="{t}Cancel{/t}" onclick="window.location.href='index.php?component=expense&page_tpl=details&expense_id={$expense_id}';" type="button">
                                                        </td>
                                                    </tr>                                        
                                                </table>
                                            </form>                                            
                                         </td>
                                     </tr>
                                 </table>
                              </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>