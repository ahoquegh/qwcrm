<!-- display_payments_block.tpl -->
{*
 * @package   QWcrm
 * @author    Jon Brown https://quantumwarp.com/
 * @copyright Copyright (C) 2016 - 2017 Jon Brown, All rights reserved.
 * @license   GNU/GPLv3 or later; https://www.gnu.org/licenses/gpl.html
*}
<b>{$block_title}</b>
<table class="olotable" width="100%" border="0" cellpadding="4" cellspacing="0">
    <tr>
        <td class="olohead"><b>{t}Payment ID{/t}</b></td>
        <td class="olohead"><b>{t}WO ID{/t}</b></td>
        <td class="olohead"><b>{t}INV ID{/t}</b></td>        
        <td class="olohead"><b>{t}Employee{/t}</b></td>
        <td class="olohead"><b>{t}Customer{/t}</b></td>
        <td class="olohead"><b>{t}Date{/t}</b></td>
        <td class="olohead"><b>{t}Method{/t}</b></td>        
        <td class="olohead"><b>{t}Amount{/t}</b></td>
        <td class="olohead"><b>{t}Note{/t}</b></td>        
        <td class="olohead"><b>{t}Action{/t}</b></td>
    </tr>
    {section name=p loop=$display_payments}        
        <tr onmouseover="this.className='row2';" onmouseout="this.className='row1';" onDblClick="window.location='index.php?component=payment&page_tpl=details&payment_id={$display_payments[p].payment_id}';" class="row1">

            <!-- Payment ID -->
            <td class="olotd4"><a href="index.php?component=payment&page_tpl=details&payment_id={$display_payments[p].payment_id}">{$display_payments[p].payment_id}</a></td>
            
            <!-- WO ID -->
            <td class="olotd4"><a href="index.php?component=payment&page_tpl=details&workorder_id={$display_payments[p].workorder_id}">{$display_payments[p].workorder_id}</a></td>

            <!-- INV ID -->
            <td class="olotd4"><a href="index.php?component=invoice&page_tpl=details&invoice_id={$display_payments[p].invoice_id}">{$display_payments[p].invoice_id}</a></td>
            
            <!-- Employee -->
            <td class="olotd4" nowrap>                
                <a class="link1" href="index.php?component=user&page_tpl=details&user_id={$display_payments[p].employee_id}">{$display_payments[p].employee_display_name}</a>
            </td>
            
            <!-- Customer -->
            <td class="olotd4" nowrap>                
                <a class="link1" href="index.php?component=customer&page_tpl=details&customer_id={$display_payments[p].customer_id}">{$display_payments[p].customer_display_name}</a>
            </td>            

            <!-- Date -->
            <td class="olotd4"> {$display_payments[p].date|date_format:$date_format}</td>

            <!-- Method -->
            <td class="olotd4" align="center">
                {section name=m loop=$payment_methods}    
                    {if $display_payments[p].method == $payment_methods[m].system_method_id}{t}{$payment_methods[m].display_name}{/t}{/if}        
                {/section}                                                                     
            </td>            

            <!-- Amount -->
            <td class="olotd4" nowrap>{$display_payments[p].amount}</td>
            
            <!-- Note -->            
            <td class="olotd4" nowrap>
                {if $display_payments[p].note}
                    <img src="{$theme_images_dir}icons/16x16/view.gif" border="0" alt="" onMouseOver="ddrivetip('<div><strong>{t}Note{/t}</strong></div><hr><div>{$display_payments[p].note|htmlentities|regex_replace:"/[\t\r\n']/":" "}</div>');" onMouseOut="hideddrivetip();">
                {/if}
             </td>            

            <!-- Action -->
            <td class="olotd4" align="center" nowrap>
                <a href="index.php?component=payment&page_tpl=details&payment_id={$display_payments[p].payment_id}">
                    <img src="{$theme_images_dir}icons/16x16/viewmag.gif" border="0" onMouseOver="ddrivetip('{t}View the payment.{/t}');" onMouseOut="hideddrivetip();">
                </a>
                <a href="index.php?component=payment&page_tpl=delete&payment_id={$display_payments[p].payment_id}" onclick="return confirmChoice('{t}Are you Sure you want to delete this Payment Record? This will permanently remove the record from the database.{/t}');">
                     <img src="{$theme_images_dir}icons/delete.gif" alt="" border="0" height="14" width="14" onMouseOver="ddrivetip('<b>{t}Delete Payment Record{/t}</b>');" onMouseOut="hideddrivetip();">
                 </a>
            </td>            

        </tr>
        {sectionelse}
            <tr>
                <td colspan="10" class="error">{t}There are no payments.{/t}</td>
            </tr>        
        {/section}
</table>