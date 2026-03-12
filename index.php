<?php
// Force serve static HTML homepage
header('Content-Type: text/html; charset=UTF-8');
readfile(__DIR__ . '/index.html');
exit;
?>
