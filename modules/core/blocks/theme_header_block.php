<?php

require('includes'.SEP.'modules'.SEP.'core.php');

/* Display Date and Time */
$smarty->assign('todays_date', date('l, j F Y'));

/* Add a welcome message based on time */
$smarty->assign('greeting_msg', greeting_message_based_on_time($login_display_name));

$smarty->display('core'.SEP.'blocks'.SEP.'theme_header_block.tpl');